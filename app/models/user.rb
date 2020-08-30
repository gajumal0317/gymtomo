class User < ApplicationRecord
    mount_uploader :img, ImgUploader
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }    
    has_secure_password
    has_many :posts
    has_many :gym_users
    has_many :gyms, through: :gym_users
    
  def join(gym)
    self.gym_users.find_or_create_by(gym_id: gym.id)
  end
   
  def resign(gym)
    join = gym_users.find_by(gym_id: gym.id)
    join.destroy if join
  end
        
  def joinings?(gym)
    self.gyms.include?(gym)
  end
end
