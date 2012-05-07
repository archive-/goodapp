require 'tempfile'

class Endorsement < ActiveRecord::Base
  belongs_to :endorser, class_name: 'User'
  belongs_to :endorsee, class_name: 'User'

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
      file = Tempfile.new('goodapp_trust')
      begin
        file.puts "#{users.count}"
        base_trusts = []
        users.map do |user|
          base_trusts << "#{user.id}:#{user.base_trust}"
        end
        base_trusts.join(' ')
        file.puts base_trusts
        # now print out grid of recommendations
        Endorsement.all.each do |e|
          file.puts
          file.write("#{e.endorser_id} #{e.endorsee_id}")
        end
        executable = File.join(Rails.root, '../bin/trust')
        # TODO error handling!!
        output = `#{executable} < #{file.path}`
        pairings = output.split
        trusts = {}
        pairings.each do |pairing|
          id, trust = pairing.split(':')
          trusts[id.to_i] = trust
        end
        User.find(trusts.keys).each do |user|
          user.update_attribute(:overall_trust, trusts[user.id])
        end
      ensure
        file.close
        file.unlink
      end
    end
    # TODO make asynchronous
    # handle_asynchronously :calculate_trust
  end
end
