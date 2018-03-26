class FriendsController < ApplicationController
  def index
    @friends = []
    @followings = []
    @followeds= []
    @others = []

    User.all.each do |u|
      if current_user.friends?(u)
        @friends << u
      elsif current_user.following?(u)
        @followings << u
      elsif current_user.followed?(u) 
        @followeds << u
      else
        @others << u
      end
    end

  end

  def show
    @user = User.find(params[:id])
    if current_user.friends?(@user)
      @friend = User.find(params[:id])
      @address = @friend.address
    else
      @friend = nil
    end
    
    # url = 'https://maps.googleapis.com/maps/api/js?key='
    url = 'https://www.google.com/maps/embed/v1/place?q='
    @location = CGI::escape(@address)
    key = '&key=' + ENV['GOOGLE_MAP_KEY']
    @endpoint = url + @location + key
  end

  def create
    @friend = User.find(params[:user_id])
    if @friend != current_user
      current_user.users << @friend
      redirect_to user_friend_path(:user_id=>current_user, :id=>@friend.id)
      flash[:notice] = "You have followed #{@friend.name}."
    else
      redirect_to search_users_path
      flash[:notice] = "You cannot follow yourself."
    end  
  end

  def destroy
    # @user = User.find(params[:user_id]) #current_user
    @friend = User.find(params[:id]) 
    
    @friendship = Friend.find_by(:user1_id=>current_user, :user2_id=>@friend.id)
    @friendship.destroy
    redirect_to user_friends_path(user_id: current_user.id)
    flash[:notice] = "You have unfollowed #{@friend.name}."
  end
end
