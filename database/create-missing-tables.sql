-- =====================================================
-- CREATE MISSING TABLES FOR KARUCU DATABASE
-- Run this script to add any missing tables
-- =====================================================

USE karucu_main_campus;

-- =====================================================
-- GALLERIES TABLE (External Gallery Links)
-- =====================================================

CREATE TABLE IF NOT EXISTS galleries (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    url VARCHAR(500) NOT NULL,
    category ENUM('worship', 'fellowship', 'outreach', 'events', 'conferences', 'other') DEFAULT 'other',
    thumbnail_url VARCHAR(500),
    platform ENUM('google_photos', 'google_drive', 'dropbox', 'onedrive', 'other') DEFAULT 'other',
    is_active BOOLEAN DEFAULT TRUE,
    view_count INT DEFAULT 0,
    created_by INT NOT NULL,
    updated_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    
    INDEX idx_category (category),
    INDEX idx_is_active (is_active),
    INDEX idx_created_by (created_by),
    INDEX idx_view_count (view_count)
);

-- =====================================================
-- VERIFY TABLES EXIST
-- =====================================================

-- Check if all required tables exist
SELECT 
    'users' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'users'

UNION ALL

SELECT 
    'events' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'events'

UNION ALL

SELECT 
    'blogs' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'blogs'

UNION ALL

SELECT 
    'leaders' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'leaders'

UNION ALL

SELECT 
    'announcements' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'announcements'

UNION ALL

SELECT 
    'sermons' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'sermons'

UNION ALL

SELECT 
    'galleries' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'galleries'

UNION ALL

SELECT 
    'verse_of_day' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'verse_of_day'

UNION ALL

SELECT 
    'bible_reading_calendar' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'bible_reading_calendar'

UNION ALL

SELECT 
    'user_prayer_requests' as table_name,
    CASE WHEN COUNT(*) > 0 THEN '✅ EXISTS' ELSE '❌ MISSING' END as status
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'karucu_main_campus' AND TABLE_NAME = 'user_prayer_requests';
