require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = tasks(:one)
  end

  test "Unauthenticated users should get redirected." do
    get project_task_path(1, 1)
    assert_response :redirect
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_match "You need to sign in or sign up", response.body
  end

  # test "should get index" do
  #   get tasks_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_task_url
  #   assert_response :success
  # end

  # test "should create task" do
  #   assert_difference("Task.count") do
  #     post tasks_url, params: { task: { completed_at: @task.completed_at, due_date: @task.due_date, name: @task.name, priority: @task.priority, project_id: @task.project_id } }
  #   end

  #   assert_redirected_to task_url(Task.last)
  # end

  # test "should show task" do
  #   get task_url(@task)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_task_url(@task)
  #   assert_response :success
  # end

  # test "should update task" do
  #   patch task_url(@task), params: { task: { completed_at: @task.completed_at, due_date: @task.due_date, name: @task.name, priority: @task.priority, project_id: @task.project_id } }
  #   assert_redirected_to task_url(@task)
  # end

  # test "should destroy task" do
  #   assert_difference("Task.count", -1) do
  #     delete task_url(@task)
  #   end

  #   assert_redirected_to tasks_url
  # end
end
