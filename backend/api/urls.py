from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import LunchSpotViewSet

router = DefaultRouter()

router.register(r'lunch_spots', LunchSpotViewSet, basename='lunch_spot')

urlpatterns = [
    path('', include(router.urls)),    

    # http://127.0.0.1:8000/api/lunch_spots/?random=true
]