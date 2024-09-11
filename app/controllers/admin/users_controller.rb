class Admin::UsersController < Admin::BaseController
  before_action :check_admin
  layout 'admin/layouts/application'

  def index
    @users = User.order(created_at: :asc).page(params[:page]).per(20)
  end
end
