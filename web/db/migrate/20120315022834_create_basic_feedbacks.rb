class CreateBasicFeedbacks < ActiveRecord::Migration
  def change
    create_table :basic_feedbacks do |t|
      t.integer :user_id
      t.string :good
      t.string :bad
      t.float :score
      t.integer :app_id

      t.timestamps
    end
  end
end
