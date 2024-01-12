class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      render json: { message: 'Comment added' }, status: :created
    else
      render json: { errors: @comment.errors.full_messages }, status: :bad_request
    end
  end

  def index
    @news = News.find(params[:news_id])
    @comments =  @news.comments
    if @comments
      render json: { message: 'Comments fetched', comments: @comments }, status: :ok
    else
      render json: { errors: @comment.errors.full_messages }, status: :bad_request
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :comment_body, :comment_added_by, :project_id, :user_id, :news_id)
  end
end