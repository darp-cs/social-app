
from database.models.user import User, UsersPublic, UserPublic, UserRegister, UserCreateValidation, UserBase
from core.security.utils import prepare_user
from core.dependencies import SessionDep
from fastapi import APIRouter
from sqlmodel import select
from typing import Any

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

@router.get("/{user_id}", response_model=UserPublic)
async def get_user(user_id: int, session: SessionDep) -> Any:
    """
    Get a user by ID.
    """
    user = session.get(User, user_id)
    # TODO: add error handling for user not found
    if not user:
        return {"error": "User not found"}
    return user

@router.post("/register", response_model=UserBase)
async def create_user(user: UserRegister, session: SessionDep) -> Any:
    """
    Create a new user.
    """
    # TODO: add error handling for duplicate username or email
    # TODO: add validation for unique fields
    validated_user = UserCreateValidation.model_validate(user)
    prepared_user = prepare_user(validated_user)
    session.add(prepared_user)
    session.commit()
    session.refresh(prepared_user)
    return user

# TODO: Add delete, only admin and own user can delete their account