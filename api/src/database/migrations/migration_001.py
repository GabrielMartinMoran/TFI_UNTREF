import pymongo
import datetime
from database.migrations.base_migration import BaseMigration


class Migration001(BaseMigration):

    MIGRATION_NUMBER = 1

    USERS_COLLECTION = 'users'
    RECOVERY_TOKEN_COLLECTION = 'recoveryTokens'

    def apply_migration(self):
        self.create_collections([self.USERS_COLLECTION, self.RECOVERY_TOKEN_COLLECTION])
        # Creamos el indice a recovery tokens
        self.database[self.RECOVERY_TOKEN_COLLECTION].create_index(
            [("userid", pymongo.TEXT)])
