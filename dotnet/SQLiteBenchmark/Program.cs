using Microsoft.EntityFrameworkCore;
using SQLiteBenchmark.Data;

var builder = WebApplication.CreateBuilder(args);
builder.Services.AddSqlite<ChinookSqliteContext>("Data Source=Chinook_Sqlite.sqlite");
var app = builder.Build();

app.MapGet("/", static async (ChinookSqliteContext db) => new
    {
        albums = await db.Albums.ToListAsync(),
        artists = await db.Artists.ToListAsync(),
        customers = await db.Customers.ToListAsync(),
        employees = await db.Employees.ToListAsync(),
        genres = await db.Genres.ToListAsync(),
        invoices = await db.Invoices.ToListAsync(),
        invoiceLines = await db.InvoiceLines.ToListAsync(),
        mediaTypes = await db.MediaTypes.ToListAsync(),
        playlists = await db.Playlists.ToListAsync(),
        tracks = await db.Tracks.ToListAsync(),
    }
);

app.Run();
