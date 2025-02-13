class Task < ApplicationRecord
  belongs_to :project
  enum :priority, { endeavour: -1, low: 0, medium: 1, high: 2, emergency: 3 }
end
