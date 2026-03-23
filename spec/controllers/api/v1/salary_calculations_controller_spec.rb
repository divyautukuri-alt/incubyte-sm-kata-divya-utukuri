require 'rails_helper'

RSpec.describe "Api::V1::SalaryCalculations API", type: :request do
  let!(:employee) { create(:employee, full_name: 'John Doe', country: 'India', salary: 100000) }
  let(:employee_id) { employee.id }

  describe 'GET /api/v1/employees/:employee_id/calculate_salary' do
    context 'when employee exists' do
      subject { get "/api/v1/employees/#{employee_id}/calculate_salary" }

      it 'returns salary calculation' do
        subject
        expect(json['employee_id']).to eq(employee_id)
        expect(json['full_name']).to eq('John Doe')
        expect(json['gross_salary']).to eq('100000.0')
        expect(json['deduction']).to eq('10000.0')
        expect(json['net_salary']).to eq('90000.0')
        expect(json['country']).to eq('India')
      end

      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(200)
      end
    end

    context 'when employee does not exist' do
      subject { get "/api/v1/employees/999999/calculate_salary" }

      it 'returns status code 404' do
        subject
        expect(response).to have_http_status(404)
      end

      it 'returns error message' do
        subject
        expect(json['error']).to match(/Couldn't find Employee/)
      end
    end
  end

  # Helper method to parse JSON response
  def json
    JSON.parse(response.body)
  end
end
