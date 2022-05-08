import 'package:riverpod/riverpod.dart';
import 'package:my_app/aws-auth.dart';

/// User from Firebase Authentication
final authUserProvider = FutureProvider<String>((ref) {
  final authAWSRepo = ref.watch(authAWSRepositoryProvider);
  return authAWSRepo.user.then((value) => value);
});
