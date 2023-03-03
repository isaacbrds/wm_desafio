class VacationsController < ApplicationController
  before_action :set_vacation, only: %i[ show edit update destroy ]
  def index
    @vacations = Vacation.all
  end

  def show;end

  def edit;end

  def new
    @vacation = Vacation.new
  end
  
  def create
    @vacation = Vacation.new(vacation_params)
    render :new, status: :unprocessable_entity unless @vacation.save
    
    redirect_to vacation_url(@vacation), notice: "vacation was successfully created."
  end


  def update
    render :edit, status: :unprocessable_entity  unless @vacation.update(vacation_params)
    
    redirect_to vacation_url(@vacation), notice: "vacation was successfully updated."     
  end

  def destroy
    @vacation.destroy
    redirect_to vacations_url, notice: "vacation was successfully destroyed."
  end

  private
    
  def set_vacation
    @vacation = Vacation.find(params[:id])
  end

  def vacation_params
    params.require(:vacation).permit(:start_date, :finish_date, :employee_id)
  end
end
