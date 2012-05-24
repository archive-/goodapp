class AddConfirmationFieldsToKey < ActiveRecord::Migration
  def change
    add_column :keys, :confirmation_email, :string
    add_column :keys, :confirmation_token, :string
    add_column :keys, :confirmed_at, :datetime
    add_column :keys, :confirmation_sent_at, :datetime
  end
end
