class AddPurposesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :purpose, :integer, default: 0
  end
end
