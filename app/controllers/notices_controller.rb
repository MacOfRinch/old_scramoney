class NoticesController < ApplicationController

  def create
    @notice = Notice.new
  end

  def index
    @notices = Notice.where(family_id: @family.id, user_id: current_user.id)
  end

  # 各ユーザーがページを開いたらReadモデルのcheckedをtrueにして既読にするよ。それまでは未読(flase)だよ。
  def show
    @notice = Notice.find(params[:id])
    @users = @family.users
    if Read.find_by(user_id: current_user.id, notice_id: @notice.id, checked: false)
      @read = Read.update(user_id: current_user.id, notice_id: @notice.id, checked: true)
    end
    # このままでは月が過ぎると自動的に先月になってしまうから直さねばならぬ
    @each_name_points = each_name_points_of_last_month(@users)
    @each_pocket_money = each_pocket_money_of_last_month(@users)
  end

  def destroy
    @notice = Notice.find(params[:id])
    @notice.destroy!
  end

  private

  def each_name_points_of_last_month(users)
    result = []
    users.each do |user|
      array = nil
      array = ["#{display_name(user)}:#{user.sum_points_of_last_month}pt (#{user.percent_of_last_month}%)", user.sum_points_of_last_month]
      result << array
    end
    result
  end

  def each_pocket_money_of_last_month(users)
    result = []
    users.each do |user|
      array = nil
      array = ["#{display_name(user)}:#{user.calculate_pocket_money_of_last_month}円", user.calculate_pocket_money_of_last_month]
      result << array
    end
    result
  end

end
