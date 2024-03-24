-- Creating the Customers Table
CREATE TABLE Customers (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    Country VARCHAR(50),
    RegistrationDate TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Creating the Suppliers Table
CREATE TABLE Suppliers (
    SupplierID SERIAL PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(50),
    Country VARCHAR(50),
    Phone VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

-- Creating the Categories Table
CREATE TABLE Categories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    Description TEXT
);

-- Creating the Products Table
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    SupplierID INT,
    CategoryID INT,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Description TEXT,
    StockQuantity INT NOT NULL DEFAULT 0,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Creating the Orders Table
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    CustomerID INT,
    OrderDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    ShippingAddress VARCHAR(255),
    OrderStatus VARCHAR(50) DEFAULT 'Processing',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Creating the OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Creating the Payments Table
CREATE TABLE Payments (
    PaymentID SERIAL PRIMARY KEY,
    OrderID INT,
    PaymentDate TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Creating the CustomerFeedback Table
CREATE TABLE CustomerFeedback (
    FeedbackID SERIAL PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    FeedbackDate TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);