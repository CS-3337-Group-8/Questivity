from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed
from .serializers import UserSerializer
from .models import User
import jwt, datetime

class RegisterView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response({
            'message': 'User created successfully',
            'data': serializer.data
        })
        

class LoginView(APIView):
    def post(self, request):
        username = request.data['username']
        password = request.data['password']

        user = User.objects.filter(username=username).first()

        if user is None:
            raise AuthenticationFailed('User not found!')
        
        if not user.check_password(password):
            raise AuthenticationFailed('Incorrect password!')
        
        payload = {
            'id': user.id,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=60),
            'iat': datetime.datetime.utcnow()
        }

        token = jwt.encode(payload, 'secret-goes-here-this-one-is-not-secure', algorithm='HS256')

        response = Response()

        response.set_cookie(key='jwt', value=token, httponly=True)

        response.data = {
            'message': 'User logged in successfully',
            'jwt': token
        }
        
        return response
    
def get_payload(token):
    if not token:
        raise AuthenticationFailed('Unauthenticated!')
    
    try:
        return jwt.decode(token, 'secret-goes-here-this-one-is-not-secure', algorithms=['HS256'])
    except jwt.ExpiredSignatureError:
        raise AuthenticationFailed('Unauthenticated!')
    
class UserView(APIView):
    def get(self, request):        
        payload = get_payload(request.COOKIES.get('jwt'))
        user = User.objects.filter(id=payload['id']).first()
        serializer = UserSerializer(user)

        return Response(serializer.data)
    
    def delete(self, request):
        payload = get_payload(request.COOKIES.get('jwt'))
        User.objects.filter(id=payload['id']).first().delete()

        return Response({'message': 'User deleted successfully'})
        

class LogoutView(APIView):
    def post(self, request):
        response = Response()
        response.delete_cookie('jwt')
        response.data = {
            'message': 'Success'
        }

        return response
        
