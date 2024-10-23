import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs/provider/login_provider.dart';
import 'package:scs/routes/routes.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: const StPrototype(),
    ),
  );
}

class StPrototype extends StatelessWidget {
  const StPrototype({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteManagerProvider.generateRoute,
      initialRoute: RouteManagerProvider.login,
    );
  }
}
