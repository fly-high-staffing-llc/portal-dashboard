#!/bin/bash

# Dealer Portal Development Setup Script
# This script sets up the development environment for the Dealer Portal project

set -e

echo "🚀 Setting up Dealer Portal Development Environment"
echo "=================================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if required tools are installed
check_requirements() {
    print_status "Checking system requirements..."
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 16+ first."
        exit 1
    fi
    
    NODE_VERSION=$(node --version | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 16 ]; then
        print_error "Node.js version 16+ is required. Current version: $(node --version)"
        exit 1
    fi
    print_success "Node.js $(node --version) ✓"
    
    # Check npm
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed."
        exit 1
    fi
    print_success "npm $(npm --version) ✓"
    
    # Check Java
    if ! command -v java &> /dev/null; then
        print_error "Java is not installed. Please install Java 11+ first."
        exit 1
    fi
    
    JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
    if [ "$JAVA_VERSION" -lt 11 ]; then
        print_error "Java version 11+ is required. Current version: $(java -version 2>&1 | head -n 1)"
        exit 1
    fi
    print_success "Java $(java -version 2>&1 | head -n 1) ✓"
    
    # Check Maven
    if ! command -v mvn &> /dev/null; then
        print_warning "Maven is not installed. Will use Maven wrapper."
    else
        print_success "Maven $(mvn --version | head -n 1) ✓"
    fi
    
    # Check PostgreSQL
    if ! command -v psql &> /dev/null; then
        print_warning "PostgreSQL is not installed. Please install PostgreSQL 13+ for database operations."
    else
        print_success "PostgreSQL $(psql --version) ✓"
    fi
}

# Setup database
setup_database() {
    print_status "Setting up database..."
    
    if ! command -v psql &> /dev/null; then
        print_warning "PostgreSQL not found. Skipping database setup."
        print_warning "Please install PostgreSQL and run the database setup manually:"
        echo "  psql -U postgres -c 'CREATE DATABASE dealer_portal;'"
        echo "  psql -U postgres -d dealer_portal -f db/schema/schema.sql"
        echo "  psql -U postgres -d dealer_portal -f db/seed/seed.sql"
        return
    fi
    
    # Try to create database
    if psql -U postgres -c "CREATE DATABASE dealer_portal;" 2>/dev/null; then
        print_success "Database 'dealer_portal' created successfully"
    else
        print_warning "Database 'dealer_portal' might already exist or connection failed"
    fi
    
    # Run schema
    if psql -U postgres -d dealer_portal -f db/schema/schema.sql 2>/dev/null; then
        print_success "Database schema applied successfully"
    else
        print_warning "Schema application failed. Please run manually:"
        echo "  psql -U postgres -d dealer_portal -f db/schema/schema.sql"
    fi
    
    # Run seed data
    if psql -U postgres -d dealer_portal -f db/seed/seed.sql 2>/dev/null; then
        print_success "Seed data applied successfully"
    else
        print_warning "Seed data application failed. Please run manually:"
        echo "  psql -U postgres -d dealer_portal -f db/seed/seed.sql"
    fi
}

# Install frontend dependencies
install_frontend_deps() {
    print_status "Installing frontend dependencies..."
    
    # Install web frontend dependencies
    cd frontend-web
    if [ -f "package-lock.json" ]; then
        npm ci
    else
        npm install
    fi
    print_success "Web frontend dependencies installed"
    cd ..
    
    # Install mobile frontend dependencies
    cd frontend-mobile
    if [ -f "package-lock.json" ]; then
        npm ci
    else
        npm install
    fi
    print_success "Mobile frontend dependencies installed"
    cd ..
}

# Install backend dependencies
install_backend_deps() {
    print_status "Installing backend dependencies..."
    
    cd backend
    if [ -f "mvnw" ]; then
        ./mvnw clean install -DskipTests
        print_success "Backend dependencies installed"
    else
        print_warning "Maven wrapper not found. Please run: mvn clean install -DskipTests"
    fi
    cd ..
}

