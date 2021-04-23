import hashlib
from src.models.measure import Measure
from bson.objectid import ObjectId
from src.models.device import Device
from .base_repository import BaseRepository


class DeviceRepository(BaseRepository):

    COLLECTION_NAME = 'devices'

    def __init__(self):
        super().__init__()

    def insert(self, model: Device, user_id: str) -> str:
        entity = model.to_json()
        entity['userId'] = user_id
        del entity['id']
        return str(self.collection.insert_one(entity).inserted_id)

    def ble_id_exists_for_user(self, ble_id: str, user_id: str) -> bool:
        result = self.collection.count(
            {'bleId': ble_id, 'userId': user_id}
        )
        return result > 0

    def add_measure(self, measure: Measure, ble_id: str, user_id: str) -> None:
        measure_json = measure.to_json()
        self.collection.update(
            {'bleId': ble_id, 'userId': user_id},
            {'$push': {'measures': measure_json}}
        )
