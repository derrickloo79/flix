module MoviesHelper

    def total_gross(movie)
        if movie.released_on > Time.now
            "No data yet"
        elsif movie.flop?
            "Flop!!"
        else
            number_to_currency(movie.total_gross, precision: 0)
        end
    end

    def year_of(movie)
        # movie.released_on.strftime("%Y")
        movie.released_on.year
    end

    def average_stars(movie)
        if movie.average_stars.zero?
            content_tag(:span, "0 Review 😢", class: "text-secondary")
        else
            pluralize(number_with_precision(movie.average_stars, precision: 1), "star")
        end
    end

    def nav_link_to(text, url)
        if current_page?(url)
            link_to(text, url, class: "active")
        else
            link_to(text, url)
        end
    end
end
