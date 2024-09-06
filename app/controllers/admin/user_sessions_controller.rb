class Admin::UserSessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]
  layout 'layouts/admin_login'

  def new
    # 新しいセッション（ログインフォーム）の表示
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to admin_root_path, success: t("user_sessions.create.success")
    else
      flash.now[:danger] = t("user_sessions.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, status: :see_other, success: t("user_sessions.destroy.success")
  end
end
