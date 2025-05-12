from AesEverywhere import aes256
from database.models.user import UserCreateValidation, User
from core.config import settings


def hash_password(password: str) -> str:
    hashed_password = aes256.encrypt(password,settings.SECRET_KEY).decode('utf-8')
    return hashed_password


def verify_password(hashed_password: str, password: str) -> bool:
    try:
        decrypt_password  = aes256.decrypt(hashed_password,settings.SECRET_KEY).decode('utf-8')
        if password != decrypt_password:
            return False
        return True
    except Exception as e:
        print(f"Error decrypting password: {e}")
        return False
    
def prepare_user(user:UserCreateValidation) -> dict:
    prepared_user = User.model_validate(user,update={"password_hash": hash_password(user.password)})
    return prepared_user
