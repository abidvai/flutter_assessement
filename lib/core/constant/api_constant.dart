class ApiConstant {
  ApiConstant._();

  static const String baseUrl = "https://dummyjson.com/";

  /// ---------------------------- Products endpoints -------------------------------- ///
  static const String products = "products";
  static String productDetail(int id) => "products/$id";
  static const String productSearch = "products/search";

  /// ---------------------------- Carts endpoints -------------------------------- ///
  static const String carts = "carts";
  static String cartDetail(int id) => "carts/$id";

  /// ---------------------------- Users endpoints -------------------------------- ///
  static String userDetail(int id) => "users/$id";

  /// ---------------------------- Auth endpoints -------------------------------- ///
  static const String login = "auth/login";
}
