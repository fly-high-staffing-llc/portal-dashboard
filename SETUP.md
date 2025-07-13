# 🛠️ Full Stack Developer Environment Setup Guide

This guide will help you set up the complete Dealer Inventory & Vendor Intelligence Portal stack, including frontend (web & mobile), middleware, backend, and database. Follow each section step-by-step for a smooth development experience.

---

## 1. Prerequisites & Core Tools

### 1.1 Node.js & npm
- **Download:** [Node.js Official Site](https://nodejs.org/)
- **Verify installation:**
  ```bash
  node -v
  npm -v
  ```

### 1.2 Git
- **Download:** [Git Official Site](https://git-scm.com/)
- **Configure:**
  ```bash
  git config --global user.name "Your Name"
  git config --global user.email "you@example.com"
  ```

### 1.3 Visual Studio Code (VS Code)
- **Download:** [VS Code](https://code.visualstudio.com/)
- **Recommended Extensions:**
  - ESLint
  - Prettier
  - GitHub Copilot
  - React Snippets
  - Tabnine AI (optional)

### 1.4 Cursor IDE ( AI-powered)
- **Download:** [Cursor](https://www.cursor.so)
- **Connect to GitHub** for AI-enhanced collaboration

### 1.5 Postman
- **Download:** [Postman](https://www.postman.com/downloads/)
- **Usage:** Test RESTful APIs, send GET/POST requests to backend endpoints

---

## 2. Frontend Setup

### 2.1 Web (React + Vite + TailwindCSS)
- **Clone the repo:**
  ```bash
  git clone <your-repo-url>
  cd frontend-web
  ```
- **Install dependencies:**
  ```bash
  npm install
  ```
- **Start the dev server:**
  ```bash
  npm run dev
  ```
- **Access:** [http://localhost:5173](http://localhost:5173) (default Vite port)

### 2.2 Mobile (React Native with Expo)
- **Install Expo CLI:**
  ```bash
  npm install -g expo-cli
  ```
- **Create/enter app directory:**
  ```bash
  cd ../frontend-mobile
  npm install
  ```
- **Start Expo server:**
  ```bash
  expo start
  ```
- **Install Expo Go** on your iOS/Android device to preview the app.

---

## 3. Middleware Setup (Node.js/Express)
- **Navigate to middleware directory (if present):**
  ```bash
  cd ../middleware
  npm install
  npm run dev
  ```
- **Configure environment variables:**
  - Copy `.env.example` to `.env` and fill in required values (API URLs, secrets, etc.)
- **Verify:** Middleware should proxy API requests and handle JWT validation.

---

## 4. Backend Setup (Java Spring Boot)

### 4.1 Java JDK (17+)
- **Download:** [Adoptium Temurin](https://adoptium.net/temurin/releases)
- **Verify:**
  ```bash
  java -version
  ```

### 4.2 IDE
- **Preferred:** [IntelliJ IDEA](https://www.jetbrains.com/idea/download/)
- **Alternative:** [Eclipse](https://www.eclipse.org/downloads/)

### 4.3 Spring Boot Project
- **Import project:**
  - Use [Spring Initializr](https://start.spring.io) for new projects
  - For this repo, open `backend` in your IDE
- **Install dependencies:**
  - Maven will auto-install on build
- **Run backend:**
  ```bash
  cd backend
  ./mvnw spring-boot:run
  ```
- **Access API docs:** [http://localhost:8080/swagger-ui.html](http://localhost:8080/swagger-ui.html)

---

## 5. Database Setup (PostgreSQL)

### 5.1 Install PostgreSQL
- **Download:** [PostgreSQL](https://www.postgresql.org/download/)
- **GUI Tool:** pgAdmin (included in installer)
- **Alternative SQL Client:** [DBeaver](https://dbeaver.io/)

### 5.2 Create Database
- **DB Name:** `dealer_portal`
- **Tables:** users, inventory, vendors, upload_logs (see schema in `/db/schema/schema.sql`)
- **Run schema and seed scripts:**
  - Use pgAdmin or DBeaver to execute `/db/schema/schema.sql` and `/db/seed/seed.sql`

### 5.3 Environment Variables
- Set DB connection details in backend `.env` or `application.yml`:
  ```yaml
  spring:
    datasource:
      url: jdbc:postgresql://localhost:5432/dealer_portal
      username: <your_db_user>
      password: <your_db_password>
  ```

---

## 6. Optional: MongoDB (For NoSQL Practice)
- **Create account:** [MongoDB Atlas](https://www.mongodb.com/cloud/atlas)
- **GUI Tool:** [MongoDB Compass](https://www.mongodb.com/try/download/compass)
- **Connect URI:**
  ```
  mongodb+srv://<user>:<password>@cluster.mongodb.net/dealer_portal
  ```

---

## 7. GitHub & Collaboration
- **Sign up:** [GitHub](https://github.com/)
- **Clone/fork project repo**
- **Push local code changes via terminal**
- **Use GitHub Projects for task management**
- **Open Pull Requests for code review**

---

## 8. AI Tools & Productivity
- **Cursor IDE:** For AI-powered code suggestions
- **GitHub Copilot:** For code completion
- **Tabnine:** For intelligent code completions

---

## 9. Testing & CI/CD
- **Frontend:**
  - Unit: Jest, React Testing Library
  - E2E: Cypress
- **Backend:**
  - Unit: JUnit, Mockito
- **API:**
  - Postman collections, Newman CLI
- **CI/CD:**
  - GitHub Actions (see `.github/workflows/deploy.yml`)

---

## 10. Troubleshooting & Tips
- **Ports in use:** Change default ports in `.env` or config files if conflicts occur
- **Dependency issues:** Delete `node_modules` and run `npm install` again
- **Database connection:** Ensure PostgreSQL is running and credentials are correct
- **API errors:** Check logs in backend and middleware for stack traces
- **Swagger not loading:** Ensure backend is running and dependencies are installed

---

## 11. Best Practices
- Use `.env` files for all secrets/config (never commit secrets)
- Use feature-based folder structure
- Write tests for all business logic and critical paths
- Use code reviews and pull requests for all changes
- Keep dependencies up to date

---

## 12. References
- [Technical Specification](./TECHNICAL_SPECIFICATION.md)
- [Project Overview](./PROJECT_OVERVIEW.md)
- [Auth & DB Tech Stack Prompts](./AUTH_DB_TECH_STACK_PROMPTS.md)
- [Swagger API Docs](http://localhost:8080/swagger-ui.html)
- [Figma Design System](#) (attach link) 