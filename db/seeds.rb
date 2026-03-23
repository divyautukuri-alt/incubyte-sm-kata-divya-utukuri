# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing data
puts "Clearing existing employees..."
Employee.destroy_all

# Create sample employees
puts "Creating sample employees..."

employees_data = [
  # India employees
  { full_name: "Raj Kumar", job_title: "Software Engineer", country: "India", salary: 80000 },
  { full_name: "Priya Sharma", job_title: "Senior Developer", country: "India", salary: 120000 },
  { full_name: "Amit Patel", job_title: "Product Manager", country: "India", salary: 150000 },

  # United States employees
  { full_name: "John Smith", job_title: "Software Engineer", country: "United States", salary: 100000 },
  { full_name: "Sarah Johnson", job_title: "Senior Developer", country: "United States", salary: 140000 },
  { full_name: "Michael Brown", job_title: "Tech Lead", country: "United States", salary: 160000 },
  { full_name: "Emily Davis", job_title: "Product Manager", country: "United States", salary: 180000 },

  # Canada employees
  { full_name: "David Chen", job_title: "Software Engineer", country: "Canada", salary: 90000 },
  { full_name: "Lisa Wang", job_title: "QA Engineer", country: "Canada", salary: 75000 },

  # United Kingdom employees
  { full_name: "James Wilson", job_title: "Senior Developer", country: "United Kingdom", salary: 110000 },
  { full_name: "Emma Thompson", job_title: "DevOps Engineer", country: "United Kingdom", salary: 95000 },

  # Germany employees
  { full_name: "Hans Mueller", job_title: "Software Engineer", country: "Germany", salary: 85000 },
  { full_name: "Anna Schmidt", job_title: "Data Analyst", country: "Germany", salary: 70000 }
]

employees_data.each do |employee_data|
  Employee.create!(employee_data)
  puts "  ✓ Created: #{employee_data[:full_name]} (#{employee_data[:country]})"
end

puts "\n✅ Seed data created successfully!"
puts "Total employees: #{Employee.count}"
puts "\nEmployees by country:"
Employee.group(:country).count.each do |country, count|
  puts "  #{country}: #{count}"
end
