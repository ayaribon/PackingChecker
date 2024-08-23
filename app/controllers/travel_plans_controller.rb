class TravelPlansController < ApplicationController
  before_action :set_template, only: [ :new, :create ]

  def index
    @travel_plans = TravelPlan.where(user_id: current_user.id).includes(:user).order("created_at DESC").page(params[:page]).per(9)
  end

  def new
    @travel_plan = @template ? @template.dup : TravelPlan.new
  end

  def create
    @travel_plan = @template ? @template.dup : TravelPlan.new(travel_plan_params)
    @travel_plan.user = current_user # Ensure the current user is associated with the new travel plan

    if @travel_plan.save
      if @template
        @template.tasks.each do |task|
          @travel_plan.tasks.create(task.attributes.except("id", "created_at", "updated_at"))
        end
      end
      redirect_to travel_plan_tasks_path(@travel_plan), success: t("travel_plans.create.success")
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
      redirect_to travel_plans_path(@travel_plan), success: t("travel_plans.update.success")
    else
      flash.now[:danger] = t("travel_plans.update.failure")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    travel_plan = current_user.travel_plans.find(params[:id])
    travel_plan.destroy!
    redirect_to travel_plans_path, success: t("travel_plans.destroy.success")
  end

  def choose_template_or_create; end

  def complete
    @travel_plan = TravelPlan.find(params[:id])
    redirect_to summary_travel_plan_path(@travel_plan), notice: "荷造りが完了しました"
  end

  def add_to_template
    @travel_plan = TravelPlan.find(params[:id])

    # 新しいテンプレートを作成
    template = TravelPlan.new(
      title: params[:template_title] || @travel_plan.title,
      user: current_user,
      is_template: true
    )

    if template.save
      @travel_plan.tasks.each do |task|
        new_task = template.tasks.create(
          title: task.title,
          body: task.body,
          status: task.status,
          baggage: task.baggage,
          due: task.due,
          is_template: true,
          user: current_user
        )
      end
      redirect_to root_path, notice: "テンプレートに追加しました"
    else
      render :summary, alert: "テンプレートの保存に失敗しました"
    end
  end



  def summary
    @travel_plan = TravelPlan.find(params[:id])
    @tasks = @travel_plan.tasks # ここで関連するタスクを取得
  end

  private

  def travel_plan_params
    params.require(:travel_plan).permit(:title, :country, :note, :due)
  end

  def set_template
    if params[:template_id]
      @template = TravelPlan.find_by(id: params[:template_id])
      redirect_to travel_plans_path, alert: "テンプレートが見つかりませんでした" unless @template
    end
  end
end
