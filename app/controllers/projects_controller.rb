class ProjectsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :set_project, only: [ :edit, :update, :destroy ]
  def index
    @projects = Project.all
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to projects_url, notice: "Project created."
    else
      redirect_to projects_url, alert: "Project NOT created: #{@project.errors.full_messages.join(",")}"
    end
  end

  def edit
  end

  def update
    @project.update(project_params)
    if @project.save
      redirect_to projects_url, notice: "Project updated."
    else
      redirect_to projects_url, alert: "Project NOT updated: #{@project.errors.full_messages.join(",")}"
    end
  end

  def destroy
    @project.destroy!
    redirect_to projects_url, notice: "Project deleted."
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
