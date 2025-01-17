part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class NavigateLoginScreenEvent extends RegisterEvent {
  final BuildContext context;
  final Widget destination;

  const NavigateLoginScreenEvent({
    required this.context,
    required this.destination,
  });
}

class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;

  final String fullName;
  final String email;
  final String contactNo;
  final String username;
  final String password;

  const RegisterUserEvent({
    required this.context,
    required this.fullName,
    required this.email,
    required this.contactNo,
    required this.username,
    required this.password,
  });
}
