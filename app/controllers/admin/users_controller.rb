class Admin::UsersController < ApplicationController
  before_action :require_admin
  protect_from_forgery except: :create
  
  PER = 5

  def index
    @users = User.all.page(params[:page]).per(PER).order('updated_at DESC')
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if params[:back].present?
      render :new
      return
    end

    if @user.save
      flash[:success] = "ユーザー「#{@user.name}」を登録しました。"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = "ユーザー「#{@user.name}」を更新しました。"
      redirect_to admin_user_path(@user)
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:indo] = "ユーザー「#{@user.name}」を更新しました。"
    redirect_to admin_users_url
  end

  def confirm_new
    # 入力されたユーザを作成しバリデーションを確認
    @user = User.new(user_params)
    # バリデーション失敗時は新規登録画面へ
    render :new unless @user.valid?
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation, :image)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
