# 🚀 Dealer Portal Backend

## 📋 Overview

This is the Spring Boot backend application for the Dealer Inventory & Vendor Intelligence Portal. It provides RESTful APIs for inventory management, user authentication, vendor operations, and KPI analytics.

## 🏗️ Architecture

```
backend/
├── src/main/java/com/dealer/
│   ├── DealerPortalApplication.java    # Main application class
│   ├── controller/                     # REST API controllers
│   ├── service/                        # Business logic services
│   ├── model/                          # JPA entities
│   ├── repository/                     # Spring Data repositories
│   ├── config/                         # Configuration classes
│   ├── dto/                           # Data Transfer Objects
│   ├── exception/                      # Custom exceptions
│   └── util/                          # Utility classes
├── src/main/resources/
│   ├── application.yml                 # Application configuration
│   ├── application-dev.yml             # Development profile
│   ├── application-test.yml            # Test profile
│   └── application-prod.yml            # Production profile
├── src/test/java/                      # Test classes
├── pom.xml                            # Maven dependencies
└── README.md                          # This file
```

## 🛠️ Prerequisites

### Required Software
- **Java 11+** (OpenJDK or Oracle JDK)
- **Maven 3.6+** (or use Maven wrapper)
- **PostgreSQL 13+**
- **Git**

### Installation Commands

**macOS:**
```bash
# Install Java 11
brew install openjdk@11

# Install Maven
brew install maven

# Install PostgreSQL
brew install postgresql
brew services start postgresql

# Set JAVA_HOME
echo 'export JAVA_HOME=$(/usr/libexec/java_home -v 11)' >> ~/.zshrc
source ~/.zshrc
```

**Ubuntu/Debian:**
```bash
# Update package list
sudo apt update

# Install Java 11
sudo apt install openjdk-11-jdk

# Install Maven
sudo apt install maven

# Install PostgreSQL
sudo apt install postgresql postgresql-contrib
sudo systemctl start postgresql
sudo systemctl enable postgresql

# Set JAVA_HOME
echo 'export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64' >> ~/.bashrc
source ~/.bashrc
```

**Windows:**
```bash
# Install Chocolatey if not already installed
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install Java 11
choco install openjdk11

# Install Maven
choco install maven

# Install PostgreSQL
choco install postgresql
```

## 🚀 Quick Start

### 1. Clone and Setup

```bash
# Clone the repository
git clone <repository-url>
cd project1_tech/backend

# Verify Java installation
java -version
mvn -version
```

### 2. Database Setup

```bash
# Connect to PostgreSQL
psql -U postgres

# Create database
CREATE DATABASE dealer_portal;

# Connect to the database
\c dealer_portal

# Exit psql
\q

# Run schema script
psql -U postgres -d dealer_portal -f ../../db/schema/schema.sql

# Run seed data
psql -U postgres -d dealer_portal -f ../../db/seed/seed.sql

# Verify setup
psql -U postgres -d dealer_portal -c "\dt"
psql -U postgres -d dealer_portal -c "SELECT COUNT(*) FROM inventory;"
```

### 3. Build and Run

```bash
# Clean and install dependencies
./mvnw clean install

# Run the application
./mvnw spring-boot:run

# Or with Maven (if installed globally)
mvn clean install
mvn spring-boot:run
```

### 4. Verify Installation

```bash
# Health check
curl http://localhost:8080/actuator/health

# API documentation
open http://localhost:8080/swagger-ui.html

# Sample API call
curl http://localhost:8080/api/inventory
```

## 🔧 Development Commands

### Build Commands

```bash
# Clean and compile
./mvnw clean compile

# Run tests
./mvnw test

# Package application
./mvnw clean package

# Install to local repository
./mvnw clean install

# Skip tests during build
./mvnw clean package -DskipTests
```

### Run Commands

