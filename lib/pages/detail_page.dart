import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:submission3/data/api/api_service.dart';
import 'package:submission3/data/model/restaurant.dart';
import 'package:submission3/data/provider/database_provider.dart';
import 'package:submission3/data/provider/detail_provider.dart';
import 'package:submission3/data/model/restaurant_details.dart';
import 'package:submission3/utils/result_state.dart';

class DetailPage extends StatelessWidget{
  static const routeName = '/restaurant_list_detail';
  final Restaurant restaurant;
  const DetailPage({Key? key, required this.restaurant}) : super(key: key);

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
                  ? ChangeNotifierProvider<DetailProvider>(
                  create: (_) => DetailProvider(apiService: ApiService(), id: restaurant.id),
                  child: Consumer<DetailProvider>(
                    builder: (context, state, _) {
                      if (state.state == ResultState.loading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.state == ResultState.hasData) {
                        final details = state.result.restaurantDetailsData;
                        return Consumer<DatabaseProvider>(
                          builder: (context, provider, child) {
                            return FutureBuilder<bool>(
                              future: provider.isFavorite(details.id),
                              builder: (context, snapshot) {
                                var isBookmarked = snapshot.data ?? false;
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: <Widget>[
                                          Hero(
                                            tag: details.id,
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius.only(
                                                  bottomLeft: Radius.circular(15),
                                                  bottomRight: Radius.circular(15)
                                              ),
                                              child: Image.network(
                                                'https://restaurant-api.dicoding.dev/images/medium/'
                                                    + details.pictureId,
                                              ),
                                            ),
                                          ),
                                          SafeArea(
                                              child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundColor: const Color(0xFFe0e0e0),
                                                        child: IconButton(
                                                            icon: const Icon(Icons.arrow_back),
                                                            color: const Color(0xFFaeaeae),
                                                            onPressed: () {
                                                              Navigator.pop(context);
                                                            }
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                              )
                                          ),
                                          Positioned(
                                            bottom: -20,
                                            right: 30,
                                            child: CircleAvatar(
                                              backgroundColor: const Color(0xFFe0e0e0),
                                              child: isBookmarked
                                                  ? IconButton(
                                                    icon: const Icon(Icons.favorite),
                                                    color: const Color(0xFFaeaeae),
                                                    onPressed: () => provider.removeFavorite(restaurant.id),
                                              )
                                                  : IconButton(
                                                    icon: const Icon(Icons.favorite_border),
                                                    color: const Color(0xFFaeaeae),
                                                    onPressed: () => provider.addFavorite(restaurant),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              details.name,
                                              style: const TextStyle(
                                                  fontFamily: 'UbuntuMedium',
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                              margin: const EdgeInsets.only(left: 0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: Colors.black26,
                                                    size: 18,
                                                  ),
                                                  const SizedBox(width: 3,),
                                                  Text(
                                                    details.address,
                                                    style: const TextStyle(
                                                        fontFamily: 'UbuntuRegular',
                                                        fontSize: 17,
                                                        color: Colors.black38),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 25),
                                            const Text(
                                              "Descriptions",
                                              style: TextStyle(
                                                fontFamily: 'UbuntuMedium',
                                                fontSize: 19,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            ReadMoreText(
                                              details.description,
                                              textAlign: TextAlign.justify,
                                              trimLines: 4,
                                              colorClickableText: Colors.blueAccent,
                                              trimMode: TrimMode.Line,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontFamily: 'OxygenRegular'
                                              ),
                                            ),
                                            const SizedBox(height: 25),
                                            const Text(
                                              "Foods",
                                              style: TextStyle(
                                                fontFamily: 'UbuntuMedium',
                                                fontSize: 19,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 150,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: state.result.restaurantDetailsData.menus.foods.length,
                                                itemBuilder: (context, index) {
                                                  return _buildFoodsItem(context, details.menus.foods[index]);
                                                },
                                              ),
                                            ),

                                            const SizedBox(height: 15),
                                            const Text(
                                              "Drinks",
                                              style: TextStyle(
                                                fontFamily: 'UbuntuMedium',
                                                fontSize: 19,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            SizedBox(
                                              height: 150,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                itemCount: state.result.restaurantDetailsData.menus.drinks.length,
                                                itemBuilder: (context, index) {
                                                  return _buildDrinksItem(context, details.menus.drinks[index]);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
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
              )
                  : const Center(
                  child: Text(
                    'Oops, something is wrong! No internet connection detected',
                    style: TextStyle(
                      fontFamily: 'UbuntuMedium',
                      fontSize: 13,
                    ),
                  )
              )
            ],
          );
        },
        child: const SizedBox(height: 0),
      ),
    );

  }
}

Widget _buildFoodsItem(BuildContext context, FoodsDrinks menu) {
  return InkWell(
      child: Card(
        margin: const EdgeInsets.only(bottom: 20, right: 20),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 180,
          height: 200,
          color: const Color(0xFFe0e0e0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 180,
                height: 95,
                child: ClipRRect(
                  child: Image.asset('assets/foods.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
                child: Text(
                  menu.name,
                  style: const TextStyle(
                      fontSize: 14,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      )
  );
}

Widget _buildDrinksItem(BuildContext context, FoodsDrinks menu) {
  return InkWell(
      child: Card(
        margin: const EdgeInsets.only(bottom: 20, right: 20),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 180,
          height: 200,
          color: const Color(0xFFe0e0e0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 180,
                height: 90,
                child: ClipRRect(
                  child: Image.asset('assets/drinks.png'),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 5),
                child: Text(
                  menu.name,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),
                ),
              )
            ],
          ),
        ),
      )
  );
}