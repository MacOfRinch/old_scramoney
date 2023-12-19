# frozen_string_literal: true

class RecordsController < ApplicationController
  include UsersHelper

  # 履歴だよ。
  def index
    @records = TaskUser.where(family_id: @family.id).this_month.order(created_at: :desc)
    @records_of_last_month = TaskUser.where(family_id: @family.id).last_month.order(created_at: :desc)
  end

  def new
    @categories = Category.where(family_id: @family.id)
    @tasks = Task.where(family_id: @family.id)
  end

  def create
    # 一括記録処理だよ。
    tasks_params = params[:task_user][:tasks]
    tasks_params.each do |task_id, task_data|
      id = task_id.to_i
      count = task_data[:count].to_i
      task = Task.find(id)
      TaskUser.create!(task_id: id, user_id: current_user.id, family_id: @family.id, count: count) if count > 0
      current_user.update_column(:points, (current_user.points + task.points * count))
    end
    @family.users.each do |user|
      user.update_column(:pocket_money, user.calculate_pocket_money)
    end
    redirect_to new_family_record_path(@family), success: 'タスクを記録しました！'
  end

  # カテゴリ一覧から飛べるタスク一覧ページのコントローラだよ。
  def task_index
    @category = Category.find(params[:id])
    @record = TaskUser.new
  end

  def increment
    @task = Task.find(params[:id])
    @record = TaskUser.new
    @record.increment!(:count)
    render turbo_frame: @task, partial: 'records/task_for_record', locals: { task: @task, record: @record }
  end

  private

  def task_user_params
    params.require(:task_user).permit(task_users_attributes: [:task_id, :count])
  end
end
