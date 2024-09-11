class Admin::TravelPlansController < Admin::BaseController
  before_action :check_admin
  layout 'admin/layouts/application'

  def index
    @user = User.find(params[:user_id])
    @travel_plans = @user.travel_plans.where(is_template: false).order(created_at: :desc).page(params[:page]).per(10)
  end
end
