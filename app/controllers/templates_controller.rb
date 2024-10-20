class TemplatesController < ApplicationController
  before_action :set_template, only: [ :show, :create_travel_plan, :add_task, :destroy ]

  def create
    @template = TravelPlan.new(template_params)
    @template.user = current_user
    @template.public = true # 公開テンプレートとして作成する

    if @template.save
      redirect_to @template, notice: "公開テンプレートが作成されました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # テンプレート一覧の表示
  def index
    # 公開テンプレート（全ユーザーに見えるテンプレート）
    @public_templates = TravelPlan.public_templates

    # ユーザー専用テンプレート
    @user_templates = TravelPlan.user_templates(current_user)
  end

  # テンプレートの詳細表示
  def show
    # @templateはbefore_actionで設定済み
    @tasks = @template.tasks
    @travel_plan = @template # または適切なアソシエーションの設定
    @q = Task.ransack(params[:q]) # 例: 検索クエリの設定
  end

  # テンプレートから新しい旅行プランを作成
  def create_travel_plan
    # @templateはbefore_actionで設定済み

    # テンプレートを複製して新しい旅行プランを作成
    new_plan = @template.dup
    new_plan.is_template = false
    new_plan.user = current_user

    if new_plan.save
      # テンプレートのタスクを新しいプランにコピー
      @template.tasks.each do |task|
        new_plan.tasks.create(
          title: task.title,
          body: task.body,
          status: task.status,
          baggage: task.baggage,
          user: current_user
        )
      end
      redirect_to edit_travel_plan_path(new_plan), notice: "テンプレートから旅行プランを作成しました"
    else
      redirect_to @template, alert: "旅行プランの作成に失敗しました"
    end
  end

  def add_task
    @task = @template.tasks.new(task_params)

    if @task.save
      redirect_to template_path(@template), notice: 'タスクが追加されました。'
    else
      redirect_to template_path(@template), alert: 'タスクの追加に失敗しました。'
    end
  end

  def destroy
    @template = TravelPlan.find(params[:id])
    
    if @template.user == current_user
      if @template.destroy
        flash[:notice] = "テンプレートを削除しました"
      else
        flash[:alert] = "テンプレートの削除に失敗しました"
      end
    else
      flash[:alert] = "このテンプレートを削除する権限がありません"
    end
    
    redirect_to templates_path
  end

  private

  # テンプレートをセットするメソッド
  def set_template
    @template = TravelPlan.templates.find_by(id: params[:id])
    unless @template
      redirect_to templates_path, alert: "テンプレートが見つかりませんでした"
    end
  end

  def task_params
    params.require(:task).permit(:title, :body, :status, :baggage, :due)
  end
end
