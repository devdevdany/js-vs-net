using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SQLiteBenchmark.Models;

[Table("Artist")]
public class Artist
{
    [Key]
    public long ArtistId { get; set; }

    [Column(TypeName = "NVARCHAR(120)")]
    public string? Name { get; set; }

    [InverseProperty("Artist")]
    public virtual ICollection<Album> Albums { get; } = new List<Album>();
}
