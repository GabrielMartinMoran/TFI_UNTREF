from flask import jsonify
from src.utils import http_methods

class CORSSolver:

    def __init__(self, request):
        self.request = request

    def is_cors_request(self) -> bool:
        return self.request.method == http_methods.OPTIONS

    def get_wanted_http_metod(self):
        return self.request.headers['Access-Control-Request-Method']

    def get_cors_response(self, method):
        if method is None:
            return jsonify(ssuccess=False)
        response = jsonify(ssuccess=True)
        req_h = self.request.headers
        response.headers['Access-Control-Allow-Origin'] = req_h['Origin']
        response.headers['Access-Control-Allow-Methods'] = req_h['Access-Control-Request-Method']
        response.headers['Access-Control-Allow-Headers'] = req_h['Access-Control-Request-Headers']
        response.headers['Access-Control-Max-Age'] = 86400
        response.headers['Access-Control-Allow-Credentials'] = 'true'
        return response
