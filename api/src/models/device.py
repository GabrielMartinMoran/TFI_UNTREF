class Device:
    def __init__(self, name, ble_id):
        self.name = name
        self.ble_id = ble_id
        self.measurements = []

    def to_dict(self):
        return {
            'name': self.name,
            'bleId': self.ble_id,
            'measurements': [measurement.to_dict() for measurement in self.measurements]
        }

    def add_measurement(self, measurement):
        self.measurements.append(measurement)
