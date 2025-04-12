import 'package:flutter/material.dart';
import '../models/favorite_model.dart';

class CryptoFavoritesCard extends StatelessWidget {
  final FavoriteModel favorite;
  final VoidCallback onDelete;

  const CryptoFavoritesCard({
    Key? key,
    required this.favorite,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(favorite.imageUrl),
          radius: 24,
        ),
        title: Text(
          favorite.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Symbol: ${favorite.symbol.toUpperCase()}"),
            Text("Price: \$${favorite.currentPrice.toStringAsFixed(2)}"),
            Text("Rank: ${favorite.marketCapRank}"),
            Text("24h Change: ${favorite.priceChange24h.toStringAsFixed(2)}%"),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
