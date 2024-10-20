class Admin::PackingTipsController < Admin::BaseController
  before_action :set_packing_tip, only: [:edit, :update, :destroy]

  def index
    @packing_tips = PackingTip.all
  end

  def new
    @packing_tip = PackingTip.new
  end

  def create
    @packing_tip = PackingTip.new(packing_tip_params)
    if @packing_tip.save
      redirect_to admin_packing_tips_path, notice: '荷造りのコツを作成しました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @packing_tip.update(packing_tip_params)
      redirect_to admin_packing_tips_path, notice: '荷造りのコツを更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @packing_tip.destroy
    redirect_to admin_packing_tips_path, notice: '荷造りのコツを削除しました。'
  end

  private

  def set_packing_tip
    @packing_tip = PackingTip.find(params[:id])
  end

  def packing_tip_params
    params.require(:packing_tip).permit(:title, :body, :image)
  end
end
