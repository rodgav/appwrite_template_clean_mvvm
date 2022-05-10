import 'package:appwrite/appwrite.dart';
import 'package:appwrite_template_clean_mvvm/app/constants.dart';

class AppWriteClientFactory {
  Future<Client> getClient() async {
    Client client = Client();
    client
        .setEndpoint(Constant.baseUrl)
        .setProject(Constant.projectId)
        .setSelfSigned(status: false);
    return client;
  }
}
