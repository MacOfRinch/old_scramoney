class FamiliesController < ApplicationController
  skip_before_action :require_login, only: %i[new create invitation]
  skip_before_action :set_family, only: %i[new create invitation]
  # after_action :initialize_categories_and_tasks, only: :create

  def new
    @family = Family.new
    @family.budget = 50000
  end

  def create
    @family = Family.new(family_params)
    @family.update(budget_of_last_month: @family.budget)

    if @family.save
      redirect_to new_family_user_path(@family), success: '家族を登録しました'
    else
      flash.now[:danger] = '家族の登録に失敗しました'
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
    @family.assign_attributes(family_params)
    if @family.valid?
      approval_request = ApprovalRequest.create(family_id: @family.id, user_id: current_user.id)
      send_approval_request(approval_request)
      # 一時的に変更後のデータを保存するよ。
      TemporaryFamilyDatum.create!(approval_request_id: approval_request.id, name: @family.name, nickname: @family.nickname, avatar: @family.avatar, budget: @family.budget)
      redirect_to family_path(@family), success: 'プロフィール編集の承認依頼を送りました'
    else
      flash.now[:danger] = '入力内容に誤りがあります'
      render :edit, status: :unprocessable_entity
    end
  end

  # 不要かも　後で消すかも
  def modify_budget; end

  def invitation
    if logged_in?
      @family = current_user.family
      @invitation_code = current_user.family_id
    else
      # URLに書かれてるfamily_idを招待コードとして取得しておくよ。
      @invitation_code = params[:family_id]
    end
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
      array = ["#{display_name(user)}:#{user.calculate_pocket_money.to_s(:delimited)}円", user.calculate_pocket_money]
      result << array
    end
    result
  end

  # 旧き時代の残滓。一応残しておくよ。
  # def initialize_categories_and_tasks
    # default_categories = Category.where(family_id: 0)
    # default_tasks = Task.where(family_id: 0)

    # default_categories.each do |category|
      # category.update(family_id: @family.id)
    # end

    # default_tasks.each do |task|
      # task.update(family_id: @family.id)
    # end
  # end
end
