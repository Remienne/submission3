import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission3/data/api/api_service.dart';
import 'package:submission3/data/model/restaurant.dart';
import 'package:submission3/data/provider/search_provider.dart';

import 'json_parsing_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  var firstSearchTest = {
    "id": "6u9lf7okjh9kfw1e867",
    "name": "Ampiran Kota",
    "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    "pictureId": "35",
    "city": "Balikpapan",
    "rating": 4.1
  };

  String jsonResponse = '''
  {
      "error": false,
      "founded": 1,
      "restaurants":[
          {
              "id": "6u9lf7okjh9kfw1e867",
              "name": "Ampiran Kota",
              "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
              "pictureId": "35",
              "city": "Balikpapan",
              "rating": 4.1
          },
      ]
  }
  ''';

  test('model test', () {
    // The model should be able to receive the following data:
    final user = Restaurant(
      id: '',
      name: '',
      description: '',
      pictureId: '',
      city: '',
      rating: '',
    );

    expect(user.id, '');
    expect(user.name, '');
    expect(user.description, '');
    expect(user.pictureId, '');
    expect(user.city, '');
    expect(user.rating, '');
  });
  test('search testing with "ampiran" as query', () async {
    final client = MockClient();
    String query = 'ampiran';
    // Use Mockito to return a successful response when it calls the
    // provided http.Client.
    when(client
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q='+query)))
        .thenAnswer((_) async =>
        http.Response(jsonResponse, 200));
    SearchProvider restaurantProvider =
    SearchProvider(apiService: ApiService(client: client), query: query);
    await restaurantProvider.fetchRestaurantSearch(query);
    //act
    var resultRestaurantId = restaurantProvider.result.restaurants[0].id ==
        Restaurant.fromJson(firstSearchTest).id;
    var resultRestaurantName = restaurantProvider.result.restaurants[0].name ==
        Restaurant.fromJson(firstSearchTest).name;
    // assert
    expect(resultRestaurantId, true);
    expect(resultRestaurantName, true);
  });
}


