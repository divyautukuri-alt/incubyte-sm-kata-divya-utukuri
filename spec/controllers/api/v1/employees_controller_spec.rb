require 'rails_helper'

RSpec.describe "Api::V1::Employees API", type: :request do
  let!(:employees) { create_list(:employee, 5) }
  let(:employee_id) { employees.first.id }

  describe 'GET /api/v1/employees' do
    subject { get '/api/v1/employees' }

    it 'returns all employees' do
      subject
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      subject
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/v1/employees/:id' do
    context 'when the employee exists' do
      subject { get "/api/v1/employees/#{employee_id}" }

      it 'returns the employee' do
        subject
        expect(json).not_to be_empty
        expect(json['id']).to eq(employee_id)
      end

      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(200)
      end
    end

    context 'when the employee does not exist' do
      subject { get "/api/v1/employees/999999" }

      it 'returns status code 404' do
        subject
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        subject
        expect(response.body).to match(/Couldn't find Employee/)
      end
    end
  end

  # Helper method to parse JSON response
  def json
    JSON.parse(response.body)
  end
end
