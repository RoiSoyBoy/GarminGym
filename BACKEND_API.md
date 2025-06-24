# GymTracker Backend API

This document outlines the backend API requirements for the GymTracker application.

## Endpoints

### Users

*   `POST /api/users/register` - Register a new user.
*   `POST /api/users/login` - Login a user.
*   `GET /api/users/me` - Get the currently logged in user.

### Workouts

*   `POST /api/workouts` - Create a new workout log.
*   `GET /api/workouts` - Get all workout logs for the current user.
*   `GET /api/workouts/:id` - Get a specific workout log.

### Templates

*   `POST /api/templates` - Create a new workout template.
*   `GET /api/templates` - Get all workout templates for the current user.
*   `GET /api/templates/marketplace` - Get all templates from the marketplace.
*   `POST /api/templates/marketplace` - Share a template to the marketplace.

### Challenges

*   `GET /api/challenges` - Get all available challenges.
*   `POST /api/challenges/:id/join` - Join a challenge.
*
*   `GET /api/challenges/:id/leaderboard` - Get the leaderboard for a challenge.

## Database Schema

### Users

*   `id` (PK)
*   `username`
*   `password` (hashed)
*   `email`

### Workouts

*   `id` (PK)
*   `user_id` (FK)
*   `timestamp`
*   `template_used`
*   `exercises` (JSON)

### SharedTemplates

*   `id` (PK)
*   `user_id` (FK)
*   `name`
*   `description`
*   `exercises` (JSON)

### ChallengeEntries

*   `id` (PK)
*   `user_id` (FK)
*   `challenge_id` (FK)
*   `score`

## Authentication

Authentication will be handled using JSON Web Tokens (JWT). The `login` endpoint will return a JWT, which will be used to authenticate all subsequent requests.
