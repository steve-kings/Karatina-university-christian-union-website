-- Blog Categories Table
CREATE TABLE IF NOT EXISTS blog_categories (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL UNIQUE,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX idx_name (name)
);

-- Insert default categories
INSERT INTO blog_categories (name, description) VALUES
('Testimony', 'Personal testimonies and faith stories'),
('Teaching', 'Biblical teachings and lessons'),
('Devotional', 'Daily devotionals and reflections'),
('Prayer', 'Prayer requests and prayer topics'),
('Worship', 'Worship experiences and insights'),
('Evangelism', 'Outreach and evangelism stories'),
('Fellowship', 'Community and fellowship experiences'),
('General', 'General blog posts and updates')
ON DUPLICATE KEY UPDATE name=name;
