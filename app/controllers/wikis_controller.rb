class WikisController < ApplicationController

  def create
    @wiki = Wiki.new(wiki_params)
    if @wiki.save
      render json: { message: 'Wiki created' }, status: :created
    else
      render json: { errors: @wiki.errors.full_messages }, status: :bad_request
    end
  end

  def index
    @project =  Project.find(params[:project_id])
    @wiki = @project.project_wiki
    if @wiki
      render json: { message: 'Wiki created', wiki: @wiki , project_name:
        @project.project_name}, status: :created
    else
      render json: { errors: @wiki.errors.full_messages }, status: :bad_request
    end
  end 

  def show
    @wiki = Wiki.find(params[:wiki_id])
    if @wiki
      render json: { message: 'Wiki fetched', wiki: @wiki , project_name:
        @wiki.project.project_name}, status: :created
    else
      render json: { errors: @wiki.errors.full_messages }, status: :bad_request
    end
  end

  def update
    @wiki = Wiki.find(params[:wiki_id])
    if @wiki.update(update_wiki_params)
      render json: { message: 'Wiki updated'}, status: :ok
    else
      render json: { errors: @wiki.errors.full_messages }, status: :bad_request
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:wiki_text, :project_id, :created_by)
  end

  def update_wiki_params
    params.require(:wiki).permit(:wiki_text, :updated_by)
  end
end