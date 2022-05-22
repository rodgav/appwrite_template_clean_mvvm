import 'package:appwrite/appwrite.dart';
import 'package:appwrite_template_clean_mvvm/app/app_preferences.dart';
import 'package:appwrite_template_clean_mvvm/app/constants.dart';
import 'package:appwrite_template_clean_mvvm/app/dependency_injection.dart';

class AppWriteClientFactory {
  final _appPreferences = instance<AppPreferences>();

  Future<Client> getClient() async {
    Client client = Client();
    client
        .setEndpoint(Constant.baseUrl)
        .setProject(Constant.projectId)
        .setSelfSigned(status: false)
        .setLocale(_appPreferences.getAppLanguage());
    return client;
  }
}
