-- Bible Study Registration System Tables

-- 1. Bible Study Sessions (Admin creates these)
CREATE TABLE IF NOT EXISTS bible_study_sessions (
  id INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(255) NOT NULL,
  description TEXT,
  registration_deadline DATETIME NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE,
  is_open BOOLEAN DEFAULT true,
  max_participants INT DEFAULT NULL,
  created_by INT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE CASCADE
);

-- 2. Study Locations (Admin manages these)
CREATE TABLE IF NOT EXISTS study_locations (
  id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description TEXT,
  capacity INT DEFAULT NULL,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 3. Bible Study Registrations (Members register)
CREATE TABLE IF NOT EXISTS bible_study_registrations (
  id INT PRIMARY KEY AUTO_INCREMENT,
  session_id INT NOT NULL,
  user_id INT NOT NULL,
  full_name VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(20),
  location_id INT NOT NULL,
  year_of_study VARCHAR(50) NOT NULL,
  school VARCHAR(255) NOT NULL COMMENT 'e.g., School of Education, School of Science',
  registration_number VARCHAR(50),
  status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
  group_number INT DEFAULT NULL,
  notes TEXT,
  registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (session_id) REFERENCES bible_study_sessions(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (location_id) REFERENCES study_locations(id) ON DELETE RESTRICT,
  UNIQUE KEY unique_registration (session_id, user_id)
);

-- 4. Group Settings (Admin configures grouping)
CREATE TABLE IF NOT EXISTS study_group_settings (
  id INT PRIMARY KEY AUTO_INCREMENT,
  session_id INT NOT NULL,
  location_id INT NOT NULL,
  members_per_group INT NOT NULL DEFAULT 10,
  group_by_criteria ENUM('location', 'school', 'year', 'mixed') DEFAULT 'location',
  auto_assign BOOLEAN DEFAULT true,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (session_id) REFERENCES bible_study_sessions(id) ON DELETE CASCADE,
  FOREIGN KEY (location_id) REFERENCES study_locations(id) ON DELETE CASCADE,
  UNIQUE KEY unique_session_location (session_id, location_id)
);

-- Insert sample locations
INSERT INTO study_locations (name, description, capacity, is_active) VALUES
('Main Campus Hostel', 'Main campus student hostels', 100, true),
('Town Hostels', 'Off-campus hostels in town', 150, true),
('Karatina Town', 'Students living in Karatina town', 80, true),
('Nearby Villages', 'Students from nearby villages', 50, true),
('Online/Remote', 'For students who prefer online study', NULL, true);

-- Create indexes for better performance
CREATE INDEX idx_registrations_session ON bible_study_registrations(session_id);
CREATE INDEX idx_registrations_location ON bible_study_registrations(location_id);
CREATE INDEX idx_registrations_status ON bible_study_registrations(status);
CREATE INDEX idx_registrations_group ON bible_study_registrations(group_number);
CREATE INDEX idx_sessions_deadline ON bible_study_sessions(registration_deadline);
CREATE INDEX idx_sessions_open ON bible_study_sessions(is_open);
