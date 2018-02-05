class BuildsController < ApplicationController
  before_action :set_build, only: [:show, :edit, :update, :destroy]

  # GET /builds
  # GET /builds.json
  def index
    if params[:project_id].present?
      @project = Project.find(params[:project_id])
      @builds = @project.builds
    else
      @builds = Build.all
    end
    @builds = @builds.order("created_at DESC")
  end

  # GET /builds/1
  # GET /builds/1.json
  def show
  end

  # GET /builds/new
  def new
    @build = Build.new branch: "master"
    if params[:project_id]
      @build.project = Project.find params[:project_id]
      @build.branch = @build.project&.default_branch
    end
  end

  # POST /builds
  # POST /builds.json
  def create
    @build = Build.new(build_params)

    respond_to do |format|
      if @build.save
        BuildWorker.perform_async(@build.id)
        format.html { redirect_to @build, notice: 'Build was successfully created.' }
        format.json { render action: 'show', status: :created, location: @build }
      else
        format.html { render action: 'new' }
        format.json { render json: @build.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /builds/1
  # DELETE /builds/1.json
  def destroy
    @build.destroy
    respond_to do |format|
      format.html { redirect_to builds_url }
      format.json { head :no_content }
    end
  end

  def all
    started_builds = []
    failed_builds = []
    Project.all.order(:repo).each do |project|
      if project.default_branch
        build = Build.new(project_id: project.id, branch: project.default_branch)
        if build.save
          BuildWorker.perform_async(build.id) 
          started_builds << "#{project.repo} - #{project.default_branch}"
        else
          failed_builds << "#{project.repo} - #{project.default_branch}"
        end
      else
        failed_builds << "#{project.repo} - No default branch specified"
      end
    end
    notice = "Builds started:<br>#{started_builds.join('<br>')}"
    notice << "<br>Builds failed to start:<br>#{failed_builds.join('<br>')}" unless failed_builds.empty?
    redirect_to root_path, notice: notice
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_build
      @build = Build.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def build_params
      params.require(:build).permit(:project_id, :started_at, :completed_at, :successful, :output, :branch)
    end
end
