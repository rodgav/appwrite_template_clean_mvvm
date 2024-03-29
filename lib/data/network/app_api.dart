import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_template_clean_mvvm/app/app_preferences.dart';
import 'package:appwrite_template_clean_mvvm/app/constants.dart';
import 'package:appwrite_template_clean_mvvm/data/request/request.dart';

class AppServiceClient {
  final Account _account;
  final Databases _databases;
  final Storage _storage;

  AppServiceClient(Client client, AppPreferences appPreferences)
      : _account = Account(client),
        _databases = Databases(client, databaseId: Constant.defaultId),
        _storage = Storage(client);

  Future<Session> login(LoginRequest loginRequest) => _account.createEmailSession(
      email: loginRequest.email, password: loginRequest.password);

  Future<User> register(LoginRequest loginRequest) => _account.create(
      userId: 'unique()',
      email: loginRequest.email,
      password: loginRequest.password,
      name: loginRequest.name);

  Future<Session> anonymousSession() => _account.createAnonymousSession();

  Future<Token> forgotPassword(String email) =>
      _account.createRecovery(email: email, url: Constant.baseUrl);

  Future<dynamic> deleteSession(String sessionId) =>
      _account.deleteSession(sessionId: sessionId);

  Future<File> createFile(Uint8List uint8list, String name) =>
      _storage.createFile(
          bucketId: Constant.buckedId,
          fileId: 'unique()',
          /*file: InputFile(
              file: MultipartFile.fromBytes('file', uint8list,
                  filename: name, contentType: MediaType('image', 'jpg'))),*/
          file: InputFile(filename: name, contentType: 'jpg', bytes: uint8list),
          read: ['role:all'],
          write: ['role:all']);

  Future deleteFile(String idFile) =>
      _storage.deleteFile(bucketId: Constant.buckedId, fileId: idFile);
}
