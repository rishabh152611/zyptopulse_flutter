class CryptoModel {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final String image;
  final int marketCapRank;
  final double priceChangePercentage24h;

  CryptoModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.image,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
  });

  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Unknown',
      symbol: json['symbol'] ?? '',
      currentPrice: (json['current_price'] ?? 0.0).toDouble(),
      image: json['image'] ?? '',
      marketCapRank: json['market_cap_rank'] ?? 0,
      priceChangePercentage24h:
      (json['price_change_percentage_24h'] ?? 0.0).toDouble(),
    );
  }
}
