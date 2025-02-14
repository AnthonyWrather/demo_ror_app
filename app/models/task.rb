class Task < ApplicationRecord
  belongs_to :project
  enum :priority, { endeavour: -1, low: 0, medium: 1, high: 2, emergency: 3 }
  before_update :update_completed_at_before
  # after_update :update_completed_at_after

  def update_completed_at_before
    self.completed_at = if completed?
      Time.current
    end
  end

  # Not the recommended way of doing things.
  # Can cause recursive loops.
  # def update_completed_at_after
  #   if completed?
  #     update_column(:completed_at, Time.current)
  #   else
  #     update_column(:completed_at, nil)
  #   end
  # end
end
