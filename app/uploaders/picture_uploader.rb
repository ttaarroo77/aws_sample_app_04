# リスト 13.69:本番環境での画像アップロードを調整する
# リスト 13.67:画像をリサイズするために画像アップローダーを修正する
# リスト 13.64:画像フォーマットのバリデーション
# app/uploaders/picture_uploader.rb

class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick  # 13.67
  process resize_to_limit: [400, 400]

  if Rails.env.production?    # 13.69
    storage :fog
  else
    storage :file
  end

  # アップロードファイルの保存先ディレクトリは上書き可能
  # 下記はデフォルトの保存先
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # アップロード可能な拡張子のリスト
  def extension_whitelist
    %w(jpg jpeg gif png)    # 13.64
  end
end
