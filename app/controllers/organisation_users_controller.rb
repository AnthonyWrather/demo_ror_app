class OrganisationUsersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!

  # TODO: Investigate why current_tenant is not set?
  def index
    # @users = [ current_user ] #  current_tenant.users
    # current_tenant ? current_tenant.users : current_user
    # current_user.owned_organisation.subdomain
    #    @users = [ (current_tenant ? current_tenant.users : (User.all)) ] #  current_tenant.users
    @users = User.all
    # TODO: Figure out why?
    # @users = current_tenant.users
  end

  def change_role
    #
  end
end
