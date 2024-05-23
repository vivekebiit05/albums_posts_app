import 'package:albums_posts_app/provider/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListScreen extends ConsumerWidget {
  const PostListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postListAsyncValue = ref.watch(postListProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: postListAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (products) => ListView.separated(
          separatorBuilder: (context, index) {
            return const Divider(
              thickness: 0.5,
            );
          },
          itemCount: products.length,
          itemBuilder: (context, index) {
            final postData = products[index];
            return InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: const Padding(
                        padding:
                            EdgeInsets.all(0), // Adjust the padding as needed
                        child: Icon(Icons.access_alarm),
                      ),
                      title: Text(
                        postData.title!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(postData.body!),
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
