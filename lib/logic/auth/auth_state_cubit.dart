import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthStateCubit extends Equatable {
  final AuthStatus status;
  final String? error;
  final String? userId;

  const AuthStateCubit({
    this.status = AuthStatus.initial,
    this.error,
    this.userId,
  });

  @override
  List<Object?> get props => [
        status,
        error,
        userId,
      ];

  AuthStateCubit copyWith({
    AuthStatus? status,
    String? error,
    String? userId,
  }) {
    return AuthStateCubit(
      status: status ?? this.status,
      error: error ?? this.error,
      userId: userId ?? this.userId,
    );
  }
}
