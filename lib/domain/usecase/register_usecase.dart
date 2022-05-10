import 'package:appwrite/models.dart';
import 'package:appwrite_template_clean_mvvm/data/network/failure.dart';
import 'package:appwrite_template_clean_mvvm/data/request/request.dart';
import 'package:appwrite_template_clean_mvvm/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

import 'base_usecase.dart';

class RegisterUseCase
    implements
        BaseUseCase<RegisterUseCaseInput, User>,
        RegisterUseCaseLogin<RegisterUseCaseInput, Session> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, User>> execute(RegisterUseCaseInput input) =>
      _repository.register(
          LoginRequest(input.email, input.password, name: input.name));

  @override
  Future<Either<Failure, Session>> login(RegisterUseCaseInput input) =>
      _repository.login(LoginRequest(input.email, input.password));
}

class RegisterUseCaseInput {
  String email, password, name;

  RegisterUseCaseInput(this.email, this.password, this.name);
}

abstract class RegisterUseCaseLogin<In, Out> {
  Future<Either<Failure, Out>> login(In input);
}
