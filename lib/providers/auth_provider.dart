import 'package:flutter_riverpod/legacy.dart';


final isLoginLoadingProvider = StateProvider<bool>((ref) {
  return false;
});

final isSignupLoadingProvider = StateProvider<bool>((ref) {
  return false;
});