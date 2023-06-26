class TaskUsersController < ApplicationController

  def create
    # 記録処理
    task = Task.find(params[:id])
    current_user.done(task)
    redirect_to new_family_record_path
  end

  def destroy
    # 記録削除処理
    task = current_user.task_users.find(params[:id]).task
    if task.user == current_user
      current_user.cancel(task)
      redirect_to family_records_path
    else
      flash.now[:danger] = '削除権限がありません'
    end
  end
end
