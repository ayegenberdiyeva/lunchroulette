from django.db import models

class LunchSpot(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=255)
    cuisine = models.CharField(max_length=255)
    average_price = models.FloatField()
    waiting_time = models.IntegerField()
    rating = models.FloatField()
    rating_count = models.IntegerField()
    address = models.CharField(max_length=255)
    working_till = models.CharField(max_length=255)
    map_url = models.CharField(max_length=255)
    menu_url = models.CharField(max_length=255)

    def __str__(self):
        return self.name