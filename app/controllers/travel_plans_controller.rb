class TravelPlansController < ApplicationController
  def index
    @travel_plans = TravelPlan.all
  end

  def new
    @travel_plan = TravelPlan.new
  end

  def create
    @travel_plan = current_user.travel_plans.build(travel_plan_params)
    if @travel_plan.save
      redirect_to travel_plans_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def travel_plan_params
    params.require(:travel_plan).permit(:title, :country, :note, :due)
  end
end
