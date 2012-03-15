class CreateEndorsements < ActiveRecord::Migration
  def change
    create_table :endorsements do |t|
      t.integer :endorser_id, :null => false
      t.integer :endorsee_id, :null => false
      t.text :message
      t.timestamps
    end
  end
end
