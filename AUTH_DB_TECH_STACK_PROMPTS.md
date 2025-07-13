# Authentication & Database Tech Stack Prompts

---

# Dealer Inventory & Vendor Intelligence Portal – Technical Specification

## 1. Frontend (Web & Mobile)

### Tech Stack
* **Web:** React (Vite), TypeScript, TailwindCSS, React Query, React Router, Formik/Yup
* **Mobile:** React Native (TypeScript), React Navigation, React Query, NativeBase or TailwindCSS

### Best Practices
* Use functional components and React hooks exclusively
* Organize code by feature (feature-based folder structure)
* Use TypeScript for type safety
* Centralize API calls in a dedicated service layer
* Use environment variables for config
* Write unit tests with Jest and React Testing Library
* Use ESLint and Prettier for code quality and formatting

### Example Prompts
* **Inventory List Page:**
  > Build a responsive, searchable inventory management table using React + TypeScript. Fetch data from `/api/inventory` using React Query. Include filters (status, vendor), pagination, and modals for add/edit forms with Formik/Yup. Use Tailwind for styling. Make the UI WCAG accessible.
* **Vendor Analytics Dashboard:**
  > Implement a KPI dashboard using Recharts. Fetch data from `/api/vendors/analytics`. Include a pie chart (vendor-wise distribution), bar chart (monthly trends), and a data table. Cache data with React Query.
* **Authentication Flow:**
  > Create login/register pages with Formik and Yup validation. On success, store JWT in HttpOnly cookies or SecureStore (mobile). Redirect user based on role. Protect routes using React Router.

---

## 2. Middleware (API Gateway/BFF)

### Tech Stack
* **Node.js** with Express.js (TypeScript)

### Best Practices
* Express middleware for auth (`express-jwt`), validation (`express-validator`), logging (`morgan`)
* Proxy backend APIs securely
* Use dotenv for environment variables
* Rate limiting and error normalization

### Example Prompts
* > Create `/api/*` middleware that verifies JWT and logs all request metadata. Add a proxy to Spring Boot APIs using `http-proxy-middleware`. Implement centralized error handler and return JSON: `{ success, message, data }`.
* > Add CORS config to allow frontend origin. Implement rate limiting (100 req/15min/IP).
* > Add route `/api/upload-csv` that validates file size < 5MB and content-type as CSV before forwarding to backend.

---

## 3. Backend (Java Spring Boot)

### Tech Stack
* Java 17, Spring Boot 3+, Spring Security, Spring Data JPA, MapStruct, Lombok

### Best Practices
* Controller → Service → Repository pattern
* DTOs for API layers, never expose entity
* MapStruct for DTO conversion
* Exception handling with `@ControllerAdvice`
* Swagger/OpenAPI for documentation

### Example Prompts
* > Create REST controller `/api/inventory` with GET/POST/PUT/DELETE methods. Use DTOs with validations and map using MapStruct. Restrict POST/DELETE to ADMIN.
* > Secure `/api/auth/*` with JWT and Spring Security. Create `UserDetailsService` and use BCrypt for password hashing.
* > Expose `/api/dashboard/summary` endpoint to return total inventory, vendors, sessions, and active users in a single DTO.

---

## 4. Authentication

### Approach
* JWT for authentication
* Store tokens in HttpOnly cookies (web) or SecureStore (mobile)
* Use refresh tokens for session extension

### Example Prompts
* > Implement `/api/auth/login` that validates credentials, returns access & refresh tokens in cookies. Add `/api/auth/refresh` to issue new access token using valid refresh token.
* > Use Spring Security filters to intercept and verify JWTs on every request. Use roles to restrict endpoint access.
* > Implement logout endpoint that clears cookie-based tokens and logs logout event.

---

## 5. Database (PostgreSQL)

### Schema Guidelines
* Use normalized schemas with UUIDs as PKs
* Use Flyway for schema migration
* Add constraints, FK indexes

### Tables
* `users(id UUID, name, email, password, role, created_at)`
* `inventory(id UUID, name, price, quantity, vendor_id FK, status, created_at)`
* `vendors(id UUID, name, location, email, created_at)`
* `upload_logs(id UUID, filename, user_id FK, status, total_rows, error_count, uploaded_at)`

### Example Prompts
* > Write a Flyway script to create the `inventory` table with UUID PK, indexed `vendor_id`, and `created_at`. Add `status` ENUM column.
* > Add query in repository to fetch inventory filtered by `vendor_id` and `status`, sorted by `updated_at`.

---

## 6. Developer Environment

### Tools
* VSCode, Cursor, Copilot
* Swagger UI
* Postman
* GitHub Projects & Actions for CI/CD

---

## 7. CI/CD & Testing

