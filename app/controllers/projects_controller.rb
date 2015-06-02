class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  
  def index

    @projects = Project.all

  end

  
  def show
  end

  
  def new

    @project = Project.new

  end

  
  def edit

    @users=User.all

  end

  
  def create
    @project = Project.new(project_params)
    
    @users = User.where(:id => params[:contributing_team])
    @project.users << @users
    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def update
   
    @project = Project.find(params[:id])
    @users = User.where(:id => params[:contributing_team])
    @project.users.destroy_all   
    @project.users << @users
    respond_to do |format|
      if @project.save
      
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_project
      @project = Project.find(params[:id])
    end

    
    def project_params
      params.require(:project).permit(:name, :user_id, :task_id,:owner_id)
    end
end