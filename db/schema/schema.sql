-- Dealer Portal Database Schema
-- PostgreSQL 13+

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR(50) NOT NULL CHECK (role IN ('ADMIN', 'VENDOR', 'LOGISTICS_USER')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Vendors table
CREATE TABLE vendors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inventory table
CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    description TEXT,
    quantity INT NOT NULL DEFAULT 0,
    location VARCHAR(100) NOT NULL,
    vendor_id INT REFERENCES vendors(id) ON DELETE SET NULL,
    delivery_date DATE,
    status VARCHAR(50) NOT NULL DEFAULT 'ACTIVE' CHECK (status IN ('ACTIVE', 'PENDING', 'OUT_OF_STOCK', 'DISCONTINUED')),
    unit_price DECIMAL(10,2),
    sku VARCHAR(50) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Upload logs table
CREATE TABLE upload_logs (
    id SERIAL PRIMARY KEY,
    file_id VARCHAR(255) UNIQUE NOT NULL,
    filename VARCHAR(255) NOT NULL,
    uploaded_by INT REFERENCES users(id) ON DELETE SET NULL,
    records_processed INT DEFAULT 0,
    records_successful INT DEFAULT 0,
    records_failed INT DEFAULT 0,
    upload_status VARCHAR(50) NOT NULL DEFAULT 'PENDING' CHECK (upload_status IN ('PENDING', 'PROCESSING', 'COMPLETED', 'FAILED')),
    error_message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- KPI cache table for performance
CREATE TABLE kpi_cache (
    id SERIAL PRIMARY KEY,
    kpi_type VARCHAR(50) NOT NULL,
    kpi_data JSONB NOT NULL,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(kpi_type)
);

-- Create indexes for performance
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
CREATE INDEX idx_inventory_location ON inventory(location);
CREATE INDEX idx_inventory_status ON inventory(status);
CREATE INDEX idx_inventory_vendor_id ON inventory(vendor_id);
CREATE INDEX idx_inventory_delivery_date ON inventory(delivery_date);
CREATE INDEX idx_upload_logs_uploaded_by ON upload_logs(uploaded_by);
CREATE INDEX idx_upload_logs_created_at ON upload_logs(created_at);

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_vendors_updated_at BEFORE UPDATE ON vendors
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_inventory_updated_at BEFORE UPDATE ON inventory
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Create views for common queries
CREATE VIEW inventory_summary AS
SELECT 
    i.id,
    i.item_name,
    i.quantity,
    i.location,
    v.name as vendor_name,
    i.delivery_date,
    i.status,
    i.unit_price,
    i.created_at
FROM inventory i
LEFT JOIN vendors v ON i.vendor_id = v.id;

CREATE VIEW vendor_inventory_summary AS
SELECT 
    v.id as vendor_id,
    v.name as vendor_name,
    COUNT(i.id) as total_items,
    SUM(i.quantity) as total_quantity,
    AVG(i.unit_price) as avg_unit_price
FROM vendors v
LEFT JOIN inventory i ON v.id = i.vendor_id
GROUP BY v.id, v.name;

-- Create function to refresh KPI cache
CREATE OR REPLACE FUNCTION refresh_kpi_cache()
RETURNS VOID AS $$
BEGIN
    -- Vendor KPI
    INSERT INTO kpi_cache (kpi_type, kpi_data, last_updated)
    VALUES (
        'vendor_summary',
        (SELECT jsonb_agg(
            jsonb_build_object(
                'vendor_id', vendor_id,
                'vendor_name', vendor_name,
                'total_items', total_items,
                'total_quantity', total_quantity,
                'avg_unit_price', avg_unit_price
            )
        ) FROM vendor_inventory_summary),
        CURRENT_TIMESTAMP
    )
    ON CONFLICT (kpi_type) 
    DO UPDATE SET 
        kpi_data = EXCLUDED.kpi_data,
        last_updated = CURRENT_TIMESTAMP;

    -- Location KPI
    INSERT INTO kpi_cache (kpi_type, kpi_data, last_updated)
    VALUES (
        'location_summary',
        (SELECT jsonb_agg(
            jsonb_build_object(
                'location', location,
                'total_items', COUNT(*),
                'total_quantity', SUM(quantity),
                'avg_unit_price', AVG(unit_price)
            )
        ) FROM inventory GROUP BY location),
        CURRENT_TIMESTAMP
    )
    ON CONFLICT (kpi_type) 
    DO UPDATE SET 
        kpi_data = EXCLUDED.kpi_data,
        last_updated = CURRENT_TIMESTAMP;
END;
$$ LANGUAGE plpgsql; 