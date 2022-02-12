import 'dart:convert';

import 'package:flutter_app_validus/models/stock_details.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class StockServices {
  static Future<List<StockDetails>?> getStockDetails() async {
    Response response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/fc3ddccf-855c-4bb6-861c-cf7896aa963e'));
    dynamic jsonAppData = json.decode(response.body);
    final dynamic responseStockDetails = jsonAppData['data'];
    if (jsonAppData != null && responseStockDetails != null) {
      final List<StockDetails> stockList = responseStockDetails
          .map<StockDetails>((dynamic json) => StockDetails.fromJson(json))
          .toList();
      return stockList;
    }

    return null;
  }
}
