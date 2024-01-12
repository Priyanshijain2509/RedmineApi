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

  def info
    @project = Project.find(params[:project_id])
    if @project
      render json: { message: 'Project details fetched', project: @project },
      status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :bad_request
    end
  end

  def addContributor
    @project = Project.find_by(id: params[:project_id])
    existing_assigned_to = @project.assigned_to || []
    new_assigned_to = project_params[:assigned_to]
    updated_assigned_to = existing_assigned_to | new_assigned_to
    @project.assigned_to = updated_assigned_to.reject(&:nil?)

    if @project.save
      update_assigned_projects(project_params[:assigned_to], @project.id)
      render json: { message: 'contributors added' }, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :bad_request
    end
  end

  def removeContributor
    @project = Project.find_by(id: params[:project_id])
    remove_users = params[:project][:assigned_to]
    removed_users = User.where(id: remove_users)  # removed_users contains assignees

    if @project.assigned_to.present?
      @project.assigned_to -= remove_users
      @project.save
      update_removed_user_projects(removed_users, @project.id)
      render json: { message: 'Contributors removed' }, status: :ok
    else
      render json: { errors: ['Assigned users not found.'] }, status: :bad_request
    end
  end

  def fetchContributors
    @project = Project.find_by(id: params[:project_id])
    @contributors_ids = @project.assigned_to || []
    @contributors = []

    @contributors_ids.each do |id|
      user = User.find_by(id: id)
      @contributors << { id: id, first_name: user&.first_name } if user
    end
    if @contributors
      render json: { contributors: @contributors }, status: :ok
    else
      render json: { errors: @project.errors.full_messages }, status: :bad_request
    end
  end

  def overview
    @issues = Project.find(params[:project_id]).issues;
    bug_issue_not_resolved = @issues.where(issue_resolved: false, tracker: 'Bug').count
    bug_issue_resolved = @issues.where(issue_resolved: true, tracker: 'Bug').count
    bug_total =  @issues.where(tracker: 'Bug').count;
    feature_issue_not_resolved = @issues.where(issue_resolved: false, tracker: 'Feature').count;
    feature_issue_resolved = @issues.where(issue_resolved: true, tracker: 'Feature').count;
    feature_total = @issues.where(tracker: 'Feature').count;
    patch_issue_not_resolved = @issues.where(issue_resolved: false, tracker: 'Patch').count;
    patch_issue_resolved = @issues.where(issue_resolved: true, tracker: 'Patch').count;
    patch_total = @issues.where(tracker: 'Patch').count;
    if @issues
      render json: {
        bug_issue_not_resolved: bug_issue_not_resolved,
        bug_issue_resolved:bug_issue_resolved,
        bug_total: bug_total,
        feature_issue_not_resolved: feature_issue_not_resolved,
        feature_issue_resolved: feature_issue_resolved,
        feature_total: feature_total,
        patch_issue_not_resolved: patch_issue_not_resolved,
        patch_issue_resolved: patch_issue_resolved,
        patch_total: patch_total
            }, status: :ok
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

  # update in user model assigned_projects column
  def update_assigned_projects(user_ids, project_id)
    user_ids.each do |user_id|
      user = User.find(user_id)
      assigned_projects = user.assigned_projects || []
      assigned_projects << project_id unless assigned_projects.include?(project_id)
      user.update(assigned_projects: assigned_projects)
    end
  end

  # remove from user model assigned_projects column
  def update_removed_user_projects(user, project_id)
    user = User.find(user[0].id) # Ensure that we have a single user instance
    if user.assigned_projects.include?(project_id)
      user.assigned_projects.delete(project_id)
      user.save
    end
  end
end
