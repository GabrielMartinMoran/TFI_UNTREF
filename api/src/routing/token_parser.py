import jwt
from src import config

class TokenParser:

    def __init__(self, request):
        self.request = request
        self.parse_token()

    def parse_token(self):
        try:
            token = self.request.headers['Authorization']
            token_type = 'Bearer'
            if token_type in token:
                token = token[len(token_type)+1:]
            data = jwt.decode(token, config.APP_SECRET,
                              algorithms=[config.HASH_ALGORITHM])
            #if self.request.headers['User-Agent'] == data['user_agent']:
            self.token = data
            return
        except Exception as ex:            
            self.token = None
            return

    def valid_token(self):
        return self.token is not None

    def get_token(self):
        return self.token
