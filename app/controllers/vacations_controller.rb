class VacationsController < ApplicationController
  before_action :set_vacation, only: %i[ show edit update destroy ]
  before_action :set_employees, only: %i[ new edit create update ]
  def index
    @vacations = Vacation.order(:start_date).page
  end

  def show;end

  def edit;end

  def new
    @vacation = Vacation.new
  end
  
  def create
    @vacation = Vacation.new(vacation_params)
    if @vacation.save
      redirect_to vacation_url(@vacation), notice: "vacation was successfully created."
    else
      render :new, status: :unprocessable_entity 
    end
  end


  def update
    if @vacation.update(vacation_params)
      redirect_to vacation_url(@vacation), notice: "vacation was successfully updated."     
    else
      render :edit, status: :unprocessable_entity  
    end
  end

  def destroy
    if @vacation.destroy
      redirect_to vacations_url, notice: "vacation was successfully destroyed."
    end
  end

  private
    
  def set_vacation
    @vacation = Vacation.find(params[:id])
  end

  def set_employees
    @employees = Employee.all
  end

  def vacation_params
    params.require(:vacation).permit(:start_date, :finish_date, :employee_id)
  end
end
