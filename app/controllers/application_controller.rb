class ApplicationController < ActionController::Base

private

    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    helper_method :current_user

    def require_signin
        unless current_user
            session[:intended_url] = request.url
            redirect_to signin_path, alert: "You must sign in first!"
        end
    end

    def require_admin
        redirect_to root_path, alert: "Unauthorized access!" unless current_user_admin?
    end

    def current_user?(user)
        current_user == user
    end

    helper_method :current_user?

    def current_user_admin?
        current_user && current_user.admin?
    end

    helper_method :current_user_admin?
end
