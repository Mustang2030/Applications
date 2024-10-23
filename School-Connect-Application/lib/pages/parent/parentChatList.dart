import 'package:flutter/material.dart';
 
class ChatList extends StatelessWidget {
  final List<Map<String, String>> contacts = [
    {'name': 'User 1', 'image': 'https://via.placeholder.com/40'},
    {'name': 'User 2', 'image': 'https://via.placeholder.com/40'},
    // Add more contacts as needed
  ];

  final Function(String, String) onContactSelected;

  ChatList({required this.onContactSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Color(0xFFF0F0F0),
      child: Column(
        children: [
          Container(
            color: Color(0xFF0F2E34),
            padding: EdgeInsets.all(20),
            child: Text(
              'Chats',
              style: TextStyle(color: Colors.white, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onContactSelected(contacts[index]['name']!, contacts[index]['image']!);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(contacts[index]['image']!),
                          radius: 20,
                        ),
                        SizedBox(width: 15),
                        Text(
                          contacts[index]['name']!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


