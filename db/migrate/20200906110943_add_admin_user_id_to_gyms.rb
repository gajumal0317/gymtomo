class AddAdminUserIdToGyms < ActiveRecord::Migration[5.2]
  def change
    add_column :gyms, :admin_user_id, :integer
  end
end
