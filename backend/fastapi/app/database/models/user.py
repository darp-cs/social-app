from uuid import uuid4, UUID
from sqlmodel import SQLModel, Field
from pydantic import field_validator, ValidationInfo

# Basic fields for User model
class UserBase(SQLModel):
    username: str = Field(index=True, nullable=False, max_length=50)
    firstname: str = Field(index=True, nullable=False, max_length=50)
    lastname: str = Field(index=True, nullable=False, max_length=50)
    
# Restricted fields for user, these reflect db fields along with user base fields
class User(UserBase, table=True):
    __tablename__ = "users"
    id: UUID = Field(
        primary_key=True,
        default_factory=uuid4,
    )
    email: str = Field(index=True, nullable=False, max_length=100)
    password_hash: str = Field(nullable=False, max_length=255)
    created_at: str = Field(default=None, nullable=False)

    
    # Later we will have to add things linked with this user so we can cascade on delete
    
# Expected Fields From UserBase Registration
class UserRegister(SQLModel):
    username: str = Field(index=True, nullable=False, max_length=50)
    firstname: str = Field(index=True, nullable=False, max_length=50)
    lastname: str = Field(index=True, nullable=False, max_length=50)
    email: str = Field(index=True, nullable=False, max_length=100)
    password: str = Field(nullable=False, max_length=255)
    
# Fields that will be used to create a user in the database needed for later hashing password
class UserCreateValidation(UserBase):
    email: str = Field(index=True, nullable=False, max_length=100)
    password: str = Field(nullable=False, max_length=255)

class UserLogin(SQLModel):
    credential: str = Field(index=True, nullable=False, max_length=50)
    password: str = Field(nullable=False, max_length=255)
    
# Fields to be shown to public in addition to user base fields
class UserPublic(UserBase):
    id: UUID

class UsersPublic(SQLModel):
    data: list[UserPublic]
    count: int