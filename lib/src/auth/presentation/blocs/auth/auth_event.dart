part of 'auth_bloc.dart';

// AuthEvent sınıfının temel sınıfı
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Giriş işlemi için olay sınıfı
class SignInEvent extends AuthEvent {
  const SignInEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

// Kayıt işlemi için olay sınıfı
class SignUpEvent extends AuthEvent {
  const SignUpEvent({
    required this.email,
    required this.password,
    required this.name,
  });
  final String email;
  final String password;
  final String name;

  @override
  List<Object> get props => [name, email, password];
}

// Şifremi unuttum işlemi için olay sınıfı
class ForgotPasswordEvent extends AuthEvent {
  const ForgotPasswordEvent({required this.email});
  final String email;

  @override
  List<Object> get props => [email];
}

// Kullanıcı bilgilerini güncelleme işlemi için olay sınıfı
class UpdateUserEvent extends AuthEvent {
  UpdateUserEvent({
    required this.userAction,
    required this.userData,
  }) : assert(userData is String || userData is File,
            "[userData] must be either a String or a File, but it was ${userData.runtimeType}");
  final dynamic userData;
  final UpdateUserAction userAction;

  @override
  List<Object> get props => [userAction, userData];
}
