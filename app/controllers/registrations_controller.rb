# frozen_string_literal: true

class RegistrationsController < ApplicationController
  def index
    render json: {message: 'linkk api successfull'}, status: :ok
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      @user = @user.reload
      render json: { message: 'Registration successful' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
  end

  private

  def registration_params
    params.require(:registration).permit(:first_name, :last_name, :email,
      :password, :password_confirmation, :language, :nick_name)
  end

end
