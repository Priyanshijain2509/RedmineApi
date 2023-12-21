# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  respond_to :json

  before_action :set_devise_mapping

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)

    render json: { message: 'Login successful', user: resource }, status: :ok
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    render json: { message: 'Logout successful' }, status: :ok
  end

  private

  def set_devise_mapping
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
end