### Guidelines
* Use GitHub Actions for lint + test + build
* Add Cypress (E2E), Jest (unit), JUnit (backend)

### Example Prompts
* > Configure GitHub Actions for each PR to run: `npm lint`, `npm test`, `build`.
* > Add Postman collection and Newman CLI test runner.

---

## 8. Sample Feature Implementation – Inventory

### Frontend
* React Table with filters, search, edit modal
* Formik forms, Yup validation
* Use `/api/inventory` via Axios + React Query

### Middleware
* JWT validation
* API request proxy
* Payload validation

### Backend
* Spring Boot endpoints `/api/inventory`
* DTOs, service logic, MapStruct, security roles

### DB
* Table with fields, index, vendor FK

---

# 🛡️ Authentication Tasks

### 1. Backend (Spring Boot)
**Prompt:**  
Implement authentication using **JWT (JSON Web Tokens)** for stateless auth.
- Use **Spring Security** for authentication and authorization.
- Use **jjwt** (`io.jsonwebtoken:jjwt-api`) or **spring-boot-starter-oauth2-resource-server** for JWT handling.
- Use **BCrypt** (`org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder`) for password hashing.
- Store JWT access tokens in **HttpOnly cookies** (for web) and use **refresh tokens** for session renewal.
- Secure all endpoints with role-based access control using Spring Security annotations.
- Never store tokens in localStorage/sessionStorage.

**Example Library Deps (Maven):**
```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-security</artifactId>
</dependency>
<dependency>
  <groupId>io.jsonwebtoken</groupId>
  <artifactId>jjwt-api</artifactId>
  <version>0.11.5</version>
</dependency>
<dependency>
  <groupId>org.springframework.security</groupId>
  <artifactId>spring-security-crypto</artifactId>
</dependency>
```

---

### 2. Middleware (Node.js/Express)
**Prompt:**  
Use **express-jwt** or **jsonwebtoken** for JWT validation in Express middleware.
- Use **express-validator** for input validation.
- Use **express-rate-limit** for rate limiting login attempts.
- Validate JWTs on all `/api/*` routes and reject unauthorized requests.

**Example Library Deps (npm):**
```bash
npm install express jsonwebtoken express-jwt express-validator express-rate-limit
```

---

### 3. Frontend (React/React Native)
**Prompt:**  
- For web, store JWT in **HttpOnly cookies** (set by backend).
- For mobile, use **expo-secure-store** or **@react-native-async-storage/async-storage** (prefer SecureStore for sensitive data).
- Use **Formik** and **Yup** for login form validation.
- On login, POST to `/api/auth/login`, handle errors, and redirect on success.

**Example Library Deps (npm):**
```bash
npm install formik yup
npm install expo-secure-store # for React Native
```

---

# 🗄️ Database Tasks

### 1. Database Choice
**Prompt:**  
Use **PostgreSQL** as the primary database for all persistent data (users, inventory, vendors, sessions, analytics).
- PostgreSQL is free, open-source, robust, and supports advanced queries and JSONB.

---

### 2. Backend (Spring Boot)
**Prompt:**  
- Use **Spring Data JPA** for ORM and repository pattern.
- Use **Flyway** or **Liquibase** for database migrations.
- Use **UUIDs** as primary keys for all tables.
- Store DB credentials in environment variables, never in code.

**Example Library Deps (Maven):**
```xml
<dependency>
  <groupId>org.springframework.boot</groupId>
  <artifactId>spring-boot-starter-data-jpa</artifactId>
</dependency>
<dependency>
  <groupId>org.postgresql</groupId>
  <artifactId>postgresql</artifactId>
  <scope>runtime</scope>
</dependency>
<dependency>
  <groupId>org.flywaydb</groupId>
  <artifactId>flyway-core</artifactId>
</dependency>
```

---

### 3. Middleware (Node.js/Express)
**Prompt:**  
- If the middleware needs to access the DB (rare, usually proxies), use **pg** (node-postgres) for PostgreSQL.
- Otherwise, proxy all DB-related requests to the backend.

**Example Library Deps (npm):**
```bash
npm install pg
```

---

### 4. DB Management
**Prompt:**  
- Use **pgAdmin** or **DBeaver** for GUI-based DB management.
- Use **.env** files for DB connection strings and secrets.

---

# 🔑 Summary Table

| Layer      | Auth Library/Tool                | DB Library/Tool         | DB Choice     |
|------------|----------------------------------|-------------------------|--------------|
| Backend    | Spring Security, jjwt, BCrypt    | Spring Data JPA, Flyway | PostgreSQL   |
| Middleware | express-jwt, jsonwebtoken        | pg (if needed)          | PostgreSQL   |
| Frontend   | HttpOnly cookies, SecureStore    | —                       | —            | 