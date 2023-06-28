class RecordsController < ApplicationController
  def index
    # ほんとはallじゃなくてwhereで月ごとに変える
    @tasks = TaskUser.all.order(created_at: :desc)
  end

  def new
    # 家族ごとに設定するようにする必要あり→FamilyにTaskを紐づけるべきか？
    @categories = Category.all
    @tasks = Task.all
  end

  def create

  end

  # タスク記録用コントローラ
  def task_show
    @task = Task.find(params[:id])
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
