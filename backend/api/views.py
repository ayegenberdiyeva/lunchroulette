from rest_framework import viewsets, filters, status
from rest_framework.decorators import action
from rest_framework.response import Response
from django_filters.rest_framework import DjangoFilterBackend
from .models import LunchSpot, Cuisine
from .serializers import LunchSpotSerializer
import random
from decimal import Decimal

def get_price_range_values(price_range_key):
    max_value = Decimal('9999999999.99')

    if price_range_key == 'low': 
        return Decimal('0.00'), Decimal('5000.00')
    elif price_range_key == 'medium':
        return Decimal('5000.01'), Decimal('12000.00')
    elif price_range_key == 'high':
        return Decimal('12000.01'), Decimal('25000.00')
    elif price_range_key == 'luxury':
        return Decimal('25000.01'), max_value
    
    return None, None

class LunchSpotViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = LunchSpot.objects.select_related('cuisine').all()
    serializer_class = LunchSpotSerializer

    filter_backends = [DjangoFilterBackend]
    filterset_fields = ['cuisine__slug']

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())

        max_waiting_time = request.query_params.get('max_waiting_time')
        if max_waiting_time:
            try:
               queryset = queryset.filter(waiting_time__lte=int(max_waiting_time))
            except (ValueError, TypeError):
               pass

        price_range = request.query_params.get('price_range')
        if price_range:
            min_val, max_val = get_price_range_values(price_range)
            if min_val is not None and max_val is not None:
                if max_val == Decimal('9999999999.99'):
                    queryset = queryset.filter(average_bill__gte=min_val)
                else:
                    queryset = queryset.filter(average_bill__gte=min_val, average_bill__lte=max_val)

        is_random = request.query_params.get('random', 'false').lower() == 'true'
        if is_random:
            filtered_list = list(queryset)
            if filtered_list:
                random_lunch_spot = random.choice(filtered_list)
                serializer = self.get_serializer(random_lunch_spot)
                return Response(serializer.data, status=status.HTTP_200_OK)
            else:
                return Response({"detail": "No lunch spots found."}, status=status.HTTP_404_NOT_FOUND)
        else:
            page = self.paginate_queryset(queryset)
            if page is not None:
                serializer = self.get_serializer(page, many=True)
                return self.get_paginated_response(serializer.data)

            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)
        
        