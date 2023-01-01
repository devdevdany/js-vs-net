﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SQLiteBenchmark.Models;

[Table("Album")]
[Index("ArtistId", Name = "IFK_AlbumArtistId")]
public class Album
{
    [Key]
    public long AlbumId { get; set; }

    [Column(TypeName = "NVARCHAR(160)")]
    public string Title { get; set; } = null!;

    public long ArtistId { get; set; }

    [ForeignKey("ArtistId")]
    [InverseProperty("Albums")]
    public virtual Artist Artist { get; set; } = null!;

    [InverseProperty("Album")]
    public virtual ICollection<Track> Tracks { get; } = new List<Track>();
}