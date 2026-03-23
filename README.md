# Employee Salary Management API

A RESTful API for managing employee records and calculating salaries with country-specific tax deductions. Built with Ruby on Rails following Test-Driven Development (TDD) practices.

## Table of Contents

- [About the Project](#about-the-project)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [API Endpoints](#api-endpoints)
- [Running Tests](#running-tests)
- [Implementation Details](#implementation-details)

## About the Project

It focus on Test-Driven Development (TDD) and clean code principles.

The API manages employee information and provides salary calculation functionality with country-specific tax deductions.

## Features

### 1. Employee CRUD Operations
- Create, Read, Update, and Delete employee records
- Each employee has:
  - Full Name
  - Job Title
  - Country
  - Salary (Gross)

### 2. Salary Calculation
- Calculate net salary from gross salary based on country-specific tax rules
- **Tax Deduction Rules:**
  - **India:** 10% TDS (Tax Deducted at Source)
  - **United States:** 12% TDS
  - **Other Countries:** No deductions (net = gross)

### 3. Salary Metrics
- Get salary statistics by country (min, max, average)
- Get average salary by job title
- Aggregate insights across the employee database

## Tech Stack

### Core Framework
- **Ruby 2.7.8**
- **Rails 7.1.6**

### Database
- **SQLite3** - Lightweight database for development and testing

### Testing
- **RSpec Rails 6.1** - Testing framework
- **FactoryBot 6.4** - Test data generation
- **Faker 3.2** - Realistic fake data for tests

### Development Tools
- **Puma** - Web server
- **Bootsnap** - Boot time optimization
- **Debug** - Debugging tool

### API Features
- RESTful endpoints with JSON responses
- Input validation and error handling
- Clean separation of concerns

## Getting Started

### Prerequisites

- Ruby 2.7.8
- Bundler
- SQLite3

### Installation

1. Clone the repository:
```bash
git clone https://github.com/divyautukuri-alt/incubyte-sm-kata-divya-utukuri.git
cd incubyte-sm-kata-divya-utukuri
```

2. Install dependencies:
```bash
bundle install
```

3. Set up the database:
```bash
rails db:create
rails db:migrate
```

### Running the Application

Start the Rails server:
```bash
rails server
```

## API Endpoints

### Employee CRUD

#### Create Employee
```
POST /api/v1/employees
Content-Type: application/json

{
  "employee": {
    "full_name": "John Doe",
    "job_title": "Software Engineer",
    "country": "India",
    "salary": 100000
  }
}
```

#### Get All Employees
```
GET /api/v1/employees
```

#### Get Single Employee
```
GET /api/v1/employees/:id
```

#### Update Employee
```
PUT /api/v1/employees/:id
Content-Type: application/json

{
  "employee": {
    "salary": 120000
  }
}
```

#### Delete Employee
```
DELETE /api/v1/employees/:id
```

### Salary Calculation

#### Calculate Net Salary
```
GET /api/v1/employees/:id/calculate_salary

Response:
{
  "employee_id": 1,
  "full_name": "John Doe",
  "gross_salary": 100000.0,
  "deduction": 10000.0,
  "net_salary": 90000.0,
  "deduction_percentage": 10,
  "country": "India"
}
```

### Salary Metrics

#### Get Salary Stats by Country
```
GET /api/v1/salary_metrics/by_country/India

Response:
{
  "country": "India",
  "minimum_salary": 50000.0,
  "maximum_salary": 150000.0,
  "average_salary": 95000.0
}
```

#### Get Average Salary by Job Title
```
GET /api/v1/salary_metrics/by_job_title/Software%20Engineer

Response:
{
  "job_title": "Software Engineer",
  "average_salary": 105000.0,
  "employee_count": 5
}
```

**Note:** Both endpoints support case-insensitive matching. Returns 404 if no employees found.

## Running Tests

This project follows TDD practices with comprehensive test coverage using RSpec.

### Run all tests:
```bash
rspec
```

### Run specific test file:
```bash
rspec spec/models/employee_spec.rb
rspec spec/controllers/api/v1/employees_controller_spec.rb
rspec spec/controllers/api/v1/salary_metrics_controller_spec.rb
```

### Run with detailed output:
```bash
rspec --format documentation
```

## Implementation Details

### AI Usage and Tools

This project was developed with AI assistance to demonstrate modern software development practices:

#### AI Tools Used:
- **Claude Opus 4.6** via Claude Code (Anthropic's official CLI)
  - Used for: Code scaffolding, test generation, implementation, and documentation
  - Rationale: Accelerate development while maintaining code quality and TDD discipline

#### Where AI was Used:
1. **Test Generation:** AI helped scaffold comprehensive RSpec tests following TDD red-green-refactor cycle
2. **Controller Implementation:** Generated CRUD endpoints and salary metrics controllers with proper error handling
3. **Service Objects:** Created SalaryCalculator service with country-specific tax logic
4. **Documentation:** Drafted README with API examples and setup instructions
5. **Refactoring:** Applied DRY principles and ensured consistent code style

#### Development Approach:
- Strict TDD workflow: Write failing tests → Implement minimal code → Refactor
- All 48 tests passing with comprehensive coverage
- Incremental commits showing red-green-refactor cycle
- Case-insensitive query support for better UX
- Clean separation of concerns (Models, Controllers, Services)

### Test Coverage:
- **Models:** Employee validations and database constraints (6 examples)
- **Controllers:** CRUD operations, error handling, edge cases (34 examples)
- **Services:** Tax calculations for multiple countries (8 examples)
- **All Tests Passing:** 48 examples, 0 failures

### Architecture Decisions:
- **Service Objects:** Extracted salary calculation logic into `SalaryCalculator` for reusability
- **RESTful Routes:** Followed Rails conventions with namespaced API routes (`/api/v1/`)
- **Database Queries:** Used case-insensitive SQL queries for flexible country/job title matching
- **Error Handling:** Consistent JSON error responses with appropriate HTTP status codes