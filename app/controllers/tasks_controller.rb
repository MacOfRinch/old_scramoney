class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update]

  def new
    @categories = Category.where(family_id: @family.id)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.family_id = @family.id
    if @task.save
      redirect_to new_family_task_path(@family), success: 'タスクが登録されました'
    else
      flash.now[:danger] = '登録できませんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @categories = Category.where(family_id: @family.id)
    @tasks = Task.includes(:category).where(family_id: @family.id)
  end

  def show
  end

  def edit
    @categories = Category.where(family_id: @family.id)
  end

  def update
    if @task.update(task_params)
      redirect_to family_tasks_path(@family), success: 'タスク情報が更新されました'
    else
      flash.now[:danger] = '入力内容に誤りがあります'
      render :show
    end
  end

  def destroy
    task = Task.find(params[:id])
    if task.user == current_user
      task.destroy!
      redirect_to family_tasks_path(@family), success: '削除しました', status: :see_other
    else
      flash.now[:danger] = '削除権限がありません'
      render :show
    end
  end

  def menu; end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :points, :category_id)
  end
end
