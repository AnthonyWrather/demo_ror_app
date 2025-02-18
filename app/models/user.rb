class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one  :owned_organisation, class_name: "Organisation", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
  has_many :projects
  has_many :tasks, through: :projects
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  belongs_to :organisation, optional: true
  accepts_nested_attributes_for :owned_organisation, reject_if: :all_blank
  before_create :set_organisation, if: :created_by_invite?

  def set_organisation
    self.organisation_id = invited_by.owned_organisation.id
  end

  def organisation_owner?
    owned_organisation.present?
  end
end
