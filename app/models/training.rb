class Training < ApplicationRecord
  belongs_to :user
  belongs_to :gym
  
  validates :part1, presence: true
  validates :part2, presence: true
  validates :part3, presence: true
  
  enum part1:{"なし":0,
              胸:1,背中:2,脚:3,肩:4,腕:5,腹筋:6,有酸素:7
            } , _prefix: true
  
  enum part2:{"なし":0,
              胸:1,背中:2,脚:3,肩:4,腕:5,腹筋:6,有酸素:7
            } , _prefix: true
 
  enum part3:{"なし":0,
              胸:1,背中:2,脚:3,肩:4,腕:5,腹筋:6,有酸素:7
            } , _prefix: true
end
