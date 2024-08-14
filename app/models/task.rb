class Task < ApplicationRecord
  extend Enumerize
  enumerize :status, in: %i(pending working done)
  enumerize :baggage, in: %i(carry leave)

  belongs_to :travel_plan
  belongs_to :user
end
