class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # set_current_tenant_by_subdomain(:organisation, :subdomain)
  # TODO: Setting this manually for now.
  set_current_tenant_through_filter
  before_action :find_the_current_tenant
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pagy::Backend

  protected

  def find_the_current_tenant
    current_account = current_user
    set_current_tenant(current_account)
  end

  def after_sign_in_path_for(resource)
    if resource.organisation_owner?
      dashboard_index_url(subdomain: resource.owned_organisation.subdomain)
    else
      dashboard_index_url(subdomain: resource.organisation.subdomain)
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :full_name, owned_organisation_attributes: [ :name, :subdomain ] ])
  end
end
