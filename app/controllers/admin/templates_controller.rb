class Admin::TemplatesController < Admin::BaseController
  before_action :check_admin
  layout 'admin/layouts/application'

  # テンプレート一覧
  def index
    @templates = TravelPlan.where(is_template: true, public: true).page(params[:page]).per(10)
  end

  # テンプレートの詳細ページ（タスク一覧表示含む）
  def show
    @template = TravelPlan.find_by(id: params[:id], is_template: true, public: true)
    @tasks = @template.tasks.page(params[:page]).per(15)
  end

  # 新しいテンプレートを作成するページ
  def new
    @template = TravelPlan.new
  end

  # テンプレート作成処理
  def create
    @template = TravelPlan.new(template_params)
    @template.is_template = true  # テンプレートフラグを設定

    if @template.save
      redirect_to admin_templates_path, notice: "テンプレートが作成されました"
    else
      render :new, alert: "テンプレートの作成に失敗しました"
    end
  end

  def add_task
    @template = TravelPlan.find(params[:id])
  
    if params[:task][:id].present?
      # 既存タスクの更新
      @task = @template.tasks.find(params[:task][:id])
      if @task.update(task_params)
        redirect_to admin_template_path(@template), notice: "タスクが更新されました"
      else
        render :show, alert: "タスクの更新に失敗しました"
      end
    else
      # 新規タスクの作成
      @task = @template.tasks.build(task_params)
      if @task.save
        redirect_to admin_template_path(@template), notice: "タスクが追加されました"
      else
        render :show, alert: "タスクの作成に失敗しました"
      end
    end
  end

  private

  # テンプレートに関連するパラメータ
  def template_params
    params.require(:travel_plan).permit(:title, :country, :note, :due, :public)
  end

  # タスクに関連するパラメータ
  def task_params
    params.require(:task).permit(:title, :body, :status, :baggage)
  end
end

