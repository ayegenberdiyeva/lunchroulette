from django.db import models

class LunchSpot(models.Model):    
    name = models.CharField(max_length=255)
    cuisine = models.ForeignKey('Cuisine', on_delete=models.CASCADE, related_name='lunch_spots')
    average_bill = models.DecimalField(max_digits=10, decimal_places=2, default=0.00)
    waiting_time = models.IntegerField()
    rating = models.DecimalField(max_digits=3, decimal_places=1)
    rating_count = models.IntegerField()
    address = models.TextField()
    working_till = models.CharField(max_length=255)
    map_url = models.URLField(max_length=500)
    menu_url = models.URLField(max_length=500)

    def __str__(self):
        return self.name
    
class Cuisine(models.Model):
    name = models.CharField(max_length=255, unique=True)
    slug = models.SlugField(max_length=255, unique=True)
    emoji = models.CharField(max_length=5, blank=True, null=True)

    def __str__(self):
        return self.name
    