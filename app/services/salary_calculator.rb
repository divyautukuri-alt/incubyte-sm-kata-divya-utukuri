class SalaryCalculator
  # Tax deduction rates by country
  TAX_RATES = {
    'India' => 10,
    'United States' => 12
  }.freeze

  def self.calculate(employee)
    new(employee).calculate
  end

  def initialize(employee)
    @employee = employee
  end

  def calculate
    {
      employee_id: @employee.id,
      full_name: @employee.full_name,
      gross_salary: @employee.salary.to_f,
      deduction: deduction_amount,
      net_salary: net_salary,
      deduction_percentage: deduction_percentage,
      country: @employee.country
    }
  end

  private

  def deduction_percentage
    TAX_RATES[@employee.country] || 0
  end

  def deduction_amount
    (@employee.salary * deduction_percentage / 100.0).round(2)
  end

  def net_salary
    (@employee.salary - deduction_amount).round(2)
  end
end
