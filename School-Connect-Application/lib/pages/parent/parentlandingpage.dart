import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ParentLandingPage extends StatelessWidget {
  const ParentLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 116, 67, 67),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.pexels.com/photos/1103970/pexels-photo-1103970.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: const Color(0xB30F2E34), // rgba(15, 46, 52, 0.7)
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Icon(FontAwesomeIcons.user,
                                  size: 80, color: Colors.white),
                              const SizedBox(height: 10),
                              const Text(
                                'Mrs April Poti',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 20),
                              _buildButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, 'parent_view_prof');
                                },
                                child: const Text('View Profile'),
                                width: 200,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'List of Schools:',
                                style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              //Display a list of schools here
                            ],
                          ),
                          _buildButton(
                            onPressed: () {
                              // TODO: Implement logout functionality
                            },
                            child: const Text('LOGOUT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800)),
                            width: 200,
                            color: Colors.transparent,
                            borderColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required Widget child,
    required double width,
    Color color = Colors.black,
    Color borderColor = Colors.transparent,
  }) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: borderColor),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}
