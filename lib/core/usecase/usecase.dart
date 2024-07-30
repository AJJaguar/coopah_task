import 'package:equatable/equatable.dart';

import '../error/failure.dart';
import 'package:dartz/dartz.dart';

mixin UseCase<Type, Param> {
  Future<Either<Failure, Type>> call(Param param);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
