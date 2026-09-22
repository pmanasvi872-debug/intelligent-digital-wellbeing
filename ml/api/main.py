from fastapi import FastAPI

app = FastAPI(
    title="Intelligent Digital Wellbeing AI",
    version="1.0.0"
)


@app.get("/")
def home():
    return {
        "message": "Digital Wellbeing AI API is running"
    }