from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlmodel import select, or_
from typing import Any

from core.dependencies import SessionDep
from database.models.user import User, UserLogin
from core.security.utils import verify_password 
from core.security.jwt import generate_access_token,get_current_user
from core.security.authtoken import AuthToken


router = APIRouter(tags=["auth"])


@router.post("/login")
async def login_user(user_in: UserLogin, session: SessionDep) -> AuthToken:
    """
    Login a user.
    """
    select_user_statement = select(User).where(or_(User.username == user_in.credential,User.email == user_in.credential))
    result = session.exec(select_user_statement)
    user = result.first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found with that username or email")
    if not verify_password(user.password_hash,user_in.password):
        return HTTPException(status_code=401, detail="Invalid credential combination")
    return AuthToken(
        access_token=generate_access_token(user.id)
    )
    

@router.post("/refresh")
async def refresh_token(current_user: User = Depends(get_current_user)):
    if not current_user:
        raise HTTPException(status_code=401, detail="Invalid token")
    new_token = generate_access_token(current_user.id)
    return AuthToken(
        access_token=new_token
    )
 


