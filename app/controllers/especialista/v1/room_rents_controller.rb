module Especialista::V1
  class RoomRentsController < ApiController
    before_action :load_rent, only: [:update, :destroy, :show]

    def index
      @rents = RoomRent.all
    end

    def create
      @rent = RoomRent.new
      @rent.attributes = room_rent_params
      @rent.user_id = @current_user.id
      save_room_rent!
    end

    def show; end

    def update
      @rent.attributes = room_rent_params
      save_room_rent!
    end

    def destroy
      @rent.destroy!
    rescue
      render_error(fields: @rent.errors.messages)
    end

    private

    def save_room_rent!
        @rent.save!
        render :show
      rescue
        render_error(fields: @rent.errors.messages)
    end

    def room_rent_params
        return {} unless params.has_key?(:room_rent)
        params.require(:room_rent).permit(
            :id, :started_at, :finish_at, :user_id,
            :room_id, :price, :description
          )
    end

    def load_rent
      @rent = RoomRent.find(params[:id]) 
    end
  end
end