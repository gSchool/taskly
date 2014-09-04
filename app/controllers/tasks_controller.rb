class TasksController < ApplicationController
  def new
    @task = Task.new
    @users = User.all
  end

  def create
    @task = Task.new(allowed_params)
    @task.task_list = TaskList.find(params[:task_list_id])

    if @task.save
      flash[:notice] = "Task was created successfully"
      redirect_to root_path
    else
      @users = User.all
      render :new
    end
  end

  def destroy
    Task.find(params[:id]).destroy
    flash[:notice] = "Task was deleted successfully"
    redirect_to root_path
  end

  def complete
    Task.find(params[:id]).toggle!(:complete)
    flash[:notice] = "Task was completed successfully"
    redirect_to root_path
  end

  private

  def allowed_params
    params.require(:task).permit(:description, :due_date, :assigned_to_id)
  end
end