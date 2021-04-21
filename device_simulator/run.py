from src.device_simulator import DeviceSimulator
import os

if __name__ == '__main__':
    DeviceSimulator()
    """
    dir_path = os.path.dirname(os.path.realpath(__file__))
    device_simulator_path = os.path.join(dir_path, 'src', 'device_simulator.py')
    os.system(f'cd {dir_path} && python {device_simulator_path}')
    """