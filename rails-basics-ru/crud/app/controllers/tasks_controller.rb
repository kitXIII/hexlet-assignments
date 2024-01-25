class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params.except %i[status, completed])

    if @task.save
      flash[:success] = 'New task was successfully created'
      redirect_to task_path(@task)
    else
      flash[:failure] = 'Task cannot be created'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task was successfully updated'
      redirect_to task_path(@task)
    else
      flash[:failure] = 'Task cannot be updated'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])

    if @task.destroy
      flash[:success] = 'Task was successfully deleted'
      redirect_to tasks_path
    else
      flash[:failure] = 'Task cannot be deleted'
      render task_path(@task)
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :creator, :performer, :status, :completed)
  end
end
