# リスト 6.29:メールアドレスの一意性を強制するためのマイグレーション
# db/migrate/[timestamp]_add_index_to_users_email.rb

class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  def change
    add_index :users, :email, unique: true
  end
end



# class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
#   def change
#   end
# end
