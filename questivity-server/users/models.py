from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    username = models.CharField(max_length=255, unique=True)
    password = models.CharField(max_length=255)
    is_instructor = models.BooleanField(default=False)
    games_played = models.PositiveIntegerField(default=0)
    experience_level = models.PositiveIntegerField(default=0)

    REQUIRED_FIELDS = []


