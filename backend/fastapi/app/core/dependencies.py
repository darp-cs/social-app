from database.db import get_db
from fastapi import Depends
from sqlmodel import Session
from typing import Annotated
from fastapi.security import OAuth2PasswordBearer



oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")

SessionDep = Annotated[Session, Depends(get_db)]
AuthTokenDep = Annotated[str, Depends(oauth2_scheme)]