class Training < ApplicationRecord
  belongs_to :user
  belongs_to :gym
  
  validates :part, presence: true
end
