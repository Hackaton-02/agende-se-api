module Storefront::V1
    class RoomsController < ApiController
      before_action :load_room, only: [:show]

    def index
      @rooms = Room.all
    end

    def show; end

    private

    def load_room
      @room = Room.find(params[:id]) 
    end
    
  end
end
