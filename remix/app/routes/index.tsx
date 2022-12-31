import {json} from "@remix-run/node";
import {db} from "~/utils/db.server";

export async function loader() {
  return json({
    orders: db.orders.findMany(),
    products: db.products.findMany(),
    orderDetails: db.order_Details.findMany(),
  });
}
