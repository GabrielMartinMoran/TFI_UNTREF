from src.models.recovery_token import RecoveryToken
from .base_repository import BaseRepository
from datetime import datetime, timedelta

class RecoveryTokenRepository(BaseRepository):

    COLLECTION_NAME = 'recoveryTokens'

    def upsert(self, model):
        entity = model.to_json()
        return str(self.collection.replaceOne({'user_id': entity['user_id']}, entity, upsert=True))

    def validate_token(self, token: str, user_id: str) -> bool:
        stored_token_data = self.collection.find_one({'user_id' : user_id}) #TODO convertir en model.
        if stored_token_data is None:
            return False
        if(stored_token_data['tokenValue'] != token):
            return False
        return True
