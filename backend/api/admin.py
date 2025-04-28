from django.contrib import admin
from .models import LunchSpot, Cuisine

@admin.register(LunchSpot)
class LunchSpotAdmin(admin.ModelAdmin):
    list_display = ('name', 'cuisine', 'average_bill', 'rating')
    search_fields = ('name',)
    list_filter = ('cuisine',)

@admin.register(Cuisine)
class CuisineAdmin(admin.ModelAdmin):
    list_display = ('name', 'slug', 'emoji')
    search_fields = ('name', 'slug')