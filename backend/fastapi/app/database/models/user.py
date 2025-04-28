from sqlmodel import SQLModel, Field
import datetime
import uuid


class UserBase(SQLModel):
    username: str = Field(index=True, nullable=False,max_length=50)
    firstname: str = Field(index=True, nullable=False,max_length=50)
    lastname: str = Field(index=True, nullable=False,max_length=50)
    
class User(SQLModel, table=True):
    __tablename__ = "users"
    id: int = Field(default=None, primary_key=True)
    email: str = Field(index=True, nullable=False,max_length=100)
    password_hash: str = Field(nullable=False,max_length=255)
    created_at: str = Field(default_factory=lambda: datetime.utcnow())
    
    
class UserPublic(UserBase):
    id: uuid.UUID 

class UsersPublic(SQLModel):
    data: list[UserPublic]
    count: int