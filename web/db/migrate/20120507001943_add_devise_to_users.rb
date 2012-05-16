class AddDeviseToUsers < ActiveRecord::Migration
  def up
    remove_column :users, :email, :password_hash, :password_salt
    change_table :users  do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Encryptable
      # t.string :password_salt

      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      ## Token authenticatable
      # t.string :authentication_token


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def down
    remove_index :users, :confirmation_token
    remove_index :users, :reset_password_token
    remove_index :users, :email
    [:unconfirmed_email, :confirmation_sent_at,
     :confirmed_at, :confirmation_token, :last_sign_in_ip,
     :current_sign_in_ip, :last_sign_in_at, :current_sign_in_at,
     :sign_in_count, :remember_created_at, :reset_password_sent_at,
     :reset_password_token, :encrypted_password, :email].each do |col|
       remove_column :users, col
     end
    add_column :users, :email, :string
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
  end
end
