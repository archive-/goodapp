class Key < ActiveRecord::Base
  attr_accessible :title, :kee, :kee_file, :email
  attr_reader :kee_file, :email

  belongs_to :user
  has_many :apps, dependent: :delete_all

  validates_presence_of :title
  # TODO (uncomment) validates_uniqueness_of :kee
  validates_uniqueness_of :title, scope: :user_id

  @queue = :main #:keys

  def kee_file=(file)
    self.kee = file.read
  end

  def email=(email)
    # TODO validate email
    self.style = :email
    self.title = self.kee = email
  end

  def email_key?
    self.style && self.style.to_sym == :email
  end

  def progress(status, state="", proper=true)
    self.status, self.state, self.proper = status, state, proper ; save
  end

  def handle_upload
    progress(10, "Checking key") # start it at 10 to give hope
    # TODO next two lines slow enough to bg?
    # TODO look for the BEGIN AND END to determine if PGP
    if self.kee.index(/PGP PUBLIC KEY/)
      Resque.enqueue(Key, self.id, :handle_pgp)
    else
      # TODO other key validity checks?
      progress(100)
    end
    true
  end

  def handle_pgp
    # whitelist protection against injection
    raise "PGP: Invalid key file" unless self.kee.match(/^[\-a-zA-Z0-9\/+\s:]+\Z/)
    # ---- STEP 1: start import
    progress(30, "PGP: Importing")
    md = nil
    status = Open4::popen4("gpg --import -") do |pid, stdin, stdout, stderr|
      stdin.puts self.kee
      stdin.close
      # ---- STEP 2: grab key_id and email
      md = stderr.read.match(/^gpg: key ([^:]+): "[^<]*<([^>]+)>"/)
    end
    raise "PGP: Import error" unless status.exitstatus.zero?
    fingerprint, email = md[1], md[2]
    self.style, self.fingerprint = :pgp, fingerprint ; save
    KeyMailer.email(email, self.id).deliver
    progress(60, "PGP: Found key #{fingerprint}. Sent confirmation email to <#{email}>.")
  rescue Exception => e
    progress(100, e.message, false)
  end

  def self.perform(key_id, handle_method)
    Key.find(key_id).send(handle_method)
  end
end
