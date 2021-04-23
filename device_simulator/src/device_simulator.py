import os
import json
import config
from src.models.device import Device
from datetime import datetime
from src.utils.console_clearer import clear_console
from src.orchestator import Orchestator
from src.repositories.device_repository import DeviceRepository


class DeviceSimulator:

    DATA_FILENAME = 'data.json'

    """
    - Estructura del archivo data.json
        [
            {
                "userSecret": string,
                "voltage": number,
                "current": number,
                "device": device,
                "createdDate": str
            }
        ]
    """

    def __init__(self):
        clear_console()
        print(f'{config.COLORS.GREEN}Iniciado el simulador de dispositivo{config.COLORS.END_COLOR}\n')
        self.__init_device()
        self.__start()

    # Devuelve el indice del dispositivo seleccionado
    def __generate_select_device_list(self, devices_names):
        print(f'\n{config.COLORS.MAGENTA}Seleccione el dispositivo a utilizar{config.COLORS.END_COLOR}')
        values_map = {}
        for i, x in enumerate(devices_names):
            values_map[i + 1] = x
            print(f'{i + 1} {config.COLORS.BLUE}- {config.COLORS.YELLOW}{x}{config.COLORS.END_COLOR}')
        selected = int(input(f'\n{config.COLORS.CYAN}Ingrese el número del dispositivo a utilizar: {config.COLORS.END_COLOR}'))
        return selected - 1

    def __start(self):
        try:
            self.orchestator = Orchestator(self.device, self.voltage, self.current, self.user_secret)
            self.orchestator.loop()
        except Exception as e:
            print(e)
        except:
            print(f'\n\n{config.COLORS.RED}Finalizando el simulador de dispositivo{config.COLORS.END_COLOR}\n')

    def __init_device(self):
        self.voltage = None
        self.current = None
        self.created_date = None
        self.load_data = False
        self.user_secret = None
        if self.__saved_data_exists():
            self.__ask_if_load()
        if self.load_data:
            self.__load_device()
        else:
            self.__create_device()

    def __ask_if_load(self):
        response = None
        while(True):
            response = input(
                f'\n{config.COLORS.CYAN}¿Desea cargar la configuración de un dispositivo existente? (S o N): {config.COLORS.END_COLOR}')
            if response.upper() in ['S', 'Y']:
                self.load_data = True
            elif response.upper() in ['N']:
                self.load_data = False
            else:
                print(
                    f'{config.COLORS.RED}La opción ingresada no es válida, por favor ingrese S o N!{config.COLORS.END_COLOR}')
                continue
            break

    def __load_device(self):
        loaded = self.__load_data()
        names = [f"{x['device']['name']} ({x['createdDate']})"  for x in loaded]
        selected_index = self.__generate_select_device_list(names)
        selected = loaded[selected_index]
        self.voltage = selected['voltage']
        self.current = selected['current']
        self.created_date = selected['createdDate']
        self.user_secret = selected['userSecret']
        self.device = Device.from_json(selected['device'])

    def __create_device(self):
        names = [x['name'] for x in config.DEVICES]
        selected_index = self.__generate_select_device_list(names)
        selected = config.DEVICES[selected_index]
        self.voltage = selected['voltage']
        self.current = selected['current']
        self.created_date = str(datetime.now())
        self.user_secret = self.__get_user_secret()
        self.device = Device(selected['name'], self.__generate_ble_id())
        DeviceRepository(self.user_secret).create(self.device)
        self.__store_data()

    def __get_user_secret(self):
        return input(f'\n{config.COLORS.CYAN}Ingrese el secreto (token) del usuario a utilizar: {config.COLORS.END_COLOR}')

    def __generate_ble_id(self):
        repository = DeviceRepository(None)
        return repository.get_ble_id()

    def __store_data(self):
        data = []
        if self.__saved_data_exists():
            data = self.__load_data()
        data.append({
            "userSecret": self.user_secret,
            "voltage": self.voltage,
            "current": self.current,
            "device": self.device.to_json(),
            "createdDate": self.created_date
        })
        with open(self.DATA_FILENAME, 'w') as f:
            f.flush()
            f.seek(0)
            f.write(json.dumps(data))

    def __saved_data_exists(self):
        return os.path.exists(self.DATA_FILENAME)

    def __load_data(self):
        with open(self.DATA_FILENAME, 'r') as f:
            return json.loads(f.read())
