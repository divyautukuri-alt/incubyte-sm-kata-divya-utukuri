module Api
  module V1
    class EmployeesController < ApplicationController
      before_action :set_employee, only: [:show]

      # GET /api/v1/employees
      def index
        @employees = Employee.all
        render json: @employees
      end

      # GET /api/v1/employees/:id
      def show
        render json: @employee
      end

      private

      def set_employee
        @employee = Employee.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: "Couldn't find Employee with 'id'=#{params[:id]}" }, status: :not_found
      end

      def employee_params
        params.require(:employee).permit(:full_name, :job_title, :country, :salary)
      end
    end
  end
end
