class TravelPlan < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy

  validates :title, presence: true

  has_many :tasks

  def self.create_from_template(template_id)
    template = find(template_id)

    # 新しいtravel_planをテンプレートから作成
    new_plan = create(
      title: "#{template.title}のコピー",
      user_id: template.user_id, # 必要であればユーザーを設定
      is_template: false # テンプレートではなく通常のプランとして作成
    )

    # テンプレートのtasksをコピー
    template.tasks.each do |task|
      new_plan.tasks.create(
        title: task.title,
        body: task.body,
        due: task.due,
        status: task.status,
        baggage: task.baggage,
        user_id: task.user_id, # 必要であればユーザーを設定
        is_template: false
      )
    end

    new_plan
  end 
end
