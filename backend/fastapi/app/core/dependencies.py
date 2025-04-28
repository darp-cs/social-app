from database import get_db
from fastapi import Depends
from sqlmodel import Session
from typing import Annotated





SessionDep = Annotated[Session, Depends(get_db)]