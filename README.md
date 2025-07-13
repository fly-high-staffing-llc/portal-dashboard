# 📦 Dealer Inventory & Vendor Intelligence Portal

## 🌟 Project Overview

A production-grade full-stack web and mobile platform designed to centralize, visualize, and streamline inventory, vendor uploads, and logistics data across dealership operations. This system serves both internal logistics users and external vendors, providing real-time visibility into stock levels, delivery tracking, and business KPIs.

### 🎯 Key Features

- **Secure Authentication**: Role-based access control (Admin, Vendor, Logistics User)
- **Inventory Management**: Large CSV file uploads (5K+ records) with validation
- **Advanced Analytics**: Powerful grid filtering, pagination, and KPI dashboards
- **Multi-Platform**: Responsive web interface and offline-first mobile application
- **API-First**: Full REST API with Swagger documentation
- **Scalable Database**: PostgreSQL with optimized indexing for performance

### 👥 Target Users

This platform is designed for training and real-time simulation by 60–70 developers across:
- **BA/Product Owner** teams
- **React/React Native** developers
- **Java backend** engineers
- **Database** engineers
- **QA** roles

Teams will use AI tools such as Cursor and GitHub Copilot for development.

## 🏗️ Project Architecture

```
project1_tech/
├── frontend-web/              # React 17 + Vite + TailwindCSS + Ag-Grid
├── frontend-mobile/           # React Native 0.66 (Expo/CLI)
├── backend/                   # Java 11, Spring Boot 2.5
├── db/                        # PostgreSQL scripts
├── scripts/                   # Node or Python utilities
├── docs/                      # Wireframes, diagrams, specs
├── .github/                   # GitHub Actions CI/CD
└── README.md
```

## 🚀 Quick Start

### Prerequisites

Before starting, ensure you have the following installed:

#### **Required Software**
- **Node.js** 16+ and npm
- **Java** 11+ and Maven
- **PostgreSQL** 13+
- **Git** (for version control)

#### **Optional (for mobile development)**
- **React Native CLI**
- **Android Studio** (for Android development)
- **Xcode** (for iOS development, macOS only)

#### **Installation Commands**

**macOS (using Homebrew):**
```bash
# Install Homebrew if not already installed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install required software
brew install node
brew install openjdk@11
brew install postgresql
brew install git

# Start PostgreSQL
brew services start postgresql
```

**Ubuntu/Debian:**
```bash
# Update package list
sudo apt update

# Install Node.js
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Java 11
sudo apt install openjdk-11-jdk

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib

# Start PostgreSQL
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Install Git
sudo apt install git
```

**Windows:**
```bash
# Install Chocolatey if not already installed
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install required software
choco install nodejs
choco install openjdk11
choco install postgresql
choco install git
```

### 1. Clone and Initial Setup

```bash
# Clone the repository
git clone <repository-url>
cd project1_tech

# Make setup script executable
chmod +x scripts/setup.sh

# Run automated setup (recommended for first-time setup)
./scripts/setup.sh
```

### 2. Manual Database Setup (if automated setup fails)

#### **PostgreSQL Installation & Configuration**

**macOS:**
```bash
# Install PostgreSQL
brew install postgresql

# Start PostgreSQL service
brew services start postgresql

# Create a PostgreSQL user (if needed)
createuser -s postgres
```

**Ubuntu/Debian:**
```bash
# Install PostgreSQL
sudo apt update
sudo apt install postgresql postgresql-contrib

# Start PostgreSQL service
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Switch to postgres user
sudo -u postgres psql

# Create a new user (optional)
CREATE USER your_username WITH PASSWORD 'your_password';
GRANT ALL PRIVILEGES ON DATABASE dealer_portal TO your_username;
\q
```

**Windows:**
```bash
# PostgreSQL is installed as a service
# Access it through pgAdmin or command line
```

#### **Database Creation & Schema Setup**

```bash
# Connect to PostgreSQL as postgres user
psql -U postgres

# Create the database
CREATE DATABASE dealer_portal;

# Connect to the new database
\c dealer_portal

# Exit psql
\q

# Run the schema script
psql -U postgres -d dealer_portal -f db/schema/schema.sql

# Run the seed data script
psql -U postgres -d dealer_portal -f db/seed/seed.sql

# Verify the setup
psql -U postgres -d dealer_portal -c "\dt"
psql -U postgres -d dealer_portal -c "SELECT COUNT(*) FROM inventory;"
```

