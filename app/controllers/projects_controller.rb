class ProjectsController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :set_project, only: [ :edit, :update, :destroy, :show ]
  def index
    @pagy, @projects = pagy(current_user.projects.includes(:tasks), limit: 10)
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      redirect_to projects_url, notice: "Project created."
    else
      redirect_to projects_url, alert: "Project NOT created: #{@project.errors.full_messages.join(",")}"
    end
  end

  def show
    @q = @project.tasks.ransack(params[:q])
    @pagy, @tasks = pagy(@q.result.incomplete_first, limit: 10)
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
    @project = current_user.projects.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name)
  end
end
