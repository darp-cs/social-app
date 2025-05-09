from sqlmodel import SQLModel, Field

# Basic fields for User model
class UserBase(SQLModel):
    username: str = Field(index=True, nullable=False,max_length=50)
    firstname: str = Field(index=True, nullable=False,max_length=50)
    lastname: str = Field(index=True, nullable=False,max_length=50)
    
# Restricted fields for user, these reflect db fields along with user base fields
class User(UserBase, table=True):
    __tablename__ = "users"
    id: int = Field(default=None, primary_key=True)
    email: str = Field(index=True, nullable=False,max_length=100)
    password_hash: str = Field(nullable=False,max_length=255)
    created_at: str = Field(default=None, nullable=False, sa_column_kwargs={"server_default": "CURRENT_TIMESTAMP"})
    # Later we will have to add things linked with this user so we can cancade on delete
    
# Expected Fields From UserBase Registration
class UserRegister(SQLModel):
    username: str = Field(index=True, nullable=False,max_length=50)
    firstname: str = Field(index=True, nullable=False,max_length=50)
    lastname: str = Field(index=True, nullable=False,max_length=50)
    email: str = Field(index=True, nullable=False,max_length=100)
    password: str = Field(nullable=False,max_length=255)
    
# Fields that will be used to create a user in the database needed for later hashing password
class UserCreateValidation(UserBase):
    email: str = Field(index=True, nullable=False,max_length=100)
    password: str = Field(nullable=False,max_length=255)

class UserLogin(SQLModel):
    credential: str = Field(index=True, nullable=False,max_length=50)
    password: str = Field(nullable=False,max_length=255)
    
# Fields to be shown to public in addition to user base fields
class UserPublic(UserBase):
    id: int

class UsersPublic(SQLModel):
    data: list[UserPublic]
    count: int