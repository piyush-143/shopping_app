import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/shopping_model.dart';
import '../utils/app_urls.dart';

class ShoppingRepository {
  Future<ShoppingModel?> getShoppingApi() async {
    try {
      final response = await http.get(Uri.parse(AppUrls.baseUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return ShoppingModel.fromJson(data);
      } else {
        if (kDebugMode) {
          print('Failed to load data. Status code: ${response.statusCode}');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching shopping data: $e');
      }
      return null;
    }
  }
}
