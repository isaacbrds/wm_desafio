class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]
  def index
    @employees = Employee.all
  end

  def show;end

  def edit;end

  def new
    @employee = Employee.new
  end
  
  def create
    @employee = Employee.new(employee_params)
    render :new, status: :unprocessable_entity unless @employee.save
    
    redirect_to employee_url(@employee), notice: "Employee was successfully created."
  end


  def update
    render :edit, status: :unprocessable_entity  unless @employee.update(employee_params)
    
    redirect_to employee_url(@employee), notice: "Employee was successfully updated."     
  end

  def destroy
    @employee.destroy
    redirect_to employees_url, notice: "Employee was successfully destroyed."
  end

  private
    
  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :position, :admission_date)
  end
end
