

INTERVENTIONS (ID, title, description, status, start_date, end_date, rating, comment, #id_partner, #id_client, #id_user)

InterventionLogs (id, type, timestamp, location, #id_intervention)

Partners (id, name, email, phone, address, created_at)

Clients (ID, name,email, phone, address, #id_region)

Regions (ID, name, code)

Users (id, name, email, password, role, phone, address, is_active, #id_region)

TechnicianAvailability (id, start_date, end_date, reason, #id_user)

USERS_SKILLS (ID, #id_user, #id_skill, level)

Skills (id, name, description)