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
      deduction_percentage: deduction_percentage,
      country: @employee.country
    }
  end

  private

  def deduction_percentage
    TAX_RATES[@employee.country]
  end

  def deduction_amount
    (@employee.salary * deduction_percentage / 100.0)
  end
end
