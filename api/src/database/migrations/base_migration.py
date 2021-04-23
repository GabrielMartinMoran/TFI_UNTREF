from pymongo import MongoClient
import config


class BaseMigration:

    MIGRATION_NUMBER = None

    def __init__(self):
        self.client = None
        self.database = None
        self.connect_to_db()

    def apply_migration(self):
        pass

    def connect_to_db(self):
        self.client = MongoClient(config.DB_URL, int(config.DB_PORT))
        self.database = self.client[config.DB_NAME]

    def create_collection(self, collection_name):
        self.database.create_collection(collection_name)

    def create_collections(self, collections_names):
        for collection in collections_names:
            self.create_collection(collection)