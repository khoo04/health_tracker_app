import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:health_tracker_app/core/enums/gender.dart';
import 'package:flutter/material.dart';
import 'package:health_tracker_app/features/profile/domain/usecases/update_basic_details.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UpdateBasicDetails _updateBasicDetails;
  final AppUserCubit _appUserCubit;
  ProfileBloc({
    required UpdateBasicDetails updatBasicDetails,
    required AppUserCubit appUserCubit,
  })  : _updateBasicDetails = updatBasicDetails,
        _appUserCubit = appUserCubit,
        super(ProfileInitial()) {
    on<ProfileEvent>((_, emit) {
      // TODO: implement event handler
    });
    on<ProfileUpdateBasicDetails>(_onUpdateBasicDetails);
  }

  void _onUpdateBasicDetails(
      ProfileUpdateBasicDetails event, Emitter emit) async {
    emit(ProfileLoading());
    final response = await _updateBasicDetails(
      UserUpdateBasicDetailsParams(
        height: event.height,
        weight: event.weight,
        bmi: event.bmi,
        age: event.age,
        gender: event.gender,
      ),
    );

    response.fold((l) => emit(ProfileFailure(l.message)), (user) {
      _appUserCubit.updateUser(user);
      emit(const ProfileSuccess("Update user details successfully"));
    });
  }
}
