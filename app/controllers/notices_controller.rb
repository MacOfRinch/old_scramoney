class NoticesController < ApplicationController
  def index
    @notices = Notice.all.order(created_at: :desc)
  end

  # 各ユーザーがページを開いたらReadモデルのcheckedをtrueにして既読にするよ。それまでは未読(flase)だよ。
  def show
    @notice = Notice.find(params[:id])
    @read = Read.new(user_id: current_user.id, notice_id: @notice.id)
    if @read.save
      @read.update(checked: true)
    end
  end
end
