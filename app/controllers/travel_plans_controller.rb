class TravelPlansController < ApplicationController
  def index
    @travel_plans = current_user.travel_plans
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

  def edit
    @travel_plan = current_user.travel_plans.find(params[:id])
  end

  def update
    @travel_plan = current_user.travel_plans.find(params[:id])
    if @travel_plan.update(travel_plan_params)
      redirect_to travel_plans_path(@travel_plan)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    travel_plan = current_user.travel_plans.find(params[:id])
    travel_plan.destroy!
    redirect_to travel_plans_path
  end

  private

  def travel_plan_params
    params.require(:travel_plan).permit(:title, :country, :note, :due)
  end
end
