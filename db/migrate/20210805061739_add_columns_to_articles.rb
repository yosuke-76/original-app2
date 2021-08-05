class AddColumnsToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :address, :string
    add_column :articles, :latitude, :float
    add_column :articles, :longitude, :float
  end
end
