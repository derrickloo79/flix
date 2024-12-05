class ReviewsController < ApplicationController
    before_action :require_signin
    before_action :set_movie
    
    def index
        @reviews = @movie.reviews.order("created_at desc")
    end

    def new
        @review = @movie.reviews.new
    end

    def create
        @review = @movie.reviews.new(review_params)
        @review.user = current_user
        if @review.save
            redirect_to movie_reviews_url(@movie), notice: "Thanks for reviewing!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @review = @movie.reviews.find(params[:id])
    end

    def update
        @review = @movie.reviews.find(params[:id])
        if @review.update(review_params)
            redirect_to movie_reviews_url(@movie), notice: "Review successfully updated!"
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @review = @movie.reviews.find(params[:id])
        @review.destroy
        redirect_to movie_reviews_path, status: :see_other, notice: "Review successfully deleted!"
    end
end

private

    def review_params
        params.require(:review).
            permit(:stars, :comment)
    end

    def set_movie
        @movie = Movie.find_by!(slug: params[:movie_id])
    end
