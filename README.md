### 🎟️ Movie Ticket Booking Application – TheaterX
## 📌 Overview
TheaterX is a modern and feature-rich Flutter mobile application designed for seamless movie ticket booking. Users can browse movies, select showtimes, book seats, and make secure payments directly from their mobile devices. The app features real-time seat selection, secure authentication, and an admin dashboard (via web) for managing movies, halls, and bookings.

## 🚀 Features
# 🔹 User Features
🎥 Browse Movies – Explore a list of movies with descriptions, posters, and showtimes.
🎟️ Movie Booking – Select a movie, pick a showtime, and book seats instantly.
🏛️ Hall & Seat Selection – View real-time seat availability and choose preferred seats.
💳 Secure Payments – Complete transactions using Stripe.
🎫 Booking Confirmation – Receive a digital movie ticket after successful payment.
📜 My Bookings – Track and manage past movie bookings.
🔐 User Authentication – Register, log in, reset passwords, and manage profiles.

# 🔹 Admin Features (Managed via Web Panel)
🎬 Manage Movies – Add, update, and delete movies from the system.
🏛️ Manage Halls & Showtimes – Configure halls, seat layouts, and schedules.
🎟️ View Bookings – Monitor user reservations and payments.
📊 Admin Dashboard – Gain insights into revenue, bookings, and user trends.

## 🛠️ Tech Stack
# Frontend (Mobile – Flutter)
🚀 Flutter (Cross-platform development)
🖌 Flutter BLoC (State management)
🎨 Custom Theming (Dark & Light Mode)
📡 Dio & HTTP (API Requests)
🛠 Sensors Plus (Shake Detection for Quick Actions)
📦 Hive & SharedPreferences (Local Storage for Offline Mode)

# Backend (Node.js API – Web Panel)
⚡ Node.js & Express (REST API)
🗄 MongoDB (Mongoose) (Database)
🔐 JWT Authentication (Secure Login)
💰 Stripe API (Payment Integration)
📤 Multer (Image Uploads)
📩 Nodemailer (Email Notifications)

## ⚙️ Installation & Setup
# 1️⃣ Clone the Repository
git clone https://github.com/manishaa8981/flutter_movie_booking.git  
cd flutter_movie_booking

# 2️⃣ Setup & Run the Flutter App
flutter pub get
flutter run

# 3️⃣ Setup & Run the Backend
cd web_backend_moviebooking  
npm install  
npm start  

## 📌 Setup .env file for backend
PORT=4011  
MONGO_URI=mongodb://localhost:27017/movie_ticket_booking  
JWT_SECRET=your-secret-key  
STRIPE_SECRET_KEY=your-stripe-secret-key  
STRIPE_PUBLIC_KEY=your-stripe-public-key  
STRIPE_WEBHOOK_SECRET=your-webhook-secret  
FRONTEND_URL=http://localhost:4000  

## 🎯 Future Enhancements
📃 Printable E-Tickets with QR Code
📊 Advanced Admin Dashboard Analytics
🏆 Loyalty Rewards & Discount Coupons
🔔 Push Notifications for Show Reminders
📍 Location-based Theater Recommendations


