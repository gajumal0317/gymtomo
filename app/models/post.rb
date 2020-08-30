class Post < ApplicationRecord
    mount_uploader :img, ImgUploader
    validates :content, presence: true, length: { maximum: 250 }
    
    belongs_to :user
    belongs_to :gym
end

