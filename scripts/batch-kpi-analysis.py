#!/usr/bin/env python3

"""
KPI Analysis Utility for Dealer Portal

This script performs batch KPI analysis on inventory data and generates reports.
It can analyze vendor performance, location distribution, and inventory trends.
"""

import requests
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from datetime import datetime, timedelta
import json
import argparse
import os
from typing import Dict, List, Any

# Configuration
API_BASE_URL = os.getenv('API_BASE_URL', 'http://localhost:8080/api')
AUTH_TOKEN = os.getenv('AUTH_TOKEN', '')

class KPIAnalyzer:
    def __init__(self, api_url: str, auth_token: str = ''):
        self.api_url = api_url
        self.auth_token = auth_token
        self.headers = {
            'Authorization': f'Bearer {auth_token}',
            'Content-Type': 'application/json'
        } if auth_token else {'Content-Type': 'application/json'}

    def fetch_inventory_data(self) -> pd.DataFrame:
        """Fetch inventory data from API"""
        try:
            response = requests.get(f"{self.api_url}/inventory", headers=self.headers)
            response.raise_for_status()
            data = response.json()
            
            if 'content' in data:
                return pd.DataFrame(data['content'])
            else:
                return pd.DataFrame(data)
        except requests.RequestException as e:
            print(f"Error fetching inventory data: {e}")
            return pd.DataFrame()

    def fetch_kpi_data(self, kpi_type: str) -> Dict[str, Any]:
        """Fetch KPI data from API"""
        try:
            response = requests.get(f"{self.api_url}/kpi/{kpi_type}", headers=self.headers)
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Error fetching {kpi_type} KPI data: {e}")
            return {}

    def analyze_vendor_performance(self, df: pd.DataFrame) -> Dict[str, Any]:
        """Analyze vendor performance metrics"""
        if df.empty:
            return {}

        vendor_analysis = df.groupby('vendor_name').agg({
            'quantity': ['sum', 'mean', 'count'],
            'unit_price': ['mean', 'sum'],
            'status': lambda x: (x == 'ACTIVE').sum()
        }).round(2)

        vendor_analysis.columns = [
            'total_quantity', 'avg_quantity', 'item_count',
            'avg_unit_price', 'total_value', 'active_items'
        ]

        return {
            'summary': vendor_analysis.to_dict('index'),
            'top_vendors': vendor_analysis.nlargest(5, 'total_value').to_dict('index'),
            'low_stock_vendors': vendor_analysis[vendor_analysis['total_quantity'] < 100].to_dict('index')
        }

    def analyze_location_distribution(self, df: pd.DataFrame) -> Dict[str, Any]:
        """Analyze inventory distribution by location"""
        if df.empty:
            return {}

        location_analysis = df.groupby('location').agg({
            'quantity': ['sum', 'count'],
            'unit_price': 'mean',
            'status': lambda x: (x == 'ACTIVE').sum()
        }).round(2)

        location_analysis.columns = ['total_quantity', 'item_count', 'avg_unit_price', 'active_items']

        return {
            'summary': location_analysis.to_dict('index'),
            'top_locations': location_analysis.nlargest(5, 'total_quantity').to_dict('index'),
            'low_stock_locations': location_analysis[location_analysis['total_quantity'] < 500].to_dict('index')
        }

    def analyze_inventory_trends(self, df: pd.DataFrame) -> Dict[str, Any]:
        """Analyze inventory trends and patterns"""
        if df.empty:
            return {}

        # Status distribution
        status_distribution = df['status'].value_counts().to_dict()

        # Price range analysis
        price_ranges = pd.cut(df['unit_price'], bins=[0, 50, 100, 200, 500, 1000, float('inf')], 
                             labels=['$0-50', '$50-100', '$100-200', '$200-500', '$500-1000', '$1000+'])
        price_distribution = price_ranges.value_counts().to_dict()

        # Quantity analysis
        quantity_ranges = pd.cut(df['quantity'], bins=[0, 10, 50, 100, 500, float('inf')], 
                                labels=['0-10', '11-50', '51-100', '101-500', '500+'])
        quantity_distribution = quantity_ranges.value_counts().to_dict()

        return {
            'status_distribution': status_distribution,
            'price_distribution': price_distribution,
            'quantity_distribution': quantity_distribution,
            'total_items': len(df),
            'total_value': (df['quantity'] * df['unit_price']).sum(),
            'avg_unit_price': df['unit_price'].mean(),
            'low_stock_items': len(df[df['quantity'] < 10])
        }

    def generate_charts(self, df: pd.DataFrame, output_dir: str = 'reports'):
        """Generate charts and visualizations"""
        if df.empty:
            print("No data available for chart generation")
            return

        os.makedirs(output_dir, exist_ok=True)
        
        # Set style
        plt.style.use('seaborn-v0_8')
        sns.set_palette("husl")

        # 1. Vendor Performance Chart
        vendor_performance = df.groupby('vendor_name')['quantity'].sum().sort_values(ascending=False).head(10)
        plt.figure(figsize=(12, 6))
        vendor_performance.plot(kind='bar')
        plt.title('Top 10 Vendors by Total Quantity')
        plt.xlabel('Vendor')
        plt.ylabel('Total Quantity')
        plt.xticks(rotation=45, ha='right')
        plt.tight_layout()
        plt.savefig(f'{output_dir}/vendor_performance.png', dpi=300, bbox_inches='tight')
        plt.close()

        # 2. Location Distribution Chart
        location_distribution = df.groupby('location')['quantity'].sum().sort_values(ascending=False)
        plt.figure(figsize=(10, 6))
        location_distribution.plot(kind='pie', autopct='%1.1f%%')
        plt.title('Inventory Distribution by Location')
        plt.ylabel('')
        plt.tight_layout()
        plt.savefig(f'{output_dir}/location_distribution.png', dpi=300, bbox_inches='tight')
        plt.close()

        # 3. Status Distribution Chart
        status_distribution = df['status'].value_counts()
        plt.figure(figsize=(8, 6))
        status_distribution.plot(kind='bar')
        plt.title('Inventory Status Distribution')
        plt.xlabel('Status')
        plt.ylabel('Count')
        plt.tight_layout()
        plt.savefig(f'{output_dir}/status_distribution.png', dpi=300, bbox_inches='tight')
        plt.close()

        # 4. Price vs Quantity Scatter Plot
        plt.figure(figsize=(10, 6))
        plt.scatter(df['unit_price'], df['quantity'], alpha=0.6)
        plt.title('Price vs Quantity Distribution')
        plt.xlabel('Unit Price ($)')
        plt.ylabel('Quantity')
        plt.tight_layout()
        plt.savefig(f'{output_dir}/price_quantity_scatter.png', dpi=300, bbox_inches='tight')
        plt.close()

        print(f"Charts generated in {output_dir}/")

    def generate_report(self, output_file: str = 'kpi_report.json'):
        """Generate comprehensive KPI report"""
        print("Fetching inventory data...")
        df = self.fetch_inventory_data()
        
        if df.empty:
            print("No data available for analysis")
            return

        print("Analyzing vendor performance...")
        vendor_analysis = self.analyze_vendor_performance(df)
        
        print("Analyzing location distribution...")
        location_analysis = self.analyze_location_distribution(df)
        
        print("Analyzing inventory trends...")
        trend_analysis = self.analyze_inventory_trends(df)

        # Generate charts
        print("Generating charts...")
        self.generate_charts(df)

        # Compile report
        report = {
            'generated_at': datetime.now().isoformat(),
            'data_summary': {
                'total_records': len(df),
                'unique_vendors': df['vendor_name'].nunique(),
                'unique_locations': df['location'].nunique(),
                'date_range': {
                    'earliest': df['created_at'].min() if 'created_at' in df.columns else None,
                    'latest': df['created_at'].max() if 'created_at' in df.columns else None
                }
            },
            'vendor_analysis': vendor_analysis,
            'location_analysis': location_analysis,
            'trend_analysis': trend_analysis,
            'recommendations': self.generate_recommendations(df)
        }

        # Save report
        with open(output_file, 'w') as f:
            json.dump(report, f, indent=2, default=str)

        print(f"KPI report generated: {output_file}")
        return report

    def generate_recommendations(self, df: pd.DataFrame) -> List[str]:
        """Generate actionable recommendations based on analysis"""
        recommendations = []

        # Low stock items
        low_stock = df[df['quantity'] < 10]
        if len(low_stock) > 0:
            recommendations.append(f"⚠️  {len(low_stock)} items have low stock (quantity < 10)")

        # Out of stock items
        out_of_stock = df[df['status'] == 'OUT_OF_STOCK']
        if len(out_of_stock) > 0:
            recommendations.append(f"🚨 {len(out_of_stock)} items are out of stock")

        # High-value items with low quantity
        high_value_low_stock = df[(df['unit_price'] > 100) & (df['quantity'] < 5)]
        if len(high_value_low_stock) > 0:
            recommendations.append(f"💰 {len(high_value_low_stock)} high-value items have low stock")

        # Vendors with low inventory
        vendor_low_stock = df.groupby('vendor_name')['quantity'].sum()
        low_stock_vendors = vendor_low_stock[vendor_low_stock < 100]
        if len(low_stock_vendors) > 0:
            recommendations.append(f"📦 {len(low_stock_vendors)} vendors have low total inventory")

        return recommendations

def main():
    parser = argparse.ArgumentParser(description='KPI Analysis Utility for Dealer Portal')
    parser.add_argument('--output', '-o', default='kpi_report.json', help='Output file for report')
    parser.add_argument('--api-url', default=API_BASE_URL, help='API base URL')
    parser.add_argument('--auth-token', default=AUTH_TOKEN, help='Authentication token')
    parser.add_argument('--charts-only', action='store_true', help='Generate charts only')
    
    args = parser.parse_args()

    analyzer = KPIAnalyzer(args.api_url, args.auth_token)

    if args.charts_only:
        df = analyzer.fetch_inventory_data()
        analyzer.generate_charts(df)
    else:
        analyzer.generate_report(args.output)

if __name__ == '__main__':
    main() 