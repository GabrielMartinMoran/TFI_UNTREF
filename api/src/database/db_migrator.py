import sys
import os
import datetime
from pymongo import MongoClient
from utils import console_colors
import config
from database.migrations.migration_001 import Migration001


class DBMigrator:

    MIGRATIONS = [
        Migration001
    ]

    def __init__(self):
        self.app_info = None
        self.load_collection()
        self.load_app_info()

    def run_migrations(self):
        print(
            F'{console_colors.INFO}Corriendo migraciones de la base de datos:{console_colors.ENDC}')
        self.MIGRATIONS.sort(key=lambda x: x.MIGRATION_NUMBER)
        for x in self.MIGRATIONS:
            common_msg = F'la migracion {x.MIGRATION_NUMBER} del archivo {self.get_migration_filename(x)}{console_colors.ENDC}'
            if x.MIGRATION_NUMBER <= self.get_last_applied_migration():
                print(F'{console_colors.WARNING} ‣ Saltando {common_msg}')
            else:
                print(F'{console_colors.OK} ‣ Aplicando {common_msg}')
                self.apply_migration(x)
        print('\n\n')

    def load_collection(self):
        self.client = MongoClient(config.DB_URL, int(config.DB_PORT))
        self.db = self.client[config.DB_NAME]
        self.collection = self.db[config.APP_INFO_COLLECTION]

    def load_app_info(self):
        self.app_info = self.collection.find_one({})

    def get_last_applied_migration(self):
        if self.app_info:
            return self.app_info[config.LAST_MIGRATION_APP_INFO_KEY]
        return 0

    def apply_migration(self, migration_class):
        migration_class().apply_migration()
        self.update_to_last_migration(migration_class.MIGRATION_NUMBER)

    def update_to_last_migration(self, last_migration_number):
        json = {
            config.LAST_MIGRATION_APP_INFO_KEY: last_migration_number,
            config.LAST_MIGRATION_APP_INFO_DATE: datetime.datetime.now()
        }
        if self.app_info:
            self.collection.update_one({'_id': self.app_info['_id']}, {"$set": json})
        else:
            self.collection.insert_one(json)
            self.app_info = json

    def get_migration_filename(self, migration_class):
        return os.path.split(sys.modules[migration_class.__module__].__file__)[1]
