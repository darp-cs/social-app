from pydantic import (
    MySQLDsn,
    computed_field,
)

from pydantic_settings import BaseSettings, SettingsConfigDict
from typing_extensions import Self


class Settings(BaseSettings):
    model_config = SettingsConfigDict(
        env_file="./.env",
        env_ignore_empty=True,
        extra="ignore",
    )

    


    MYSQL_SERVER: str = "localhost"
    MYSQL_PORT: int = 3306
    MYSQL_USER: str = "root"
    MYSQL_PASSWORD: str = "password"
    MYSQL_DB: str = "social_app"

    @computed_field
    @property
    def  MYSQL_DATABASE_URI(self) -> MySQLDsn:
        return MySQLDsn.build(
            scheme="mysql+mysqlconnector",
            user=self.MYSQL_USER,
            password=self.MYSQL_PASSWORD,
            host=self.MYSQL_SERVER,
            port=str(self.MYSQL_PORT),
            path=f"/{self.MYSQL_DB}",
        )



settings = Settings()  # type: ignore