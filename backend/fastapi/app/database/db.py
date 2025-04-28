from sqlmodel import create_engine
from collections.abc import Generator
from sqlmodel import Session

from core.config import settings

engine = create_engine(str(settings.MYSQL_DATABASE_URI))

def get_db() -> Generator[Session, None, None]:
    with Session(engine) as session:
        yield session



