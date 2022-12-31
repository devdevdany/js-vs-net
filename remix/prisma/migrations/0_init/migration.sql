-- CreateTable
CREATE TABLE "Album"
(
    "AlbumId"  INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Title"    TEXT    NOT NULL,
    "ArtistId" INTEGER NOT NULL,
    CONSTRAINT "Album_ArtistId_fkey" FOREIGN KEY ("ArtistId") REFERENCES "Artist" ("ArtistId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Artist"
(
    "ArtistId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Name"     TEXT
);

-- CreateTable
CREATE TABLE "Customer"
(
    "CustomerId"   INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "FirstName"    TEXT    NOT NULL,
    "LastName"     TEXT    NOT NULL,
    "Company"      TEXT,
    "Address"      TEXT,
    "City"         TEXT,
    "State"        TEXT,
    "Country"      TEXT,
    "PostalCode"   TEXT,
    "Phone"        TEXT,
    "Fax"          TEXT,
    "Email"        TEXT    NOT NULL,
    "SupportRepId" INTEGER,
    CONSTRAINT "Customer_SupportRepId_fkey" FOREIGN KEY ("SupportRepId") REFERENCES "Employee" ("EmployeeId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Employee"
(
    "EmployeeId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "LastName"   TEXT    NOT NULL,
    "FirstName"  TEXT    NOT NULL,
    "Title"      TEXT,
    "ReportsTo"  INTEGER,
    "BirthDate"  DATETIME,
    "HireDate"   DATETIME,
    "Address"    TEXT,
    "City"       TEXT,
    "State"      TEXT,
    "Country"    TEXT,
    "PostalCode" TEXT,
    "Phone"      TEXT,
    "Fax"        TEXT,
    "Email"      TEXT,
    CONSTRAINT "Employee_ReportsTo_fkey" FOREIGN KEY ("ReportsTo") REFERENCES "Employee" ("EmployeeId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Genre"
(
    "GenreId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Name"    TEXT
);

-- CreateTable
CREATE TABLE "Invoice"
(
    "InvoiceId"         INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
    "CustomerId"        INTEGER  NOT NULL,
    "InvoiceDate"       DATETIME NOT NULL,
    "BillingAddress"    TEXT,
    "BillingCity"       TEXT,
    "BillingState"      TEXT,
    "BillingCountry"    TEXT,
    "BillingPostalCode" TEXT,
    "Total"             DECIMAL  NOT NULL,
    CONSTRAINT "Invoice_CustomerId_fkey" FOREIGN KEY ("CustomerId") REFERENCES "Customer" ("CustomerId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "InvoiceLine"
(
    "InvoiceLineId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "InvoiceId"     INTEGER NOT NULL,
    "TrackId"       INTEGER NOT NULL,
    "UnitPrice"     DECIMAL NOT NULL,
    "Quantity"      INTEGER NOT NULL,
    CONSTRAINT "InvoiceLine_TrackId_fkey" FOREIGN KEY ("TrackId") REFERENCES "Track" ("TrackId") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "InvoiceLine_InvoiceId_fkey" FOREIGN KEY ("InvoiceId") REFERENCES "Invoice" ("InvoiceId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "MediaType"
(
    "MediaTypeId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Name"        TEXT
);

-- CreateTable
CREATE TABLE "Playlist"
(
    "PlaylistId" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Name"       TEXT
);

-- CreateTable
CREATE TABLE "PlaylistTrack"
(
    "PlaylistId" INTEGER NOT NULL,
    "TrackId"    INTEGER NOT NULL,

    PRIMARY KEY ("PlaylistId", "TrackId"),
    CONSTRAINT "PlaylistTrack_TrackId_fkey" FOREIGN KEY ("TrackId") REFERENCES "Track" ("TrackId") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "PlaylistTrack_PlaylistId_fkey" FOREIGN KEY ("PlaylistId") REFERENCES "Playlist" ("PlaylistId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateTable
CREATE TABLE "Track"
(
    "TrackId"      INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "Name"         TEXT    NOT NULL,
    "AlbumId"      INTEGER,
    "MediaTypeId"  INTEGER NOT NULL,
    "GenreId"      INTEGER,
    "Composer"     TEXT,
    "Milliseconds" INTEGER NOT NULL,
    "Bytes"        INTEGER,
    "UnitPrice"    DECIMAL NOT NULL,
    CONSTRAINT "Track_MediaTypeId_fkey" FOREIGN KEY ("MediaTypeId") REFERENCES "MediaType" ("MediaTypeId") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "Track_GenreId_fkey" FOREIGN KEY ("GenreId") REFERENCES "Genre" ("GenreId") ON DELETE NO ACTION ON UPDATE NO ACTION,
    CONSTRAINT "Track_AlbumId_fkey" FOREIGN KEY ("AlbumId") REFERENCES "Album" ("AlbumId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- CreateIndex
CREATE INDEX "IFK_AlbumArtistId" ON "Album" ("ArtistId");

-- CreateIndex
CREATE INDEX "IFK_CustomerSupportRepId" ON "Customer" ("SupportRepId");

-- CreateIndex
CREATE INDEX "IFK_EmployeeReportsTo" ON "Employee" ("ReportsTo");

-- CreateIndex
CREATE INDEX "IFK_InvoiceCustomerId" ON "Invoice" ("CustomerId");

-- CreateIndex
CREATE INDEX "IFK_InvoiceLineTrackId" ON "InvoiceLine" ("TrackId");

-- CreateIndex
CREATE INDEX "IFK_InvoiceLineInvoiceId" ON "InvoiceLine" ("InvoiceId");

-- CreateIndex
CREATE INDEX "IFK_PlaylistTrackTrackId" ON "PlaylistTrack" ("TrackId");

-- CreateIndex
CREATE INDEX "IFK_TrackMediaTypeId" ON "Track" ("MediaTypeId");

-- CreateIndex
CREATE INDEX "IFK_TrackGenreId" ON "Track" ("GenreId");

-- CreateIndex
CREATE INDEX "IFK_TrackAlbumId" ON "Track" ("AlbumId");
