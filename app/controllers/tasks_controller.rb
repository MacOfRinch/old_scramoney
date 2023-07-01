class TasksController < ApplicationController
  def new
    @categories = Category.where(family_id: @family.id).or(Category.where(family_id: nil))
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.family_id = @family.id
    if @task.save
      redirect_to new_family_task_path(@family), success: 'タスクが登録されました'
    else
      flash.now[:danger] = '登録できひんでした'
      render :new, status: :unprocessable_entity
    end
  end

  def index
    # 家族ごとにする必要あり
    @categories = Category.where(family_id: @family.id).or(family_id: nil)
    @tasks = Task.where(family_id: @family.id)
  end

  def show

  end

  def edit
  end

  def update
  end

  def destroy
    task = Task.find(params[:id])
    if task.user == current_user
      task.destroy!
      redirect_to family_tasks_path, success: '削除しました', status: :see_other
    else
      flash.now[:danger] = '削除権限がありません'
      render :show
    end
  end

  def menu; end

  private

  def task_params
    params.require(:task).permit(:title, :description, :points, :category_id)
  end
end
