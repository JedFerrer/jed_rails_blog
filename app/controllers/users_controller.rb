class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.exists?(:email => user_params[:email])
      flash.now[:notice] = "User email already taken."
      render action: 'new'
      # redirect_to new_user_path, notice: 'User email already taken'
    else
    	if @user.save
  			#redirect_to @user, notice: 'User was successfully created.'
        #redirect_to user_articles_path(@user), notice: 'User was successfully created.'
        redirect_to new_session_path(@user), notice: 'User was successfully created, You can now login.'
  		else
  			render action: "new"
  		end
    end	
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
