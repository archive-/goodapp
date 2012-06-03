module EndorsementRatingSyncJob
  @queue = :main

  def self.perform(opts={})
    users = User.all
    now = Time.now
    file = Tempfile.new("goodapp_er_sync")
    begin
      file.puts("#{users.count}")
      file.puts(users.map {|u| "#{u.id}:#{u.base_rating}"}.join(" "))
      Endorsement.all.each do |endorsement|
        file.puts("#{endorsement.endorser_id} #{endorsement.endorsee_id}")
      end
      executable = File.join(Rails.root, "../bin/trust")
      output = `#{executable} < #{file.path}`
      pairings = output.split
      ratings = {}
      pairings.each do |pairing|
        id, rating = pairing.split(":")
        ratings[id.to_i] = rating.to_f
      end
      users = User.find(ratings.keys)
      endorsement_ratings = {}
      users.each do |user|
        endorsement_ratings[user.id] = ratings[user.id] - user.base_rating
      end
      # normalize the ratings (highest endorsement bonus is 1.0
      max_endorsement_rating = endorsement_ratings.values.max
      users.each do |user|
        user.update_attribute(:endorsement_rating,
          endorsement_ratings[user.id] / max_endorsement_rating)
      end
    ensure
      file.close
      file.unlink
    end
  end
end
