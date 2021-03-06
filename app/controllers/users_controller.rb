class UsersController < ApplicationController
skip_before_action :authorize_request, only: :create
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    #render json: { meta: {status: 'SUCCESS', code: 200, message: 'Updated todo'}, data: @todo}, status: 200
    response = { meta: {status: 'SUCCESS', code: 200, message: Message.account_created}, data: { auth_token: auth_token }}
    #response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
