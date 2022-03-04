import 'package:aqua_store/model/cart_model.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<Cart> lst = <Cart>[];

  add(
    String id,
    String image,
    String name,
    int price,
  ) {
    lst.add(
      Cart(id: id, image: image, name: name, productPrice: price),
    );
    notifyListeners();
  }

  del(
    int index,
  ) {
    lst.removeAt(index);
    notifyListeners();
  }

  clean() {
    lst.clear();
    notifyListeners();
  }
}
