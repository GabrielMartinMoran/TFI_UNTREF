class Device:
    def __init__(self, name, ble_id, active=True):
        self.name = name
        self.ble_id = ble_id
        self.measurements = []
        self.active = active

    def to_dict(self):
        return {
            'name': self.name,
            'bleId': self.ble_id,
            'measurements': [measurement.to_dict() for measurement in self.measurements],
            'active': self.active
        }

    def add_measurement(self, measurement):
        self.measurements.append(measurement)
