class UsersController < ApplicationController
  def index
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      FanMailer.notify(@user).deliver
      flash[:notice] = "You've successfully submitted your message."
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,
                                 :email,
                                 :text)
  end
end
