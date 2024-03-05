# リスト 10.54:boolean型のadmin属性をUserに追加するマイグレーション
# db/migrate/[timestamp]_add_admin_to_users.rb

class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end


# class AddAdminToUsers < ActiveRecord::Migration[5.1]
#   def change
#     add_column :users, :admin, :boolean
#   end
# end
