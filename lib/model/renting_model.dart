import 'dart:convert';

RequestAttendance requestAttendanceFromJson(String str) =>
    RequestAttendance.fromJson(json.decode(str));

String requestAttendanceToJson(RequestAttendance data) =>
    json.encode(data.toJson());

class RequestAttendance {
  RequestAttendance({
    this.user,
    this.orderItems,
    this.shippingAddress,
    this.taxPrice,
    this.shippingPrice,
    this.totalPrice,
    this.isPaid,
    this.isDelivered,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? user;
  List<OrderItem>? orderItems;
  ShippingAddress? shippingAddress;
  int? taxPrice;
  int? shippingPrice;
  int? totalPrice;
  bool? isPaid;
  bool? isDelivered;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory RequestAttendance.fromJson(Map<String, dynamic> json) =>
      RequestAttendance(
        user: json["user"],
        orderItems: List<OrderItem>.from(
            json["orderItems"].map((x) => OrderItem.fromJson(x))),
        shippingAddress: ShippingAddress.fromJson(json["shippingAddress"]),
        taxPrice: json["taxPrice"],
        shippingPrice: json["shippingPrice"],
        totalPrice: json["totalPrice"],
        isPaid: json["isPaid"],
        isDelivered: json["isDelivered"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "orderItems": List<dynamic>.from(orderItems!.map((x) => x.toJson())),
        "shippingAddress": shippingAddress?.toJson(),
        "taxPrice": taxPrice,
        "shippingPrice": shippingPrice,
        "totalPrice": totalPrice,
        "isPaid": isPaid,
        "isDelivered": isDelivered,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class OrderItem {
  OrderItem({
    this.name,
    this.qty,
    this.image,
    this.price,
    this.product,
    this.id,
  });

  String? name;
  int? qty;
  String? image;
  int? price;
  String? product;
  String? id;

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        name: json["name"],
        qty: json["qty"],
        image: json["image"],
        price: json["price"],
        product: json["product"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "qty": qty,
        "image": image,
        "price": price,
        "product": product,
        "_id": id,
      };
}

class ShippingAddress {
  ShippingAddress({
    this.address,
    this.city,
    this.postalCode,
    this.country,
  });

  String? address;
  String? city;
  String? postalCode;
  String? country;

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
        address: json["address"],
        city: json["city"],
        postalCode: json["postalCode"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "address": address,
        "city": city,
        "postalCode": postalCode,
        "country": country,
      };
}
