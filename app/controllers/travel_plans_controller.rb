class TravelPlansController < ApplicationController
  def index
    @travel_plans = TravelPlan.where(user_id: current_user.id).includes(:user).order("created_at DESC").page(params[:page]).per(9)
  end

  def new
    @travel_plan = TravelPlan.new
  end

  def create
    @travel_plan = current_user.travel_plans.build(travel_plan_params)
    if @travel_plan.save
      redirect_to travel_plans_path, success: t('travel_plans.create.success')
    else
      flash.now[:danger] = t('travel_plans.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @travel_plan = current_user.travel_plans.find(params[:id])
  end

  def update
    @travel_plan = current_user.travel_plans.find(params[:id])
    if @travel_plan.update(travel_plan_params)
      redirect_to travel_plans_path(@travel_plan), success: t('travel_plans.update.success')
    else
      flash.now[:danger] = t('travel_plans.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    travel_plan = current_user.travel_plans.find(params[:id])
    travel_plan.destroy!
    redirect_to travel_plans_path, success: t('travel_plans.destroy.success')
  end

  private

  def travel_plan_params
    params.require(:travel_plan).permit(:title, :country, :note, :due)
  end
end