### 3. Backend Setup & Run

#### **First Time Setup**
```bash
# Navigate to backend directory
cd backend

# Check Java version
java -version

# Check Maven version (if installed)
mvn -version

# Install dependencies using Maven wrapper
./mvnw clean install

# If Maven wrapper doesn't work, install Maven manually:
# macOS: brew install maven
# Ubuntu: sudo apt install maven
# Windows: choco install maven
```

#### **Run Backend Application**
```bash
# Start the Spring Boot application
./mvnw spring-boot:run

# Or if you have Maven installed globally
mvn spring-boot:run

# The application will start on http://localhost:8080
# Swagger UI: http://localhost:8080/swagger-ui.html
# API Base: http://localhost:8080/api
```

#### **Backend Development Commands**
```bash
# Run tests
./mvnw test

# Run with specific profile
./mvnw spring-boot:run -Dspring.profiles.active=dev

# Build JAR file
./mvnw clean package

# Run JAR file
java -jar target/dealer-portal-0.0.1-SNAPSHOT.jar
```

### 4. Frontend Web Setup & Run

#### **First Time Setup**
```bash
# Navigate to frontend-web directory
cd frontend-web

# Check Node.js version
node --version
npm --version

# Install dependencies
npm install

# Or if you prefer yarn
yarn install
```

#### **Run Web Application**
```bash
# Start development server
npm run dev

# Or with yarn
yarn dev

# The application will start on http://localhost:3000
# It will automatically proxy API calls to http://localhost:8080
```

#### **Web Development Commands**
```bash
# Run tests
npm test

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint

# Fix linting issues
npm run lint:fix
```

### 5. Frontend Mobile Setup & Run

#### **First Time Setup**
```bash
# Navigate to frontend-mobile directory
cd frontend-mobile

# Install dependencies
npm install

# Install React Native CLI globally (if not already installed)
npm install -g @react-native-community/cli

# For iOS development (macOS only)
cd ios && pod install && cd ..
```

#### **Run Mobile Application**

**Start Metro Bundler:**
```bash
# Start the Metro bundler
npm start

# Or
npx react-native start
```

**For Android:**
```bash
# Make sure you have Android Studio and Android SDK installed
# Set ANDROID_HOME environment variable

# Run on Android device/emulator
npm run android

# Or
npx react-native run-android
```

**For iOS (macOS only):**
```bash
# Make sure you have Xcode installed
# Install iOS dependencies
cd ios && pod install && cd ..

# Run on iOS simulator
npm run ios

# Or
npx react-native run-ios
```

#### **Mobile Development Commands**
```bash
# Run tests
npm test

# Lint code
npm run lint

# Type checking
npm run type-check

# Clean and rebuild
cd android && ./gradlew clean && cd ..
cd ios && xcodebuild clean && cd ..
```

### 6. Complete Development Environment

#### **Start All Services (Recommended)**
```bash
# From the project root directory
./start-all.sh

# This will start:
# - Backend on http://localhost:8080
# - Web frontend on http://localhost:3000
# - Mobile Metro bundler on http://localhost:8081
```

#### **Stop All Services**
```bash
# Stop all running services
./stop-all.sh
```

#### **Individual Service Management**
```bash
# Backend only
cd backend && ./mvnw spring-boot:run

# Web frontend only
cd frontend-web && npm run dev

# Mobile Metro only
cd frontend-mobile && npm start
```

### 7. Utility Scripts

#### **CSV Upload Utility**
```bash
# Generate sample CSV file
node scripts/csv-uploader.js generate sample.csv 100

# Upload CSV file to API
node scripts/csv-uploader.js upload sample.csv

# Validate CSV file structure
node scripts/csv-uploader.js validate sample.csv
```

#### **KPI Analysis Utility**
```bash
# Generate KPI report
python3 scripts/batch-kpi-analysis.py

# Generate charts only
python3 scripts/batch-kpi-analysis.py --charts-only

# Custom output file
python3 scripts/batch-kpi-analysis.py --output my_report.json
```

