import 'package:albums_posts_app/provider/repository_provider.dart';
import 'package:albums_posts_app/screen/albums/album_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AlbumScreen extends ConsumerWidget {
  const AlbumScreen({super.key});

  // Future<void> _navigateToNext() async {
  //   await Future.delayed(const Duration(seconds: 3));
  //   bool isAuthenticated = false; // Replace with actual authentication check

  //   if (isAuthenticated) {
  //   } else {}
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsAsyncValue = ref.watch(albumProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album List Screen'),
      ),
      body: productsAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (products) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns

            childAspectRatio: 1 / 1.3, // Aspect ratio of the items
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return InkWell(
              onTap: () {
                //context.go('/albumListScreen');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AlbumListScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.grey[300],
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 2,
                      child: const Center(
                        child: Icon(
                          size: 80,
                          Icons.folder,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Text(
                      product.title!,
                      maxLines: 2,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
