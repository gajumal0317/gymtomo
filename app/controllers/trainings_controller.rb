class TrainingsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  
  def new
    @training = Training.new
  end


  
  def create
    @training = current_user.trainings.build(training_params)
      if @training.save
      else
        flash[:danger] = '投稿できませんでした。'
      end
      redirect_to user_path(current_user)
  end
  
  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to user_path(current_user.id)
    else
      flash.now[:danger] = '投稿は更新されませんでした'
      render :edit
    end
  end

  def destroy
  end
  
  private

  def training_params
    params.require(:training).permit(:part1, :part2, :part3, :partner, :user_id, :gym_id)
  end
  
  def correct_user
    @training = current_user.trainings.find_by(id: params[:id])
    unless @training
      redirect_to trainings_path(current_user.id)
    end
  end
end
