# リスト 9.1:記憶ダイジェスト用に生成したマイグレーション
# db/migrate/[timestamp]_add_remember_digest_to_users.rb


class AddRememberDigestToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :remember_digest, :string
  end
end
