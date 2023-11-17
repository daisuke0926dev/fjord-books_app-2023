# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable
  before_action :set_comment, only: [:destroy]
  before_action :check_owner, only: [:destroy]

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to_commentable('OK')
    else
      # エラーハンドリングの処理
      redirect_to_commentable(@comment.errors.full_messages.to_s)
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy
    redirect_to_commentable('OK')
  end

  private

  def set_commentable
    if /books/.match?(request.path)
      @commentable = Book.find(params[:book_id])
    elsif /reports/.match?(request.path)
      @commentable = Report.find(params[:report_id])
    end
  end

  def check_owner
    return if @comment.user == current_user

    respond_to do |format|
      format.html { redirect_to_commentable('NG') }
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def redirect_to_commentable(message)
    redirect_to @commentable, notice: message
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end
end
