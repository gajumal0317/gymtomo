class GymsController < ApplicationController
  before_action :require_user_logged_in
  before_action :admin_user, only: [:edit, :update, :destroy]
  
  def index
    @gyms = Gym.order(id: :desc).page(params[:page]).per(10).search(params[:search])
  end
  
  def new
    @gym = Gym.new
  end

  def show
    @gym = Gym.find(params[:id])
    @post = current_user.posts.build
    @posts = @gym.posts.order(id: :desc).page(params[:page]).per(10)
  
  end
  
  def member
    @gym = Gym.find(params[:id])
    @users = @gym.users.order(id: :desc).page(params[:page]).per(25)
  end
  
  def create
    @gym = Gym.new(gym_params)
    if @gym.save
      flash[:success] = 'ジムを登録しました'
      redirect_to gyms_path
    else
      render :new
    end
  end

  def edit
    @gym = Gym.find(params[:id])
  end

  def update
    @gym = Gym.find(params[:id])
    if @gym.update(gym_params)
      flash[:success] = 'ジムを更新しました'
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  def destroy
    @gym.destroy
    flash[:success] = 'ジムを削除しました。'
    redirect_to gyms_path
  end
  
  private

  def gym_params
    params.require(:gym).permit(:name, :address, :img, :admin_user_id, user_ids: [] )
  end
  
  def admin_user
    @gym = Gym.find_by(id: params[:id])
    unless current_user.id == @gym.admin_user_id
      redirect_back(fallback_location: root_path)
    end
  end
  
end
