class ApplicationController < ActionController::Base
    respond_to :html, :json

    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token

    rescue_from StandardError, with: :generic_error

    def spa; end

    private
        def generic_error
            render json: {isOk: false, msg: "Something went wrong."}, status: :internal_server_error
        end
end
