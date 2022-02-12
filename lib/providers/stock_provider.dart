import 'package:flutter/cupertino.dart';
import 'package:flutter_app_validus/models/stock_details.dart';
import 'package:flutter_app_validus/services/stock_services.dart';

class StockProvider extends ChangeNotifier {
  List<StockDetails>? stockDetails;

  StockProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    stockDetails = await StockServices.getStockDetails();
    notifyListeners();
  }
}
