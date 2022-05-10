import 'dart:typed_data';

import 'package:appwrite/models.dart';
import 'package:appwrite_template_clean_mvvm/data/network/app_api.dart';
import 'package:appwrite_template_clean_mvvm/data/request/request.dart';

abstract class RemoteDataSource {
  Future<Session> login(LoginRequest loginRequest);

  Future<User> register(LoginRequest loginRequest);

  Future<Session> anonymousSession();

  Future<Token> forgotPassword(String email);

  Future<dynamic> deleteSession(String sessionId);

  Future<File> createFile(Uint8List uint8list, String name);

  Future<dynamic> deleteFile(String idFile);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<Session> login(LoginRequest loginRequest) =>
      _appServiceClient.login(loginRequest);

  @override
  Future<User> register(LoginRequest loginRequest) =>
      _appServiceClient.register(loginRequest);

  @override
  Future<Session> anonymousSession() => _appServiceClient.anonymousSession();

  @override
  Future<Token> forgotPassword(String email) =>
      _appServiceClient.forgotPassword(email);

  @override
  Future<dynamic> deleteSession(String sessionId) =>
      _appServiceClient.deleteSession(sessionId);

  @override
  Future<File> createFile(Uint8List uint8list, String name) =>
      _appServiceClient.createFile(uint8list, name);

  @override
  Future deleteFile(String idFile) => _appServiceClient.deleteFile(idFile);
}
