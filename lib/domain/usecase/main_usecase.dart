import 'package:appwrite_template_clean_mvvm/data/network/failure.dart';
import 'package:appwrite_template_clean_mvvm/domain/repository/repository.dart';
import 'package:appwrite_template_clean_mvvm/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class MainUseCase
    implements BaseUseCase<MainDeleteSessionUseCaseInput, dynamic> {
  final Repository _repository;

  MainUseCase(this._repository);

  @override
  Future<Either<Failure, dynamic>> execute(
          MainDeleteSessionUseCaseInput input) =>
      _repository.deleteSession(input.sessionId);
}

class MainDeleteSessionUseCaseInput {
  String sessionId;

  MainDeleteSessionUseCaseInput(this.sessionId);
}
