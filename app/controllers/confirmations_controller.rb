# frozen_string_literal: true

class ConfirmationsController < ApplicationController
  def show
    puts 'from create confirmation'
    @user = User.find_by(id: params[:user_id])
    if @user.confirmation_token == params[:confirmation_token]
      if @user.update(confirmed_at: Time.zone.now)
        redirect_to 'http://localhost:3001/users/sign_up'
      else
        flash[:error] = "Account can't be confirmed"
      end
    else
      flash[:error] = 'Wrong activation'
    end
  end
end
