from fastapi import FastAPI

app = FastAPI()

@app.get("/mytest1")
def mytest():
    return {"message": "Hello, FastAPI!"}
