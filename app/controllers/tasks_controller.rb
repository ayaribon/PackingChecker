class TasksController < ApplicationController
  def index
    @travel_plan = TravelPlan.find(params[:travel_plan_id])
    @tasks = @travel_plan.tasks
  end
end
