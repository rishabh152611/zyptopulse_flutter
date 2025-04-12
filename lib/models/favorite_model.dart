// class FavoriteModel {
//   final String id;
//   final String name;
//   final String symbol;
//   final double currentPrice;
//   final String marketCapRank;
//   final double priceChange24h;
//   final String imageUrl;
//
//   FavoriteModel({
//     required this.id,
//     required this.name,
//     required this.symbol,
//     required this.currentPrice,
//     required this.marketCapRank,
//     required this.priceChange24h,
//     required this.imageUrl,
//   });
//
//   factory FavoriteModel.fromJson(Map<String, dynamic> json) {
//     return FavoriteModel(
//       id: json['id'].toString(),
//       name: json['name'],
//       symbol: json['symbol'],
//       currentPrice: (json['current_price'] as num).toDouble(),
//       marketCapRank: json['market_cap_rank'].toString(),
//       priceChange24h: (json['price_change_percentage_24h'] as num).toDouble(),
//       imageUrl: json['image_url'],
//     );
//   }
// }
class FavoriteModel {
  final String id;
  final String name;
  final String symbol;
  final double currentPrice;
  final String marketCapRank;
  final double priceChange24h;
  final String imageUrl;

  FavoriteModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.currentPrice,
    required this.marketCapRank,
    required this.priceChange24h,
    required this.imageUrl,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json['id'].toString(),
      name: json['name'],
      symbol: json['symbol'],
      currentPrice: (json['current_price'] as num).toDouble(),
      marketCapRank: json['market_cap_rank'].toString(),
      priceChange24h: (json['price_change_percentage_24h'] as num).toDouble(),
      imageUrl: json['image_url'],
    );
  }
}
