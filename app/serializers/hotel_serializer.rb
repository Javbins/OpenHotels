class HotelSerializer < ActiveModel::Serializer
  attributes :id, :name, :slug, :description, :image_url,
             :website, :address, :city, :star_category
end

