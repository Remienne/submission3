import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:submission3/data/model/restaurant.dart';
import 'package:submission3/data/model/restaurant_details.dart';

void main() {
  test('test 1', () {
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
  test('test 3', () async {
    Future<Response> _mockRequest(Request request) async {
      if (request.url
          .toString()
          .startsWith('https://jsonplaceholder.typicode.com/posts/')) {
        return http.Response(
            File('test/test_resources/random_user.json').readAsStringSync(),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            });
      }
      return http.Response('Error: Unknown endpoint', 404);
    }

    final apiProvider = ApiProvider(MockClient(_mockRequest));
    final user = await apiProvider.getUser();
    expect(user.userId, 1);
    expect(user.id, 1);
    expect(
      user.title,
      'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
    );
    expect(
      user.body,
      'quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto',
    );
  });
}
