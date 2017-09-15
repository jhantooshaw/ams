class UsersController < ApplicationController
  before_action :authenticate_user!, :get_user
  def profile
    @address = @user.addresses.first
  end
  
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)        
        format.html { redirect_to profile_user_path(@user), notice: 'User was successfully updated.' }        
        format.json { head :no_content }
      else
        @address = @user.addresses.first
        format.html { render action: "profile" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update_password
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(@user)
      redirect_to root_path
    else
      render "edit"
    end
  end  
  
  private
  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
    
end
