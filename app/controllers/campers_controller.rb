class CampersController < ApplicationController

    # rescue_from ActiveRecord::RecordNotFound :camper_not_found

    def index
        render json: Camper.all, except: [:created_at, :updated_at], status: :ok
    end

    def show
        camper = Camper.find_by( id: params[:id] )
        if camper
            render json: camper, except: [:created_at, :updated_at], include: [:activities => { except: [:created_at, :updated_at] }], status: :ok
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
            render json: { errors: camper.errors.full_messages }, status: :unprocessable_entity
        end
    end
    

    def signup
        new_signup = Signup.new( signup_params )
        if new_signup.valid?
            new_signup.save
            render json: new_signup.activity, except: [:created_at, :updated_at], status: :ok
        else
            render json: { errors: new_signup.errors.full_messages }, status: 422
        end
    end

    private

    def camper_params
        params.permit( :name, :age )
    end

    def camper_not_found
        render json: { errors: ['Camper not found.'] }, status: :not_found
    end

    def signup_params
        params.permit( :time, :camper_id, :activity_id )
    end

end
