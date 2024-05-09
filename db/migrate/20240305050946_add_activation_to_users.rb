# リスト 11.2:アカウント有効化用の属性とインデックスを追加するマイグレーション
# db/migrate/[timestamp]_add_activation_to_users.rb


class AddActivationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :activation_digest, :string
    add_column :users, :activated, :boolean, default: false  # 11.2
    add_column :users, :activated_at, :datetime
  end
end



# class AddActivationToUsers < ActiveRecord::Migration[5.1]
#   def change
#     add_column :users, :activation_digest, :string
#     add_column :users, :activated, :boolean
#     add_column :users, :activated_at, :datetime
#   end
# end
