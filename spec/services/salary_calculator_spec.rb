require 'rails_helper'

RSpec.describe SalaryCalculator do
  describe '.calculate' do
    context 'when employee is from India' do
      let(:employee) { create(:employee, country: 'India', salary: 100000) }
      subject { described_class.calculate(employee) }

      it 'applies 10% TDS deduction' do
        result = subject
        expect(result[:deduction]).to eq(10000)
      end

      it 'calculates correct net salary' do
        result = subject
        expect(result[:net_salary]).to eq(90000)
      end

      it 'returns complete salary breakdown' do
        result = subject
        expect(result[:gross_salary]).to eq(100000)
        expect(result[:deduction_percentage]).to eq(10)
        expect(result[:country]).to eq('India')
      end
    end

    context 'when employee is from United States' do
      let(:employee) { create(:employee, country: 'United States', salary: 100000) }
      subject { described_class.calculate(employee) }

      it 'applies 12% TDS deduction' do
        result = subject
        expect(result[:deduction]).to eq(12000)
      end

      it 'calculates correct net salary' do
        result = subject
        expect(result[:net_salary]).to eq(88000)
      end

      it 'returns complete salary breakdown' do
        result = subject
        expect(result[:gross_salary]).to eq(100000)
        expect(result[:deduction_percentage]).to eq(12)
        expect(result[:country]).to eq('United States')
      end
    end

    context 'when employee is from other countries' do
      let(:employee) { create(:employee, country: 'Canada', salary: 100000) }
      subject { described_class.calculate(employee) }

      it 'applies no deduction' do
        result = subject
        expect(result[:deduction]).to eq(0)
      end

      it 'net salary equals gross salary' do
        result = subject
        expect(result[:net_salary]).to eq(100000)
      end

      it 'returns complete salary breakdown' do
        result = subject
        expect(result[:gross_salary]).to eq(100000)
        expect(result[:deduction_percentage]).to eq(0)
        expect(result[:country]).to eq('Canada')
      end
    end

    context 'with decimal salaries' do
      let(:employee) { create(:employee, country: 'India', salary: 123456.78) }
      subject { described_class.calculate(employee) }

      it 'handles decimal calculations correctly' do
        result = subject
        expect(result[:deduction]).to eq(12345.68)
        expect(result[:net_salary]).to eq(111111.10)
      end
    end
  end
end
