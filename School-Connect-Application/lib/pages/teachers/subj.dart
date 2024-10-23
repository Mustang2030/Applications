import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';
import 'package:scs/routes/routes.dart';

class Subject extends StatelessWidget {
  const Subject({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        // actions: const [DrawerButtonIcon()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "GEOGRAPHY",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text(
              "GRADE: 10B",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            rslButton(context, "MAKE REPORTS", () {
              Navigator.pushNamed(context, RouteManagerProvider.makereport);
            }),
            const SizedBox(height: 10),
            const Student(
              name: "Thembile Poti",
              subject: "",
            ),
            const SizedBox(height: 10),
            const Student(
              name: "Thabiso Soaisa",
              subject: "",
            ),
            const SizedBox(height: 10),
            const Student(
              name: "Lebohang Senyane",
              subject: "",
            ),
            const SizedBox(height: 10),
            const Student(
              name: "Lukhanyo Mayekiso",
              subject: "",
            ),
            const SizedBox(height: 10),
            const Student(
              name: "Khayelihle Mathebula",
              subject: "",
            ),
            const SizedBox(height: 10),
            const Student(
              name: "Puleng Senyatso",
              subject: "",
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(400, 0, 0, 30),
              child: FloatingActionButton(
                  backgroundColor: Colors.grey,
                  child: const Icon(
                    Icons.chat,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(
                        context, RouteManagerProvider.pcontactlist);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
