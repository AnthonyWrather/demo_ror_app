class ProjectsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  def index
    @projects = Project.all
  end

  def create
    #
  end
end
