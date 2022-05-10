import 'package:freezed_annotation/freezed_annotation.dart';
part 'freezed_data_classes.freezed.dart';
//flutter pub run build_runner build
@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String username, String password,String name) = _LoginObject;
}



