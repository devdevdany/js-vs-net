-- CreateTable
CREATE TABLE "Categories"
(
    "CategoryID"   INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "CategoryName" TEXT,
    "Description"  TEXT,
    "Picture"      BLOB
);

-- CreateTable
CREATE TABLE "CustomerCustomerDemo"
(
    "CustomerID"     TEXT NOT NULL,
    "CustomerTypeID" TEXT NOT NULL,

    PRIMARY KEY ("CustomerID", "CustomerTypeID"),
    CONSTRAINT "CustomerCustomerDemo_CustomerTypeID_fkey" FOREIGN KEY ("CustomerTypeID") REFERENCES "CustomerDemographics" ("CustomerTypeID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "CustomerCustomerDemo_CustomerID_fkey" FOREIGN KEY ("CustomerID") REFERENCES "Customers" ("CustomerID") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "CustomerDemographics"
(
    "CustomerTypeID" TEXT NOT NULL PRIMARY KEY,
    "CustomerDesc"   TEXT
);

-- CreateTable
CREATE TABLE "Customers"
(
    "CustomerID"   TEXT PRIMARY KEY,
    "CompanyName"  TEXT,
    "ContactName"  TEXT,
    "ContactTitle" TEXT,
    "Address"      TEXT,
    "City"         TEXT,
    "Region"       TEXT,
    "PostalCode"   TEXT,
    "Country"      TEXT,
    "Phone"        TEXT,
    "Fax"          TEXT
);

-- CreateTable
CREATE TABLE "EmployeeTerritories"
(
    "EmployeeID"  INTEGER NOT NULL,
    "TerritoryID" TEXT    NOT NULL,

    PRIMARY KEY ("EmployeeID", "TerritoryID"),
    CONSTRAINT "EmployeeTerritories_TerritoryID_fkey" FOREIGN KEY ("TerritoryID") REFERENCES "Territories" ("TerritoryID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "EmployeeTerritories_EmployeeID_fkey" FOREIGN KEY ("EmployeeID") REFERENCES "Employees" ("EmployeeID") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Employees"
(
    "EmployeeID"      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "LastName"        TEXT,
    "FirstName"       TEXT,
    "Title"           TEXT,
    "TitleOfCourtesy" TEXT,
    "BirthDate"       DATETIME,
    "HireDate"        DATETIME,
    "Address"         TEXT,
    "City"            TEXT,
    "Region"          TEXT,
    "PostalCode"      TEXT,
    "Country"         TEXT,
    "HomePhone"       TEXT,
    "Extension"       TEXT,
    "Photo"           BLOB,
    "Notes"           TEXT,
    "ReportsTo"       INTEGER,
    "PhotoPath"       TEXT,
    CONSTRAINT "Employees_ReportsTo_fkey" FOREIGN KEY ("ReportsTo") REFERENCES "Employees" ("EmployeeID") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Order Details"
(
    "OrderID"   INTEGER NOT NULL,
    "ProductID" INTEGER NOT NULL,
    "UnitPrice" DECIMAL NOT NULL DEFAULT 0,
    "Quantity"  INTEGER NOT NULL DEFAULT 1,
    "Discount"  REAL    NOT NULL DEFAULT 0,

    PRIMARY KEY ("OrderID", "ProductID"),
    CONSTRAINT "Order Details_ProductID_fkey" FOREIGN KEY ("ProductID") REFERENCES "Products" ("ProductID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "Order Details_OrderID_fkey" FOREIGN KEY ("OrderID") REFERENCES "Orders" ("OrderID") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Orders"
(
    "OrderID"        INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "CustomerID"     TEXT,
    "EmployeeID"     INTEGER,
    "OrderDate"      DATETIME,
    "RequiredDate"   DATETIME,
    "ShippedDate"    DATETIME,
    "ShipVia"        INTEGER,
    "Freight"        DECIMAL DEFAULT 0,
    "ShipName"       TEXT,
    "ShipAddress"    TEXT,
    "ShipCity"       TEXT,
    "ShipRegion"     TEXT,
    "ShipPostalCode" TEXT,
    "ShipCountry"    TEXT,
    CONSTRAINT "Orders_ShipVia_fkey" FOREIGN KEY ("ShipVia") REFERENCES "Shippers" ("ShipperID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "Orders_CustomerID_fkey" FOREIGN KEY ("CustomerID") REFERENCES "Customers" ("CustomerID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "Orders_EmployeeID_fkey" FOREIGN KEY ("EmployeeID") REFERENCES "Employees" ("EmployeeID") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Products"
(
    "ProductID"       INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "ProductName"     TEXT    NOT NULL,
    "SupplierID"      INTEGER,
    "CategoryID"      INTEGER,
    "QuantityPerUnit" TEXT,
    "UnitPrice"       DECIMAL          DEFAULT 0,
    "UnitsInStock"    INTEGER          DEFAULT 0,
    "UnitsOnOrder"    INTEGER          DEFAULT 0,
    "ReorderLevel"    INTEGER          DEFAULT 0,
    "Discontinued"    TEXT    NOT NULL DEFAULT '0',
    CONSTRAINT "Products_SupplierID_fkey" FOREIGN KEY ("SupplierID") REFERENCES "Suppliers" ("SupplierID") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "Products_CategoryID_fkey" FOREIGN KEY ("CategoryID") REFERENCES "Categories" ("CategoryID") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Regions"
(
    "RegionID"          INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "RegionDescription" TEXT    NOT NULL
);

-- CreateTable
CREATE TABLE "Shippers"
(
    "ShipperID"   INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "CompanyName" TEXT    NOT NULL,
    "Phone"       TEXT
);

-- CreateTable
CREATE TABLE "Suppliers"
(
    "SupplierID"   INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "CompanyName"  TEXT    NOT NULL,
    "ContactName"  TEXT,
    "ContactTitle" TEXT,
    "Address"      TEXT,
    "City"         TEXT,
    "Region"       TEXT,
    "PostalCode"   TEXT,
    "Country"      TEXT,
    "Phone"        TEXT,
    "Fax"          TEXT,
    "HomePage"     TEXT
);

-- CreateTable
CREATE TABLE "Territories"
(
    "TerritoryID"          TEXT    NOT NULL PRIMARY KEY,
    "TerritoryDescription" TEXT    NOT NULL,
    "RegionID"             INTEGER NOT NULL,
    CONSTRAINT "Territories_RegionID_fkey" FOREIGN KEY ("RegionID") REFERENCES "Regions" ("RegionID") ON DELETE NO ACTION ON UPDATE NO ACTION
);
