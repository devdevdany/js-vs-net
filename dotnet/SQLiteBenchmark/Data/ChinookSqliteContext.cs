using Microsoft.EntityFrameworkCore;
using SQLiteBenchmark.Models;

namespace SQLiteBenchmark.Data;

public partial class ChinookSqliteContext : DbContext
{
    public ChinookSqliteContext()
    {
    }

    public ChinookSqliteContext(DbContextOptions<ChinookSqliteContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Album> Albums { get; set; }

    public virtual DbSet<Artist> Artists { get; set; }

    public virtual DbSet<Customer> Customers { get; set; }

    public virtual DbSet<Employee> Employees { get; set; }

    public virtual DbSet<Genre> Genres { get; set; }

    public virtual DbSet<Invoice> Invoices { get; set; }

    public virtual DbSet<InvoiceLine> InvoiceLines { get; set; }

    public virtual DbSet<MediaType> MediaTypes { get; set; }

    public virtual DbSet<Playlist> Playlists { get; set; }

    public virtual DbSet<Track> Tracks { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code
// You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration
// - see https: //go.microsoft.com/fwlink/?linkid=2131148.
// For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlite("Data Source=Chinook_Sqlite.sqlite");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Album>(entity =>
        {
            entity.Property(e => e.AlbumId).ValueGeneratedNever();

            entity.HasOne(d => d.Artist).WithMany(p => p.Albums).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<Artist>(entity => { entity.Property(e => e.ArtistId).ValueGeneratedNever(); });

        modelBuilder.Entity<Customer>(entity => { entity.Property(e => e.CustomerId).ValueGeneratedNever(); });

        modelBuilder.Entity<Employee>(entity => { entity.Property(e => e.EmployeeId).ValueGeneratedNever(); });

        modelBuilder.Entity<Genre>(entity => { entity.Property(e => e.GenreId).ValueGeneratedNever(); });

        modelBuilder.Entity<Invoice>(entity =>
        {
            entity.Property(e => e.InvoiceId).ValueGeneratedNever();

            entity.HasOne(d => d.Customer).WithMany(p => p.Invoices).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<InvoiceLine>(entity =>
        {
            entity.Property(e => e.InvoiceLineId).ValueGeneratedNever();

            entity.HasOne(d => d.Invoice).WithMany(p => p.InvoiceLines).OnDelete(DeleteBehavior.ClientSetNull);

            entity.HasOne(d => d.Track).WithMany(p => p.InvoiceLines).OnDelete(DeleteBehavior.ClientSetNull);
        });

        modelBuilder.Entity<MediaType>(entity => { entity.Property(e => e.MediaTypeId).ValueGeneratedNever(); });

        modelBuilder.Entity<Playlist>(entity =>
        {
            entity.Property(e => e.PlaylistId).ValueGeneratedNever();

            entity.HasMany(d => d.Tracks).WithMany(p => p.Playlists)
                .UsingEntity<Dictionary<string, object>>(
                    "PlaylistTrack",
                    r => r.HasOne<Track>().WithMany()
                        .HasForeignKey("TrackId")
                        .OnDelete(DeleteBehavior.ClientSetNull),
                    l => l.HasOne<Playlist>().WithMany()
                        .HasForeignKey("PlaylistId")
                        .OnDelete(DeleteBehavior.ClientSetNull),
                    j =>
                    {
                        j.HasKey("PlaylistId", "TrackId");
                        j.ToTable("PlaylistTrack");
                        j.HasIndex(new[] { "TrackId" }, "IFK_PlaylistTrackTrackId");
                    });
        });

        modelBuilder.Entity<Track>(entity =>
        {
            entity.Property(e => e.TrackId).ValueGeneratedNever();

            entity.HasOne(d => d.MediaType).WithMany(p => p.Tracks).OnDelete(DeleteBehavior.ClientSetNull);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
