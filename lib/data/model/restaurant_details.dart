// To parse this JSON data, do
//
//     final restaurantDetails = restaurantDetailsFromJson(jsonString);

class RestaurantDetails {
  RestaurantDetails({
    required this.error,
    required this.message,
    required this.restaurantDetailsData,
  });

  bool error;
  String message;
  RestaurantDetailsData restaurantDetailsData;

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) => RestaurantDetails(
    error: json["error"],
    message: json["message"],
    restaurantDetailsData: RestaurantDetailsData.fromJson(json["restaurant"]),
  );
}

class RestaurantDetailsData {
  RestaurantDetailsData({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<Category> categories;
  Menus menus;
  String rating;
  List<CustomerReview> customerReviews;

  factory RestaurantDetailsData.fromJson(Map<String, dynamic> json) => RestaurantDetailsData(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    address: json["address"],
    pictureId: json["pictureId"],
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
    menus: Menus.fromJson(json["menus"]),
    rating: json["rating"].toString(),
    customerReviews: List<CustomerReview>.from(json["customerReviews"]
        .map((x) => CustomerReview.fromJson(x))),
  );
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
  );
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
    name: json["name"],
    review: json["review"],
    date: json["date"],
  );

}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  List<FoodsDrinks> foods;
  List<FoodsDrinks> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<FoodsDrinks>.from(json["foods"].map((x) => FoodsDrinks.fromJson(x))),
    drinks: List<FoodsDrinks>.from(json["drinks"].map((x) => FoodsDrinks.fromJson(x))),
  );

}

class FoodsDrinks {
  FoodsDrinks({
    required this.name,
  });

  String name;

  factory FoodsDrinks.fromJson(Map<String, dynamic> json) => FoodsDrinks(
    name: json["name"],
  );
}
