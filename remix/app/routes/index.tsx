import {json} from "@remix-run/node";
import {db} from "~/utils/db.server";

export async function loader() {
  return json({
    albums: await db.album.findMany(),
    artists: await db.artist.findMany(),
    customers: await db.customer.findMany(),
    employees: await db.employee.findMany(),
    genres: await db.genre.findMany(),
    invoices: await db.invoice.findMany(),
    invoiceLines: await db.invoiceLine.findMany(),
    mediaTypes: await db.mediaType.findMany(),
    playlists: await db.playlist.findMany(),
    tracks: await db.track.findMany(),
  });
}
