skip_before_action :authorize_request, only: [:signup, :login]

module Api
  module V1
    class AuthController < ApplicationController

      # POST /api/v1/auth/signup
      def signup
        user = User.new(user_params)
        if user.save
          token = JsonWebToken.encode(user_id: user.id)
          render json: { user: user, token: token }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # POST /api/v1/auth/login
      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { user: user, token: token }, status: :ok
        else
          render json: { errors: ['Invalid email or password'] }, status: :unauthorized
        end
      end

      private

      def user_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end
