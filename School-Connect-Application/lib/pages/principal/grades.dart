import 'package:flutter/material.dart';
import 'package:scs/routes/routes.dart';

class GradesPrince extends StatefulWidget {
  const GradesPrince({super.key});

  @override
  State<GradesPrince> createState() => _GradesPrinceState();
}

class _GradesPrinceState extends State<GradesPrince> {
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
        //   DrawerButton(
        //     color: Color.fromRGBO(0, 0, 0, 1),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "GRADES",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Grade 8",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.teachprofpv);
                            },
                            child: const Text(
                              "8A",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 30),
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.teachprofpv);
                            },
                            child: const Text(
                              "8B",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Grade 9",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.teachprofpv);
                            },
                            child: const Text(
                              "9A",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 300,
                        child: FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.teachprofpv);
                          },
                          child: const Text(
                            "9B",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Grade 10",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.teachprofpv);
                            },
                            child: const Text(
                              "10A",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 300,
                        child: FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.teachprofpv);
                          },
                          child: const Text(
                            "10B",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Grade 11",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.teachprofpv);
                            },
                            child: const Text(
                              "11A",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 300,
                        child: FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.teachprofpv);
                          },
                          child: const Text(
                            "11B",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Grade 12",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                  Column(
                    children: [
                      SizedBox(
                          width: 300,
                          child: FloatingActionButton(
                            backgroundColor: Colors.black,
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RouteManagerProvider.teachprofpv);
                            },
                            child: const Text(
                              "12A",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: 300,
                        child: FloatingActionButton(
                          backgroundColor: Colors.black,
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RouteManagerProvider.teachprofpv);
                          },
                          child: const Text(
                            "12B",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