```bash
# Run with default profile
./mvnw spring-boot:run

# Run with specific profile
./mvnw spring-boot:run -Dspring.profiles.active=dev

# Run with custom port
./mvnw spring-boot:run -Dserver.port=9090

# Run with debug mode
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=5005"

# Run JAR file
java -jar target/dealer-portal-0.0.1-SNAPSHOT.jar

# Run with custom configuration
java -jar target/dealer-portal-0.0.1-SNAPSHOT.jar --spring.profiles.active=prod
```

### Testing Commands

```bash
# Run all tests
./mvnw test

# Run specific test class
./mvnw test -Dtest=InventoryControllerTest

# Run tests with coverage
./mvnw test jacoco:report

# Run integration tests
./mvnw verify

# Run tests in parallel
./mvnw test -Dparallel=methods -DthreadCount=4

# Run tests with specific profile
./mvnw test -Dspring.profiles.active=test
```

### Debug Commands

```bash
# Run with debug logging
./mvnw spring-boot:run -Dlogging.level.com.dealer=DEBUG

# Run with SQL logging
./mvnw spring-boot:run -Dlogging.level.org.hibernate.SQL=DEBUG -Dlogging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE

# Run with actuator endpoints
./mvnw spring-boot:run -Dmanagement.endpoints.web.exposure.include=*

# Run with custom JVM options
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xms512m -Xmx1024m"
```

## 📊 Monitoring & Health Checks

### Actuator Endpoints

```bash
# Health check
curl http://localhost:8080/actuator/health

# Application info
curl http://localhost:8080/actuator/info

# Metrics
curl http://localhost:8080/actuator/metrics

# Environment variables
curl http://localhost:8080/actuator/env

# Configuration properties
curl http://localhost:8080/actuator/configprops

# Database health
curl http://localhost:8080/actuator/health/db

# Disk space
curl http://localhost:8080/actuator/health/diskSpace
```

### Logging Commands

```bash
# View application logs
tail -f logs/application.log

# View error logs
grep "ERROR" logs/application.log

# View SQL queries
grep "Hibernate" logs/application.log

# View specific package logs
grep "com.dealer" logs/application.log
```

## 🔐 Security & Authentication

### JWT Configuration

```bash
# Generate JWT secret
openssl rand -base64 32

# Set JWT secret in environment
export JWT_SECRET=your-generated-secret

# Run with custom JWT secret
./mvnw spring-boot:run -Djwt.secret=your-secret-key
```

### Database Security

```bash
# Create database user
psql -U postgres -c "CREATE USER dealer_user WITH PASSWORD 'secure_password';"
psql -U postgres -c "GRANT ALL PRIVILEGES ON DATABASE dealer_portal TO dealer_user;"

# Update application.yml with new credentials
# Update spring.datasource.username and spring.datasource.password
```

## 🗄️ Database Operations

### Database Management

```bash
# Connect to database
psql -U postgres -d dealer_portal

# List all tables
\dt

# Describe table structure
\d inventory

# View sample data
SELECT * FROM inventory LIMIT 5;

# Check table sizes
SELECT schemaname, tablename, attname, n_distinct, correlation 
FROM pg_stats 
WHERE schemaname = 'public';

# Analyze table performance
ANALYZE inventory;
```

### Database Backup & Restore

```bash
# Create backup
pg_dump -U postgres dealer_portal > backup_$(date +%Y%m%d_%H%M%S).sql

# Restore from backup
psql -U postgres -d dealer_portal < backup_20240101_120000.sql

# Backup specific tables
pg_dump -U postgres -t inventory -t vendors dealer_portal > tables_backup.sql

# Restore specific tables
psql -U postgres -d dealer_portal < tables_backup.sql
```

### Database Migration

```bash
# Run schema updates
psql -U postgres -d dealer_portal -f db/migrations/001_add_new_column.sql

# Rollback changes
psql -U postgres -d dealer_portal -f db/migrations/rollback/001_rollback.sql

# Check migration status
psql -U postgres -d dealer_portal -c "SELECT * FROM schema_version;"
```

## 🧪 Testing

### Unit Testing

