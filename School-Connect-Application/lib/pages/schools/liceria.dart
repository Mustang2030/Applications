import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/routes/routes.dart';

class Liceria extends StatefulWidget {
  const Liceria({super.key});

  @override
  State<Liceria> createState() => _LiceriaState();
}

class _LiceriaState extends State<Liceria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          // actions: const [
          //   DrawerButton(),
          // ],
        ),
        body: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/liceria.jpg",
                      scale: 2,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "LICERIA HIGH SCHOOL",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    slButton(context, "Thembile Poti", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.childpro);
                    }),
                    slButton(context, "Omphile   Poti", () {
                      Navigator.pushNamed(
                          context, RouteManagerProvider.childpro);
                    }),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
