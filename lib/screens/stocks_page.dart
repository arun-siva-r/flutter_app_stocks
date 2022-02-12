import 'package:flutter/material.dart';
import 'package:flutter_app_validus/providers/stock_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/stock_details.dart';

class StocksPage extends StatefulWidget {
  const StocksPage({Key? key}) : super(key: key);

  @override
  StocksPageState createState() => StocksPageState();
}

class StocksPageState extends State<StocksPage> {
  late StockProvider _stockProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _stockProvider = Provider.of<StockProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: Text(
          'My wishlist',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
      body: _stockProvider.stockDetails == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _stockProvider.stockDetails!.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10),
              itemBuilder: (BuildContext context, int index) {
                StockDetails currentDetails =
                    _stockProvider.stockDetails![index];
                final double percentage = _getPercentChange(
                    currentDetails.lastPrice!, currentDetails.price!);

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  color: Theme.of(context).cardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          (currentDetails.stockName ?? '').toUpperCase(),
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ),
                      _getRow('Price', currentDetails.price.toString()),
                      _getRow('Day gain', currentDetails.dayGain.toString()),
                      _getRow('Last trade',
                          _getTimeValue(currentDetails.lastTrade)),
                      _getRow('Extended hrs',
                          _getTimeValue(currentDetails.extendedHours)),
                      _getRow(
                          '%Change',
                          percentage.isNegative
                              ? percentage.toStringAsFixed(1)
                              : '+' + percentage.toStringAsFixed(1),
                          isPercentage: true,
                          isNegative: percentage.isNegative),
                    ],
                  ),
                );
              }),
    );
  }

  Widget _getRow(String title, String value,
      {bool isPercentage = false, bool isNegative = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.headline3,
          ),
          Text(
            value,
            style: isPercentage && isNegative
                ? Theme.of(context).textTheme.headline6
                : isPercentage
                    ? Theme.of(context).textTheme.headline5
                    : Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }

  double _getPercentChange(double lastPrice, double currentPrice) {
    final double difference = currentPrice - lastPrice;
    return difference / lastPrice * 100;
  }

  String _getTimeValue(String? hours) {
    if (hours == null) {
      return '';
    }

    return DateFormat('h:mm a')
        .format(DateTime.fromMicrosecondsSinceEpoch(int.parse(hours)));
  }
}
