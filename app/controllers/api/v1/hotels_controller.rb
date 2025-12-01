module Api
  module V1
    class HotelsController < ApplicationController
      before_action :authorize_admin, only: [:create, :update, :destroy]
      
      private

       def set_hotel
       @hotel = Hotel.find_by!(slug: params[:slug])
       end

      def index
        hotels = Hotel.all
        render json: hotels, each_serializer: HotelSerializer, status: :ok
      end

      def show
        hotel = Hotel.find_by!(slug: params[:slug])
        render json: hotel, serializer: HotelSerializer, status: :ok
      end

      def create
        hotel = Hotel.new(hotel_params)

        if hotel.save
        render json: hotel, serializer: HotelSerializer, status: :created
        else
        render json: { errors: hotel.errors.full_messages }, status: :unprocessable_entity
      end
    end

     def update
       hotel = Hotel.find_by!(slug: params[:slug])

       if hotel.update(hotel_params)
         render json: hotel, serializer: HotelSerializer, status: :ok
       else
         render json: { errors: hotel.errors.full_messages }, status: :unprocessable_entity
       end
     end

     def destroy
       hotel = Hotel.find_by!(slug: params[:slug])
       hotel.destroy
       head :no_content
     end

   end
end

private

def hotel_params
  params.require(:hotel).permit(
    :name, :description, :image_url, :website,
    :address, :city, :star_category
  )
end


