import 'dart:collection';

import 'package:flutter_app/shoppingCart/model/item.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  int get totalPrice => _items.length * 42;

  void add(Item item) {
    _items.add(item);

    notifyListeners();
  }

  void clear() {
    _items.clear();
  }
}