
# ✅ Flutter Task Manager App with Supabase

A clean and modern **task manager** app built using **Flutter** and **Supabase**, featuring user authentication, real-time updates, task editing, and light/dark theme support.

---

## 🚀 Features

### 1️⃣ Authentication  
- Email/password sign-up & login using Supabase  
- Auto-redirect to login screen if not authenticated  
- Redirects to dashboard after login  
- Logout functionality included  

### 2️⃣ Dashboard  
- View all tasks (title + status: pending/completed)  
- Add new tasks via dialog or bottom sheet  
- Delete tasks (via swipe or button)  
- Mark tasks as completed  
- Edit tasks  
- Real-time updates powered by Supabase Realtime  

### 3️⃣ Add/Edit Task UI  
- Simple UI for entering or editing task names  
- Submit to store or update in Supabase  

### 🌓 Theme Support  
- Toggle between **Light** and **Dark** themes  

---

## 🛠️ Setup Instructions

### 1. Clone the Repository

bash
git clone https://github.com/Cipher-Dark/mini_taskhub
cd task_manager_app


### 2. Install Dependencies

bash
flutter pub get


### 3. Configure Supabase

Update your Supabase credentials in your app’s `main.dart` or use a `key.sample.dart` file:

dart
await Supabase.initialize(
  url: 'https://your-project.supabase.co',
  anonKey: 'your-anon-key',
);


Make sure this runs early in your `main()` function.

---

## 🧪 Supabase Setup Steps

1. Go to [supabase.com](https://supabase.com) and create a new project.
2. Enable **Email/Password** under **Authentication**.
3. Create a `tasks` table with columns:
   - `id` (int)
   - `created_at` (timestamp)
   - `user_id` (varchar)
   - `title` (varchar)
   - `is_completed` (boolean)
     
4. Enable **Realtime** on the `tasks` table.

---

## 🔁 Hot Reload vs Hot Restart

|               | Hot Reload                        | Hot Restart                          |
|---------------|-----------------------------------|---------------------------------------|
| **Speed**     | Fast (injects code)              | Slower (restarts app)                |
| **App State** | Preserved                        | Reset to initial state               |
| **Use Case**  | UI/layout changes                | Init logic, dependency or state changes |

---

## 📦 Packages Used

- `get_it: ^8.0.3`
- `flutter_bloc: ^9.1.0`
- `equatable: ^2.0.7`
- `supabase_flutter: ^2.8.4`
- `provider: ^6.1.4`
- `shared_preferences: ^2.5.3`
- `intl: ^0.20.2`

- In this project Provider for theme and for other state management flutter_bloc(cubit) is used

---

## 🧑‍💻 Author

**Sagar Bisht**  

