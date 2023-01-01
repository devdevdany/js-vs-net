using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SQLiteBenchmark.Models;

[Table("MediaType")]
public class MediaType
{
    [Key]
    public long MediaTypeId { get; set; }

    [Column(TypeName = "NVARCHAR(120)")]
    public string? Name { get; set; }

    [InverseProperty("MediaType")]
    public virtual ICollection<Track> Tracks { get; } = new List<Track>();
}
