class ProfileFieldsController < ApplicationController
    def create
      field = current_user.profile_fields.create(field_params)
  
      puts "SAVED: #{field.inspect}"   # 🔥 DEBUG LINE
  
      redirect_to "/profile"
    end
  
    private
  
    def field_params
      params.require(:profile_field).permit(:key, :value)
    end
  end
