from django.shortcuts import render
from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework.views import APIView
from . import models

class LunchSpotViewSet(viewsets.ModelViewSet):
    queryset = models.LunchSpot.objects.all()
    serializer_class = models.LunchSpotSerializer

    def list(self, request):
        queryset = self.get_queryset()
        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
    
    
