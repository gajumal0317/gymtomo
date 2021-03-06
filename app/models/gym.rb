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
    has_many :gym_users, dependent: :destroy
    has_many :users, through: :gym_users
    accepts_nested_attributes_for :gym_users
    has_many :posts, dependent: :destroy
    has_many :trainings, dependent: :destroy
    
  def self.search(search)
    if search
      where(['name LIKE ? OR address LIKE ?', "%#{search}%", "%#{search}%"])
    else
      all
    end
  end
end
