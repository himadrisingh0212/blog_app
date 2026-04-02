class ProfilesController < ApplicationController
  def show
    @user = current_user
  end

  def new
    @user = User.new
    @user.profile_fields.build   # important for form
  end
  
  def edit
    @user = current_user
    @user.profile_fields.build if @user.profile_fields.empty?
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end
  
  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(
      :name, :email,
      profile_fields_attributes: [:id, :key, :value, :_destroy]
    )
  end
end