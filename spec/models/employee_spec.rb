require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'validations' do
    it 'is valid with all required attributes' do
      employee = Employee.new(
        full_name: 'John Doe',
        job_title: 'Software Engineer',
        country: 'India',
        salary: 100000
      )
      expect(employee).to be_valid
    end

    it 'is invalid without a full_name' do
      employee = Employee.new(
        job_title: 'Software Engineer',
        country: 'India',
        salary: 100000
      )
      expect(employee).to_not be_valid
      expect(employee.errors[:full_name]).to include("can't be blank")
    end

    it 'is invalid without a job_title' do
      employee = Employee.new(
        full_name: 'John Doe',
        country: 'India',
        salary: 100000
      )
      expect(employee).to_not be_valid
      expect(employee.errors[:job_title]).to include("can't be blank")
    end

    it 'is invalid without a country' do
      employee = Employee.new(
        full_name: 'John Doe',
        job_title: 'Software Engineer',
        salary: 100000
      )
      expect(employee).to_not be_valid
      expect(employee.errors[:country]).to include("can't be blank")
    end

    it 'is invalid without a salary' do
      employee = Employee.new(
        full_name: 'John Doe',
        job_title: 'Software Engineer',
        country: 'India'
      )
      expect(employee).to_not be_valid
      expect(employee.errors[:salary]).to include("can't be blank")
    end

    it 'is invalid with a negative salary' do
      employee = Employee.new(
        full_name: 'John Doe',
        job_title: 'Software Engineer',
        country: 'India',
        salary: -1000
      )
      expect(employee).to_not be_valid
      expect(employee.errors[:salary]).to include("must be greater than 0")
    end

    it 'is invalid with a zero salary' do
      employee = Employee.new(
        full_name: 'John Doe',
        job_title: 'Software Engineer',
        country: 'India',
        salary: 0
      )
      expect(employee).to_not be_valid
      expect(employee.errors[:salary]).to include("must be greater than 0")
    end
  end
end
