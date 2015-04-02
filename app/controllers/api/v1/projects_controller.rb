class Api::V1::ProjectsController < Api::V1::BaseController
  
  before_action :authorize_admin!, except: [:index, :show]
  before_action :find_project, only:[:show]

  def index
    respond_with Project.for(current_user).all
  end

  def create
    project = Project.new(project_params)

    if project.save
      respond_with(project, location: api_v1_project_path(project))
    else
      respond_with(project)
    end
  end

  def show
    respond_with(@project, :methods => "last_ticket")
  end

  private

    def project_params
      params.require(:project).permit(:name)
    end

    def find_project
      @project = Project.for(current_user).find(params[:id])
    rescue ActiveRecord::RecordNotFound
      error = { error: "The project you were looking for could not be found." }
      respond_with(error, status: 404)
    end
end
