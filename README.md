# E-commerce Database Management System

## About This Project

Hello! I'm excited to share my **E-commerce Database Management System** – a complete relational database solution I built using MySQL. This project demonstrates my understanding of database design principles, relationship modeling, and constraint implementation through a real-world e-commerce scenario.

## What I Built

I designed a streamlined 5-entity database system that captures the core functionality of an online retail store. Rather than creating an overly complex system, I focused on demonstrating all essential database relationships while keeping the design clean and manageable.

### My Database Entities

1. **Users** - Customer account management
2. **Categories** - Hierarchical product categorization  
3. **Products** - Complete product catalog
4. **Orders** - Customer purchase tracking
5. **Order_Items** - Junction table for order details

## Database Relationships I Implemented

### One-to-Many Relationships
- **Users → Orders**: Each customer can place multiple orders
- **Categories → Products**: Each category contains multiple products
- **Orders → Order_Items**: Each order can have multiple line items

### Many-to-Many Relationship
- **Products ↔ Orders**: Products can appear in multiple orders, and orders can contain multiple products (implemented via the `order_items` junction table)

### Self-Referencing Relationship
- **Categories → Categories**: I created a category hierarchy where categories can have parent categories (e.g., Electronics > Computers > Laptops)

## Key Features I Implemented

### Comprehensive Constraints
- **Primary Keys**: Auto-incrementing IDs for all tables
- **Foreign Keys**: Proper referential integrity with CASCADE/RESTRICT rules
- **Unique Constraints**: Username, email, SKU, and composite constraints
- **Check Constraints**: Email format validation, positive prices, non-negative stock levels
- **Not Null Constraints**: All essential business fields properly protected

### Sample Data
I populated each table with 5 realistic records to demonstrate the relationships:
- 5 customers from different cities
- 5 product categories with parent-child hierarchy
- 5 products across different categories
- 5 orders with various statuses
- 5 order items showing cross-references

### Business Logic
- Automatic price calculations
- Stock quantity validation
- Order status tracking
- Customer relationship management

## How to Use This Database

### Prerequisites
- MySQL Server 5.7+ or MySQL 8.0+
- MySQL Workbench or command line access
- Basic understanding of SQL

### Installation Steps
1. Download the `ecommerce_store.sql` file
2. Open MySQL Workbench or connect via command line
3. Execute the entire script:
   #sql
   SOURCE /path/to/ecommerce_store.sql;
 
4. The script will automatically:
   - Drop any existing database
   - Create the new database and tables
   - Insert all sample data
   - Run verification queries

### Verification
After running the script, you'll see output showing:
- All table contents
- Relationship demonstrations
- Category hierarchy visualization
- Product popularity analysis
- Customer order summaries

## What This Project Demonstrates

### Database Design Skills
- **Normalization**: Proper table structure following 3NF principles
- **Relationship Modeling**: All relationship types implemented correctly
- **Constraint Design**: Comprehensive data integrity enforcement
- **Index Strategy**: Performance optimization through strategic indexing

### Real-World Application
- **E-commerce Domain Knowledge**: Understanding of online retail operations
- **Business Logic**: Practical constraints that reflect real business rules
- **Scalability**: Design that can handle growth and additional features
- **Data Integrity**: Robust validation and referential integrity

### Technical Proficiency
- **Advanced SQL**: Complex joins, subqueries, and aggregate functions
- **MySQL Features**: Proper use of data types, constraints, and triggers
- **Documentation**: Clear, comprehensive documentation and comments
- **Testing**: Verification queries to validate all functionality

## Future Enhancements

While this system demonstrates core concepts, I designed it to be easily extensible:

- **Payment Processing**: Add payment method and transaction tables
- **Inventory Management**: Implement stock tracking and supplier management
- **Customer Reviews**: Add product rating and review functionality
- **Shipping Integration**: Include shipping providers and tracking
- **Analytics**: Add reporting tables for business intelligence

## Technical Specifications

- **Database Engine**: MySQL 8.0+ compatible
- **Storage Requirements**: Minimal (sample data only)
- **Performance**: Optimized with strategic indexes
- **Scalability**: Designed for horizontal scaling
- **Security**: Input validation via CHECK constraints

## Contact & Collaboration

I'm always interested in discussing database design, SQL optimization, and system architecture. Feel free to reach out if you have questions about my implementation choices or want to collaborate on similar projects.

This project represents my systematic approach to database design – starting with business requirements, modeling relationships, implementing constraints, and validating with real data. I believe it showcases both my technical SQL skills and my understanding of practical business applications.
