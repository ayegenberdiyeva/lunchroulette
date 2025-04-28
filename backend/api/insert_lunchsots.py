# from django.core.management.base import BaseCommand
# from .models import LunchSpot, Cuisine

# class Command(BaseCommand):
#     help = "Insert initial LunchSpot entries"

#     def handle(self, *args, **kwargs):

#         cuisines = {
#             "National": Cuisine.objects.get_or_create(name="National", slug="national", emoji="🍲")[0],
#             "Korean": Cuisine.objects.get_or_create(name="Korean", slug="korean", emoji="🍚")[0],
#             "Japanese": Cuisine.objects.get_or_create(name="Japanese", slug="japanese", emoji="🍣")[0],
#             "Chinese": Cuisine.objects.get_or_create(name="Chinese", slug="chinese", emoji="🥡")[0],
#             "Italian": Cuisine.objects.get_or_create(name="Italian", slug="italian", emoji="🍝")[0],
#             "French": Cuisine.objects.get_or_create(name="French", slug="french", emoji="🥖")[0],
#             "Turkish": Cuisine.objects.get_or_create(name="Turkish", slug="turkish", emoji="🥙")[0],
#         }

#         lunch_spots = [
#             LunchSpot(
#                 name="Sakura Sushi",
#                 cuisine=cuisines["Japanese"],
#                 average_bill=12000,
#                 waiting_time=15,
#                 rating=4.5,
#                 rating_count=100,
#                 address="Almaty, Nazarbayev ave 123",
#                 working_till="23:00",
#                 map_url="https://2gis.kz/almaty/geo/70000001088050245",
#                 menu_url="https://okadzaki.kz/"
#             ),
#             LunchSpot(
#                 name="Bella Italia",
#                 cuisine=cuisines["Italian"],
#                 average_bill=18000,
#                 waiting_time=20,
#                 rating=3.8,
#                 rating_count=200,
#                 address="Almaty, Kairbekov str 456",
#                 working_till="22:00",
#                 map_url="https://2gis.kz/almaty/geo/70000001088050245",
#                 menu_url="https://okadzaki.kz/"
#             ),
#             LunchSpot(
#                 name="Chopan",
#                 cuisine=cuisines["National"],
#                 average_bill=8000,
#                 waiting_time=30,
#                 rating=4.2,
#                 rating_count=100,
#                 address="Almaty, Kairbekov str 456",
#                 working_till="22:00",
#                 map_url="https://2gis.kz/almaty/geo/70000001088050245",
#                 menu_url="https://okadzaki.kz/"
#             ),
#             LunchSpot(
#                 name="Maison de Paris",
#                 cuisine=cuisines["French"],
#                 average_bill=25000,
#                 waiting_time=45,
#                 rating=2.9,
#                 rating_count=500,
#                 address="Almaty, Kairbekov str 456",
#                 working_till="21:30",
#                 map_url="https://2gis.kz/almaty/geo/70000001088050245",
#                 menu_url="https://okadzaki.kz/"
#             ),
#             LunchSpot(
#                 name="Bosphorus Grill",
#                 cuisine=cuisines["Turkish"],
#                 average_bill=15000,
#                 waiting_time=60,
#                 rating=4.7,
#                 rating_count=100,
#                 address="Almaty, Kairbekov str 456",
#                 working_till="22:00",
#                 map_url="https://2gis.kz/almaty/geo/70000001088050245",
#                 menu_url="https://okadzaki.kz/"
#             ),
#             LunchSpot(
#                 name="Han Kuk",
#                 cuisine=cuisines["Korean"],
#                 average_bill=10000,
#                 waiting_time=15,
#                 rating=3.5,
#                 rating_count=200,
#                 address="Almaty, Kairbekov str 456",
#                 working_till="23:00",
#                 map_url="https://2gis.kz/almaty/geo/70000001088050245",
#                 menu_url="https://okadzaki.kz/"
#             )
#         ]

#         LunchSpot.objects.bulk_create(lunch_spots)
#         print("✅ Successfully inserted LunchSpots!")

#         self.stdout.write(self.style.SUCCESS("Successfully inserted lunch spots!"))