# Create environment files
create_env_files() {
    print_status "Creating environment files..."
    
    # Backend environment
    if [ ! -f "backend/.env" ]; then
        cat > backend/.env << EOF
# Database Configuration
DB_URL=jdbc:postgresql://localhost:5432/dealer_portal
DB_USERNAME=postgres
DB_PASSWORD=postgres

# JWT Configuration
JWT_SECRET=dealer-portal-secret-key-2024
JWT_EXPIRATION=86400000

# Server Configuration
SERVER_PORT=8080
EOF
        print_success "Backend .env file created"
    fi
    
    # Frontend environment
    if [ ! -f "frontend-web/.env" ]; then
        cat > frontend-web/.env << EOF
# API Configuration
VITE_API_BASE_URL=http://localhost:8080/api
VITE_APP_NAME=Dealer Portal

# Development Configuration
VITE_DEV_MODE=true
EOF
        print_success "Web frontend .env file created"
    fi
    
    # Mobile environment
    if [ ! -f "frontend-mobile/.env" ]; then
        cat > frontend-mobile/.env << EOF
# API Configuration
API_BASE_URL=http://localhost:8080/api
APP_NAME=Dealer Portal

# Development Configuration
DEV_MODE=true
EOF
        print_success "Mobile frontend .env file created"
    fi
}

# Create development scripts
create_dev_scripts() {
    print_status "Creating development scripts..."
    
    # Create start-all script
    cat > start-all.sh << 'EOF'
#!/bin/bash

echo "🚀 Starting Dealer Portal Development Environment"
echo "================================================"

# Start backend
echo "Starting backend server..."
cd backend
./mvnw spring-boot:run &
BACKEND_PID=$!
cd ..

# Wait for backend to start
echo "Waiting for backend to start..."
sleep 10

# Start web frontend
echo "Starting web frontend..."
cd frontend-web
npm run dev &
WEB_PID=$!
cd ..

# Start mobile frontend (Metro bundler)
echo "Starting mobile Metro bundler..."
cd frontend-mobile
npm start &
MOBILE_PID=$!
cd ..

echo "✅ All services started!"
echo "Backend: http://localhost:8080"
echo "Web Frontend: http://localhost:3000"
echo "Mobile Metro: http://localhost:8081"
echo ""
echo "Press Ctrl+C to stop all services"

# Wait for interrupt
trap "echo 'Stopping all services...'; kill $BACKEND_PID $WEB_PID $MOBILE_PID; exit" INT
wait
EOF
    chmod +x start-all.sh
    print_success "start-all.sh script created"
    
    # Create stop-all script
    cat > stop-all.sh << 'EOF'
#!/bin/bash

echo "🛑 Stopping Dealer Portal Development Environment"

# Kill all Node.js processes
pkill -f "node.*dealer-portal" || true
pkill -f "npm.*dev" || true

# Kill Java processes
pkill -f "spring-boot:run" || true

echo "✅ All services stopped"
EOF
    chmod +x stop-all.sh
    print_success "stop-all.sh script created"
}

# Main setup function
main() {
    echo ""
    print_status "Starting setup process..."
    
    check_requirements
    setup_database
    install_frontend_deps
    install_backend_deps
    create_env_files
    create_dev_scripts
    
    echo ""
    print_success "Setup completed successfully! 🎉"
    echo ""
    echo "Next steps:"
    echo "1. Start the development environment: ./start-all.sh"
    echo "2. Access the web application: http://localhost:3000"
    echo "3. Access the API documentation: http://localhost:8080/swagger-ui.html"
    echo "4. For mobile development: cd frontend-mobile && npm run android/ios"
    echo ""
    echo "Default login credentials:"
    echo "  Email: admin@dealer-portal.com"
    echo "  Password: password"
    echo ""
    echo "Happy coding! 🚀"
}

# Run main function
main "$@" 