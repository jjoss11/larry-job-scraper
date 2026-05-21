from fastapi import FastAPI

app = FastAPI()

@app.get('/')
async def root():
    return {"message": "FastAPI frontend placeholder — implement endpoints to query job postings and manage filters"}

# Example endpoints to add:
# - GET /postings -> list job postings (with pagination)
# - POST /filters -> create keyword filters
# - POST /scrape -> trigger scraping for given URLs (calls Rails API or enqueues job)
