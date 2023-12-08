# frozen_string_literal: true

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
    @category = @task.category
  end

  def edit
    @categories = Category.where(family_id: @family.id)
  end

  def update
    @category = @task.category
    if @task.update(task_params)
      @family.users.each do |user|
        user.update_column(:points, user.calculate_points)
        user.update_column(:pocket_money, user.calculate_pocket_money)
      end
      redirect_to family_category_path(@family, @category), success: 'タスク情報が更新されました'
    else
      flash.now[:danger] = '入力内容に誤りがあります'
      render :edit, :unprocessable_entity
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task
      records = TaskUser.where(task_id: task.id)
      if records.present?
        records.each do |record|
          record.user.update_column(:points, record.user.points - record.task.points * record.count)
          record.destroy!
        end
      end
      task.destroy!
      @family.users.each { |user| user.update_column(:pocket_money, user.calculate_pocket_money) }
      redirect_to family_categories_path(@family), success: 'タスクを削除しました', status: :see_other
    else
      flash.now[:danger] = '無効な操作です'
      render :index, :unprocessable_entity
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
