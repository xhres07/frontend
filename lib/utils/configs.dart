class Configs {
  static const String mainURL = "http://192.168.10.71:5000";
  // static const String mainURL = "http://10.0.0.2:5000";
  // static const String mainURL = "http://localhost:5000";
  // static const String mainURL = "https://49.244.106.116:5000";

  static const String signUp = "$mainURL/api/users";

  static const String login = "$mainURL/api/users/login";

  static const String product = "$mainURL/api/products";

  static const String adminOrder = "$mainURL/api/orders";

  static const String viewOrder = "$mainURL/api/orders/myorders";
}
