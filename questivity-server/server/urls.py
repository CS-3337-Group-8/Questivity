from django.contrib import admin
from django.urls import path, include
from .views import ServerView

urlpatterns = [
    path('admin/', admin.site.urls),
    path('users/', include('users.urls')),
    path('', ServerView.as_view(), name="Server")
]
