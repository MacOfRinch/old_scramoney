class FamiliesController < ApplicationController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :set_family, only: %i[new create]
  after_action :initialize_categories_and_tasks, only: :create

  def new
    @family = Family.new
    @family.budget = 50000
  end

  def create
    @family = Family.new(family_params)

    if @family.save
      redirect_to new_family_user_path(@family), success: '家族を登録しました'
    else
      falsh.now[:danger] = '家族の登録に失敗しました'
      render :new
    end
  end

  def show
    users = @family.users
    @each_name_points = each_name_points(users)
    @each_pocket_money = each_pocket_money(users)
  end

  def configuration; end

  def edit; end

  def update
    if @family.update(family_params)
      redirect_to family_path, success: '正常に更新されました'
    else
      flash.now[:danger] = '正常に更新できませんでした'
      render :edit
    end
  end

  # 不要かも　後で消すかも
  def modify_budget; end

  def invitation
    @invitation_code = current_user.family_id
  end

  private

  def family_params
    params.require(:family).permit(:name, :nickname, :avatar, :budget)
  end

  def each_name_points(users)
    result = []
    users.each do |user|
      array = nil
      array = ["#{display_name(user)}:#{user.sum_points}pt (#{user.percent}%)", user.sum_points]
      result << array
    end
    result
  end

  def each_pocket_money(users)
    result = []
    users.each do |user|
      array = nil
      array = ["#{display_name(user)}:#{user.calculate_pocket_money}円", user.calculate_pocket_money]
      result << array
    end
    result
  end

  def initialize_categories_and_tasks
    default_categories = Category.where(family_id: 0)
    default_tasks = Task.where(family_id: 0)

    default_categories.each do |category|
      category.update(family_id: @family.id)
    end

    default_tasks.each do |task|
      task.update(family_id: @family.id)
    end
  end
end
