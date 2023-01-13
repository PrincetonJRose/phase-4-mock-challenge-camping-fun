class ActivitiesController < ApplicationController

    def index
        render json: Activity.all, except: [:created_at, :updated_at], status: :ok
    end

    def destroy
        activity = Activity.find_by( id: params[:id] )
        if activity
            # activity.signups.destroy_all
            activity.destroy
            # head :no_content
            render json: { messages: ["Activity #{activity.id} was deleted."] }, status: 418
        else
            render json: { errors: ['Activity not found.'] }, status: 404
        end
    end
end
