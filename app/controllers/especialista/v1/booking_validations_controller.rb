module Especialista::V1
  class BookingValidationsController < ApplicationController
    def index 
      @booking = RoomRent.where(room_id: params[:room_id]).select(:id, :started_at, :finish_at)
      @range = @booking.map { |booked| { range: (booked.started_at..booked.finish_at).to_a } }
      render :show
    end
  end
end
