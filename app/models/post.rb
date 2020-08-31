class Post < ApplicationRecord
    mount_uploader :img, ImgUploader
    validates :content, presence: true, length: { maximum: 250 }
    validate  :img_size
    
    # アップロードされた画像のサイズをバリデーションする
    def img_size
      if img.size > 5.megabytes
        errors.add(:img, "should be less than 5MB")
      end
    end
    
    belongs_to :user
    belongs_to :gym
end

