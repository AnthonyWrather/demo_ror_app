class Task < ApplicationRecord
  # acts_as_tenant :organisation
  belongs_to :project, touch: true
  has_many :noticed_events, as: :record, dependent: :destroy, class_name: "Noticed::Event"
  has_many :notifications, through: :noticed_events, class_name: "Noticed::Notification"
  validates :name, :due_date, presence: true
  validates :due_date, comparison: { greater_than_or_equal_to: Date.current }
  validates :name, uniqueness: { case_sensitive: false, scope: :project_id }
  enum :priority, { endeavour: -1, low: 0, medium: 1, high: 2, emergency: 3 }
  before_update :update_completed_at
  # TODO: Find out what I have missed with notifications?
  # after_update :notify_urgent_tasks

  scope :incomplete_first, -> { order(completed_at: :desc) }
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where("due_date > ? AND completed = ?", Date.current, false) }
  scope :expired, -> { where("due_date < ? AND completed = ?", Date.current, false) }
  scope :urgent, -> { where(due_date: (Time.current..24.hours.from_now)).where(completed: false) }

  def notify_urgent_tasks
    UrgentTaskJob.perform_later
  end

  def expired?
    due_date < Date.current && !completed
  end

  def urgent?
    (Time.current..24.hours.from_now).cover?(due_date) && !completed
  end

  def due_date_is_not_in_past
    if due_date.present? && due_date < Date.current
      errors.add(:due_date, "The Due Date can not be in the past.")
    end
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
