import 'dart:async';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides methods to interact with Cognito Authentication.
final authAWSRepositoryProvider =
    Provider<AWSAuthRepository>((ref) => AWSAuthRepository());

class AWSAuthRepository {
  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  Future<String> get user async {
    try {
      final AuthUser awsUser = await Amplify.Auth.getCurrentUser();
      return awsUser.userId;
    } on Exception {
      rethrow;
    }
  }

  Future<String> get email async {
    try {
      List<AuthUserAttribute> attributes =
          (await Amplify.Auth.fetchUserAttributes()).toList();
      for (AuthUserAttribute attribute in attributes) {
        if (attribute.userAttributeKey.key == 'email') {
          return attribute.value;
        }
      }
      throw Exception('No Attribute with Email Found');
    } on Exception {
      rethrow;
    }
  }

  Future<String> get idToken async {
    try {
      final CognitoAuthSession session = await Amplify.Auth.fetchAuthSession(
              options: CognitoSessionOptions(getAWSCredentials: true))
          as CognitoAuthSession;
      return session.userPoolTokens!.idToken;
    } on Exception {
      rethrow;
    }
  }

  /// Creates a new user with the provided [email] and [password].
  Future<void> signUp(String email, String password) async {
    try {
      final CognitoSignUpOptions options = CognitoSignUpOptions(
          userAttributes: {CognitoUserAttributeKey.email: email});
      await Amplify.Auth.signUp(
          username: email, password: password, options: options);
    } on Exception {
      rethrow;
    }
  }

  /// Creates a new user with the provided [email] and [password].
  Future<void> confirmSignUp(String email, String confirmationCode) async {
    try {
      await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: confirmationCode);
    } on Exception {
      rethrow;
    }
  }

  /// Creates a new user with the provided [email] and [password].
  Future<void> signIn(String email, String password) async {
    try {
      await Amplify.Auth.signIn(username: email, password: password);
    } on Exception {
      rethrow;
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  Future<void> logOut() async {
    try {
      await Amplify.Auth.signOut();
    } on Exception {
      rethrow;
    }
  }
}
