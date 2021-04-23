class Device:
    def __init__(self, name, ble_id, active=True, turned_on=False):
        self.name = name
        self.ble_id = ble_id
        self.last_measure = None
        self.active = active
        self.turned_on = turned_on

    def to_json(self):
        return {
            'name': self.name,
            'bleId': self.ble_id,
            'active': self.active,
            'turnedOn': self.turned_on
        }

    def set_last_measure(self, measure):
        self.last_measure = measure

    @staticmethod
    def from_json(json_data):
        return Device(json_data['name'], json_data['bleId'], active=json_data['active'], turned_on=json_data['turnedOn'])
