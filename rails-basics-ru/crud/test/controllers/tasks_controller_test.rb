require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task = Task.create(get_task_attrs)
  end

  test 'should get index' do
    get tasks_url
    assert_response :success
  end

  test 'should get show' do
    get task_url(@task)
    assert_response :success
  end

  test 'should get new' do
    get new_task_url
    assert_response :success
  end

  test 'should create new task' do
    assert_difference('Task.count', 1) do
      post tasks_url, params: { task: get_task_attrs }
    end

    assert_redirected_to task_path(Task.last)
  end

  test 'should update an existed task' do
    new_attrs = get_task_attrs()
    patch task_url(@task), params: { task: new_attrs }

    assert_redirected_to task_path(@task)

    @task.reload
    assert_equal new_attrs[:name], @task.name
    assert_equal new_attrs[:description], @task.description
    assert_equal new_attrs[:creator], @task.creator
    assert_equal new_attrs[:performer], @task.performer
    assert_equal new_attrs[:status], @task.status
    assert_equal new_attrs[:completed], @task.completed
  end

  test 'should delete an existed task' do
    assert_difference('Task.count', -1) do
      delete task_url(@task)
    end

    assert_redirected_to tasks_path
  end
end
