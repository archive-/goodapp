class CreateDevs < ActiveRecord::Migration
  def change
    create_table :devs do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.string :password_salt

      t.timestamps
    end
  end
end
