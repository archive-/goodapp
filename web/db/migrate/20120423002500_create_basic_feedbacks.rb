class CreateBasicFeedbacks < ActiveRecord::Migration
  def change
    create_table :basic_feedbacks do |t|
      # sorry mom
      t.integer :user_id
      t.integer :app_id
      t.boolean :g_speed
      t.boolean :g_ease
      t.boolean :g_updates
      t.boolean :g_on_offline
      t.boolean :g_battery
      t.boolean :g_personalize
      t.boolean :g_location_services
      t.boolean :g_performs
      t.boolean :g_useful
      t.boolean :b_battery
      t.boolean :b_ads
      t.boolean :b_permissions
      t.boolean :b_crashes
      t.boolean :b_privacy
      t.boolean :b_sounds
      t.boolean :b_updates
      t.boolean :b_internet
      t.boolean :b_money
      t.boolean :b_other_apps
      t.boolean :b_location_services
      t.boolean :b_overall
      t.text :comment
      t.timestamps
    end
  end
end
