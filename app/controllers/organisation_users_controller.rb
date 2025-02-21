class OrganisationUsersController < ApplicationController
  layout "admin"
  before_action :authenticate_user!

  # TODO: Investigate why current_tenant is not set?
  def index
    # @users = [ current_user ] #  current_tenant.users
    # current_tenant ? current_tenant.users : current_user
    # current_user.owned_organisation.subdomain
    #    @users = [ (current_tenant ? current_tenant.users : (User.all)) ] #  current_tenant.users
    # TODO: Figure out why?
    # @users = current_tenant.users
    # current_user.id
    # @users = User.all
    @org_id = current_user.organisation_id? ? current_user.organisation_id : current_user.owned_organisation.id
    @users = User.where(organisation_id: @org_id).or(User.where(owned_organisation: @org_id))
  end

  def change_role
    # TODO: Figure out why?
    # @user = current_tenant.users.find(params[:id])
    # User.find(params[:id]).add_role(params[:role])
    @user = User.find(params[:id])
    # binding.pry

    if @user.roles.any?
      found = false
      roles = @user.roles.map(&:name)
      roles.each do |role|
        if role.eql? params[:role]
          @user.remove_role(params[:role])
          found = true
        end
      end
      if !found
        @user.add_role(params[:role])
      end
    else
      @user.add_role(params[:role])
    end

    redirect_to organisation_users_path, notice: "The Role has been updated."
  end
end
