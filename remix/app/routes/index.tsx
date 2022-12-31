import {json} from "@remix-run/node";
import {db} from "~/utils/db.server";

export async function loader() {
  const albums = await db.album.findMany();
  const artists = await db.artist.findMany();
  const customers = await db.customer.findMany();
  const employees = await db.employee.findMany();
  const genres = await db.genre.findMany();
  const invoices = await db.invoice.findMany();
  const invoiceLines = await db.invoiceLine.findMany();
  const mediaTypes = await db.mediaType.findMany();
  const playlists = await db.playlist.findMany();
  const playlistTracks = await db.playlistTrack.findMany();
  const tracks = await db.track.findMany();

  return json({
    albums,
    artists,
    customers,
    employees,
    genres,
    invoices,
    invoiceLines,
    mediaTypes,
    playlists,
    playlistTracks,
    tracks,
  });
}
