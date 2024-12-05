class AddFieldsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :released_on, :datetime
    add_column :movies, :description, :text
  end
end
