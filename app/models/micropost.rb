# リスト 13.65:画像に対するバリデーションを追加する
# リスト 13.59:Micropostモデルに画像を追加する
# リスト 13.17:default_scopeでマイクロポストを順序付ける green
# リスト 13.10:マイクロポストがユーザーに所属する (belongs_to) 関連付け green
# リスト 13.8:Micropostモデルのバリデーション green
# リスト 13.5:マイクロポストのuser_idに対する検証 green
# リスト 13.2:自動生成されたMicropostモデル
# app/models/micropost.rb


class Micropost < ApplicationRecord
  belongs_to :user  # 13.2   # 13.10
  default_scope -> { order(created_at: :desc) }   # 13.17
  mount_uploader :picture, PictureUploader    # 13.59
  validates :user_id, presence: true    # 13.5
  validates :content, presence: true, length: { maximum: 140 }    # 13.8
  validate  :picture_size   # 13.65

  private

    def picture_size    # アップロードされた画像のサイズをバリデーションする		# 13.65
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end



# # リスト 13.65:画像に対するバリデーションを追加する
# # app/models/micropost.rb

# class Micropost < ApplicationRecord
#   belongs_to :user
#   default_scope -> { order(created_at: :desc) }
#   mount_uploader :picture, PictureUploader
#   validates :user_id, presence: true
#   validates :content, presence: true, length: { maximum: 140 }
#   validate  :picture_size

#   private

#     # アップロードされた画像のサイズをバリデーションする
#     def picture_size
#       if picture.size > 5.megabytes
#         errors.add(:picture, "should be less than 5MB")
#       end
#     end
# end


# # class Micropost < ApplicationRecord
# #   belongs_to :user
# # end
