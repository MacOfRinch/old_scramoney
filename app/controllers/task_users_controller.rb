class TaskUsersController < ApplicationController

  def create
    # 記録処理
    task = Task.find(params[:id])
    TaskUser.create!(task_id: task.id, user_id: current_user.id, count: params[:task_user][:count].to_i)
    current_user.update(pocket_money: current_user.calculate_pocket_money)
    redirect_to new_family_record_path
  end

  def destroy
    # 記録削除処理
    task = TaskUser.find(params[:id])
    if task.user == current_user
      current_user.cancel(task)
      current_user.update(pocket_money: current_user.calculate_pocket_money)
      redirect_to family_records_path, success: 'タスクを削除しました', status: :see_other
    else
      flash.now[:danger] = '削除権限がありません'
    end
  end

  private

  def record_params
    params.require(:task_user).permit(:task_id, :user_id, :count)
  end
end
