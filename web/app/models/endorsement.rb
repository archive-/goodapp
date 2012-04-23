class Endorsement < ActiveRecord::Base
  belongs_to :endorser, :class_name => 'User'
  belongs_to :endorsee, :class_name => 'User'

  class << self
    def calculate_trust
      # num_users
      # id:trust id:trust id:trust ...
      # endorser_id:endorsee_id
      # endorser_id:endorsee_id
      # endorser_id:endorsee_id
      # ...
      # grab all users from db and write out file
      users = User.all
      timestamp = DateTime.now.strftime('%s')
      File.open("../data/#{timestamp}.in", 'w') do |file|
        file.write("#{users.count}\n")
        base_trusts = users.map {|user| "#{user.id}:#{user.base_trust}"}
        users.each do |user|
          file.write(base_trusts.join(' '))
        end
        # now print out grid of recommendations
        Endorsement.all.each do |e|
          file.write("\n")
          file.write("#{e.endorser_id} #{e.endorsee_id}")
        end
      end
    end
    handle_asynchronously :calculate_trust
  end
end
