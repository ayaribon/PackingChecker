class TravelPlan < ApplicationRecord
  belongs_to :user, optional: -> { !public? }
  has_many :tasks, dependent: :destroy

  validates :title, presence: true

  def self.create_from_template(template_id)
    template = find(template_id)

    # 新しい旅行プランをテンプレートから作成
    new_plan = create(
      title: "#{template.title}のコピー",
      user_id: template.user_id,
      is_template: false
    )

    # テンプレートのタスクを新しいプランにコピー
    template.tasks.each do |task|
      new_plan.tasks.create(
        title: task.title,
        body: task.body,
        status: task.status, # 状態をリセットする場合は別途設定
        baggage: task.baggage,
        due: task.due
      )
    end

    new_plan
  end

  # テンプレートだけを取得するスコープ
  scope :templates, -> { where(is_template: true) }

  # 公開テンプレートを取得するスコープ（ユーザーがnilの場合）
  scope :public_templates, -> { where(is_template: true, user_id: nil, public: true) }

  # ユーザー専用テンプレートを取得するスコープ
  scope :user_templates, ->(user) { where(is_template: true, user_id: user.id) }
end
