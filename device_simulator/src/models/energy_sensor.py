import random


class EnergySensor:

    VOLTAGE_VARIATION_PERCENTAJE = 0.01
    CURRENT_VARIATION_PERCENTAJE = 0.05
    PRECISION = 3

    def __init__(self, ref_voltage, ref_current):
        self.ref_voltage = ref_voltage
        self.ref_current = ref_current

    def get_voltage(self):
        return self.__get_variation(self.ref_voltage, self.VOLTAGE_VARIATION_PERCENTAJE)

    def get_current(self):
        return self.__get_variation(self.ref_current, self.CURRENT_VARIATION_PERCENTAJE)

    def __get_variation(self, reference, variation_percentaje):
        variation = reference + (reference * random.uniform(-variation_percentaje, variation_percentaje))
        return round(variation, self.PRECISION)