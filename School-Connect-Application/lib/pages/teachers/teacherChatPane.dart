import 'package:flutter/material.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatLayoutState();
}

class _ChatLayoutState extends State<ChatApp> {
  String selectedSubject = 'Enquire';
  final TextEditingController _controller = TextEditingController();
  List<String> messages = [];

  void sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        messages.add(_controller.text.trim());
        _controller.clear();
      });
    }
  }

  void selectSubject(String subject) {
    setState(() {
      selectedSubject = subject;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          // Chat Header
          Container(
            padding: EdgeInsets.all(15),
            color: Color(0xff0F2E34),
            child: const Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://via.placeholder.com/45',
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'ChatRoom',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          // Subject Button
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
            child: Row(
              children: [
                Text('Subject: $selectedSubject'),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: selectSubject,
                  itemBuilder: (BuildContext context) {
                    return ['Enquire', 'Complaint', 'Report']
                        .map((String subject) {
                      return PopupMenuItem<String>(
                        value: subject,
                        child: Text(subject),
                      );
                    }).toList();
                  },
                  child: const Icon(Icons.more_vert),
                ),
              ],
            ),
          ),
          // Chat Messages Area
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xff0F2E34),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input Area
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xffddd))),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xff0F2E34),
                  ),
                  color: const Color(0xff0F2E34),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(ChatApp());
}
