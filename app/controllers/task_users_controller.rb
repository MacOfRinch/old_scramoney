# frozen_string_literal: true

class TaskUsersController < ApplicationController
  def create
    # 記録処理
    task = Task.find_by(id: params[:id])
    if task
      TaskUser.create!(task_id: task.id, user_id: current_user.id, family_id: @family.id,
                       count: params[:task_user][:count].to_i)
      current_user.update(pocket_money: current_user.calculate_pocket_money)
      redirect_to new_family_record_path, success: 'タスクが記録されました'
    else
      redirect_to new_family_record_path, danger: '無効な操作です'
    end
  end

  def destroy
    # 記録削除処理
    task = TaskUser.find_by(id: params[:id])
    if task && task.user == current_user
      current_user.cancel(task)
      current_user.update(pocket_money: current_user.calculate_pocket_money)
      redirect_to family_records_path, success: '記録を削除しました', status: :see_other
    else
      redirect_to family_records_path, danger: '無効な操作です'
    end
  end
end
