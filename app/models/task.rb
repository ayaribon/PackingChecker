class Task < ApplicationRecord
  extend Enumerize
  enumerize :status, in: %i[pending working done]
  enumerize :baggage, in: %i[carry leave]

  validates :body, length: { maximum: 30 }
  validates :title, presence: true

  belongs_to :travel_plan
  belongs_to :user, optional: -> { !public? }

  def self.ransackable_attributes(auth_object = nil)
    [ "baggage", "body", "created_at", "due", "id", "status", "title", "travel_plan_id", "updated_at", "user_id" ]
  end

  def self.create_task_for_template(title, body, due, travel_plan_id, is_public = false, user = nil)
    travel_plan = TravelPlan.find(travel_plan_id)

    task_attributes = {
      title: title,
      body: body,
      due: due,
      travel_plan_id: travel_plan_id,
      public: is_public
    }

    task_attributes[:user_id] = is_public ? nil : user.id

    Task.create(task_attributes)
  end

  scope :templates, -> { where(is_template: true) }
end
