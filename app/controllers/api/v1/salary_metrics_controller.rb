module Api
  module V1
    class SalaryMetricsController < ApplicationController
      # GET /api/v1/salary_metrics/by_country/:country
      def by_country
        country_param = params[:country]

        employees = Employee.where('LOWER(country) = ?', country_param.downcase)

        # Get the actual country name from the first employee (preserves case)
        actual_country = employees.first.country

        salaries = employees.pluck(:salary)

        render json: {
          country: actual_country,
          minimum_salary: salaries.min.to_f,
          maximum_salary: salaries.max.to_f,
          average_salary: (salaries.sum.to_f / salaries.size).round(2)
        }
      end
    end
  end
end
