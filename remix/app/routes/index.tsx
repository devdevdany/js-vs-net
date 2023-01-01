import {json} from "@remix-run/node";
import {db} from "~/utils/db.server";

export async function loader() {
  return json({
    albums: await db.album.findMany({
      select: {
        AlbumId: true,
        Title: true,
        ArtistId: true,
      }
    }),
    artists: await db.artist.findMany({
      select: {
        ArtistId: true,
        Name: true,
      }
    }),
    customers: await db.customer.findMany({
      select: {
        CustomerId: true,
        FirstName: true,
        LastName: true,
        Company: true,
        Address: true,
        City: true,
        State: true,
        Country: true,
        PostalCode: true,
        Phone: true,
        Fax: true,
        Email: true,
        SupportRepId: true,
      }
    }),
    employees: await db.employee.findMany({
      select: {
        EmployeeId: true,
        LastName: true,
        FirstName: true,
        Title: true,
        ReportsTo: true,
        BirthDate: true,
        HireDate: true,
        Address: true,
        City: true,
        State: true,
        Country: true,
        PostalCode: true,
        Phone: true,
        Fax: true,
        Email: true,
      }
    }),
    genres: await db.genre.findMany({
      select: {
        GenreId: true,
        Name: true,
      }
    }),
    invoices: await db.invoice.findMany({
      select: {
        InvoiceId: true,
        CustomerId: true,
        InvoiceDate: true,
        BillingAddress: true,
        BillingCity: true,
        BillingState: true,
        BillingCountry: true,
        BillingPostalCode: true,
        Total: true,
      }
    }),
    invoiceLines: await db.invoiceLine.findMany({
        select: {
          InvoiceLineId: true,
          InvoiceId: true,
          TrackId: true,
          UnitPrice: true,
          Quantity: true,
        }
      }
    ),
    mediaTypes: await db.mediaType.findMany({
      select: {
        MediaTypeId: true,
        Name: true
      }
    }),
    playlists: await db.playlist.findMany({
      select: {
        PlaylistId: true,
        Name: true,
      }
    }),
    tracks: await db.track.findMany({
      select: {
        TrackId: true,
        Name: true,
        AlbumId: true,
        MediaTypeId: true,
        GenreId: true,
        Composer: true,
        Milliseconds: true,
        Bytes: true,
        UnitPrice: true,
      }
    }),
  });
}
