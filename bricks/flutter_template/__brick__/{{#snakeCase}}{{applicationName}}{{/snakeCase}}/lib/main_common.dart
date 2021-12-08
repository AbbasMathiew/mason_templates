import 'package:flutter/material.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/injection/dependencies.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/nstack/nstack.dart';
import 'package:{{#snakeCase}}{{applicationName}}{{/snakeCase}}/presentation/app.dart';

import 'presentation/app_flavor.dart';

void mainCommon(AppFlavor flavor) async {
  await DependencyManager.inject(flavor);
  runApp(NStackWidget(child: const App()));
}
