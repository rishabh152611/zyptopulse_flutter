import 'package:flutter/material.dart';
import '../models/favorite_model.dart';
import '../services/favorite_service.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late Future<List<FavoriteModel>> _favoritesFuture;

  @override
  void initState() {
    super.initState();
    _refreshFavorites();
  }

  void _refreshFavorites() {
    setState(() {
      _favoritesFuture = FavoriteService().fetchFavorites();
    });
  }

  Future<void> _deleteFavorite(String id) async {
    bool success = await FavoriteService().deleteFavorite(id);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Favorite deleted")),
      );
      _refreshFavorites();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Favorite deleted")),
      );
      _refreshFavorites();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      // Wrap the body in a Container with your app's gradient background.
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Color(0xFF0F3028)],
          ),
        ),
        child: FutureBuilder<List<FavoriteModel>>(
          future: _favoritesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No favorites yet",style: TextStyle(color: Colors.white),));
            }
            final favorites = snapshot.data!;
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(favorite.imageUrl),
                    ),
                    title: Text(favorite.name),
                    subtitle: Text(favorite.symbol.toUpperCase()),
                    trailing: IconButton(
                      onPressed: () {
                        _deleteFavorite(favorite.id);
                      },
                      icon: const Icon(Icons.delete),
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
