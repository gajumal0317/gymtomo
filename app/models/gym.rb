class Gym < ApplicationRecord
    mount_uploader :img, ImgUploader
    validates :name, presence: true, length: { maximum: 50 }
    validates :address, presence: true, length: { maximum: 200 }
    
    has_many :gym_users
    has_many :users, through: :gym_users
    accepts_nested_attributes_for :gym_users
    has_many :posts
end
