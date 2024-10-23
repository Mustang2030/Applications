import 'package:flutter/material.dart';

class TChatListScreen extends StatefulWidget {
  const TChatListScreen({super.key});

  @override
  State<TChatListScreen> createState() => _TChatListScreenState();
}

class _TChatListScreenState extends State<TChatListScreen> {
  List<Map<String, String>> contacts = [
    {'name': 'User 1', 'image': 'https://via.placeholder.com/40'},
    {'name': 'User 2', 'image': 'https://via.placeholder.com/40'},
    {'name': 'User 3', 'image': 'https://via.placeholder.com/40'},
    {'name': 'User 4', 'image': 'https://via.placeholder.com/40'},
    {'name': 'User 5', 'image': 'https://via.placeholder.com/40'},
    {'name': 'User 6', 'image': 'https://via.placeholder.com/40'},
    {'name': 'User 7', 'image': 'https://via.placeholder.com/40'},
    {'name': 'User 8', 'image': 'https://via.placeholder.com/40'},

    // Add more contacts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF0F2E34),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contacts[index]['image']!),
                  ),
                  title: Text(contacts[index]['name']!),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
