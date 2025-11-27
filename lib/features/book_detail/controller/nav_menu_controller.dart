import 'package:get/get.dart';

class NavMenuController extends GetxController {
  final isOpen = false.obs;

  void toggle() => isOpen.value = !isOpen.value;
  void close() => isOpen.value = false;
}
