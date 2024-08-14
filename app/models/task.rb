class Task < ApplicationRecord
  extend Enumerize
  enumerize :status, in: %i(pending working done)
  enumerize :baggage, in: %i(carry leave)

  validates :body, length: { maximum: 30 }
  validates :title, presence: true

  belongs_to :travel_plan
  belongs_to :user

  def self.ransackable_attributes(auth_object = nil)
    ["baggage", "body", "created_at", "due", "id", "status", "title", "travel_plan_id", "updated_at", "user_id"]
  end
end
