class MockedCollection:

    def __init__(self):
        self.query_params = None
        self.prepared_returns = {}

    def prepare_return(self, method_name: str, expected: object):
        self.prepared_returns[method_name] = expected

    def find_one(self, query_params: dict):
        self.query_params = query_params
        if 'find_one' in self.prepared_returns:
            return self.prepared_returns['find_one']

    def insert_one(self, query_params: dict):
        self.query_params = query_params
        if 'insert_one' in self.prepared_returns:
            return self.prepared_returns['insert_one']