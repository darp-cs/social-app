from fastapi import Depends, FastAPI
from routers.main import api_router

app = FastAPI()


app.include_router(api_router)
