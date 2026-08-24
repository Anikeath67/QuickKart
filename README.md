# QuickKart 🛒

QuickKart is a simple Flutter shopping application created as a mini-project.

## Features

- View products
- Add products to cart
- Increase/decrease quantity
- Calculate total amount
- Place an order
- Display order confirmation
- Loading state while products are fetched
- Error state with retry when product loading fails
- Provider state management
- Mock local REST-style product service

## Products

| Product | Price |
|---|---:|
| 🍎 Fresh Apples | ₹120 |
| 🥛 Milk | ₹60 |
| 🍞 Bread | ₹45 |



## Order

The assignment uses a mock order flow. A successful order displays:

- Order ID: `QK-1001`
- Status: `Order Placed`

In production, the backend should generate the unique order ID.

## To Run Project

The project uses Provider because the state requirements are small and straightforward. The cart state is separated from UI widgets using `ChangeNotifier`. The product service is separated from screens so the mock data source can later be replaced with a real REST API without rewriting the UI.
