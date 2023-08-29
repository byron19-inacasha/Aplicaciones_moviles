import 'package:flutter/material.dart';
import 'package:pokedex_mobile/main.dart';
import 'package:pokedex_mobile/providers/login_provider.dart';
import 'package:pokedex_mobile/screens/login_screen.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: LoginPk().AuthCredential,
      builder: (context, snapshot){
        if (snapshot.hasData){
          return const MainWidget();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}