### 8. Testing & Quality Assurance

#### **Backend Testing**
```bash
cd backend

# Run all tests
./mvnw test

# Run specific test class
./mvnw test -Dtest=InventoryControllerTest

# Run with coverage
./mvnw test jacoco:report
```

#### **Frontend Testing**
```bash
# Web frontend tests
cd frontend-web
npm test

# Mobile frontend tests
cd frontend-mobile
npm test
```

#### **End-to-End Testing**
```bash
# Install Playwright (for web testing)
cd frontend-web
npm install -D @playwright/test

# Run E2E tests
npx playwright test
```

### 9. Production Deployment

#### **Build Production Artifacts**
```bash
# Backend JAR
cd backend
./mvnw clean package -DskipTests

# Web frontend build
cd frontend-web
npm run build

# Mobile APK (Android)
cd frontend-mobile
cd android && ./gradlew assembleRelease && cd ..
```

#### **Docker Deployment**
```bash
# Build Docker images
docker build -t dealer-portal-backend ./backend
docker build -t dealer-portal-web ./frontend-web

# Run with Docker Compose
docker-compose up -d
```

### 10. Troubleshooting

#### **Common Issues & Solutions**

**Backend Issues:**
```bash
# Port 8080 already in use
lsof -ti:8080 | xargs kill -9

# Database connection issues
# Check PostgreSQL is running
brew services list | grep postgresql

# Reset database
psql -U postgres -c "DROP DATABASE IF EXISTS dealer_portal;"
psql -U postgres -c "CREATE DATABASE dealer_portal;"
```

**Frontend Issues:**
```bash
# Node modules issues
rm -rf node_modules package-lock.json
npm install

# Metro bundler cache
npx react-native start --reset-cache

# iOS build issues
cd ios && pod deintegrate && pod install && cd ..
```

**Mobile Issues:**
```bash
# Android build issues
cd android && ./gradlew clean && cd ..

# iOS build issues
cd ios && xcodebuild clean && cd ..

# Reset React Native cache
npx react-native start --reset-cache
```

### 11. Development Workflow

#### **Daily Development Commands**
```bash
# 1. Start all services
./start-all.sh

# 2. Make changes to code

# 3. Run tests
cd backend && ./mvnw test && cd ..
cd frontend-web && npm test && cd ..

# 4. Commit changes
git add .
git commit -m "Your commit message"
git push origin your-branch

# 5. Stop services when done
./stop-all.sh
```

#### **Git Workflow**
```bash
# Create feature branch
git checkout -b feature/your-feature-name

# Make changes and commit
git add .
git commit -m "Add your feature"

# Push to remote
git push origin feature/your-feature-name

# Create pull request on GitHub
```

### 12. Environment Variables

#### **Backend Environment (.env)**
```bash
# Database Configuration
DB_URL=jdbc:postgresql://localhost:5432/dealer_portal
DB_USERNAME=postgres
DB_PASSWORD=postgres

# JWT Configuration
JWT_SECRET=your-secret-key
JWT_EXPIRATION=86400000

# Server Configuration
SERVER_PORT=8080
```

#### **Frontend Environment**
```bash
# Web frontend (.env)
VITE_API_BASE_URL=http://localhost:8080/api
VITE_APP_NAME=Dealer Portal

# Mobile frontend (.env)
API_BASE_URL=http://localhost:8080/api
APP_NAME=Dealer Portal
```

### 13. Access Points

Once everything is running, you can access:

- **Web Application**: http://localhost:3000
- **API Documentation**: http://localhost:8080/swagger-ui.html
- **Backend API**: http://localhost:8080/api
- **Mobile Metro**: http://localhost:8081

### 14. Default Credentials

For testing purposes, use these default credentials:
- **Email**: admin@dealer-portal.com
- **Password**: password

### 15. Performance Monitoring

#### **Backend Monitoring**
```bash
# Health check
curl http://localhost:8080/actuator/health

# Metrics
curl http://localhost:8080/actuator/metrics
```

#### **Frontend Monitoring**
```bash
# Web performance
# Open Chrome DevTools > Performance tab

# Mobile performance
# Use React Native Debugger or Flipper
```

