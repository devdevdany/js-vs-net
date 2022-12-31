import {json} from "@remix-run/node";
import {db} from "~/utils/db.server";

export async function loader() {
  const orders = await db.orders.findMany();
  const products = await db.products.findMany();
  const orderDetails = await db.order_Details.findMany();

  return json({
    orders,
    products,
    orderDetails,
  });
}
