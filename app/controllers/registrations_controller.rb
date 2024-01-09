# frozen_string_literal: true

class RegistrationsController < ApplicationController
  before_action :authenticate_user_by_token, only: %i[update ]

  def index
    render json: {message: 'link api successfull'}, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user = @user.reload
      render json: { message: 'Registration successful' }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @current_user.update(user_params)
      render json: { message: 'User updated successfully' }, status: :ok
    else
      render json: { error: 'User update failed', details: user.errors.full_messages },
      status: :unprocessable_entity
    end
  end

  def search
    search_term = params[:email]
    @users = User.where('email LIKE ?', "%#{search_term}%")
    render json: { users: @users }
  end

  def show
    @user = User.find(params[:user_id])
    if @user
      render json: { message: 'Assignee fetched', user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :bad_request
    end
  end
  
  private

  def user_params
    params.require(:registration).permit(:first_name, :last_name, :email,
      :password, :password_confirmation, :language, :nick_name)
  end

  def authenticate_user_by_token
    token = request.headers['Authorization']&.split(' ')&.last
    decoded_token = decode_token(token)
    if decoded_token && (user = User.find_by(id: decoded_token['user_id']))
      @current_user = user
    else
      render json: { errors: ['Unauthorized'] }, status: :unauthorized
    end
  end

  def decode_token(token)
    begin
      secret_key = ENV['SECRET_KEY_BASE']
      decoded = JWT.decode(token, secret_key, true, algorithm: 'HS256')
      decoded[0]
    rescue JWT::DecodeError
      nil
    end
  end
end
