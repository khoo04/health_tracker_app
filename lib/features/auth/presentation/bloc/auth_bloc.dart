import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_tracker_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:health_tracker_app/core/common/entities/user.dart';
import 'package:health_tracker_app/core/usecase/usecase.dart';
import 'package:health_tracker_app/core/utils/logger.dart';
import 'package:health_tracker_app/features/auth/domain/usecases/current_user.dart';
import 'package:health_tracker_app/features/auth/domain/usecases/user_login.dart';
import 'package:health_tracker_app/features/auth/domain/usecases/user_logout.dart';
import 'package:health_tracker_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  //Use Cases
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final AppUserCubit _appUserCubit;
  final CurrentUser _currentUser;
  final UserLogout _userLogout;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required AppUserCubit appUserCubit,
    required CurrentUser currentUser,
    required UserLogout userLogout,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _appUserCubit = appUserCubit,
        _currentUser = currentUser,
        _userLogout = userLogout,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) {
      emit(AuthLoading());
    });
    on<AuthLogin>(_onAuthLogin);
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
    on<AuthLogout>(_onAuthLogout);
  }

  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final response =
        await _currentUser(NoParams()); //== _currentUser.call(NoParams());

    response.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        firstName: event.firstName,
        lastName: event.lastName,
      ),
    );

    /// Left = Failure, Right = Success
    res.fold((failure) {
      emit(AuthFailure(failure.message));
    }, (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );

    /// Left = Failure, Right = Success
    res.fold((failure) => emit(AuthFailure(failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  //Logout User
  void _onAuthLogout(AuthLogout event, Emitter<AuthState> emit) async {
    final res = await _userLogout(NoParams());

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success){
        emit(AuthInitial());
        _appUserCubit.updateUser(null);
      }
    );
  }

  //Function to update App User Cubit
  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
