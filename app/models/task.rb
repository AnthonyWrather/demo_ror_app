class Task < ApplicationRecord
  belongs_to :project
  validates :name, :due_date, presence: true
  validates :due_date, comparison: { greater_than_or_equal_to: Date.current }
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  enum :priority, { endeavour: -1, low: 0, medium: 1, high: 2, emergency: 3 }
  before_update :update_completed_at

  scope :incomplete_first, -> { order(completed_at: :desc) }
  scope :completed, -> { where(completed: true) }

  def expired?
    due_date < Date.current && !completed
  end

  def update_completed_at
    self.completed_at = if completed?
      Time.current
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "completed", "completed_at", "created_at", "due_date", "id", "id_value", "name", "priority", "project_id", "updated_at" ]
  end
end
