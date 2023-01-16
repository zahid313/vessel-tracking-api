class Api::VesselsController < ApplicationController
    include  Pagination
    before_action :set_vessel, only: [:show, :update, :current_voyage]
  
    def index
      @q = Vessel.ransack(params[:q])
      @vessels = @q.result(distinct: true).order("id asc").page(params[:page])
      @pagination  = paginate(@vessels)
    end
  
    def create
      @vessel = Vessel.new(vessel_params)
      @vessel.save!
      render 'show', status: :created
    end
  
    def show
    end

    def current_voyage
      @voyage = @vessel.current_voyage
    end
  
    def update
      @vessel.update!(vessel_params)
      render 'show'
    end
  
    private
  
    def set_vessel
      @vessel = Vessel.find(params[:id])
    end
  
    def vessel_params
      params.require(:vessel).permit(:name, :owner_id, :naccs_code)
    end
  end
  