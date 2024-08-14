class TasksController < ApplicationController
  def index
    @travel_plan = TravelPlan.find(params[:travel_plan_id])
    @tasks = @travel_plan.tasks
  end

  def new
    @travel_plan = TravelPlan.find(params[:travel_plan_id])
    @task = @travel_plan.tasks.build
  end

  def create
    @travel_plan = TravelPlan.find(params[:travel_plan_id])
    @task = @travel_plan.tasks.build(task_params)
    @task.user = current_user
    if @task.save
      redirect_to travel_plan_tasks_path(@travel_plan)
    else
      render :new
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :body, :status, :baggage, :due)
  end
end
