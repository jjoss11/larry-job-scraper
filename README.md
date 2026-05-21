# Job Scraper (Rails API + FastAPI frontend) — skeleton

This repository provides a high-level scaffold and commentary to help you build a job-scraping app using Ruby on Rails (API mode) with an optional Python FastAPI frontend.

Overview:
- Rails API: stores `JobPosting` records, runs background scraping jobs with Sidekiq, sends email alerts via ActionMailer.
- FastAPI: optional UI/API for viewing postings and managing keywords/schedules.
- MySQL as the primary database. Redis for background job queue.

I kept implementation intentionally minimal and commented so you can implement each piece and learn.

Next steps I can take for you (pick one):
- Generate the full Rails app and implement the commented files.
- Create example scraper templates (Nokogiri-based) for a sample district page.
- Wire up Sidekiq jobs and a scheduler with example `whenever` or cron configs.
