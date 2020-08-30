class GymUser < ApplicationRecord
  belongs_to :user
  belongs_to :gym
end
