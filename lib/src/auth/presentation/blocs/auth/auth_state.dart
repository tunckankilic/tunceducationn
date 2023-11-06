part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class SignedUp extends AuthState {
  const SignedUp();
}

class SignedIn extends AuthState {
  final LocalUser localUser;
  const SignedIn({required this.localUser});
}

class UserUpdated extends AuthState {
  const UserUpdated();
}

class AuthError extends AuthState {
  const AuthError(this.errorMessage);
  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}
