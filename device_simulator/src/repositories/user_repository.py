import requests
import config
from src.models.user import User
from src.repositories.base_repository import BaseRepository

class UserRepository(BaseRepository):

    ENDPOINT = '/users'

    def get_user_data(self) -> User:
        response = self.get(f"{config.API_URL}{self.ENDPOINT}/get_logged_user_data")
        return User(response['id'], response['username'], response['email'])