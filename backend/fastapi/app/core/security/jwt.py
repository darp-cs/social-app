from datetime import datetime, timedelta, timezone
from typing import Any, Annotated
from fastapi import Depends
import jwt
from core.config import settings
from core.dependencies import SessionDep, AuthTokenDep
from database.models.user import User

ALGORITHM = "HS256"


def generate_access_token(subject: str | Any) -> str:
    expires_delta = timedelta(minutes=settings.ACCESS_TOKEN_TTL)
    expire = datetime.now(timezone.utc) + expires_delta
    to_encode = {"exp": expire, "sub": str(subject)}
    encoded_jwt = jwt.encode(to_encode, settings.SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt




def verify_access_token(token: str) -> dict[str, Any]:
    try:
        payload = jwt.decode(token, settings.SECRET_KEY, algorithms=[ALGORITHM])
        return payload
    except jwt.ExpiredSignatureError:
        return {"error": "Token has expired"}
    except jwt.InvalidTokenError:
        return {"error": "Invalid token"} 
    
def get_current_user(session: SessionDep, token: AuthTokenDep) -> User:
    payload = verify_access_token(token)
    if "error" in payload:
        return payload
    user_id = payload.get("sub")
    user = session.get(User, user_id)
    if not user:
        return {"error": "User not found"}
    return user