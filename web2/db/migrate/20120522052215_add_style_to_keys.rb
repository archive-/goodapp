class AddStyleToKeys < ActiveRecord::Migration
  def change
    add_column :keys, :style, :string

  end
end
