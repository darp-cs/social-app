from fastapi import APIRouter
from database.models.user import User, UserBase, UsersPublic, UserPublic
from sqlmodel import select
from typing import Any
from core.dependencies import SessionDep

router = APIRouter(
    prefix="/users",
    tags=["users"],
    responses={404: {"description": "Not found"}},
)

@router.get("/",response_model=UsersPublic)
async def get_users(session: SessionDep) -> Any:
    """
    Get all users from the database.
    """ 
    select_all_users_statement = select(User)
    result = session.exec(select_all_users_statement)
    users = result.all()
    return UsersPublic(data=users,count=len(users))