import 'package:flutter/material.dart';
import 'package:scs/misc/constants.dart';

class MakeReport extends StatefulWidget {
  const MakeReport({super.key});

  @override
  State<MakeReport> createState() => _MakeReportState();
}

class _MakeReportState extends State<MakeReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Grade 10B\n",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              Table(
                defaultColumnWidth: const FlexColumnWidth(),
                children: const [
                  TableRow(
                    children: [
                      Text("Learner",
                          style: TextStyle(fontWeight: FontWeight.w700)),
                      Text(
                        "Work Done",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Mark",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      // Text(
                      //   "",
                      //   // "Feedback",
                      //   style: TextStyle(fontWeight: FontWeight.w700),
                      // ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text("Thembile Poti"),
                      Row(
                        children: [
                          Icon(Icons.my_library_books_rounded),
                          Text("ESSAY")
                        ],
                      ),
                      Text("8/27/2024"),
                      Text("47/100"),
                      // Text(""),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 60),
                      //   child: Icon(Icons.message_outlined),
                      // )
                    ],
                  ),
                  TableRow(
                    children: [
                      Text("Thabiso Soaisa"),
                      Row(
                        children: [
                          Icon(Icons.my_library_books_rounded),
                          Text("ESSAY")
                        ],
                      ),
                      Text("8/27/2024"),
                      Text("100/100"),
                      // Text(""),
                    ],
                  ),
                  TableRow(
                    children: [
                      Text("Lukhanyo May"),
                      Row(
                        children: [
                          Icon(Icons.my_library_books_rounded),
                          Text("ESSAY")
                        ],
                      ),
                      Text("8/27/2024"),
                      Text("48/100\n"),
                      // Text(""),
                      // Padding(
                      //   padding: EdgeInsets.only(right: 60),
                      //   child: Icon(Icons.message_outlined),
                      // )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Upload Reports\n",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(
                  height: 150,
                  child: Container(
                      decoration: BoxDecoration(border: Border.all()),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.pages),
                          ),
                          const Text("Drag and drop..."),
                        ],
                      )))),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(170, 0, 170, 0),
                child: rslButton(context, "Upload", () {
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
