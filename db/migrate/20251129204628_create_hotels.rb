class CreateHotels < ActiveRecord::Migration[8.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :slug
      t.text :description
      t.string :image_url
      t.string :website
      t.string :address
      t.string :city
      t.integer :star_category

      t.timestamps
    end
  end
end
