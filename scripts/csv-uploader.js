#!/usr/bin/env node

/**
 * CSV Upload Utility for Dealer Portal
 * 
 * This script helps test bulk CSV uploads to the inventory system.
 * It can generate sample CSV files and upload them to the API.
 */

const fs = require('fs');
const path = require('path');
const axios = require('axios');
const csv = require('csv-parser');
const createCsvWriter = require('csv-writer').createObjectCsvWriter;

// Configuration
const API_BASE_URL = process.env.API_BASE_URL || 'http://localhost:8080/api';
const AUTH_TOKEN = process.env.AUTH_TOKEN || '';

// Sample data for CSV generation
const sampleInventoryData = [
  {
    item_name: 'Engine Oil Filter',
    description: 'High-quality oil filter for various engine types',
    quantity: 150,
    location: 'Dallas',
    vendor_name: 'AutoParts Pro',
    delivery_date: '2024-02-15',
    status: 'ACTIVE',
    unit_price: 12.99,
    sku: 'OIL-FILTER-001'
  },
  {
    item_name: 'Air Filter',
    description: 'Premium air filter for improved engine performance',
    quantity: 200,
    location: 'Dallas',
    vendor_name: 'AutoParts Pro',
    delivery_date: '2024-02-10',
    status: 'ACTIVE',
    unit_price: 8.50,
    sku: 'AIR-FILTER-001'
  },
  {
    item_name: 'Spark Plugs Set',
    description: 'Iridium spark plugs set (4 pieces)',
    quantity: 75,
    location: 'Dallas',
    vendor_name: 'MotorCity Supplies',
    delivery_date: '2024-02-20',
    status: 'ACTIVE',
    unit_price: 24.99,
    sku: 'SPARK-PLUGS-001'
  },
  {
    item_name: 'Brake Pads Front',
    description: 'Ceramic brake pads for front wheels',
    quantity: 120,
    location: 'Chicago',
    vendor_name: 'MotorCity Supplies',
    delivery_date: '2024-02-12',
    status: 'ACTIVE',
    unit_price: 45.99,
    sku: 'BRAKE-PADS-FRONT-001'
  },
  {
    item_name: 'Brake Pads Rear',
    description: 'Ceramic brake pads for rear wheels',
    quantity: 100,
    location: 'Chicago',
    vendor_name: 'MotorCity Supplies',
    delivery_date: '2024-02-12',
    status: 'ACTIVE',
    unit_price: 39.99,
    sku: 'BRAKE-PADS-REAR-001'
  }
];

/**
 * Generate a sample CSV file
 */
function generateSampleCSV(filename = 'sample_inventory.csv', count = 100) {
  const csvWriter = createCsvWriter({
    path: filename,
    header: [
      { id: 'item_name', title: 'item_name' },
      { id: 'description', title: 'description' },
      { id: 'quantity', title: 'quantity' },
      { id: 'location', title: 'location' },
      { id: 'vendor_name', title: 'vendor_name' },
      { id: 'delivery_date', title: 'delivery_date' },
      { id: 'status', title: 'status' },
      { id: 'unit_price', title: 'unit_price' },
      { id: 'sku', title: 'sku' }
    ]
  });

  const data = [];
  for (let i = 0; i < count; i++) {
    const baseItem = sampleInventoryData[i % sampleInventoryData.length];
    data.push({
      ...baseItem,
      sku: `${baseItem.sku}-${String(i + 1).padStart(3, '0')}`,
      quantity: Math.floor(Math.random() * 200) + 10
    });
  }

  return csvWriter.writeRecords(data);
}

/**
 * Upload CSV file to the API
 */
async function uploadCSV(filePath) {
  try {
    const formData = new FormData();
    formData.append('file', fs.createReadStream(filePath));

    const response = await axios.post(`${API_BASE_URL}/inventory/upload`, formData, {
      headers: {
        'Authorization': `Bearer ${AUTH_TOKEN}`,
        'Content-Type': 'multipart/form-data'
      }
    });

    console.log('Upload successful:', response.data);
    return response.data;
  } catch (error) {
    console.error('Upload failed:', error.response?.data || error.message);
    throw error;
  }
}

/**
 * Validate CSV file structure
 */
function validateCSV(filePath) {
  return new Promise((resolve, reject) => {
    const results = [];
    const requiredHeaders = ['item_name', 'quantity', 'location', 'status'];
    let headers = [];

    fs.createReadStream(filePath)
      .pipe(csv())
      .on('headers', (headerList) => {
        headers = headerList;
      })
      .on('data', (data) => {
        results.push(data);
      })
      .on('end', () => {
        const missingHeaders = requiredHeaders.filter(h => !headers.includes(h));
        
        if (missingHeaders.length > 0) {
          reject(new Error(`Missing required headers: ${missingHeaders.join(', ')}`));
          return;
        }

        console.log(`CSV validation passed: ${results.length} records found`);
        resolve(results);
      })
      .on('error', reject);
  });
}

/**
 * Main function
 */
async function main() {
  const command = process.argv[2];
  const filename = process.argv[3] || 'sample_inventory.csv';
  const count = parseInt(process.argv[4]) || 100;

  try {
    switch (command) {
      case 'generate':
        console.log(`Generating sample CSV with ${count} records...`);
        await generateSampleCSV(filename, count);
        console.log(`Sample CSV generated: ${filename}`);
        break;

      case 'upload':
        console.log(`Uploading CSV file: ${filename}`);
        await validateCSV(filename);
        await uploadCSV(filename);
        console.log('Upload completed successfully');
        break;

      case 'validate':
        console.log(`Validating CSV file: ${filename}`);
        await validateCSV(filename);
        console.log('Validation completed successfully');
        break;

      default:
        console.log(`
CSV Upload Utility for Dealer Portal

Usage:
  node csv-uploader.js <command> [filename] [count]

Commands:
  generate [filename] [count]  Generate a sample CSV file
  upload [filename]            Upload CSV file to API
  validate [filename]          Validate CSV file structure

Examples:
  node csv-uploader.js generate sample.csv 50
  node csv-uploader.js upload sample.csv
  node csv-uploader.js validate sample.csv

Environment Variables:
  API_BASE_URL  API base URL (default: http://localhost:8080/api)
  AUTH_TOKEN    Authentication token for API requests
        `);
    }
  } catch (error) {
    console.error('Error:', error.message);
    process.exit(1);
  }
}

// Run if called directly
if (require.main === module) {
  main();
}

module.exports = {
  generateSampleCSV,
  uploadCSV,
  validateCSV
}; 