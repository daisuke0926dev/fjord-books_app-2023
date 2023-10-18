# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: 'Comment was successfully created.'
    else
      # エラーハンドリングの処理
      redirect_to @commentable, notice: @comment.errors.full_messages.to_s
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to @commentable, notice: 'Comment was successfully deleted.'
  end

  private

  def set_commentable
    if request.path.match(/books/)
      @commentable = Book.find(params[:book_id])
    elsif request.path.match(/reports/)
      @commentable = Report.find(params[:report_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