```bash
# Run all unit tests
./mvnw test

# Run specific test class
./mvnw test -Dtest=InventoryServiceTest

# Run specific test method
./mvnw test -Dtest=InventoryServiceTest#testCreateInventory

# Run tests with coverage
./mvnw test jacoco:report

# View coverage report
open target/site/jacoco/index.html
```

### Integration Testing

```bash
# Run integration tests
./mvnw verify

# Run with test profile
./mvnw test -Dspring.profiles.active=test

# Run with H2 in-memory database
./mvnw test -Dspring.profiles.active=test

# Run specific integration test
./mvnw test -Dtest=InventoryControllerIntegrationTest
```

### API Testing

```bash
# Test health endpoint
curl -X GET http://localhost:8080/actuator/health

# Test inventory endpoint
curl -X GET http://localhost:8080/api/inventory

# Test with authentication
curl -X GET http://localhost:8080/api/inventory \
  -H "Authorization: Bearer your-jwt-token"

# Test POST request
curl -X POST http://localhost:8080/api/inventory \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer your-jwt-token" \
  -d '{"item_name":"Test Item","quantity":10,"location":"Test"}'
```

## 🔧 Configuration

### Environment Variables

```bash
# Set environment variables
export SPRING_PROFILES_ACTIVE=dev
export DB_URL=jdbc:postgresql://localhost:5432/dealer_portal
export DB_USERNAME=postgres
export DB_PASSWORD=postgres
export JWT_SECRET=your-secret-key
export SERVER_PORT=8080

# Run with environment variables
./mvnw spring-boot:run
```

### Application Properties

```bash
# Override properties via command line
./mvnw spring-boot:run \
  -Dspring.datasource.url=jdbc:postgresql://localhost:5432/dealer_portal \
  -Dspring.datasource.username=postgres \
  -Dspring.datasource.password=postgres \
  -Dserver.port=8080 \
  -Djwt.secret=your-secret-key
```

### Profile-Specific Configuration

```bash
# Development profile
./mvnw spring-boot:run -Dspring.profiles.active=dev

# Test profile
./mvnw spring-boot:run -Dspring.profiles.active=test

# Production profile
./mvnw spring-boot:run -Dspring.profiles.active=prod
```

## 🚀 Deployment

### Local Deployment

```bash
# Build JAR file
./mvnw clean package -DskipTests

# Run JAR file
java -jar target/dealer-portal-0.0.1-SNAPSHOT.jar

# Run with custom configuration
java -jar target/dealer-portal-0.0.1-SNAPSHOT.jar \
  --spring.profiles.active=prod \
  --server.port=8080
```

### Docker Deployment

```bash
# Build Docker image
docker build -t dealer-portal-backend .

# Run Docker container
docker run -p 8080:8080 \
  -e SPRING_PROFILES_ACTIVE=prod \
  -e DB_URL=jdbc:postgresql://host.docker.internal:5432/dealer_portal \
  dealer-portal-backend

# Run with Docker Compose
docker-compose up -d
```

### Production Deployment

```bash
# Build for production
./mvnw clean package -DskipTests -Pprod

# Create production JAR
./mvnw clean package -DskipTests -Pprod -Dmaven.test.skip=true

# Run with production settings
java -Xms512m -Xmx1024m \
  -jar target/dealer-portal-0.0.1-SNAPSHOT.jar \
  --spring.profiles.active=prod \
  --server.port=8080
```

## 🔍 Troubleshooting

### Common Issues

**Port Already in Use:**
```bash
# Find process using port 8080
lsof -ti:8080

# Kill process
lsof -ti:8080 | xargs kill -9

# Or use different port
./mvnw spring-boot:run -Dserver.port=9090
```

**Database Connection Issues:**
```bash
# Check PostgreSQL status
brew services list | grep postgresql

# Restart PostgreSQL
brew services restart postgresql

# Test database connection
psql -U postgres -d dealer_portal -c "SELECT 1;"

# Check database logs
tail -f /usr/local/var/log/postgresql.log
```

