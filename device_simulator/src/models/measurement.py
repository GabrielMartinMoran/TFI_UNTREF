class Measurement():

    def __init__(self, voltage, current, timestamp):
        self.voltage = voltage
        self.current = current        
        self.power = voltage * current
        self.timestamp = timestamp

    def to_dict(self):
        return {
            'voltage': self.voltage,
            'current': self.current,
            'power': self.power,
            'timestamp': self.timestamp
        }
