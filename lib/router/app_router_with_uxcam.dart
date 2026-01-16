import 'package:flutter_uxcam/flutter_uxcam.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/dashboard/dashboard.dart';
import 'package:my_app/gallery/gallery.dart';
import 'package:my_app/home/home.dart';
import 'package:my_app/messages/messages.dart';
import 'package:my_app/profile/profile.dart';
import 'package:my_app/tasks/tasks.dart';

final class AppRouterWithUxcam {
  AppRouterWithUxcam._();

  static final GoRouter router = GoRouter(
    observers: [
      FlutterUxcamNavigatorObserver(),
    ],
    initialLocation: '/home',
    onException: (context, state, exception) {
      // Handle navigation errors
    },
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => const ProfilePage(),
            routes: [
              GoRoute(
                path: 'edit',
                name: 'profile-edit',
                builder: (context, state) => const ProfileEditPage(),
              ),
              GoRoute(
                path: 'settings',
                name: 'profile-settings',
                builder: (context, state) => const ProfileSettingsPage(),
              ),
            ],
          ),
          GoRoute(
            path: 'dashboard',
            name: 'dashboard',
            builder: (context, state) => const DashboardPage(),
            routes: [
              GoRoute(
                path: 'analytics',
                name: 'analytics',
                builder: (context, state) => const AnalyticsPage(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/tasks',
        name: 'tasks',
        builder: (context, state) => const TasksPage(),
      ),
      GoRoute(
        path: '/gallery',
        name: 'gallery',
        builder: (context, state) => const GalleryPage(),
      ),
      GoRoute(
        path: '/messages',
        name: 'messages',
        builder: (context, state) => const MessagesPage(),
      ),
    ],
  );
}
