import {Database} from "bun:sqlite"; // NOSONAR

const db = Database.open("./db/Chinook_Sqlite.sqlite");

const albumsQuery = db.prepare(`select AlbumId, Title, ArtistId
                                from Album`);
const artistsQuery = db.prepare(`select ArtistId, Name
                                 from Artist`);
const customersQuery = db.prepare(`select CustomerId,
                                          FirstName,
                                          LastName,
                                          Company,
                                          Address,
                                          City,
                                          State,
                                          Country,
                                          PostalCode,
                                          Phone,
                                          Fax,
                                          Email,
                                          SupportRepId
                                   from Customer`);
const employeesQuery = db.prepare(`select EmployeeId,
                                          LastName,
                                          FirstName,
                                          Title,
                                          ReportsTo,
                                          BirthDate,
                                          HireDate,
                                          Address,
                                          City,
                                          State,
                                          Country,
                                          PostalCode,
                                          Phone,
                                          Fax,
                                          Email
                                   from Employee`);
const genresQuery = db.prepare(`select GenreId, Name
                                from Genre`);
const invoicesQuery = db.prepare(`select InvoiceId,
                                         CustomerId,
                                         InvoiceDate,
                                         BillingAddress,
                                         BillingCity,
                                         BillingState,
                                         BillingCountry,
                                         BillingPostalCode,
                                         Total
                                  from Invoice`);
const invoiceLinesQuery = db.prepare(`select InvoiceLineId,
                                             InvoiceId,
                                             TrackId,
                                             UnitPrice,
                                             Quantity
                                      from InvoiceLine`);
const mediaTypesQuery = db.prepare(`select MediaTypeId, Name
                                    from MediaType`);
const playlistsQuery = db.prepare(`select PlaylistId, Name
                                   from Playlist`);
const tracksQuery = db.prepare(`select TrackId,
                                       Name,
                                       AlbumId,
                                       MediaTypeId,
                                       GenreId,
                                       Composer,
                                       Milliseconds,
                                       Bytes,
                                       UnitPrice
                                from Track`);

const datePattern = /(?<date>\d{4}-\d{2}-\d{2})\s(?<time>\d{2}:\d{2}:\d{2})/;

Bun.serve({
  port: 8888,
  fetch() {
    return new Response(JSON.stringify({
      albums: albumsQuery.all(),
      artists: artistsQuery.all(),
      customers: customersQuery.all(),
      employees: employeesQuery.all(),
      genres: genresQuery.all(),
      invoices: invoicesQuery.all(),
      invoiceLines: invoiceLinesQuery.all(),
      mediaTypes: mediaTypesQuery.all(),
      playlists: playlistsQuery.all(),
      tracks: tracksQuery.all(),
    }, (_key: string, value: unknown) => {
      if (typeof value === "number") {
        return String(value);
      }

      if (typeof value === "string") {
        return value.replace(datePattern, "$<date>T$<time>.000Z");
      }

      return value;
    }));
  },
  error(error: Error) {
    return new Response(`Uh oh!! ${error.toString()}`, {status: 500});
  },
});
