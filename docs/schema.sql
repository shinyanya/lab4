-- 📹 Таблица источников видео
CREATE TABLE VideoSource (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    file_path TEXT NOT NULL,
    type TEXT CHECK(type IN ('file', 'camera')) NOT NULL,
    fps INTEGER,
    resolution TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- ⚙️ Таблица пользовательских настроек
CREATE TABLE UserSetting (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    setting_name TEXT UNIQUE NOT NULL,
    canny_threshold1 INTEGER DEFAULT 50,
    canny_threshold2 INTEGER DEFAULT 100,
    hough_threshold INTEGER DEFAULT 50,
    hough_min_line_length INTEGER DEFAULT 10,
    hough_max_line_gap INTEGER DEFAULT 30,
    roi_points TEXT, -- JSON формат
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 📊 Таблица логов распознавания
CREATE TABLE DetectionLog (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    frame_index INTEGER NOT NULL,
    success BOOLEAN NOT NULL,
    left_line TEXT, -- JSON
    right_line TEXT, -- JSON
    video_source_id INTEGER,
    FOREIGN KEY (video_source_id) REFERENCES VideoSource(id)
);

-- Пример данных
INSERT INTO VideoSource (name, file_path, type, fps, resolution)
VALUES ('MyLane.mp4', 'data/MyLane.mp4', 'file', 30, '1280x720');

INSERT INTO UserSetting (
    setting_name, canny_threshold1, canny_threshold2,
    hough_threshold, hough_min_line_length, hough_max_line_gap,
    roi_points
) VALUES (
    'Default', 50, 100, 50, 10, 30,
    '[[200, 720], [640, 400], [1280, 720]]'
);