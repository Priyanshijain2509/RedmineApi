class ProjectsController < ApplicationController

  def index
    @projects = User.find(params[:user_id]).projects
    render json: { message: 'Projects fetched', projects: @projects},
      status: :ok
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      render json: { message: 'Project created' }, status: :created
    else
      render json: { errors: @project.errors.full_messages }, status: :bad_request
    end
  end

  private

  def project_params
    params.require(:project).permit(:project_name, :project_description,
      :identifier, :public, :user_id, :issue_tracking, :project_news,
      :wiki, assigned_to: []
    )
  end

end
