class Admin::TasksController < Admin::BaseController
  before_action :check_admin
  layout 'admin/layouts/application'

  def index
    @travel_plan = TravelPlan.find(params[:travel_plan_id])
    @tasks = @travel_plan.tasks.page(params[:page]).per(15)
  end

  def create
    @template = TravelPlan.find(params[:travel_plan_id]) # 関連するテンプレートを取得
    @task = @template.tasks.build(task_params)
  
    if @task.save
      redirect_to admin_template_path(@template), notice: 'タスクが追加されました。'
    else
      @tasks = @template.tasks.page(params[:page]).per(15) # ページネーションに必要
      render :show
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:notice] = "タスクが正常に削除されました。"
    redirect_to admin_template_path(params[:template_id])
  end
  
  private
  
  def task_params
    params.require(:task).permit(:title, :body, :status, :baggage)
  end
end
