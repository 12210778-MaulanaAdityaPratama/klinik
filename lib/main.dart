import 'package:flutter/material.dart';
import 'package:sismdlb/providers/berita_panel_provider.dart';
import 'package:sismdlb/providers/peta_provider.dart';
import 'package:sismdlb/views/login_views.dart';
import 'package:sismdlb/providers/dashboard_provider.dart';
import 'package:provider/provider.dart';
import 'package:sismdlb/views/crud_view.dart';

main(List<String> args) {
  runApp(MultiProvider(
    builder: (context, widget) {
      return const MaterialApp(home: LoginView());
    },
    providers: [
      ChangeNotifierProvider(create: (c) => DashboardProvider()),
      ChangeNotifierProvider(create: (c) => BeritaPanelProvider()),
      ChangeNotifierProvider(create: (c) => PetaProvider()),
    ],
  ));
}
