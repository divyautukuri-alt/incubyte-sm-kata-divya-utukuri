require 'rails_helper'

RSpec.describe "Api::V1::Employees API", type: :request do
  let!(:employees) { create_list(:employee, 5) }
  let(:employee_id) { employees.first.id }
  let(:valid_attributes) do
    {
      full_name: 'Jane Smith',
      job_title: 'Product Manager',
      country: 'United States',
      salary: 120000
    }
  end
  let(:invalid_attributes) do
    {
      full_name: '',
      job_title: '',
      country: '',
      salary: nil
    }
  end

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

  describe 'POST /api/v1/employees' do
    context 'when the request is valid' do
      subject { post '/api/v1/employees', params: { employee: valid_attributes } }

      it 'creates an employee' do
        subject
        expect(json['full_name']).to eq('Jane Smith')
        expect(json['job_title']).to eq('Product Manager')
        expect(json['country']).to eq('United States')
        expect(json['salary']).to eq('120000.0')
      end

      it 'returns status code 201' do
        subject
        expect(response).to have_http_status(201)
      end

      it 'increases employee count by 1' do
        expect { subject }.to change(Employee, :count).by(1)
      end
    end

    context 'when the request is invalid' do
      subject { post '/api/v1/employees', params: { employee: invalid_attributes } }

      it 'returns status code 422' do
        subject
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        subject
        expect(response.body).to match(/can't be blank/)
      end

      it 'does not create an employee' do
        expect { subject }.to_not change(Employee, :count)
      end
    end
  end

  describe 'PUT /api/v1/employees/:id' do
    let(:updated_attributes) { { salary: 150000 } }

    context 'when the employee exists' do
      subject { put "/api/v1/employees/#{employee_id}", params: { employee: updated_attributes } }

      it 'updates the employee' do
        subject
        expect(json['salary']).to eq('150000.0')
      end

      it 'returns status code 200' do
        subject
        expect(response).to have_http_status(200)
      end
    end

    context 'when the employee does not exist' do
      subject { put "/api/v1/employees/999999", params: { employee: updated_attributes } }

      it 'returns status code 404' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /api/v1/employees/:id' do
    context 'when the employee exists' do
      subject { delete "/api/v1/employees/#{employee_id}" }

      it 'returns status code 204' do
        subject
        expect(response).to have_http_status(204)
      end

      it 'deletes the employee' do
        subject
        expect(Employee.find_by(id: employee_id)).to be_nil
      end

      it 'decreases employee count by 1' do
        expect { subject }.to change(Employee, :count).by(-1)
      end
    end

    context 'when the employee does not exist' do
      subject { delete "/api/v1/employees/999999" }

      it 'returns status code 404' do
        subject
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'GET /api/v1/employees/:id/calculate_salary' do
    let!(:india_employee) { create(:employee, full_name: 'Raj Kumar', country: 'India', salary: 100000) }

    context 'when employee exists' do
      subject { get "/api/v1/employees/#{india_employee.id}/calculate_salary" }

      it 'returns salary calculation' do
        subject
        expect(json['employee_id']).to eq(india_employee.id)
        expect(json['full_name']).to eq('Raj Kumar')
        expect(json['gross_salary']).to eq(100000.0)
        expect(json['deduction']).to eq(10000.0)
        expect(json['net_salary']).to eq(90000.0)
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
