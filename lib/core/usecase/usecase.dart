import 'package:fpdart/fpdart.dart';
import 'package:health_tracker_app/core/error/failure.dart';

abstract interface class UseCase<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

//Use Cases for No Params
class NoParams {}
