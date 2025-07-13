-- Seed data for Dealer Portal
-- Run this after schema.sql

-- Insert sample users
INSERT INTO users (email, password_hash, role) VALUES
('admin@dealer-portal.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'ADMIN'), -- password: password
('vendor1@supplier.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'VENDOR'),
('vendor2@supplier.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'VENDOR'),
('logistics@dealer-portal.com', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'LOGISTICS_USER');

-- Insert sample vendors
INSERT INTO vendors (name, contact_email, phone, address) VALUES
('AutoParts Pro', 'contact@autopartspro.com', '+1-555-0101', '123 Industrial Blvd, Detroit, MI 48201'),
('MotorCity Supplies', 'sales@motorcitysupplies.com', '+1-555-0102', '456 Warehouse Dr, Detroit, MI 48202'),
('Premium Auto Components', 'info@premiumautocomponents.com', '+1-555-0103', '789 Manufacturing Ave, Chicago, IL 60601'),
('Elite Auto Parts', 'orders@eliteautoparts.com', '+1-555-0104', '321 Distribution Center Rd, Dallas, TX 75201'),
('Quality Auto Supply', 'service@qualityautosupply.com', '+1-555-0105', '654 Logistics Way, Atlanta, GA 30301');

-- Insert sample inventory items
INSERT INTO inventory (item_name, description, quantity, location, vendor_id, delivery_date, status, unit_price, sku) VALUES
-- Engine Components
('Engine Oil Filter', 'High-quality oil filter for various engine types', 150, 'Dallas', 1, '2024-02-15', 'ACTIVE', 12.99, 'OIL-FILTER-001'),
('Air Filter', 'Premium air filter for improved engine performance', 200, 'Dallas', 1, '2024-02-10', 'ACTIVE', 8.50, 'AIR-FILTER-001'),
('Spark Plugs Set', 'Iridium spark plugs set (4 pieces)', 75, 'Dallas', 2, '2024-02-20', 'ACTIVE', 24.99, 'SPARK-PLUGS-001'),

-- Brake Components
('Brake Pads Front', 'Ceramic brake pads for front wheels', 120, 'Chicago', 2, '2024-02-12', 'ACTIVE', 45.99, 'BRAKE-PADS-FRONT-001'),
('Brake Pads Rear', 'Ceramic brake pads for rear wheels', 100, 'Chicago', 2, '2024-02-12', 'ACTIVE', 39.99, 'BRAKE-PADS-REAR-001'),
('Brake Rotors', 'Vented brake rotors for improved cooling', 60, 'Chicago', 3, '2024-02-18', 'ACTIVE', 89.99, 'BRAKE-ROTORS-001'),

-- Transmission Components
('Transmission Fluid', 'Synthetic transmission fluid 1L', 300, 'Atlanta', 3, '2024-02-08', 'ACTIVE', 15.99, 'TRANS-FLUID-001'),
('Clutch Kit', 'Complete clutch kit with pressure plate', 25, 'Atlanta', 3, '2024-02-25', 'ACTIVE', 299.99, 'CLUTCH-KIT-001'),
('CV Joint Boot', 'CV joint boot replacement kit', 80, 'Atlanta', 4, '2024-02-14', 'ACTIVE', 18.50, 'CV-BOOT-001'),

-- Electrical Components
('Battery', '12V automotive battery 60Ah', 40, 'Detroit', 4, '2024-02-16', 'ACTIVE', 129.99, 'BATTERY-001'),
('Alternator', 'High-output alternator 140A', 15, 'Detroit', 4, '2024-02-22', 'ACTIVE', 199.99, 'ALTERNATOR-001'),
('Starter Motor', 'Heavy-duty starter motor', 20, 'Detroit', 5, '2024-02-19', 'ACTIVE', 159.99, 'STARTER-001'),

-- Suspension Components
('Shock Absorbers', 'Gas-charged shock absorbers (pair)', 50, 'Dallas', 5, '2024-02-11', 'ACTIVE', 89.99, 'SHOCKS-001'),
('Control Arms', 'Front control arms with bushings', 30, 'Dallas', 1, '2024-02-17', 'ACTIVE', 75.99, 'CONTROL-ARMS-001'),
('Tie Rod Ends', 'Inner and outer tie rod ends', 90, 'Chicago', 1, '2024-02-13', 'ACTIVE', 22.99, 'TIE-RODS-001'),

-- Cooling System
('Radiator', 'Aluminum radiator for various models', 25, 'Atlanta', 2, '2024-02-21', 'ACTIVE', 249.99, 'RADIATOR-001'),
('Water Pump', 'High-flow water pump', 35, 'Atlanta', 2, '2024-02-09', 'ACTIVE', 69.99, 'WATER-PUMP-001'),
('Thermostat', 'Temperature-controlled thermostat', 150, 'Detroit', 3, '2024-02-15', 'ACTIVE', 12.50, 'THERMOSTAT-001'),

-- Exhaust System
('Catalytic Converter', 'EPA-compliant catalytic converter', 20, 'Dallas', 3, '2024-02-23', 'ACTIVE', 399.99, 'CAT-CONVERTER-001'),
('Muffler', 'Performance muffler with resonator', 30, 'Chicago', 4, '2024-02-20', 'ACTIVE', 89.99, 'MUFFLER-001'),
('Exhaust Pipes', 'Stainless steel exhaust pipes', 40, 'Atlanta', 4, '2024-02-16', 'ACTIVE', 45.99, 'EXHAUST-PIPES-001'),

-- Interior Components
('Floor Mats', 'Custom-fit floor mats (set of 4)', 100, 'Detroit', 5, '2024-02-12', 'ACTIVE', 34.99, 'FLOOR-MATS-001'),
('Seat Covers', 'Universal seat covers (pair)', 80, 'Dallas', 5, '2024-02-14', 'ACTIVE', 29.99, 'SEAT-COVERS-001'),
('Steering Wheel Cover', 'Leather steering wheel cover', 120, 'Chicago', 1, '2024-02-18', 'ACTIVE', 19.99, 'STEERING-COVER-001'),

-- Pending Items
('LED Headlights', 'High-performance LED headlight kit', 0, 'Dallas', 2, '2024-03-01', 'PENDING', 199.99, 'LED-HEADLIGHTS-001'),
('Turbocharger', 'Performance turbocharger kit', 0, 'Chicago', 3, '2024-03-05', 'PENDING', 899.99, 'TURBO-001'),
('Nitrous Kit', 'Wet nitrous oxide injection kit', 0, 'Atlanta', 4, '2024-03-10', 'PENDING', 599.99, 'NITROUS-001'),

-- Out of Stock Items
('Carbon Fiber Hood', 'Lightweight carbon fiber hood', 0, 'Detroit', 5, '2024-02-28', 'OUT_OF_STOCK', 1299.99, 'CARBON-HOOD-001'),
('Racing Seats', 'Competition racing seats (pair)', 0, 'Dallas', 1, '2024-03-02', 'OUT_OF_STOCK', 799.99, 'RACING-SEATS-001');

-- Insert sample upload logs
INSERT INTO upload_logs (file_id, filename, uploaded_by, records_processed, records_successful, records_failed, upload_status) VALUES
('upload-001', 'inventory_batch_1.csv', 1, 25, 23, 2, 'COMPLETED'),
('upload-002', 'vendor_inventory.csv', 1, 15, 15, 0, 'COMPLETED'),
('upload-003', 'new_items.csv', 1, 10, 8, 2, 'COMPLETED');

-- Refresh KPI cache
SELECT refresh_kpi_cache(); 