class GymUsersController < ApplicationController
  before_action :require_user_logged_in

  def create
    gym = Gym.find(params[:gym_id])
    current_user.join(gym)
    flash[:success] = 'ジムに参加しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    gym = Gym.find(params[:gym_id])
    current_user.resign(gym)
    flash[:success] = '退会しました。'
    redirect_back(fallback_location: root_path)
  end
end
