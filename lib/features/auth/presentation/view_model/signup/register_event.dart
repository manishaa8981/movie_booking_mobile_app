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
  final String email;
  final String contactNo;
  final String username;
  final String password;
  final String? image;

  const RegisterUserEvent({
    required this.context,
    required this.email,
    required this.contactNo,
    required this.username,
    required this.password,
    this.image,
  });
}

class LoadImage extends RegisterEvent {
  final File file;
  const LoadImage({
    required this.file,
  });
}
