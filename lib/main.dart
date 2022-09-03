import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx_cover/RouteGenerator.dart';
import 'package:olx_cover/views/Anuncios.dart';
import 'package:olx_cover/views/NovoAnuncio.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xff9c27b0),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xff7b1fa2)),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "OLX",
    //home: Anuncios(),
    home: NovoAnuncio(),
    theme: temaPadrao,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}
