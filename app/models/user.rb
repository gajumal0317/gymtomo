class User < ApplicationRecord
    mount_uploader :img, ImgUploader
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 20 }
    validates :email, presence: true, length: { maximum: 50 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }    
    validates :password, length: { minimum: 6 }, format: { with: /\A[a-zA-Z0-9]+\z/ }
    validates :status, length: { maximum: 200 }
    validates :twitter, length: { maximum: 20 }
    validate  :img_size
    # アップロードされた画像のサイズをバリデーションする
    def img_size
      if img.size > 5.megabytes
        errors.add(:img, "should be less than 5MB")
      end
    end
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
  
  enum purpose:{
     "未定":0,
     健康:1,ダイエット:2,コンペティター:3,スポーツ:4,モテたい:5
  }
end
