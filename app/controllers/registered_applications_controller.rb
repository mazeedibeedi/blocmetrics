class RegisteredApplicationsController < ApplicationController
  before_action :set_app, except: [:index, :new, :create]
  def index
    @registered_applications = current_user.registered_applications
  end

  def new
    @registered_application = RegisteredApplication.new
  end

  def create
    @registered_application = current_user.registered_applications.new(app_params)
    if @registered_application.save
      redirect_to @registered_application, notice: "Application was successfully registered"
    else
      flash.now[:alert] = "There was an error registering your application"
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @registered_application.update_attributes(app_params)
      redirect_to @registered_application, notice: "Application was successfully updated"
    else
      flash.now[:alert] = "There was an error in updating your application"
      render :edit
    end
  end

  def destroy
    if @registered_application.destroy
      redirect_to registered_applications_path, notice: "Application was successfully deleted"
    else
      redirect_to @registered_application, notice: "There was an error in deleting your application"
    end
  end

  private
  def app_params
    params.require(:registered_application).permit(:name, :url)
  end

  def set_app
    @registered_application = RegisteredApplication.find(params[:id])
  end
end
