# Dealer Inventory & Vendor Intelligence Portal – Technical Specification

## 1. Frontend (Web & Mobile)

### Tech Stack
- **Web:** React (Vite), TypeScript, TailwindCSS, React Query, React Router, Formik/Yup
- **Mobile:** React Native (TypeScript), React Navigation, React Query, NativeBase or TailwindCSS

### Best Practices
- Use functional components and React hooks exclusively
- Organize code by feature (feature-based folder structure)
- Use TypeScript for type safety
- Centralize API calls in a dedicated service layer
- Use environment variables for config
- Write unit tests with Jest and React Testing Library
- Use ESLint and Prettier for code quality and formatting

### Example Prompts
- **Inventory List Page:**
  > Create a paginated, searchable inventory table using React, TypeScript, and TailwindCSS. Fetch data via React Query from `/api/inventory`. Each row should have actions for view, edit, and delete. Use a modal for editing.
- **Vendor Analytics Dashboard:**
  > Build a dashboard page that visualizes vendor KPIs using Recharts. Fetch analytics data from `/api/vendors/analytics`. Use React Query for data fetching and caching.
- **Authentication Flow:**
  > Implement a login page with Formik and Yup for validation. On submit, call `/api/auth/login` and store the JWT in HttpOnly cookies (web) or SecureStore (mobile). Redirect to dashboard on success.

---

## 2. Middleware (API Gateway/Backend-for-Frontend Layer)

### Tech Stack
- **Node.js** with Express.js (TypeScript)
- **Purpose:** API aggregation, request validation, rate limiting, CORS, logging, and proxying to backend services

### Best Practices
- Use express middlewares for validation (`express-validator`), logging (`morgan`), and error handling
- Centralize authentication/authorization logic
- Use environment variables for config
- Write integration tests with Jest and Supertest
- Use OpenAPI/Swagger for API documentation

### Example Prompts
- > Create an Express middleware that validates JWTs in the Authorization header for all `/api/*` routes. Reject requests with 401 if invalid or missing.
- > Implement a rate limiter using `express-rate-limit` to allow max 100 requests per 15 minutes per IP.
- > Proxy all `/api/inventory` requests to the backend service at `http://backend:8080/api/inventory` and return the response.

---

## 3. Backend (Java Spring Boot)

### Tech Stack
- **Java 17+**, **Spring Boot 3+**, **Spring Security**, **Spring Data JPA**, **MapStruct**, **Lombok**, **Swagger/OpenAPI**

### Best Practices
- Use layered architecture: Controller → Service → Repository
- DTOs for all API input/output; never expose entities directly
- Use MapStruct for mapping between entities and DTOs
- Use constructor injection for dependencies
- Centralized exception handling with `@ControllerAdvice`
- Write unit and integration tests (JUnit, Mockito, Testcontainers)
- Use OpenAPI annotations for API docs

### Example Prompts
- > Implement a REST controller for `/api/inventory` with CRUD endpoints. Use DTOs for requests/responses. Validate input with `@Valid` and custom validators.
- > Add a service method to fetch paginated inventory with optional filters for make, model, and year.
- > Secure all endpoints with JWT authentication using Spring Security. Only users with role `ADMIN` can delete inventory.

---

## 4. Authentication

### Recommended Approach
- **JWT (JSON Web Tokens)** for stateless authentication
- **Spring Security** (backend) for token validation and role-based access
- **HttpOnly Cookies** (web) for storing JWTs (prevents XSS)
- **SecureStore** (mobile) for storing JWTs securely
- **Refresh Tokens** for session renewal (store refresh token in HttpOnly cookie)

### Best Practices
- Never store JWTs in localStorage/sessionStorage
- Use HTTPS everywhere
- Implement token expiration and refresh logic
- Use strong password hashing (BCrypt)
- Implement account lockout after repeated failed logins

### Example Prompts
- > Implement a `/api/auth/login` endpoint that authenticates user credentials, returns a JWT (access token) in an HttpOnly cookie, and a refresh token.
- > Create a `/api/auth/refresh` endpoint to issue new access tokens using a valid refresh token.
- > Protect all sensitive endpoints with a JWT filter in Spring Security.

---

## 5. Database

### Recommended DB
- **PostgreSQL** (free, open-source, robust, supports advanced queries and JSONB)

### Best Practices
- Use normalized schema for inventory, vendors, users, roles, analytics, etc.
- Use UUIDs as primary keys
- Use migrations (Flyway or Liquibase) for schema management
- Use parameterized queries (via JPA) to prevent SQL injection
- Index frequently queried columns
- Store secrets/config in environment variables, not in code

### Example Prompts
- > Design a PostgreSQL schema for inventory, vendors, users, and roles. Use UUIDs for all primary keys. Add foreign key constraints and indexes for performance.
- > Write a Flyway migration script to create the `inventory` table with columns: id (UUID), make, model, year, price, vendor_id (UUID, FK), created_at, updated_at.
- > Implement a repository method to fetch all inventory items for a given vendor, paginated and sorted by updated_at.

---

## 6. General Best Practices
- Use GitHub Actions for CI/CD (lint, test, build)
- Use `.env` files for all secrets/config (never commit secrets)
- Write clear, concise documentation (README, API docs)
- Use code reviews and pull requests for all changes
- Write tests for all business logic and critical paths
- Use semantic versioning and conventional commits

---

## 7. Example Feature: Inventory Management

### Frontend
- Inventory list, search, filter, add/edit/delete forms, validation, optimistic UI updates

### Middleware
- JWT validation, request logging, proxy to backend, input validation

### Backend
- CRUD endpoints, DTOs, service layer, repository, validation, role-based access

### DB
- Inventory table, vendor FK, user/role tables, migrations

### Authentication
- JWT-based, role checks, refresh tokens, secure storage 