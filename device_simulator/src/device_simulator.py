import time
import config
from src.models.console_display import ConsoleDisplay
from src.models.device import Device
from src.models.measurement import Measurement
import random
from datetime import datetime


class DeviceSimulator:

    def __init__(self):
        self.device = Device('nombre', 'ble_id')
        self.voltage = None
        self.current = None
        self.__get_params()
        self.__start()        

    def __get_params(self):
        self.voltage = float(input('Ingrese el voltage de referencia: '))
        self.current = float(input('Ingrese la corriente de referencia: '))

    def __get_timestamp(self):
        return int(datetime.now().timestamp())

    def __get_variation(self, value):
        # 10% de variacion
        return value + (value * random.uniform(-0.1, 0.1))

    def __start(self):
        print("Iniciando dispositivo")
        display = ConsoleDisplay()
        while(True):
            self.device.add_measurement(
                Measurement(
                    self.__get_variation(self.voltage),
                    self.__get_variation(self.current),
                    self.__get_timestamp()
                )
            )
            display.set_ui(self.device)
            display.draw()
            time.sleep(config.TIME_BETWEEN_MEASUREMENTS)
