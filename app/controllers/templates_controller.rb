class TemplatesController < ApplicationController
  def index
    @templates = TravelPlan.where(is_template: true)
  end

  def show
    @template = TravelPlan.find(params[:id])
    @travel_plan = @template # または適切なアソシエーションの設定
    @q = Task.ransack(params[:q]) # 例: 検索クエリの設定
  end

  def create_travel_plan
    template = TravelPlan.find(params[:id])
    new_plan = TravelPlan.create_from_template(template.id)
    redirect_to edit_travel_plan_path(new_plan), notice: "テンプレートから旅行プランを作成しました"
  end
end
