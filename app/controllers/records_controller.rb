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

  def create; end

  # カテゴリ一覧から飛べるタスク一覧ページのコントローラだよ。
  def task_index
    @tasks = Task.where(category_id: params[:id])
    @category = Category.find(params[:id])
  end

  # タスク記録用コントローラだよ。
  def task_show
    @task = Task.find(params[:id])
    @category = @task.category
    @task_user = TaskUser.new
  end

  def show
    @record = TaskUser.find(params[:id])
    @task = @record.task
    @user = @record.user
  end

  def edit; end

  def update; end
end
