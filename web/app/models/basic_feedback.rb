class BasicFeedback < ActiveRecord::Base
  @@goods = [:g_speed, :g_ease, :g_updates, :g_on_offline, :g_battery, :g_personalize, :g_location_services, :g_performs, :g_useful]
  @@bads = [:b_battery, :b_ads, :b_permissions, :b_crashes, :b_privacy, :b_sounds, :b_updates, :b_internet, :b_money, :b_other_apps, :b_location_services, :b_overall]
  attr_accessible *@@goods, *@@bads, :comment
  validates_uniqueness_of :user_id, scope: :app_id

  belongs_to :user
  belongs_to :app

  def ngoods
    @@goods.inject(0) {|sum, bool| self.send(bool) ? sum + 1 : sum}
  end

  def nbads
    @@bads.inject(0) {|sum, bool| self.send(bool) ? sum + 1 : sum}
  end
end
