class TasksController < ApplicationController
  layout "admin"
  before_action :authenticate_user!
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_project

  # GET /tasks or /tasks.json
  def index
    @tasks = @current_user.tasks
  end

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    # TODO: Investigate?
    # Seems to be getting sent a task not a project.
    # @task = @project.task.build
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks or /tasks.json
  def create
    @task = @project.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to project_url(@project), notice: "Task was successfully created." }
      else
        format.html { redirect_to project_url(@project), alert: "Task was NOT created: #{@task.errors.full_messages.join(",")}" }
      end
    end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to project_url(@project), notice: "Task was successfully updated." }
      else
        format.html { redirect_to project_url(@project), alert: "Task was NOT updated: #{@task.errors.full_messages.join(",")}" }
      end
    end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to project_url(@project), status: :see_other, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
    end

    def set_project
      @project = current_user.tasks.find(params[:project_id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:name, :due_date, :completed, :completed_at, :priority, :project_id)
    end
end
