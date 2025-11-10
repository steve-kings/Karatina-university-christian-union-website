# 🗄️ Database Schema

This folder contains the complete database schema for KarUCU Main Campus.

## 📁 Files

- **karucu_database.sql** - Complete database schema with all tables and data

## 🚀 Setup Instructions

### 1. Create Database

```bash
# Using MySQL command line
mysql -u root -p

# Then run:
CREATE DATABASE karucu_main_campus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
exit;
```

### 2. Import Schema

```bash
# Import the complete schema
mysql -u root -p karucu_main_campus < database/karucu_database.sql
```

### 3. Verify Installation

```bash
mysql -u root -p karucu_main_campus

# Check tables
SHOW TABLES;

# Check users table structure
DESCRIBE users;

# Exit
exit;
```

## 📊 Database Structure

### Core Tables

1. **users** - User accounts and authentication
2. **ministries** - Church ministries
3. **events** - Church events and activities
4. **blogs** - Blog posts and testimonies
5. **leaders** - Leadership information
6. **galleries** - Photo galleries
7. **sermons** - Sermon videos
8. **announcements** - Church announcements
9. **prayer_requests** - Prayer requests
10. **bible_reading_calendar** - Bible reading plans

### Authentication Tables

- **password_reset_tokens** - Password reset tokens
- **email_verification_tokens** - Email verification

### Spiritual Content Tables

- **bible_studies** - Bible study materials
- **verse_of_day** - Daily verses
- **reading_progress** - User reading progress
- **user_prayer_requests** - Personal prayer journal

## 🔑 Default Admin Account

After importing the schema, you'll have a default admin account:

- **Email**: kingscreationagency635@gmail.com
- **Password**: @Kings635
- **Role**: admin

**⚠️ IMPORTANT**: Change this password immediately after first login!

## 🔄 Updates

The schema includes all necessary fields for:
- ✅ User authentication
- ✅ Password reset functionality
- ✅ Role-based access control
- ✅ All content management features

## 📝 Environment Variables

Make sure your `.env.local` has the correct database configuration:

```env
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=karucu_main_campus
```

## 🛠️ Maintenance

### Backup Database

```bash
mysqldump -u root -p karucu_main_campus > backup_$(date +%Y%m%d).sql
```

### Reset Database

```bash
# Drop and recreate
mysql -u root -p -e "DROP DATABASE IF EXISTS karucu_main_campus;"
mysql -u root -p -e "CREATE DATABASE karucu_main_campus CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
mysql -u root -p karucu_main_campus < database/karucu_database.sql
```

## ✅ Schema Features

- ✅ Complete table structure
- ✅ Foreign key relationships
- ✅ Indexes for performance
- ✅ Default data and sample content
- ✅ Admin user account
- ✅ Ministry data
- ✅ Sample events
- ✅ System settings

Your database is ready to use! 🎉
