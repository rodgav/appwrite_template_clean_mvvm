import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:appwrite_template_clean_mvvm/data/network/failure.dart';
import 'package:appwrite_template_clean_mvvm/data/request/request.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, Session>> login(LoginRequest loginRequest);

  Future<Either<Failure, User>> register(LoginRequest loginRequest);

  Future<Either<Failure, Session>> anonymousSession();

  Future<Either<Failure, Token>> forgotPassword(String email);

  Future<Either<Failure, dynamic>> deleteSession(String sessionId);

  Future<Either<Failure, File>> createFile(Uint8List uint8list, String name);

  Future<Either<Failure, dynamic>> deleteFile(String idFile);
}
