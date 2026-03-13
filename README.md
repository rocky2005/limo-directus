# 🚗 Limo Directus Backend

Headless CMS backend for limo reservations. Admin panel + REST API.
Deploy to Railway in ~5 minutes.

---

## What you get

- **Admin panel** at `https://your-app.up.railway.app/admin`
- **REST API** at `https://your-app.up.railway.app/items/bookings`
- 4 collections ready to go: **Vehicles, Bookings, Customers, Drivers**
- All fields pre-configured — status dropdowns, pricing, dates, relations

---

## Deploy to Railway (step by step)

### 1. Push this project to GitHub

```bash
git init
git add .
git commit -m "limo directus backend"
```

Create a new repo on github.com, then:
```bash
git remote add origin https://github.com/YOUR_USERNAME/limo-directus.git
git push -u origin main
```

### 2. Create Railway project

1. Go to **railway.app** → sign in
2. Click **New Project → Deploy from GitHub repo**
3. Select your `limo-directus` repo

### 3. Add PostgreSQL

1. In your Railway project click **+ New → Database → PostgreSQL**
2. Railway automatically adds `DATABASE_URL` to your environment — you don't need to do anything else

### 4. Add environment variables

In Railway → your Directus service → **Variables** tab, add these:

```
DB_CLIENT=pg
DB_CONNECTION_STRING=${{Postgres.DATABASE_URL}}
SECRET=             ← generate below
ADMIN_EMAIL=        ← your email
ADMIN_PASSWORD=     ← choose a strong password
PUBLIC_URL=         ← fill in after first deploy
CORS_ENABLED=true
CORS_ORIGIN=true
```

**Generate SECRET:**
```bash
node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"
```

### 5. Deploy

Railway will auto-deploy. Watch the logs — when you see `Server started` it's live.

### 6. Set PUBLIC_URL

Copy your Railway URL (e.g. `https://limo-directus.up.railway.app`) and add it as:
```
PUBLIC_URL=https://limo-directus.up.railway.app
```

Then redeploy (Railway does this automatically when you save variables).

### 7. Open your admin panel

Go to `https://your-app.up.railway.app/admin` and log in with your `ADMIN_EMAIL` and `ADMIN_PASSWORD`.

---

## Set API permissions for your frontend

By default everything is private. To allow your frontend to submit bookings:

1. Admin panel → **Settings → Access Control → Public**
2. Find **Bookings** → enable `create`
3. Find **Customers** → enable `create`
4. Find **Vehicles** → enable `read`
5. Save

---

## API — connect any frontend

### Get all vehicles
```javascript
const res = await fetch('https://YOUR_APP.up.railway.app/items/vehicles');
const { data } = await res.json();
```

### Submit a booking
```javascript
const res = await fetch('https://YOUR_APP.up.railway.app/items/bookings', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify({
    service_type: 'airport_transfer',
    pickup_datetime: '2026-05-01T14:00:00',
    pickup_address: '123 Main St, San Jose CA',
    dropoff_address: 'SJC Airport',
    passenger_count: 2,
    vehicle: 1,          // vehicle ID
    total_price: 180
  })
});
```

### Create a customer + booking together (use a Flow)
See Directus Flows in the admin panel → you can chain a "Create Customer" → "Create Booking" action triggered by a webhook from your form.

---

## Your collections

| Collection | Fields |
|---|---|
| **vehicles** | name, type, make, model, year, capacity, base_rate_per_hour, base_rate_flat, min_hours, features, color, license_plate, status |
| **bookings** | confirmation_number, status, service_type, pickup_datetime, dropoff_datetime, pickup_address, dropoff_address, passenger_count, flight_number, hours_booked, base_price, extras_price, tax, total_price, payment_status, special_requests, internal_notes → relations to vehicle, customer, driver |
| **customers** | first_name, last_name, email, phone, company, notes |
| **drivers** | first_name, last_name, email, phone, license_number, license_expiry, status, notes |

---

## Day-to-day admin workflow

1. New booking comes in → appears in **Bookings** list
2. Open it → assign a **Vehicle** and **Driver**
3. Change **Status** from `Pending` → `Confirmed`
4. Change **Payment Status** when paid
5. Use the built-in filters to see today's pickups, pending bookings, etc.
