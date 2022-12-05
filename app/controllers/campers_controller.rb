class CampersController < ApplicationController

    def index
        campers = Camper.all
        render json: campers, except: [:created_at, :updated_at], status: :ok
    end

    def show
        camper = Camper.find_by( id: params[:id] )
        if camper
            render json: camper.to_json( except: [:created_at, :updated_at], include: [:activities => { except: [:created_at, :updated_at] } ]), status: :ok
        else
            camper_not_found
        end
    end

    def create
        camper = Camper.new( camper_params )
        if camper.valid?
            camper.save
            render json: camper, except: [:created_at, :updated_at], status: :created
        else
            cannot_process_camper( camper )
        end
    end

    private

    def camper_params
        params.require( :camper ).permit( :name, :age )
    end

    def cannot_process_camper camper
        render json: { errors: camper.errors.full_messages }, status: :unprocessable_entity
    end

    def camper_not_found
        render json: { errors: ['Camper not found.'] }, status: :not_found
    end
end
