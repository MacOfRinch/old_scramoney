class RecordsController < ApplicationController

  include UsersHelper

  def index
    @tasks = TaskUser.this_month.order(created_at: :desc)
    @tasks_of_last_month = TaskUser.last_month.order(created_at: :desc)
  end

  def new
    @categories = Category.where(family_id: @family.id).or(Category.where(family_id: nil))
    @tasks = Task.where(family_id: @family.id).or(Task.where(family_id: nil))
  end

  def create

  end

  # タスク記録用コントローラ
  def task_show
    @task = Task.find(params[:id])
    @task_user = TaskUser.new
  end

  def show
    @task = TaskUser.find(params[:id])
    @user = @task.user
  end

  def edit
  end

  def update
  end
end
