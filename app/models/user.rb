class User < ApplicationRecord
  ROLES = [ :product_owner, :team_leader, :team_member ]
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable # , request_keys: [:subdomain]
  has_one  :owned_organisation, class_name: "Organisation", foreign_key: :owner_id, inverse_of: :owner, dependent: :destroy
  has_many :projects
  has_many :tasks, through: :projects
  has_many :teams, through: :team_members
  belongs_to :organisation, optional: true
  has_many :notifications, as: :recipient, dependent: :destroy, class_name: "Noticed::Notification"
  accepts_nested_attributes_for :owned_organisation, reject_if: :all_blank
  before_create :set_organisation, if: :created_by_invite?
  after_create :assign_default_role

  def organisation_owner?
    owned_organisation.present?
  end

  def set_organisation
    self.organisation_id = invited_by.owned_organisation.id
  end

  def assign_default_role
    self.add_role(:team_member) if self.roles.blank?
  end
end
