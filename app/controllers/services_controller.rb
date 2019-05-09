class ServicesController < ApplicationController
  before_action :find_service, except: %i[index new create]

  def index
    @services = Service.all
  end

  def show
    @current_price = format_price(@service.current_price)
    @price_records = @service.price_records.sort_by(&:effective_from)

    @service.visitor_count = @service.visitor_count + 1
    @service.save
  end

  def new
    authorized_for(current_user.id)
    @service = Service.new
    @current_price = @service.price_records.build
  end

  def edit
    authorized_for(current_user.id)
    @current_price = @service.current_price
  end

  def create
    authorized_for(current_user.id)
    @service = Service.new(service_params)
    if @service.save
      @service.current_price = service_params[:current_price]
      flash[:success] = 'Service successfully created'
      redirect_to @service
    else
      flash[:error] = 'Something went wrong'
      render 'new'
    end
  end

  def update
    authorized_for(current_user.id)
    if @service.update_attributes(service_params)
      flash[:success] = 'Service was successfully updated'
      redirect_to @service
    else
      flash[:error] = 'Something went wrong'
      render 'edit'
    end
  end

  def destroy
    authorized_for(current_user.id)
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
    # params.require(:service).permit(:name, :description, price_records_attributes: %i[monthly_price])
    params.require(:service).permit(:name, :description, :current_price)
  end
end
