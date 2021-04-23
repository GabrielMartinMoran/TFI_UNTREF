class Measure():

    def __init__(self, voltage, current, timestamp):
        self.voltage = voltage
        self.current = current
        self.power = voltage * current
        self.timestamp = timestamp

    def to_json(self):
        return {
            'voltage': self.voltage,
            'current': self.current,
            'timestamp': self.timestamp
        }
