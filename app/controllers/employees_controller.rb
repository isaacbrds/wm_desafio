class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[ show edit update destroy ]
  def index
    @employees = Employee.order(:name).page

    term = params[:term]
    
    @employees = Employee.where("name LIKE ?", "%#{term}%").distinct.order(:name).page  if term.present?
  end

  def show;end

  def edit;end

  def new
    @employee = Employee.new
  end
  
  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to employee_url(@employee), notice: "Employee was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
     if @employee.update(employee_params)
      redirect_to employee_url(@employee), notice: "Employee was successfully updated."     
     else
      render :edit, status: :unprocessable_entity 
     end
  end

  def destroy
    if @employee.destroy
      redirect_to employees_url, notice: "Employee was successfully destroyed."
    end
  end

  private
    
  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit(:name, :position, :admission_date)
  end
end
