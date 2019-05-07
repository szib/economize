class ServicesController < ApplicationController
  before_action :find_service, except: %i[index new create]

  def index
    @services = Service.all
  end

  def show; end

  def new
    @service = Service.new
  end

  def edit; end

  def create
    @service = Service.new(service_params)
    if @service.save
      flash[:success] = 'Service successfully created'
      redirect_to @service
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    if @service.update_attributes(service_params)
      flash[:success] = 'Service was successfully updated'
      redirect_to @service
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    if @service.destroy
      flash[:success] = 'Service was successfully deleted'
      redirect_to @services_path
    else
      flash[:error] = 'Something went wrong'
      redirect_to @services_path
    end
  end

  private

  def find_service
    @service = Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit(:name, :description)
  end
end
