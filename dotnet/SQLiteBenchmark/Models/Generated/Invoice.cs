﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace SQLiteBenchmark.Models;

[Table("Invoice")]
[Index("CustomerId", Name = "IFK_InvoiceCustomerId")]
public class Invoice
{
    [Key]
    public long InvoiceId { get; set; }

    public long CustomerId { get; set; }

    [Column(TypeName = "DATETIME")]
    public byte[] InvoiceDate { get; set; } = null!;

    [Column(TypeName = "NVARCHAR(70)")]
    public string? BillingAddress { get; set; }

    [Column(TypeName = "NVARCHAR(40)")]
    public string? BillingCity { get; set; }

    [Column(TypeName = "NVARCHAR(40)")]
    public string? BillingState { get; set; }

    [Column(TypeName = "NVARCHAR(40)")]
    public string? BillingCountry { get; set; }

    [Column(TypeName = "NVARCHAR(10)")]
    public string? BillingPostalCode { get; set; }

    [Column(TypeName = "NUMERIC(10,2)")]
    public byte[] Total { get; set; } = null!;

    [ForeignKey("CustomerId")]
    [InverseProperty("Invoices")]
    public virtual Customer Customer { get; set; } = null!;

    [InverseProperty("Invoice")]
    public virtual ICollection<InvoiceLine> InvoiceLines { get; } = new List<InvoiceLine>();
}