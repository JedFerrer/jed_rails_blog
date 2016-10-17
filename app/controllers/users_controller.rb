class UsersController < ApplicationController

  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    if User.exists?(:email => user_params[:email])
      flash.now[:notice] = "User email already taken."
      render action: 'new'
    else
    	if @user.save
        redirect_to new_session_path(), notice: 'User was successfully created, You can now login.'
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
