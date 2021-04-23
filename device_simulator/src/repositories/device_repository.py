import config
from src.models.device import Device
from src.models.measure import Measure
from src.repositories.base_repository import BaseRepository


class DeviceRepository(BaseRepository):

    ENDPOINT = '/devices'

    def get_ble_id(self) -> str:
        response = self.get(f"{config.API_URL}{self.ENDPOINT}/generate_ble_id")
        return response['bleId']

    def create(self, device: Device) -> None:
        self.post(f"{config.API_URL}{self.ENDPOINT}/create", device.to_json())

    def add_measure(self, ble_id: str, measure: Measure) -> None:
        self.post(f"{config.API_URL}{self.ENDPOINT}/add_measure/{ble_id}", measure.to_json())
