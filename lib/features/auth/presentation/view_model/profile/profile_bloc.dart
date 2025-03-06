import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_ticket_booking/features/auth/domain/entity/auth_entity';
import '../../../../../app/shared_prefs/user_shared_prefs.dart';
import '../../../domain/use_case/get_user_by_id_usecase.dart';
import '../../../domain/use_case/upload_image_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserByIdUsecase _getUserByIdUsecase;
  final UserSharedPrefs _userSharedPrefs;
  final UploadImageUsecase _uploadImageUseCase;

  ProfileBloc({
    
    required GetUserByIdUsecase getUserByIdUsecase,
    required UserSharedPrefs userSharedPrefs,
    required UploadImageUsecase uploadImageUseCase,
  })  : 
        _getUserByIdUsecase = getUserByIdUsecase,
        _userSharedPrefs = userSharedPrefs,
        _uploadImageUseCase = uploadImageUseCase,
        super(ProfileState.initial()) {
    on<LoadImage>(_onLoadImage);
    on<FetchUserById>(_onFetchUserById);

    // Fetch userId from shared preferences and load user data
    _fetchAndLoadUserProfile();
  }

  void _onLoadImage(
    LoadImage event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isImageLoading: true));
    final result = await _uploadImageUseCase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isImageLoading: false, isImageSuccess: false)),
      (r) {
        emit(state.copyWith(
          isImageLoading: false,
          isImageSuccess: true,
          imageName: r,
        ));
      },
    );
  }

  Future<void> _fetchAndLoadUserProfile() async {
    final userData = await _userSharedPrefs.getUserData();
    final authId = userData.fold(
      (failure) => null,
      (data) => data[2], // userId is at index 2 in the user data
    );

    print("Fetched authId: $authId"); // Debugging

    if (authId != null && authId != "userId") {
      // Ensure it’s not a placeholder
      emit(state.copyWith(authId: authId));
      add(FetchUserById(authId: authId));
    }
  }

  Future<void> _onFetchUserById(
    FetchUserById event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getUserByIdUsecase.call(
      GetUserByIdParams(authId: event.authId),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        ));
      },
      (auth) {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          auth: auth,
        ));
      },
    );
  }

  
}