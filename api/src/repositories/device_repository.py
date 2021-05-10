import hashlib
from src.models.measure import Measure
from bson.objectid import ObjectId
from src.models.device import Device
from .base_repository import BaseRepository


class DeviceRepository(BaseRepository):

    def insert(self, model: Device, user_id: int) -> str:
        self._execute_query(f"INSERT INTO Devices (user_id, ble_id, name, active, turned_on) VALUES ({user_id}, '{model.ble_id}', '{model.name}', {model.active}, {model.turned_on})")
        res = self._execute_query(f"SELECT device_id FROM Devices WHERE user_id = {user_id} AND ble_id = '{model.ble_id}'")
        return res.table['device_id'][0]

    def ble_id_exists_for_user(self, ble_id: str, user_id: int) -> bool:
        res = self._execute_query(f"SELECT COUNT(device_id) FROM Devices WHERE user_id = {user_id} AND ble_id = '{ble_id}'")
        res.table['count'][0] > 0

    def add_measure(self, measure: Measure, ble_id: str, user_id: int) -> None:
        # TODO: Cambiar el tipo de dato del timestamp a datetime
        self._execute_query(f"INSERT INTO Measures (device_id, voltage, current, timestamp) VALUES ("
                            f"(SELECT device_id FROM Devices WHERE user_id = {user_id} AND ble_id = '{ble_id}'), "
                            f"{measure.voltage}, {measure.current}, to_timestamp({measure.timestamp}))"
        )
