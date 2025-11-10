-- Add missing fields to prayer_requests table
USE karucu_main_campus;

-- Add requester_name column for anonymous submissions
ALTER TABLE prayer_requests 
ADD COLUMN requester_name VARCHAR(255) NULL AFTER requester_id;

-- Add description column as alias for content (for compatibility)
-- Note: We'll use content as the main field, description is just for reference
ALTER TABLE prayer_requests 
ADD COLUMN description TEXT NULL AFTER content;

-- Update existing records to copy content to description
UPDATE prayer_requests SET description = content WHERE description IS NULL;

SELECT 'Prayer requests table updated successfully!' as message;
