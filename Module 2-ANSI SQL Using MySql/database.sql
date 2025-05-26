
-- =============================
-- 1. User Upcoming Events
-- =============================
SELECT e.name, e.date, e.location
FROM events e
JOIN registrations r ON e.id = r.event_id
JOIN users u ON r.user_id = u.id
WHERE e.date >= CURDATE()
ORDER BY e.date;

-- =============================
-- 2. Top Rated Events
-- =============================
SELECT e.name, AVG(f.rating) AS avg_rating
FROM feedback f
JOIN events e ON f.event_id = e.id
GROUP BY e.name
HAVING COUNT(f.id) >= 10
ORDER BY avg_rating DESC;

-- =============================
-- 3. Inactive Users
-- =============================
SELECT u.name, u.email
FROM users u
LEFT JOIN registrations r ON u.id = r.user_id
GROUP BY u.id
HAVING MAX(r.date) < CURDATE() - INTERVAL 90 DAY OR MAX(r.date) IS NULL;


-- =============================
-- 4. Peak Session Hours
-- =============================
SELECT e.name, COUNT(s.id) AS session_count
FROM sessions s
JOIN events e ON s.event_id = e.id
WHERE TIME(s.start_time) BETWEEN '10:00:00' AND '12:00:00'
GROUP BY e.name;

-- =============================
-- 5. Most Active Cities
-- =============================
SELECT location, COUNT(DISTINCT user_id) AS registered_users
FROM registrations
JOIN events ON registrations.event_id = events.id
GROUP BY location
ORDER BY registered_users DESC
LIMIT 5;

-- =============================
-- 6. Event Resource Summary
-- =============================
SELECT e.name, COUNT(r.id) AS resource_count
FROM resources r
JOIN events e ON r.event_id = e.id
GROUP BY e.name;

-- =============================
-- 7. Low Feedback Alerts
-- =============================
SELECT u.name, f.rating, f.comments, e.name AS event_name
FROM feedback f
JOIN users u ON f.user_id = u.id
JOIN events e ON f.event_id = e.id
WHERE f.rating < 3;

-- =============================
-- 8. Sessions per Upcoming Event
-- =============================
SELECT e.name, COUNT(s.id) AS session_count
FROM sessions s
JOIN events e ON s.event_id = e.id
WHERE e.date >= CURDATE()
GROUP BY e.name;

-- =============================
-- 9. Organizer Event Summary
-- =============================
SELECT o.name, COUNT(e.id) AS total_events,
       SUM(CASE WHEN e.date >= CURDATE() THEN 1 ELSE 0 END) AS upcoming_events,
       SUM(CASE WHEN e.date < CURDATE() THEN 1 ELSE 0 END) AS completed_events,
       SUM(CASE WHEN e.status = 'cancelled' THEN 1 ELSE 0 END) AS cancelled_events
FROM organizers o
JOIN events e ON o.id = e.organizer_id
GROUP BY o.name;

-- =============================
-- 10. Feedback Gap
-- =============================
SELECT e.name
FROM events e
LEFT JOIN feedback f ON e.id = f.event_id
GROUP BY e.id
HAVING COUNT(f.id) = 0;


-- =============================
-- 11. Daily New User Count
-- =============================
SELECT DATE(created_at) AS registration_date, COUNT(id) AS new_users
FROM users
WHERE created_at >= CURDATE() - INTERVAL 7 DAY
GROUP BY registration_date;

-- =============================
-- 12. Event with Maximum Sessions
-- =============================
SELECT e.name, COUNT(s.id) AS session_count
FROM events e
JOIN sessions s ON e.id = s.event_id
GROUP BY e.name
ORDER BY session_count DESC
LIMIT 1;

-- =============================
-- 13. Average Rating per City
-- =============================
SELECT e.location, AVG(f.rating) AS avg_rating
FROM feedback f
JOIN events e ON f.event_id = e.id
GROUP BY e.location;

-- =============================
-- 14. Most Registered Events
-- =============================
SELECT e.name, COUNT(r.id) AS registrations
FROM events e
JOIN registrations r ON e.id = r.event_id
GROUP BY e.name
ORDER BY registrations DESC
LIMIT 3;

-- =============================
-- 15. Event Session Time Conflict
-- =============================
SELECT e.name, s1.start_time, s2.start_time
FROM sessions s1
JOIN sessions s2 ON s1.event_id = s2.event_id AND s1.id <> s2.id
JOIN events e ON s1.event_id = e.id
WHERE s1.start_time BETWEEN s2.start_time AND s2.end_time;

-- =============================
-- 16. Unregistered Active Users
-- =============================
SELECT u.name, u.email
FROM users u
LEFT JOIN registrations r ON u.id = r.user_id
WHERE u.created_at >= CURDATE() - INTERVAL 30 DAY AND r.user_id IS NULL;

-- =============================
-- 17. Multi-Session Speakers
-- =============================
SELECT s.speaker_name, COUNT(s.id) AS total_sessions
FROM sessions s
GROUP BY s.speaker_name
HAVING total_sessions > 1;

-- =============================
-- 18. Resource Availability Check
-- =============================
SELECT e.name
FROM events e
LEFT JOIN resources r ON e.id = r.event_id
WHERE r.id IS NULL;

-- =============================
-- 19. Completed Events with Feedback Summary
-- =============================
SELECT e.name, COUNT(r.id) AS total_registrations, AVG(f.rating) AS avg_feedback
FROM events e
LEFT JOIN registrations r ON e.id = r.event_id
LEFT JOIN feedback f ON e.id = f.event_id
WHERE e.date < CURDATE()
GROUP BY e.name;

-- =============================
-- 20. User Engagement Index
-- =============================
SELECT u.name, COUNT(r.id) AS attended_events, COUNT(f.id) AS feedbacks_given
FROM users u
LEFT JOIN registrations r ON u.id = r.user_id
LEFT JOIN feedback f ON u.id = f.user_id
GROUP BY u.name;

-- =============================
-- 21. Top Feedback Providers
-- =============================
SELECT u.name, COUNT(f.id) AS feedback_count
FROM feedback f
JOIN users u ON f.user_id = u.id
GROUP BY u.name
ORDER BY feedback_count DESC
LIMIT 5;

-- =============================
-- 22. Duplicate Registrations Check
-- =============================
SELECT user_id, event_id, COUNT(*) AS duplicate_count
FROM registrations
GROUP BY user_id, event_id
HAVING duplicate_count > 1;

-- =============================
-- 23. Registration Trends
-- =============================
SELECT DATE_FORMAT(created_at, '%Y-%m') AS month, COUNT(id) AS registrations
FROM users
GROUP BY month
ORDER BY month DESC;

-- =============================
-- 24. Average Session Duration per Event
-- =============================
SELECT e.name, AVG(TIMESTAMPDIFF(MINUTE, s.start_time, s.end_time)) AS avg_duration
FROM events e
JOIN sessions s ON e.id = s.event_id
GROUP BY e.name;

-- =============================
-- 25. Events Without Sessions
-- =============================
SELECT e.name
FROM events e
LEFT JOIN sessions s ON e.id = s.event_id
WHERE s.id IS NULL;
