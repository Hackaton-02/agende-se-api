module Storefront::V1
  class ConsultsValidationsController < ApplicationController
    def index 
      @consults = Consult.where(room_rent_id: params[:room_rent_id]).select(:id, :started_at, :finish_at)
      @range = @consults.map { |consult| { range: (consult.started_at.to_date..consult.finish_at.to_date).to_a } }
      render :show
    end    
  end
end
