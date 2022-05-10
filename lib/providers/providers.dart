import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/model/entry.dart';
import 'package:riverpod/riverpod.dart';
import 'package:my_app/providers/aws-auth.dart';
import 'package:my_app/providers/database.dart';

/// User from Cognito Authentication
final FutureProvider<String> authUserProvider = FutureProvider<String>((ref) {
  final authAWSRepo = ref.watch(authAWSRepositoryProvider);
  return authAWSRepo.user.then((value) => value);
});

final FutureProvider<String> emailProvider = FutureProvider<String>((ref) {
  final authAWSRepo = ref.watch(authAWSRepositoryProvider);
  return authAWSRepo.email.then((value) => value);
});

final FutureProvider<String> tokenProvider = FutureProvider<String>((ref) {
  final authAWSRepo = ref.watch(authAWSRepositoryProvider);
  return authAWSRepo.idToken.then((value) => value);
});

final entriesProvider = FutureProvider<List<Entry>>((ref) {
  final authAWSRepo = ref.watch(authAWSRepositoryProvider);
  return authAWSRepo.user.then((userId) => authAWSRepo.idToken.then(
      (idToken) => DataBase().getEntries(GetEntriesRequest(userId, idToken))));
});

// final AutoDisposeFutureProviderFamily<List<Entry>, String> entriesProvider =
//     FutureProvider.autoDispose.family<List<Entry>, String>((ref, userId) {
//   final database = ref.watch(dataBaseProvider);
//   // 3. pass the itemId to the database method and return the output stream
//   return database.getEntries(userId);
// });
