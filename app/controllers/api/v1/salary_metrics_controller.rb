module Api
  module V1
    class SalaryMetricsController < ApplicationController
      # GET /api/v1/salary_metrics/by_country/:country
      def by_country
        country_param = params[:country]

        employees = Employee.where('LOWER(country) = ?', country_param.downcase)

        if employees.empty?
          render json: { error: "No employees found for country: #{country_param}" }, status: :not_found
          return
        end

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

      # GET /api/v1/salary_metrics/by_job_title/:job_title
      def by_job_title
        job_title_param = params[:job_title]

        employees = Employee.where('LOWER(job_title) = ?', job_title_param.downcase)

        if employees.empty?
          render json: { error: "No employees found for job title: #{job_title_param}" }, status: :not_found
          return
        end

        actual_job_title = employees.first&.job_title

        salaries = employees.pluck(:salary)

        render json: {
          job_title: actual_job_title,
          average_salary: (salaries.sum.to_f / salaries.size).round(2),
          employee_count: employees.count
        }
      end
    end
  end
end
