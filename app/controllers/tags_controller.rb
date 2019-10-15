class TagsController < ApplicationController
  before_action :set_target_tag, only: %i[edit update destroy]
  
  def index
    @tags = Tag.all
  end

  def new
    @tag = Tag.new
  end

  def create
    tag = Tag.new(tag_params)
    if tag.save
      redirect_to tag, flash: {
        success: "[#{tag.name}]を登録しました"
      }
    else
      flash[:tag] = tag
      flash[:error_messages] = tag.errors.full_messages
      redirect_back(fallback_location: new_tag_path)
    end
  end

  def edit
  end

  def update
    if @tag.update(tag_params)
      redirect_to tags_path, flash: {
        success: "[#{@tag.name}]を更新しました"
      }
    else
      flash[:tag] = @tag
      flash[:error_messages] = @tag.errors.full_messages
      redirect_back(fallback_location: @tag)
    end
  end

  def destroy
    @tag.destroy

    redirect_to tags_path, flash: {danger: "[#{@tag.name}]を削除しました"}
  end
  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def set_target_tag
    @tag = Tag.find(params[:id])
  end
end
