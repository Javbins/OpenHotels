class ApplicationController < ActionController::API
  before_action :authorize_request

  private

  def authorize_request
    header = request.headers['Authorization']

    if header.present?
      token = header.split(' ').last
      decoded = JsonWebToken.decode(token)

      if decoded
        @current_user = User.find_by(id: decoded[:user_id])
      else
        render json: { errors: ['Invalid or expired token'] }, status: :unauthorized
      end
    else
      render json: { errors: ['Missing token'] }, status: :unauthorized
    end
  end
  
  def authorize_admin
  unless @current_user&.admin?
    render json: { errors: ['Admin permissions required'] }, status: :forbidden
  end
end

end

