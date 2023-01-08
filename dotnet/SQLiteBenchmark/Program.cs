using Microsoft.EntityFrameworkCore;
using SQLiteBenchmark.Data;
using SQLiteBenchmark.JsonConverters;
using SQLiteBenchmark.JsonNamingPolicies;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddDbContextPool<ChinookSqliteContext>(optionsBuilder =>
{
    optionsBuilder.UseSqlite(builder.Configuration.GetConnectionString("ChinookSqliteContext"));
});

var decimalJsonConverter = new DecimalJsonConverter();
var nullableDecimalJsonConverter = new NullableDecimalJsonConverter();
var dateTimeJsonConverter = new DateTimeJsonConverter();
var nullableDateTimeJsonConverter = new NullableDateTimeJsonConverter();
builder.Services.ConfigureHttpJsonOptions(options =>
{
    options.SerializerOptions.PropertyNamingPolicy = new LeaveUnchangedNamingPolicy();
    options.SerializerOptions.Converters.Add(decimalJsonConverter);
    options.SerializerOptions.Converters.Add(nullableDecimalJsonConverter);
    options.SerializerOptions.Converters.Add(dateTimeJsonConverter);
    options.SerializerOptions.Converters.Add(nullableDateTimeJsonConverter);
});

var app = builder.Build();

app.MapGet("/", static async (ChinookSqliteContext db) => new
    {
        albums = await db.Albums.AsNoTracking()
            .Select(static album => new { album.AlbumId, album.Title, album.ArtistId }).ToListAsync(),
        artists = await db.Artists.AsNoTracking().Select(static artist => new { artist.ArtistId, artist.Name })
            .ToListAsync(),
        customers = await db.Customers.AsNoTracking().Select(static customer => new
        {
            customer.CustomerId, customer.FirstName, customer.LastName, customer.Company, customer.Address,
            customer.City, customer.State, customer.Country, customer.PostalCode, customer.Phone, customer.Fax,
            customer.Email, customer.SupportRepId
        }).ToListAsync(),
        employees = await db.Employees.AsNoTracking().Select(static employee => new
        {
            employee.EmployeeId, employee.LastName, employee.FirstName, employee.Title, employee.ReportsTo,
            employee.BirthDate, employee.HireDate, employee.Address, employee.City, employee.State, employee.Country,
            employee.PostalCode, employee.Phone, employee.Fax, employee.Email
        }).ToListAsync(),
        genres = await db.Genres.AsNoTracking().Select(static genre => new { genre.GenreId, genre.Name }).ToListAsync(),
        invoices = await db.Invoices.AsNoTracking().Select(static invoice => new
        {
            invoice.InvoiceId, invoice.CustomerId, invoice.InvoiceDate, invoice.BillingAddress, invoice.BillingCity,
            invoice.BillingState, invoice.BillingCountry, invoice.BillingPostalCode, invoice.Total
        }).ToListAsync(),
        invoiceLines = await db.InvoiceLines.AsNoTracking().Select(static invoiceLine =>
            new
            {
                invoiceLine.InvoiceLineId, invoiceLine.InvoiceId, invoiceLine.TrackId, invoiceLine.UnitPrice,
                invoiceLine.Quantity
            }).ToListAsync(),
        mediaTypes = await db.MediaTypes.AsNoTracking()
            .Select(static mediaType => new { mediaType.MediaTypeId, mediaType.Name }).ToListAsync(),
        playlists = await db.Playlists.AsNoTracking()
            .Select(static playlist => new { playlist.PlaylistId, playlist.Name }).ToListAsync(),
        tracks = await db.Tracks.AsNoTracking().Select(static track => new
        {
            track.TrackId, track.Name, track.AlbumId, track.MediaTypeId, track.GenreId, track.Composer,
            track.Milliseconds, track.Bytes, track.UnitPrice
        }).ToListAsync()
    }
);

app.Run();
