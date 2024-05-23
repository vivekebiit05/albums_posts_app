import 'package:albums_posts_app/screen/albums/home_albums_screen.dart';
import 'package:albums_posts_app/screen/posts/post_list_screen.dart';
import 'package:albums_posts_app/screen/widgets/display_image_widget.dart';
import 'package:albums_posts_app/screen/widgets/profile_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../provider/repository_provider.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsyncValue = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: profileAsyncValue.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
          data: (products) {
            final profileData = products[0];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    print('object');
                    showBottomSheet(context);
                  },
                  child: DisplayImage(
                    imagePath:
                        'https://static-00.iconduck.com/assets.00/profile-user-icon-2048x2048-m41rxkoe.png',
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ProfileLabel(
                  labelValue: profileData.name!,
                  setBold: true,
                  alignCenter: true,
                ),
                ProfileLabel(
                  labelValue: profileData.email!,
                  alignCenter: true,
                ),
                ProfileLabel(
                  labelValue: profileData.phone!,
                  alignCenter: true,
                ),
                ProfileLabel(
                  labelValue: profileData.website!,
                  alignCenter: true,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ProfileLabel(
                        labelValue:
                            '${profileData.address!.suite!}, ${profileData.address!.street!}',
                      ),
                      ProfileLabel(
                        labelValue: profileData.address!.city!,
                      ),
                      ProfileLabel(
                        labelValue: profileData.address!.zipcode!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        'Company',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ProfileLabel(
                        labelValue: profileData.company!.name!,
                      ),
                      ProfileLabel(
                        labelValue: profileData.company!.catchPhrase!,
                      ),
                      ProfileLabel(
                        labelValue: profileData.company!.bs!,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              //context.go('/albumScreen');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AlbumScreen()),
                              );
                            },
                            child: Text('View Album'.toUpperCase())),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              //  context.go('/postListScreen');
                              //GoRouter.of(context).go('/postListScreen');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PostListScreen()),
                              );
                            },
                            child: Text('View Posts'.toUpperCase())),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }

  List<XFile?> selectedFiles = [];

  showBottomSheet(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Camera'),
                onTap: () async {
                  final XFile? cameraPhoto =
                      await picker.pickImage(source: ImageSource.camera);
                  selectedFiles.add(cameraPhoto);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                title: const Text('Gallery'),
                onTap: () async {
                  final List<XFile> galleryPhotos =
                      await picker.pickMultiImage();
                  selectedFiles.addAll(galleryPhotos);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
