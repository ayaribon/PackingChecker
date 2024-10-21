class TasksController < ApplicationController
  before_action :set_travel_plan
  
  def create
    if params[:task][:template_id].present?
      template_task = @travel_plan.tasks.find(params[:task][:template_id])
      @task = template_task.dup
      @task.assign_attributes(task_params)
    else
      @task = @travel_plan.tasks.build(task_params)
    end

    @task.user = current_user
    if @task.save
      redirect_to travel_plan_path(@travel_plan), success: t("tasks.create.success")
    else
      flash.now[:danger] = t("tasks.create.failure")
      render 'travel_plans/show', status: :unprocessable_entity
    end
  end

  def destroy
    task = @travel_plan.tasks.find(params[:id])
    task.destroy!
    redirect_to travel_plan_path(@travel_plan), success: t("tasks.destroy.success")
  end

  private

  def task_params
    params.require(:task).permit(:title, :body, :status, :baggage, :due)
  end

  def set_travel_plan
    @travel_plan = current_user.travel_plans.find(params[:travel_plan_id])
  end
end
