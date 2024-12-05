class GenresController < ApplicationController
    before_action :require_signin
    before_action :require_admin
    before_action :get_genre, except: [:index, :new, :create]

    def index
        @genres = Genre.all.order("name")
    end

    def show
        @movies = @genre.movies
    end

    def edit
    end

    def update
        if @genre.update(genre_params)
            redirect_to genres_path, notice: "Genre successfully updated!"
        else
            render :edit, status: unprocessable_entity
        end
    end

    def new
        @genre = Genre.new
    end

    def create
        @genre = Genre.new(genre_params)
        if @genre.save
            redirect_to genres_path, notice: "Genre successfully added"
        else
            render :new, status: :unprocessable_entity
        end
    end

    def destroy
        @genre.destroy
        redirect_to genres_path, status: :see_other, notice: "Genre successfully deleted!"
    end

private

    def genre_params
        params.require(:genre).
            permit(:name)
    end

    def get_genre
        @genre = Genre.find_by!(slug: params[:id])
    end
end
