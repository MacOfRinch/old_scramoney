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
    @categories = Category.where(family_id: @family.id).or(Category.where(family_id: nil))
    @tasks = Task.where(family_id: @family.id).or(Task.where(family_id: nil))
  end

  def show

  end

  def edit
    @task = Task.find(params[:id])
    @categories = Category.where(family_id: @family.id).or(Category.where(family_id: nil))
  end

  def update
    @task = Task.find(params[:id])
    @task.update!(task_params)
    redirect_to family_configuration_path(@family)
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
