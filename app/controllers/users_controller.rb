class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show,:edit,:update]
  before_action :correct_user, only:[:edit, :update, :destroy]

  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @schedules = @user.schedules.order('created_at DESC')#.page(params[:page])
    
    @secret = Schedule.where("start > '#{DateTime.now.in_time_zone('UTC')}'").where(user_id: current_user.following_ids, publicflag:0).order("deadline ASC")#.page(params[:page])

    @schedules = @schedules + @secret
    counts(@user)
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
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)
  end  
    
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = '正常に更新されました'
      redirect_to @user
    else
      flash.now[:danger] ='更新されませんでした'
      render :edit
    end  
  end

private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to current_user
    end
  end 
end

 