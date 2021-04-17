from flask import Flask, jsonify
from threading import Thread
import time
import random
from datetime import datetime

from models.device import Device
from models.measurement import Measurement

app = Flask(__name__)

APP_PORT = 5000

REF_VOLTAGE = 220

data = [
    Device('Heladera', 'b3240d32-9ee9-11eb-a8b3-0242ac130003'),
    Device('Lavarropas', 'bbe4137c-9ee9-11eb-a8b3-0242ac130003'),
    Device('Cafetera', 'c331ee60-9ee9-11eb-a8b3-0242ac130003'),
    Device('Computadora', 'c80fbd68-9ee9-11eb-a8b3-0242ac130003'),
]

def data_generating_thread():
    global data
    loop = True
    while(loop):
        for device in data:
            device.add_measurement(
                Measurement(
                    REF_VOLTAGE + random.uniform(-10, 10),
                    random.uniform(0, 1),
                    int(datetime.now().timestamp() * 1000)
                )
            )
        time.sleep(20)
        loop = True


@app.route('/get_data', methods=['GET'])
def get_data():
    return jsonify([device.to_dict() for device in data])

if __name__ == '__main__':
    thread = Thread(target=data_generating_thread)
    thread.start()
    app.run(port=APP_PORT)
