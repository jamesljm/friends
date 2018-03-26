class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :show, :update, :destroy, :following?, :followed?, :friends?]
  before_action :require_login, except: [:new, :create, :search]
  before_action :require_admin, only: [:index]
  before_action :check_correct_current_user, only: [:show]

  def index
    if current_user.admin?
      @user = User.all
    else
      @user = nil
    end  
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_user_params)
    @user.status = "regular"
    if @user.save
      log_in @user
      # to redirect to login path later. 
      flash[:notice] = "Welcome to Friends!"
      redirect_to user_path(@user)
    else
      flash.now[:notice] = (@user.errors.full_messages)
      render 'new'
    end  
  end

  def show
    if current_user.address
      @address = current_user.address
      url = 'https://www.google.com/maps/embed/v1/place?q='
      @location = CGI::escape(@address)
      key = '&key=' + ENV['GOOGLE_MAP_KEY']
      @endpoint = url + @location + key
      render 'show'
    end
  end

  def search
    if params[:search_name].blank?
      @users = User.all
    else
      @users = User.search_name(params[:search_name])
    end
    
    @user= @users.order(name: :asc)
    # .page(params[:page]).per(12)

  end

  def edit   
    respond_to do |format|
      format.js
    end
  end

  def update
    if @user.update(edit_user_params)
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  def admin_edit
  end

  def admin_update
  end

  def destroy
    @user.delete
    redirect_to users_path
    flash[:notice] = "Admin has removed #{@user.name}."
  end

  private
  def create_user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address)
  end 

  def edit_user_params
    params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :address)
  end

  def admin_edit_user_params
    params.require(:user).permit(:name, :email, :phone, :status)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def require_login
    if !current_user 
      redirect_to root_path
      flash[:notice] = "Please login to continue."
    end  
  end

  def require_admin
    if !current_user.admin?
      redirect_to root_path
      flash[:notice] = "Permission denied."
    end  
  end  

  def check_correct_current_user
    if params[:id] != current_user.id.to_s
      redirect_to user_path(current_user)
    end
  end
end