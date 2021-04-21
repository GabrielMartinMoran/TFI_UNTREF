class Device:
    def __init__(self, name, ble_id, active=True, turned_on=False):
        self.name = name
        self.ble_id = ble_id
        self.measurements = []
        self.active = active
        self.turned_on = turned_on

    def to_dict(self):
        return {
            'name': self.name,
            'bleId': self.ble_id,
            'measurements': [measurement.to_dict() for measurement in self.measurements],
            'active': self.active,
            'turnedOn': self.turned_on
        }

    def add_measurement(self, measurement):
        self.measurements.append(measurement)
