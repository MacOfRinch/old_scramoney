class TaskUsersController < ApplicationController

  def create
    task = Task.find(params[:id])
    current_user.done(task)
    redirect_to new_family_record_path
  end

  def destroy
    task = current_user.task_users.find(params[:id]).task
    current_user.cancel(task)
    redirect_to family_records_path
  end
end
