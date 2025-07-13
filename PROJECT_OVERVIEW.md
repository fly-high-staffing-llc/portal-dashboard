# 🚗 Dealer Inventory & Vendor Intelligence Portal – Project Overview

## 1. Project Overview
The Dealer Inventory & Vendor Intelligence Portal is a full-stack, enterprise-grade platform designed to help automotive dealerships efficiently manage their inventory, analyze vendor performance, and gain actionable business insights. The system supports both web and mobile interfaces, providing a seamless experience for admins, managers, and staff.

---

## 2. Core Objectives
- **Centralized Inventory Management:** Track, update, and analyze all vehicles and assets in real time.
- **Vendor Intelligence:** Evaluate vendor performance, manage relationships, and optimize procurement.
- **Business Analytics:** Visualize KPIs, trends, and operational metrics with interactive dashboards.
- **Role-Based Access:** Secure, granular permissions for admins, managers, and users.
- **Seamless User Experience:** Consistent, modern UI/UX across web and mobile.
- **Scalability & Maintainability:** Modular, best-practice codebase for easy extension and robust operation.

---

## 3. Key Features
- **Dashboard:** Overview of inventory, vendors, sessions, and KPIs with charts and summary cards.
- **Inventory Management:** CRUD operations, search, filter, and bulk upload (CSV) for vehicles/assets.
- **Vendor Management:** Add/edit vendors, view analytics, and manage relationships.
- **Analytics & Reports:** Visual dashboards (bar, pie charts), exportable data, and trend analysis.
- **Authentication & Authorization:** JWT-based login, refresh tokens, role-based access, secure session handling.
- **User Profile & Settings:** Manage user info, password, preferences, and notifications.
- **Mobile App:** Key features available on-the-go for field staff and managers.

---

## 4. Architecture Overview
### Frontend
- **Web:** React (Vite), TypeScript, TailwindCSS, React Query, React Router, Formik/Yup, Recharts
- **Mobile:** React Native (TypeScript), React Navigation, React Query, NativeBase/TailwindCSS

### Middleware (API Gateway/BFF)
- **Node.js** with Express.js (TypeScript)
- Handles JWT validation, request proxying, input validation, rate limiting, and logging

### Backend
- **Java 17+, Spring Boot 3+, Spring Security, Spring Data JPA, MapStruct, Lombok**
- RESTful APIs, business logic, DTO mapping, role-based security, and OpenAPI docs

### Database
- **PostgreSQL** (normalized schema, UUID PKs, Flyway migrations)
- Tables: users, inventory, vendors, upload_logs, etc.

### DevOps & Tooling
- **CI/CD:** GitHub Actions (lint, test, build, deploy)
- **Testing:** Jest, React Testing Library, Cypress (frontend); JUnit, Mockito (backend)
- **API Docs:** Swagger/OpenAPI
- **Collaboration:** GitHub Projects, VSCode, Cursor, Postman

---

## 5. UI/UX & Design System
- **Theme:** Modern, clean, accessible (WCAG), with consistent color palette and typography
- **Atomic Design:** Atoms (buttons, inputs), Molecules (cards, tables), Organisms (dashboards, forms), Pages (routes)
- **Responsive:** Mobile-first, adaptive layouts for all devices
- **Icons:** Lucide/Heroicons, Inter font

---

## 6. Security & Best Practices
- **Authentication:** JWT (HttpOnly cookies for web, SecureStore for mobile), refresh tokens, BCrypt password hashing
- **Authorization:** Role-based access control (Spring Security)
- **Validation:** Formik/Yup (frontend), express-validator (middleware), JSR-303 (backend)
- **Error Handling:** Centralized, user-friendly error messages
- **Environment Config:** .env files, never commit secrets
- **Code Quality:** ESLint, Prettier, code reviews, PR-based workflow

---

## 7. Sample Data Flow
1. **User logs in** via web/mobile → credentials sent to `/api/auth/login`
2. **Middleware** validates input, proxies to backend
3. **Backend** authenticates, issues JWT/refresh token (stored securely)
4. **Frontend** fetches dashboard data from `/api/dashboard/summary`
5. **Middleware** validates JWT, proxies to backend
6. **Backend** aggregates data, returns DTOs
7. **Frontend** renders dashboard with charts, tables, and cards

---

## 8. Extensibility & Future Roadmap
- **Integrate third-party vendor APIs**
- **Advanced analytics (ML-based insights)**
- **Push notifications (mobile/web)**
- **Multi-language support**
- **Customizable dashboards and reports**

---

## 9. Getting Started
- Clone the repo, follow the README for setup
- Use provided scripts for DB schema and seed data
- Run frontend, middleware, and backend locally
- Access API docs via Swagger UI
- Use Postman collections for API testing

---

## 10. References
- [Technical Specification](./TECHNICAL_SPECIFICATION.md)
- [Auth & DB Tech Stack Prompts](./AUTH_DB_TECH_STACK_PROMPTS.md)
- [Figma Design System](#) (attach link)
- [Swagger API Docs](http://localhost:8080/swagger-ui.html) 