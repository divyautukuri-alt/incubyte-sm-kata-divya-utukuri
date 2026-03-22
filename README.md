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
POST /employees
Content-Type: application/json

{
  "full_name": "John Doe",
  "job_title": "Software Engineer",
  "country": "India",
  "salary": 100000
}
```

#### Get All Employees
```
GET /employees
```

#### Get Single Employee
```
GET /employees/:id
```

#### Update Employee
```
PUT /employees/:id
Content-Type: application/json

{
  "salary": 120000
}
```

#### Delete Employee
```
DELETE /employees/:id
```

### Salary Calculation

#### Calculate Net Salary
```
GET /employees/:id/calculate_salary

Response:
{
  "employee_id": 1,
  "full_name": "John Doe",
  "gross_salary": 100000,
  "deduction": 10000,
  "net_salary": 90000,
  "country": "India"
}
```

### Salary Metrics

#### Get Salary Stats by Country
```
GET /salary_metrics/by_country?country=India

Response:
{
  "country": "India",
  "min_salary": 50000,
  "max_salary": 150000,
  "average_salary": 95000
}
```

#### Get Average Salary by Job Title
```
GET /salary_metrics/by_job_title?job_title=Software Engineer

Response:
{
  "job_title": "Software Engineer",
  "average_salary": 105000,
  "employee_count": 5
}
```

## Running Tests

This project follows TDD practices with comprehensive test coverage using RSpec.

### Run all tests:
```bash
rspec
```

### Run specific test file:
```bash
rspec spec/models/employee_spec.rb
rspec spec/controllers/employees_controller_spec.rb
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
  - Used for: Code scaffolding, test generation, boilerplate reduction
  - Rationale: Accelerate development while maintaining code quality and TDD discipline

### Test Coverage:
- Model validations and business logic
- Controller actions and error handling
- Service objects for salary calculations
- Integration tests for complete workflows