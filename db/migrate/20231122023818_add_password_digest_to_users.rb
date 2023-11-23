# リスト 6.35:password_digestカラムを追加するマイグレーション
# db/migrate/[timestamp]_add_password_digest_to_users.rb

class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :password_digest, :string
  end
end


# class AddPasswordDigestToUsers < ActiveRecord::Migration[5.1]
#   def change
#     add_column :users, :password_digest, :string
#   end
# end
