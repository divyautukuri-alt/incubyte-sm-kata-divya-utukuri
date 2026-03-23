require 'rails_helper'

RSpec.describe Api::V1::SalaryMetricsController, type: :controller do
  describe 'GET #by_country' do
    let!(:india_employee1) { Employee.create!(full_name: 'Raj Kumar', job_title: 'Developer', country: 'India', salary: 50000) }
    let!(:india_employee2) { Employee.create!(full_name: 'Priya Sharma', job_title: 'Manager', country: 'India', salary: 80000) }
    let!(:india_employee3) { Employee.create!(full_name: 'Amit Patel', job_title: 'Developer', country: 'India', salary: 60000) }
    let!(:us_employee) { Employee.create!(full_name: 'John Doe', job_title: 'Developer', country: 'United States', salary: 100000) }

    it 'returns salary metrics for a specific country' do
      get :by_country, params: { country: 'India' }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)

      expect(json_response['country']).to eq('India')
      expect(json_response['minimum_salary']).to eq(50000.0)
      expect(json_response['maximum_salary']).to eq(80000.0)
      expect(json_response['average_salary']).to eq(63333.33)
    end

    it 'returns salary metrics for United States' do
      get :by_country, params: { country: 'United States' }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)

      expect(json_response['country']).to eq('United States')
      expect(json_response['minimum_salary']).to eq(100000.0)
      expect(json_response['maximum_salary']).to eq(100000.0)
      expect(json_response['average_salary']).to eq(100000.0)
    end

    it 'returns 404 when no employees found for the country' do
      get :by_country, params: { country: 'Canada' }

      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('No employees found for country: Canada')
    end

    it 'handles case-insensitive country names' do
      get :by_country, params: { country: 'india' }

      expect(response).to have_http_status(:success)
      json_response = JSON.parse(response.body)
      expect(json_response['country']).to eq('India')
    end
  end
end
