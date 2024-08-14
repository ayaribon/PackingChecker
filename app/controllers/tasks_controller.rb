class TasksController < ApplicationController
  before_action :set_travel_plan
  def index
    @q = @travel_plan.tasks.ransack(params[:q])
    @tasks = @q.result.page(params[:page]).order('created_at desc').per(10)
  end
  
  def new
    @task = @travel_plan.tasks.build
  end

  def create
    @task = @travel_plan.tasks.build(task_params)
    @task.user = current_user
    if @task.save
      redirect_to travel_plan_tasks_path(@travel_plan), success: t('tasks.create.success')
    else
      flash.now[:danger] = t('tasks.create.failure')
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = @travel_plan.tasks.find(params[:id])
  end

  def update
    @task = @travel_plan.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to travel_plan_tasks_path(@travel_plan), success: t('tasks.update.success')
    else
      flash.now[:danger] = t('tasks.update.failure')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    task = @travel_plan.tasks.find(params[:id])
    task.destroy!
    redirect_to travel_plan_tasks_path, success: t('travel_plans.destroy.success')
  end

  private

  def task_params
    params.require(:task).permit(:title, :body, :status, :baggage, :due)
  end

  def set_travel_plan
    @travel_plan = current_user.travel_plans.find(params[:travel_plan_id])
  end
end
