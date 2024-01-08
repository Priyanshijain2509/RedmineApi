class IssuesController < ApplicationController
  def index
    @issues = Project.find(params[:project_id]).issues
    if @issues
      render json: { message: 'Issues fetched', issues: @issues}, status: :ok
    else
      render json: { errors: @issues.errors.full_messages }, status: :bad_request
    end
  end

  def create
    @issue = Issue.new(issue_params)
    debugger
    if @issue.save
      render json: { message: 'Issue raised!' }, status: :created
    else
      render json: { errors: @issue.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @issue = Issue.find(params[:issue_id])
    if @issue
      render json: { message: 'Issue fetched', issue: @issue}, status: :ok
    else
      render json: { errors: @issue.errors.full_messages }, status: :bad_request
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:tracker, :subject, :issue_description,
      :category, :start_date, :end_date, :estimated_time, :issue_resolved,
      :project_id, :user_id, :issue_status => [], :assignee => [])
  end
end