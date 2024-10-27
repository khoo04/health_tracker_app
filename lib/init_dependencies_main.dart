part of 'init_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initProfile();
  _initArticle();
  _initHome();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supaseAnonKey,
  );

  serviceLocator
      .registerFactory<InternetConnection>(() => InternetConnection());
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
  serviceLocator.registerFactory<ConnectionChecker>(
      () => ConnectionCheckerImpl(serviceLocator<InternetConnection>()));
}

void _initAuth() {
  //Data Source
  //Create a new instance in every single request
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(() => AuthRemoteDataSourceImp(
          serviceLocator<SupabaseClient>(),
        ))
    //Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator<AuthRemoteDataSource>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    //Use Case
    ..registerFactory(
      () => UserSignUp(
        serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator<AuthRepository>(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(serviceLocator<AuthRepository>()),
    )
    ..registerFactory(
      () => UserLogout(
        serviceLocator<AuthRepository>(),
      ),
    )
    // ..registerFactory(
    //   () => CurrentUser(serviceLocator<AuthRepository>()),
    // )
    //Bloc
    //Bloc use Lazy Singleton, so that the state will not lose
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator<UserSignUp>(),
        userLogin: serviceLocator<UserLogin>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
        currentUser: serviceLocator<CurrentUser>(),
        userLogout: serviceLocator<UserLogout>(),
      ),
    );
}

void _initProfile() {
  serviceLocator
    ..registerFactory<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImp(
        serviceLocator<SupabaseClient>(),
      ),
    )
    ..registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(
        serviceLocator<ProfileRemoteDataSource>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    ..registerFactory(
      () => UpdateBasicDetails(
        serviceLocator<ProfileRepository>(),
      ),
    )
    ..registerLazySingleton(
      () => ProfileBloc(
        updatBasicDetails: serviceLocator<UpdateBasicDetails>(),
        appUserCubit: serviceLocator<AppUserCubit>(),
      ),
    );
}

void _initArticle() {
  serviceLocator
    ..registerFactory<ArticleRemoteDataSource>(
        () => ArticleRemoteDataSourceImp(serviceLocator<SupabaseClient>()))
    ..registerFactory<ArticleRepository>(
      () => ArticleRepositoryImpl(
        serviceLocator<ArticleRemoteDataSource>(),
        serviceLocator<ConnectionChecker>(),
      ),
    )
    ..registerFactory(
      () => FetchArticle(
        serviceLocator<ArticleRepository>(),
      ),
    )
    ..registerLazySingleton(
      () => ArticleBloc(
        fetchArticle: serviceLocator<FetchArticle>(),
      ),
    );
}

void _initHome() {
  serviceLocator.registerLazySingleton(() => HomeBloc());
}
