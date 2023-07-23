class CategoriesController < ApplicationController
  before_action :set_category
  skip_before_action :set_category, only: %i[new create index]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.family_id = @family.id

    if @category.save
      flash.now[:notice] = "#{task.name}を登録しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @categories = Category.includes(:tasks).where(family_id: @family.id).or(Category.where(family_id: nil))
  end

  def show
    @tasks = Task.where(category_id: params[:id])
  end

  def edit

  end

  private

  def set_category
    @category = Category.find(params[:id])
    @categories = Category.where(family_id: @family.id).or(Category.where(family_id: nil))
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
