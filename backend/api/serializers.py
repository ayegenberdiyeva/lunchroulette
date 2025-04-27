from rest_framework import serializers
from . import models

class LunchSpotSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.LunchSpot
        fields = '__all__'