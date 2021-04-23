import requests
import config

class BaseRepository:

    def __init__(self, user_secret: str) -> None:
        self.secret = user_secret

    def get(self, url:str) -> dict:
        response = requests.get(url, headers=self.get_auth_header())
        response.raise_for_status()
        return response.json()

    def post(self, url: str, json: dict) -> dict:
        response = requests.post(url, json=json, headers=self.get_auth_header())
        response.raise_for_status()
        return response.json()

    def get_auth_header(self) -> dict:
        return {
            'Authorization': f'Bearer {self.secret}'
        }