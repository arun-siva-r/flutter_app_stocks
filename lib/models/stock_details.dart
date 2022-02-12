class StockDetails {
  String? id;
  String? stockName;
  double? price;
  double? dayGain;
  String? lastTrade;
  String? extendedHours;
  double? lastPrice;

  StockDetails(
      {this.id,
      this.stockName,
      this.price,
      this.dayGain,
      this.lastTrade,
      this.extendedHours,
      this.lastPrice});

  StockDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stockName = json['stockName'];
    price = json['price'];
    dayGain = json['dayGain'];
    lastTrade = json['lastTrade'];
    extendedHours = json['extendedHours'];
    lastPrice = json['lastPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stockName'] = stockName;
    data['price'] = price;
    data['dayGain'] = dayGain;
    data['lastTrade'] = lastTrade;
    data['extendedHours'] = extendedHours;
    data['lastPrice'] = lastPrice;
    return data;
  }
}
