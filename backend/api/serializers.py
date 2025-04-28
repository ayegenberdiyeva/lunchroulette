from rest_framework import serializers
from . import models

class CuisineSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.Cuisine
        fields = '__all__'

class LunchSpotSerializer(serializers.ModelSerializer):
    cuisine = CuisineSerializer(read_only=True)
    cuisine_slug = serializers.SlugRelatedField(
        slug_field='slug',
        queryset=models.Cuisine.objects.all(),
        write_only=True,
        source='cuisine'
    )
    class Meta:
        model = models.LunchSpot
        fields = [
            'id', 'name', 'cuisine', 'cuisine_slug', 'average_bill',
            'waiting_time', 'rating', 'rating_count', 'address',
            'working_till', 'map_url', 'menu_url'
        ]
        read_only_fields = ['cuisine']

