import 'dart:collection';

import 'package:flutter/material.dart';

class Titles extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<String> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<String> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $42).
  int get totalPrice => _items.length * 42;

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(String item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void addAll(List<String> items) {
    _items.addAll(items);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void update(List<String> items) {
    _items.clear();
    _items.addAll(items);
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void confirmData() async {
    notifyListeners();
  }
}