## 📊 Data Model

### Users Table
| Field          | Type         | Description                  |
| -------------- | ------------ | ---------------------------- |
| id             | SERIAL       | Primary key                  |
| email          | VARCHAR(255) | Unique user email            |
| password_hash  | TEXT         | Hashed password              |
| role           | VARCHAR(50)  | Admin, Vendor, LogisticsUser |
| created_at     | TIMESTAMP    | Account creation date        |

### Inventory Table
| Field          | Type         | Description                     |
| -------------- | ------------ | ------------------------------- |
| id             | SERIAL       | Primary key                     |
| item_name      | VARCHAR(100) | Name of inventory item          |
| quantity       | INT          | Available quantity              |
| location       | VARCHAR(100) | Physical location (e.g. Dallas) |
| vendor_id      | INT          | Foreign key to `vendors`        |
| delivery_date  | DATE         | Expected delivery date          |
| status         | VARCHAR(50)  | Status: Active, Pending, etc.   |
| created_at     | TIMESTAMP    | Record creation timestamp       |

### Vendors Table
| Field          | Type         | Description          |
| -------------- | ------------ | -------------------- |
| id             | SERIAL       | Primary key          |
| name           | VARCHAR(100) | Vendor name          |
| contact_email  | VARCHAR(255) | Vendor contact email |

## 🔌 API Endpoints

### Authentication
- `POST /api/auth/login` - User authentication
- `POST /api/auth/register` - User registration (optional)

### Inventory Management
- `POST /api/inventory/upload` - CSV upload (Admin only)
- `GET /api/inventory` - Paginated inventory list
- `GET /api/inventory/:id` - Get item by ID
- `PUT /api/inventory/:id` - Update inventory item
- `DELETE /api/inventory/:id` - Delete inventory record

### Analytics & KPIs
- `GET /api/kpi/vendor` - Vendor-wise totals
- `GET /api/kpi/location` - Location-wise totals
- `GET /api/kpi/status` - Status-wise breakdown

### Admin Operations
- `GET /api/admin/logs` - Upload logs
- `GET /api/admin/users` - User management
- `PUT /api/admin/users/:id/role` - Role management

## 🛠️ Development Guidelines

### Backend (Spring Boot)
- Package-by-layer: `controller`, `service`, `model`, `repository`
- Use DTOs for request/response separation
- JUnit + MockMVC for testing
- `@RestControllerAdvice` for error handling
- JWT + Spring Security with `@PreAuthorize`

### Frontend (React/React Native)
- Redux Toolkit with slices per feature
- Atomic Design: components → templates → pages
- TypeScript + React Navigation + Axios
- Modular structure: `/components`, `/screens`, `/redux`, `/services`
- Axios interceptors for auth headers

### Database
- Use UUIDs or SERIAL keys
- Apply constraints and indexes on search columns
- SQL scripts versioned per module

## 🧪 Testing

### Backend Tests
```bash
cd backend
./mvnw test
```

### Frontend Tests
```bash
cd frontend-web
npm test

cd frontend-mobile
npm test
```

## 🚀 Deployment

### Development
- Backend: `http://localhost:8080`
- Frontend Web: `http://localhost:3000`
- Database: `localhost:5432`

### Production
- Use GitHub Actions for CI/CD
- Deploy to cloud platforms (AWS, GCP, Azure)
- Configure environment variables
- Set up monitoring and logging

## 📝 Development Workflow

1. **Feature Development**: 3-week sprints
2. **Code Review**: Pull request reviews
3. **Testing**: Unit, integration, and E2E tests
4. **Documentation**: API docs, component docs
5. **Deployment**: Staging → Production

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit changes: `git commit -m 'Add amazing feature'`
4. Push to branch: `git push origin feature/amazing-feature`
5. Open a Pull Request

## 📚 Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [React Documentation](https://reactjs.org/docs/)
- [React Native Documentation](https://reactnative.dev/docs/getting-started)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)

## 🆘 Support

For questions and support:
- Create an issue in the repository
- Contact the development team
- Check the documentation in `/docs`

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

**Happy Coding! 🚀** 