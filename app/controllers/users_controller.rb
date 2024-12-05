class UsersController < ApplicationController
    before_action :require_signin, except: [:new, :create]
    before_action :require_correct_user, only: [:edit, :update]
    before_action :require_admin, only: [:destroy]
    before_action :set_name, only: [:show, :edit, :update, :destroy]

    def index
        @users = User.not_admins
    end

    def show
        @reviews = @user.reviews
        @fav_movies = @user.fav_movies.order("title")
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to @user, notice: "Thanks for signing up!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @user.update(user_params)
            redirect_to @user, notice: "User updated successfully!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path, status: :see_other, alert: "User deleted successfully!"
    end

private

    def user_params
        params.require(:user).
            permit(:name, :email, :password, :password_confirmation)
    end

    def require_correct_user
        @user = User.find_by!(slug: params[:id])
        redirect_to movies_path, status: :see_other unless current_user?(@user)
    end

    def set_name
        @user = User.find_by!(slug: params[:id])
    end

end
