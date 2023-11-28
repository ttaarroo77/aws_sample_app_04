# リスト 6.2:(usersテーブルを作るための) Userモデルのマイグレーション
# db/migrate/[timestamp]_create_users.rb

class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
