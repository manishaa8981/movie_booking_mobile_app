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
  final String full_name;
  final String email;
  final String contact_no;
  final String username;
  final String password;

  const RegisterUserEvent({
    required this.full_name,
    required this.email,
    required this.contact_no,
    required this.username,
    required this.password,
  });
}
