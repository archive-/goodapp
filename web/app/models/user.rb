class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
   :recoverable, :rememberable, :trackable, :validatable,
   :confirmable

  attr_accessible :name, :about, :email, :password,
    :password_confirmation, :remember_me

  has_many :keys, dependent: :delete_all
  has_many :apps, through: :keys

  has_many :endorsements_as_endorser, foreign_key: :endorser_id, class_name: "Endorsement", dependent: :delete_all
  has_many :endorsements_as_endorsee, foreign_key: :endorsee_id, class_name: "Endorsement", dependent: :delete_all
  has_many :endorsees, through: :endorsements_as_endorser
  has_many :endorsers, through: :endorsements_as_endorsee

  has_one :github_account

  validates_presence_of :name

  auto_strip :name, :email, :about

  def valid_keys
    keys.where(status: 100, proper: true)
  end

  def valid_email_keys
    keys.where(status: 100, style: "email", proper: true)
  end

  def valid_apps
    apps.where(status: 100, proper: true)
  end

  def avg_app_rating
    return 0.0 if self.valid_apps.empty?
    self.valid_apps.map {|a| a.rating}.inject(:+).to_f / self.valid_apps.count
  end

  def max_email_key
    self.valid_email_keys.max {|a, b| (a.rating || 0.0) <=> (b.rating || 0.0)}
  end

  def max_email_key_rating
    mek = max_email_key
    # because key.rating can be nil (if not email key -- *poor* design)
    mek ? (mek.rating || 0.0) : 0.0
  end

  def github_account_rating
    self.github_account ? self.github_account.rating : 0.0
  end

  def base_rating
    base_rating = 0.0
    # GITHUB - 10%
    base_rating += self.github_account_rating * 10.0
    # CORPORATE EMAIL - 10%
    base_rating += self.max_email_key_rating * 10.0
    # APPS
    base_rating += self.avg_app_rating * 40.0
    # weighted to 60%
    base_rating
  end

  # calculated and stored
  def rating
    self.base_rating + (self.endorsement_rating || 0.0) * 30.0
  end

  def has_endorsed?(endorsee)
    self.endorsees.map {|e| e.id}.index(endorsee.id)
  end

  def as_json(opts={})
    {id: self.id, name: self.name, rating: self.rating}
  end

  def self.can_endorse?(endorser, endorsee)
    return false unless endorser && endorsee   # if either is nil
    return false if endorser.id == endorsee.id # endorsing self
    !endorser.has_endorsed?(endorsee)
  end

  # TODO with high activity?
  # TODO maybe most trusted users??
  def self.featured
    # TODO determined featured users list
    User.last(5)
  end
end
