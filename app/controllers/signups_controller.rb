class SignupsController < ApplicationController

    def create
        signup = Signup.new( signup_params )
        if signup.valid?
            signup.save
            render json: signup.activity, except: [:created_at, :updated_at], status: :created
        else
            signup_not_processable( signup )
        end
    end

    def update
        signup = Signup.find_by( id: params[:id] )
        # signup.update( signup_params )

        signup[:time] = signup_params[:time]

        if signup.valid?
            signup.save
            render json: signup, status: :ok
        else
            signup_not_processable( signup )
        end
    end

    private 

    def signup_params
        params.require( :signup ).permit( :time, :camper_id, :activity_id )
    end

    def signup_not_processable signup
        render json: { errors: signup.errors.full_messages }, status: :unprocessable_entity
    end
end
