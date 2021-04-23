from copy import deepcopy
from src.utils.console_clearer import clear_console
import config
import datetime

class ConsoleDisplay():    

    COLORS_REPLACEMENT = {
        '{magenta}': config.COLORS.END_COLOR + config.COLORS.MAGENTA,
        '{white}': config.COLORS.END_COLOR + config.COLORS.WHITE,
        '{red}': config.COLORS.END_COLOR + config.COLORS.RED,
        '{green}': config.COLORS.END_COLOR + config.COLORS.GREEN,
        '{yellow}': config.COLORS.END_COLOR + config.COLORS.YELLOW,
        '{blue}': config.COLORS.END_COLOR + config.COLORS.BLUE,
        '{cyan}': config.COLORS.END_COLOR + config.COLORS.CYAN,
    }

    def __init__(self):
        self.ui = []
        self.__load_default_ui()

    def __load_default_ui(self):
        with open(config.BASE_UI_PATH, 'r', encoding='utf-8') as f:
            self.default_ui = f.read()


    def __replace_colors(self):
        for key in self.COLORS_REPLACEMENT:
            self.ui = self.ui.replace(key, self.COLORS_REPLACEMENT[key])

    def __map_properties(self, device, user, out_message):
        self.ui = self.ui.replace('{current}', str(device.last_measure.current))
        self.ui = self.ui.replace('{voltage}', str(device.last_measure.voltage))
        self.ui = self.ui.replace('{power}', str(device.last_measure.power))
        self.ui = self.ui.replace('{time}', str(datetime.datetime.fromtimestamp(device.last_measure.timestamp)))
        self.ui = self.ui.replace('{name}', str(device.name))
        self.ui = self.ui.replace('{ble_id}', str(device.ble_id))
        self.ui = self.ui.replace('{username}', str(user.username))
        self.ui = self.ui.replace('{email}', str(user.email))
        self.ui = self.ui.replace('{user_id}', str(user.id))
        self.ui = self.ui.replace('{output_message}', out_message)

    def set_ui(self, device, user, out_message):
        self.ui = deepcopy(self.default_ui)
        self.__replace_colors()
        self.__map_properties(device, user, out_message)
        self.ui += config.COLORS.END_COLOR

    def draw(self):
        clear_console()
        print(self.ui, end='')
