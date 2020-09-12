class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
  
  def index
    #@users = User.order(id: :desc).page(params[:page]).per(25) #viewsではgym内のmemberのみ表示#
  end

  def show
    @user = User.find(params[:id])
    @gyms = @user.gyms.order(id: :desc).page(params[:page]).per(25) 
    
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user == @user
 
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を編集しました。'
        redirect_to user_path(current_user)
      else
        flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
        render :edit
      end   
    else
      redirect_to root_url
    end
  end

  def destroy
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :img, :status, :purpose, :twitter)
  end

end