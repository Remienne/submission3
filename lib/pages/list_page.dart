
import 'package:flutter/cupertino.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission3/data/api/api_service.dart';
import 'package:submission3/data/provider/main_list_provider.dart';
import 'package:submission3/data/model/restaurant.dart';
import 'package:submission3/utils/result_state.dart';
import 'detail_page.dart';

class ListPage extends StatefulWidget{
  static const routeName = '/restaurant_list';

  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity, Widget child) {
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  connected
                      ? _buildList(context)
                      : const Center(
                      child: Text(
                        'Oops, something is wrong! No internet connection detected',
                        style: TextStyle(
                          fontFamily: 'UbuntuMedium',
                          fontSize: 13,
                        ),
                      )
                  ),
                ],
              );
        },
        child: const SizedBox(height: 0),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ChangeNotifierProvider<MainListProvider>(
        create: (_) => MainListProvider(apiService: ApiService()),
        child: Consumer<MainListProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 30.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "Restaurant",
                                    style: TextStyle(fontSize: 30.0, fontFamily: 'UbuntuRegular'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8,),
                              const Text(
                                "Recommendations restaurant for you!",
                                style: TextStyle(fontSize: 15.0, fontFamily: 'UbuntuLight', color: Colors.grey),
                              ),

                            ],
                          ),
                        ),

                        Expanded(
                          child: ListView.builder(
                            itemCount: state.result.restaurants.length,
                            itemBuilder: (context, index) {
                              var restaurant = state.result.restaurants[index];
                              return BuildRestaurantItem(restaurant: restaurant);
                            },
                          ),
                        )
                      ],
                    )
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text(''));
            }
          },
        )
    );
  }
}



class BuildRestaurantItem extends StatelessWidget{
  final Restaurant restaurant;

  const BuildRestaurantItem({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName,
              arguments: restaurant);
        },
        child: Card(
          margin: const EdgeInsets.only(bottom: 20),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(children: <Widget>[
            SizedBox(
                height: 90,
                width: 110,
                child: Hero(
                  tag: restaurant.id,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(14),
                          bottom: Radius.circular(14)),
                      child: Image.network(
                        'https://restaurant-api.dicoding.dev/images/small/'
                            + restaurant.pictureId,
                        fit: BoxFit.cover,
                      ),
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: const TextStyle(
                      fontFamily: 'UbuntuBold',
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black26,
                        size: 15,
                      ),
                      const SizedBox(width: 3,),
                      Text(
                        restaurant.city,
                        style: const TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontSize: 14,
                            color: Colors.black38),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.black45,
                        size: 15,
                      ),
                      const SizedBox(width: 3,),
                      Text(
                        restaurant.rating,
                        style: const TextStyle(
                            fontFamily: 'UbuntuRegular',
                            fontSize: 14,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ]),
        )
    );
  }

}



