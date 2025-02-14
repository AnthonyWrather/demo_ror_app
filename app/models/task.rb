class Task < ApplicationRecord
  belongs_to :project
  validates :name, :due_date, presence: true
  validate :due_date_is_not_in_past
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  enum :priority, { endeavour: -1, low: 0, medium: 1, high: 2, emergency: 3 }
  before_update :update_completed_at_before

  scope :incomplete_first, -> { order(completed_at: :desc) }

  def due_date_is_not_in_past
    if due_date.present? && due_date < Date.today
      errors.add(:due_date, "The Due Date can not be in the past.")
    end
  end

  def update_completed_at_before
    self.completed_at = if completed?
      Time.current
    end
  end
end
