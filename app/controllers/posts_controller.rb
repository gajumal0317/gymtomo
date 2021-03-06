class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  

  def create
    @post = current_user.posts.build(post_params)
      if @post.save
      else
        #投稿に失敗したときフラッシュが出ない＝投稿できたことになっている。
        flash[:danger] = '投稿できませんでした。'
      end
      redirect_back(fallback_location: root_path)
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
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def post_params
    params.require(:post).permit(:content, :img, :user_id, :gym_id)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to user_path(current_user.id)
    end
  end
  
end