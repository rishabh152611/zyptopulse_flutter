import 'package:flutter/material.dart';
import '../models/crypto_model.dart';

class CryptoCard extends StatelessWidget {
  final CryptoModel crypto;

  const CryptoCard({Key? key, required this.crypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Image.network(
          crypto.image,
          width: 40,
          height: 40,
          errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.error),
        ),
        title: Text(crypto.name),
        subtitle: Text(
            '${crypto.symbol.toUpperCase()} - \$${crypto.currentPrice.toStringAsFixed(2)}'),
        trailing:
        Text('${crypto.priceChangePercentage24h.toStringAsFixed(2)}%'),
      ),
    );
  }
}
