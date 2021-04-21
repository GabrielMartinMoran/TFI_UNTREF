from copy import deepcopy
import sys
import os
import config


class ConsoleDisplay():

    END_COLOR = '\033[0m'

    COLORS_REPLACEMENT = {
        '{purple}': END_COLOR + '\033[35m',
        '{white}': END_COLOR +'\033[37m',
        '{red}': END_COLOR + '\033[91m',
        '{green}': END_COLOR + '\033[92m',
        '{yellow}': END_COLOR + '\033[93m',
        '{blue}': END_COLOR + '\033[94m',
        '{cyan}': END_COLOR + '\033[96m',
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

    def __map_properties(self, device):
        self.ui = self.ui.replace('{current}', str(device.measurements[-1].current))
        self.ui = self.ui.replace('{voltage}', str(device.measurements[-1].voltage))
        self.ui = self.ui.replace('{power}', str(device.measurements[-1].power))
        self.ui = self.ui.replace('{time}', str(device.measurements[-1].timestamp))

    def set_ui(self, device):
        self.ui = deepcopy(self.default_ui)
        #self.ui = self.ui.replace('{iterator_value}', str(iterator_value))
        self.__replace_colors()
        self.__map_properties(device)
        self.ui += self.END_COLOR

    def draw(self):
        #cmd_print_command = self.ui.replace('\n',' && echo ')
        os.system('cls')
        print(self.ui, end='')
        #sys.stdout.write(self.ui)
        #sys.stdout.flush()
        #print(self.ui, end=self.END_COLOR)
