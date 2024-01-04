class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      token = generate_token(user)
      render json: { message: 'Login successful', user: user, token: token },
      status: :created
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  def destroy
    token = request.headers['Authorization']
    if token
      render json: { message: 'Logout successful...' }, status: :ok
    else
      render json: { errors: ['Invalid token'] }, status: :unauthorized
    end
  end

  private

  def generate_token(user)
    secret_key = ENV['SECRET_KEY_BASE']
    JWT.encode({ user_id: user.id }, secret_key, 'HS256')
  end
end
