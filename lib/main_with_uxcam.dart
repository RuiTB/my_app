import 'package:my_app/app/view/app_with_uxcam.dart';
import 'package:my_app/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const AppWithUxcam());
}
