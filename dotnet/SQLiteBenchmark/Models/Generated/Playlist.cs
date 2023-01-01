using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace SQLiteBenchmark.Models;

[Table("Playlist")]
public class Playlist
{
    [Key]
    public long PlaylistId { get; set; }

    [Column(TypeName = "NVARCHAR(120)")]
    public string? Name { get; set; }

    [ForeignKey("PlaylistId")]
    [InverseProperty("Playlists")]
    public virtual ICollection<Track> Tracks { get; } = new List<Track>();
}
