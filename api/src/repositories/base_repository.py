from pymongo import MongoClient
from src.utils import global_variables
import src.config as config

class BaseRepository:

    COLLECTION_NAME = None

    def __init__(self):
        if not global_variables.MONGO_CLIENT_INSTANCE:
            global_variables.MONGO_CLIENT_INSTANCE = MongoClient(config.DB_URL, int(config.DB_PORT))
        self.data_base = global_variables.MONGO_CLIENT_INSTANCE[config.DB_NAME]
        self.collection = self.get_collection()

    def get_collection(self):
        return self.data_base[self.COLLECTION_NAME]
