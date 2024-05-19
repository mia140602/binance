// leverage_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final leverageProvider = StateProvider<int>((ref) {
  return 25; // Giá trị mặc định
});
final marginProvider = StateProvider<String>((ref) {
  return "Cross"; // Giá trị mặc định là "Cross"
});