**Memory Issues:**
```bash
# Increase heap size
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Xms512m -Xmx1024m"

# Monitor memory usage
jstat -gc <pid>

# Check for memory leaks
jmap -histo <pid>
```

**Build Issues:**
```bash
# Clean Maven cache
./mvnw clean
rm -rf ~/.m2/repository/com/dealer

# Update dependencies
./mvnw dependency:resolve

# Force update
./mvnw clean install -U
```

### Debug Commands

```bash
# Enable debug logging
./mvnw spring-boot:run -Dlogging.level.com.dealer=DEBUG

# Enable SQL logging
./mvnw spring-boot:run \
  -Dlogging.level.org.hibernate.SQL=DEBUG \
  -Dlogging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE

# Enable Spring Security debug
./mvnw spring-boot:run -Dlogging.level.org.springframework.security=DEBUG

# Enable all debug logs
./mvnw spring-boot:run -Dlogging.level.root=DEBUG
```

## 📚 API Documentation

### Swagger UI
- **URL**: http://localhost:8080/swagger-ui.html
- **API Docs**: http://localhost:8080/v2/api-docs
- **OpenAPI Spec**: http://localhost:8080/v3/api-docs

### API Endpoints

```bash
# Health check
GET /actuator/health

# Inventory endpoints
GET /api/inventory
GET /api/inventory/{id}
POST /api/inventory
PUT /api/inventory/{id}
DELETE /api/inventory/{id}

# Authentication
POST /api/auth/login
POST /api/auth/register

# KPI endpoints
GET /api/kpi/vendor
GET /api/kpi/location
GET /api/kpi/status

# Admin endpoints
GET /api/admin/logs
GET /api/admin/users
PUT /api/admin/users/{id}/role
```

## 🔧 Development Tools

### IDE Setup

**IntelliJ IDEA:**
1. Open project as Maven project
2. Set JDK 11 as project SDK
3. Configure Run Configuration for Spring Boot
4. Enable annotation processing

**Eclipse:**
1. Import as Maven project
2. Configure Java 11
3. Install Spring Tools Suite plugin

**VS Code:**
1. Install Java Extension Pack
2. Install Spring Boot Extension Pack
3. Configure Java runtime

### Code Quality

```bash
# Run checkstyle
./mvnw checkstyle:check

# Run spotbugs
./mvnw spotbugs:check

# Run PMD
./mvnw pmd:check

# Run all quality checks
./mvnw verify
```

## 📈 Performance Tuning

### JVM Tuning

```bash
# Optimize for production
java -server \
  -Xms512m -Xmx1024m \
  -XX:+UseG1GC \
  -XX:MaxGCPauseMillis=200 \
  -jar target/dealer-portal-0.0.1-SNAPSHOT.jar

# Enable GC logging
java -Xloggc:gc.log \
  -XX:+PrintGCDetails \
  -XX:+PrintGCTimeStamps \
  -jar target/dealer-portal-0.0.1-SNAPSHOT.jar
```

### Database Tuning

```bash
# Analyze table statistics
psql -U postgres -d dealer_portal -c "ANALYZE;"

# Check slow queries
psql -U postgres -d dealer_portal -c "SELECT query, calls, total_time, mean_time FROM pg_stat_statements ORDER BY mean_time DESC LIMIT 10;"

# Check table sizes
psql -U postgres -d dealer_portal -c "SELECT schemaname, tablename, pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) as size FROM pg_tables WHERE schemaname = 'public';"
```

## 🎯 Next Steps

1. **Set up your IDE** with the recommended extensions
2. **Configure your database** with the provided scripts
3. **Run the application** using the provided commands
4. **Explore the API** using Swagger UI
5. **Write your first test** following the testing patterns
6. **Contribute to the project** following the coding standards

## 📞 Support

For issues and questions:
- Create an issue in the repository
- Check the troubleshooting section above
- Review the application logs for error details
- Consult the Spring Boot documentation

---

**Happy Coding! 🚀** 