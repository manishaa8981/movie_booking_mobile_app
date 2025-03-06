part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isUpdateLoading;
  final bool isUpdateSuccess;
  final bool isImageLoading;
  final bool isImageSuccess;
  final AuthEntity? auth;
  final String? imageName;
  final String? authId;
  final String? errorMessage;

  ProfileState({
    required this.isLoading,
    required this.isSuccess,
    required this.isUpdateLoading,
    required this.isUpdateSuccess,
    required this.isImageLoading,
    required this.isImageSuccess,
    this.auth,
    this.imageName,
    this.authId,
    this.errorMessage,
  });

  ProfileState.initial()
      : isLoading = false,
        isSuccess = false,
        isUpdateLoading = false,
        isUpdateSuccess = false,
        isImageLoading = false,
        isImageSuccess = false,
        auth = null,
        imageName = null,
        authId = null,
        errorMessage = null;

  ProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isUpdateLoading,
    bool? isUpdateSuccess,
    bool? isImageLoading,
    bool? isImageSuccess,
    AuthEntity? auth,
    String? errorMessage,
    String? imageName,
    String? authId,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isUpdateLoading: isUpdateLoading ?? this.isUpdateLoading,
      isUpdateSuccess: isUpdateSuccess ?? this.isUpdateSuccess,
      auth: auth ?? this.auth,
      imageName: imageName ?? this.imageName,
      errorMessage: errorMessage ?? this.errorMessage,
      isImageLoading: isImageLoading ?? this.isImageLoading,
      isImageSuccess: isImageSuccess ?? this.isImageSuccess,
      authId: authId ?? this.authId,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isSuccess,
        isUpdateLoading,
        isUpdateSuccess,
        auth,
        imageName,
        errorMessage,
        authId
      ];
}
