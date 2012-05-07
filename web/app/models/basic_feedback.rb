class BasicFeedback < ActiveRecord::Base
  @@goods = {
    g_speed: 'Fast and reliable',
    g_ease: 'Easy to use',
    g_updates: 'Updates are consistent',
    g_on_offline: 'Works on and off line',
    g_battery: 'Low battery usage',
    g_personalize: 'Ability to personalize',
    g_location_services: 'Uses my location nicely',
    g_performs: 'Performs as expected',
    g_useful: 'Interesting and useful'
  }
  @@bads = {
    b_battery: 'Drains battery',
    b_ads: 'Too many advertisements',
    b_permissions: 'Doesn\'t ask for permission',
    b_crashes: 'Crashes often',
    b_privacy: 'Steals private info',
    b_sounds: 'Triggers unexpected sounds',
    b_updates: 'Updates cause problems',
    b_internet: 'Uses too much data',
    b_money: 'Charges me without consent',
    b_other_apps: 'Opens other app without consent',
    b_location_services: 'Uses my location poorly',
    b_overall: 'Doesn\'t perform properly'
  }
  attr_accessible *@@goods.keys, *@@bads.keys, :comment
  validates_uniqueness_of :user_id, scope: :app_id

  belongs_to :user
  belongs_to :app

  def ngoods
    @@goods.keys.inject(0) {|sum, bool| self.send(bool) ? sum + 1 : sum}
  end

  def nbads
    @@bads.keys.inject(0) {|sum, bool| self.send(bool) ? sum + 1 : sum}
  end

  def details
    goods = []
    bads = []
    @@goods.each do |g_attr, g_value|
      goods << g_value if self.send(g_attr)
    end
    @@bads.each do |b_attr, b_value|
      bads << b_value if self.send(b_attr)
    end
    [goods, bads]
  end
end
