class Api::VoyagesController < ApplicationController
    include  Pagination
    before_action :set_voyage, only: [:show, :update]
  
    def index
      @q = Voyage.ransack(params[:q])
      @voyages = @q.result(distinct: true).order("id asc").page(params[:page])
      @pagination  = paginate(@voyages)      
    end
  
    def create
      @voyage = Voyage.new(voyage_params)
      @voyage.save!
      render 'show', status: :created
    end
  
    def show
    end
  
    def update
      @voyage.update!(voyage_params)
      render 'show'  
    end
  
    private
  
    def set_voyage
      @voyage = Voyage.find(params[:id])
    end
  
    def voyage_params
      params.require(:voyage).permit(:from_place, :to_place, :start_at, 
                                    :end_at, :vessel_id)
    end
  end
  