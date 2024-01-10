class NewsController < ApplicationController
  def create
    @news = News.new(news_params)
    if @news.save
      render json: { message: 'News added' }, status: :created
    else
      render json: { errors: @news.errors.full_messages }, status: :bad_request
    end
  end

  def index
    @project = Project.find(params[:project_id])
    @news = @project.news
    if @news
      render json: { message: 'All News fetched', news: @news }, status: :ok
    else
      render json: { errors: @news.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @news = News.find(params[:news_id])
    if @news
      render json: { message: 'News fetched', news: @news }, status: :ok
    else
      render json: { errors: @news.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @news = News.find(params[:news_id])
    if @news.update(update_news_params)
      render json: { message: 'News updated'}, status: :ok
    else
      render json: { errors: @news.errors.full_messages }, status: :bad_request
    end
  end

  private

  def news_params
    params.require(:news).permit(:news_title, :news_content, :news_added_by, :project_id)
  end

  def update_news_params
    params.require(:news).permit(:news_title, :news_content)
  end

end