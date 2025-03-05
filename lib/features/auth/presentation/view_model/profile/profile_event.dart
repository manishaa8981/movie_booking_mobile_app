part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

// Fetch User Data
class FetchUserById extends ProfileEvent {
  final String authId;

  const FetchUserById({required this.authId});

  @override
  List<Object?> get props => [authId];
}

// Upload Image
class LoadImage extends ProfileEvent {
  final File file;

  const LoadImage({required this.file});

  @override
  List<Object?> get props => [file];
}
