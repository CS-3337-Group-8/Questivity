from rest_framework.response import Response
from rest_framework.views import APIView

class ServerView(APIView):
    def get(self, request):
        return Response({
            'message': 'Questivity Server Version 1.2',
        })
