import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';
import 'app/dependency_injection.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initModule();
  runApp(Phoenix(child: MyApp()));
}


