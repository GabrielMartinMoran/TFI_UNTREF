import datetime
from src.models.recovery_token import RecoveryToken
import jwt
from flask import jsonify
from src.controllers.base_controller import BaseController, http_method
from src.repositories.user_repository import UserRepository
from src.repositories.recovery_token_repository import RecoveryTokenRepository
from src.models.user import User
import src.config as config
from src.utils import http_methods
from src import config


class AuthController(BaseController):

    @http_method(http_methods.POST)
    def login(self) -> dict:
        body = self.get_json_body()
        user = UserRepository().get_by_email(body['email'])
        if user is None or not user.password_matches(body['password']):
            return self.error('Invalid email or password')
        """
        if not user.verified:
            response = jsonify({'message': 'Account is not verified', 'code' : config.ErrorCodes.ACCOUNT_NOT_VERIFIED})
            response.status_code = 403
            return response
        """
        return self.ok_success({'token': self.generate_jwt(user)})

    def generate_jwt(self, user: User) -> str:
        token_data = {
            'id': user.user_id,
            'email': user.email,
            'timestamp': datetime.datetime.utcnow().timestamp(),
            #'user_agent': self.request.headers['User-Agent']
        }
        return jwt.encode(token_data, config.APP_SECRET, algorithm=config.HASH_ALGORITHM)

    @http_method(http_methods.POST)
    def verify_account(self, user_id: str) -> dict:
        if not user_id:
            return self.validation_error('No userId provided')
        body = self.get_json_body()
        if not 'verificationToken' in body:
            return self.validation_error('No verificationToken provided')
        verified = False
        try:
            verified = UserRepository().verify_user(user_id, body['verificationToken'])
        except Exception as ex:
            return self.error(F'An error has occured while trying to verify user with id {user_id}')
        if not verified:
            return self.validation_error(F'Invalid userId or verificationToken')
        return self.ok_success()

    @http_method(http_methods.POST)
    def send_verification_email(self, email: str) -> dict:
        repo = UserRepository()
        user = repo.get_by_email(email)
        if not user or user.verified:
            return self.validation_error('Invalid email to send verification email')
        try:
            user.send_verification_email()
        except Exception as ex:
            return self.error(F'An error has occured while trying to send verification email to {email}')
        return self.ok_success()

    @http_method(http_methods.POST)
    def password_reset_request(self, email: str) -> dict:
        repo = UserRepository()
        user = repo.get_by_email(email)
        if not user:
            return self.error('No user registered with that email')
        
        reco_token = RecoveryToken(user.user_id)

        try:
            RecoveryTokenRepository().insert(reco_token)
        except Exception as ex:
            return self.error('Error generating token')
        try:
            user.send_reset_pass_email(reco_token.token_value)
        except Exception as ex:
            return self.error(F'An error has occured while trying to send password reset email to {email}')
        return self.ok_success()

    @http_method(http_methods.GET, auth_required=True)
    def get_renewed_token(self) -> dict:
        user = User()
        user.email = self.token['email']
        user.user_id = self.get_authenticated_user_id()
        return self.ok_success({'token': self.generate_jwt(user)})
