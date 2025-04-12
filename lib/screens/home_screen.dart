
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/crypto_model.dart';
import '../models/favorite_model.dart';
import '../services/api_service.dart';
import '../services/favorite_service.dart';

class MarketsStreamScreen extends StatefulWidget {
  const MarketsStreamScreen({Key? key}) : super(key: key);

  @override
  State<MarketsStreamScreen> createState() => _MarketsStreamScreenState();
}

class _MarketsStreamScreenState extends State<MarketsStreamScreen> {
  bool isDarkMode = true;

  Future<void> _addFavorite(CryptoModel crypto, BuildContext context) async {
    final favorite = FavoriteModel(
      id: crypto.id,
      name: crypto.name,
      symbol: crypto.symbol,
      currentPrice: crypto.currentPrice,
      marketCapRank: crypto.marketCapRank.toString(),
      priceChange24h: crypto.priceChangePercentage24h,
      imageUrl: crypto.image,
    );

    bool success = await FavoriteService().saveFavorite(favorite);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(success ? "Added to favorites" : "Failed to add favorite")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final gradientColors = isDarkMode
        ? [Colors.black, const Color(0xFF0F3028)]
        : [Colors.white, Colors.lightGreenAccent.shade100];

    return Scaffold(
      appBar: AppBar(
        title: Text("Markets", style: TextStyle(color: textColor)),
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: textColor),
            tooltip: 'Toggle Theme',
            onPressed: () {
              setState(() {
                isDarkMode = !isDarkMode;
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, color: textColor),
            tooltip: 'Logout',
            onPressed: () => context.go('/logout'),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: gradientColors,
          ),
        ),
        child: StreamBuilder<List<CryptoModel>>(
          stream: ApiService().fetchCryptosStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: textColor)));
            } else if (!snapshot.hasData) {
              return Center(child: Text("No data available.", style: TextStyle(color: textColor)));
            }

            final cryptos = snapshot.data!;
            return ListView.builder(
              itemCount: cryptos.length,
              itemBuilder: (context, index) {
                final crypto = cryptos[index];
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: Colors.blue.withOpacity(0.4),
                    highlightColor: Colors.blue.withOpacity(0.2),
                    onTap: () {}, // Visual ripple effect
                    onDoubleTap: () => _addFavorite(crypto, context),
                    child: ListTile(
                      leading: CircleAvatar(backgroundImage: NetworkImage(crypto.image)),
                      title: Text(crypto.name, style: TextStyle(color: textColor)),
                      subtitle: Text(crypto.symbol.toUpperCase(), style: TextStyle(color: textColor)),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("\$${crypto.currentPrice.toStringAsFixed(2)}", style: TextStyle(color: textColor)),
                          Text(
                            "${crypto.priceChangePercentage24h.toStringAsFixed(2)}%",
                            style: TextStyle(
                              color: crypto.priceChangePercentage24h >= 0 ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
//
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../models/crypto_model.dart';
// import '../models/favorite_model.dart';
// import '../services/api_service.dart';
// import '../services/favorite_service.dart';
//
// class MarketsStreamScreen extends StatefulWidget {
//   const MarketsStreamScreen({Key? key}) : super(key: key);
//
//   @override
//   _MarketsStreamScreenState createState() => _MarketsStreamScreenState();
// }
//
// class _MarketsStreamScreenState extends State<MarketsStreamScreen> {
//   bool isDarkMode = false;
//
//   // This method converts the Future from ApiService to a Stream.
//   Stream<List<CryptoModel>> _cryptoStream() {
//     return Stream.fromFuture(ApiService().fetchCryptos());
//   }
//
//   Future<void> _addFavorite(CryptoModel crypto, BuildContext context) async {
//     // Convert CryptoModel to FavoriteModel.
//     final favorite = FavoriteModel(
//       id: crypto.id,
//       name: crypto.name,
//       symbol: crypto.symbol,
//       currentPrice: crypto.currentPrice,
//       marketCapRank: crypto.marketCapRank.toString(),
//       priceChange24h: crypto.priceChangePercentage24h,
//       imageUrl: crypto.image,
//     );
//
//     bool success = await FavoriteService().saveFavorite(favorite);
//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Added to favorites")),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Failed to add favorite")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text(
//             "Market",
//             style: TextStyle(color: Colors.white),
//           ),
//           backgroundColor: Colors.black,
//           elevation: 0,
//           actions: [
//             // Light/Dark Mode Toggle Button
//             IconButton(
//               icon: Icon(
//                 isDarkMode ? Icons.dark_mode : Icons.light_mode,
//                 color: Colors.white,
//               ),
//               tooltip: 'Toggle Light/Dark Mode',
//               onPressed: () {
//                 setState(() {
//                   isDarkMode = !isDarkMode;
//                 });
//               },
//             ),
//             // Logout Button
//             IconButton(
//               icon: const Icon(Icons.logout, color: Colors.white),
//               tooltip: 'Logout',
//               onPressed: () {
//                 // Navigate to the logout screen.
//                 context.go('/logout');
//               },
//             ),
//           ],
//         ),
//         // Theme background applied using a gradient.
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Colors.black, Color(0xFF0F3028)],
//             ),
//           ),
//           child: StreamBuilder<List<CryptoModel>>(
//             stream: ApiService().fetchCryptosStream(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text("Error: ${snapshot.error}"));
//               } else if (!snapshot.hasData) {
//                 return const Center(child: Text("No data available."));
//               }
//               final cryptos = snapshot.data!;
//               // List of cryptocurrencies with glowing (ripple) effect on tap.
//               return ListView.builder(
//                 itemCount: cryptos.length,
//                 itemBuilder: (context, index) {
//                   final crypto = cryptos[index];
//                   return Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       splashColor: Colors.blue.withOpacity(0.3),
//                       highlightColor: Colors.blue.withOpacity(0.1),
//                       onTap: () {
//                         // On tap: just show the glowing effect.
//                       },
//                       onDoubleTap: () {
//                         _addFavorite(crypto, context);
//                       },
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundImage: NetworkImage(crypto.image),
//                         ),
//                         title: Text(
//                           crypto.name,
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         subtitle: Text(
//                           crypto.symbol.toUpperCase(),
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         trailing: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("\$${crypto.currentPrice.toStringAsFixed(2)}"),
//                             Text(
//                               "${crypto.priceChangePercentage24h.toStringAsFixed(2)}%",
//                               style: TextStyle(
//                                 color: crypto.priceChangePercentage24h >= 0
//                                     ? Colors.green
//                                     : Colors.red,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
