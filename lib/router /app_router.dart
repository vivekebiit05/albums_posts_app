import 'package:albums_posts_app/screen/albums/album_list_screen.dart';
import 'package:albums_posts_app/screen/albums/home_albums_screen.dart';
import 'package:albums_posts_app/screen/home_screen.dart';
import 'package:albums_posts_app/screen/posts/post_list_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String splashScreen = '/splashScreen';

  static const String homsScreen = '/homsScreen';
  static const String albumScreen = '/albumScreen';
  static const String albumListScreen = '/albumListScreen';
  static const String postListScreen = '/postListScreen';

  static final GoRouter router = GoRouter(
    initialLocation: homsScreen,
    routes: [
      GoRoute(
        path: homsScreen,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: albumScreen,
        builder: (context, state) => const AlbumScreen(),
      ),
      GoRoute(
        path: albumListScreen,
        builder: (context, state) => const AlbumListScreen(),
      ),
      GoRoute(
        path: postListScreen,
        builder: (context, state) => const PostListScreen(),
      ),
    ],
  );
}
