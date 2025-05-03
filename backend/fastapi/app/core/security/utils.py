from database.models.user import User, UserCreateValidation


# TODO: Implement hashing function
def hash_password(password: str) -> str:
    return password

def prepare_user(user:UserCreateValidation) -> dict:
    prepared_user = User.model_validate(user,update={"password_hash": hash_password(user.password)})
    return prepared_user
