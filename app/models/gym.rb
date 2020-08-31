class Gym < ApplicationRecord
    mount_uploader :img, ImgUploader
    validates :name, presence: true, length: { maximum: 50 }
    validates :address, presence: true, length: { maximum: 200 }
    validate  :img_size
    
    # アップロードされた画像のサイズをバリデーションする
    def img_size
      if img.size > 5.megabytes
        errors.add(:img, "should be less than 5MB")
      end
    end
    has_many :gym_users
    has_many :users, through: :gym_users
    accepts_nested_attributes_for :gym_users
    has_many :posts
end
