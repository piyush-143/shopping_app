import 'package:flutter/material.dart';

class CartViewModel with ChangeNotifier {
  double _totalAmount = 0;
  double get totalAmount => _totalAmount;

  double _totalQuantity = 0;
  double get totalQuantity => _totalQuantity;

  final List<Map<String, dynamic>> _cartList = [];
  List<Map<String, dynamic>> get cartList => _cartList;

  void _calculateTotal() {
    double amount = 0;
    double quantity = 0;
    for (var item in _cartList) {
      amount += item['DiscountPrice'] * item['Quantity'];
      quantity += item['Quantity'];
    }
    _totalAmount = amount;
    _totalQuantity = quantity;
    notifyListeners();
  }

  void incrementQuantity(int index) {
    _cartList[index]['Quantity']++;
    _calculateTotal();
    notifyListeners();
  }

  void decrementQuantity(int index) {
    if (_cartList[index]['Quantity'] > 1) {
      _cartList[index]['Quantity']--;
      _calculateTotal();
      notifyListeners();
    }
  }

  void addToCart({
    required String name,
    String? brand,
    required double price,
    required double discount,
    required String imageUrl,
  }) {
    final double discountedPrice = price * (1 - discount / 100);
    _cartList.add({
      'Name': name,
      'Brand': brand,
      'Price': price,
      'Discount': discount,
      'ImageUrl': imageUrl,
      'Quantity': 1,
      'DiscountPrice': discountedPrice * 100,
    });
    _calculateTotal();
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartList.removeAt(index);
    _calculateTotal();
    notifyListeners();
  }
}
