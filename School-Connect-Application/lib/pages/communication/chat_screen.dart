// Import the Flutter Material library
import 'package:flutter/material.dart';

// Define a stateful widget for the chat screen
class ChatScreen extends StatefulWidget {
  // Constructor for the ChatScreen widget
  const ChatScreen({super.key});

  // Create the state for the ChatScreen widget
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

// Define the state for the ChatScreen widget
class _ChatScreenState extends State<ChatScreen> {
  // Controller for the message input field
  final TextEditingController _messageController = TextEditingController();

  // List of chat messages
  final List<ChatMessage> _messages = [];

  // Selected subject for the chat
  String _selectedSubject = '';

  // Build the chat screen UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Build the app bar
      appBar: _buildAppBar(),
      // Build the body of the chat screen
      body: Column(
        children: <Widget>[
          // Display the selected subject if it's not empty
          if (_selectedSubject.isNotEmpty) _buildSubjectContainer(),
          // Build the list of chat messages
          _buildMessagesList(),
          // Build the message input field
          _buildMessageInput(),
        ],
      ),
    );
  }

  // UI Components

  // Build the app bar
  AppBar _buildAppBar() {
    return AppBar(
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.maybePop(context);
            },
          );
        },
      ),
      // Set the title of the app bar
      title: const Text(
        'Chat Room',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      // Remove the elevation of the app bar
      elevation: 0,
      // Add a popup menu button to the app bar
      // actions: [
      //   PopupMenuButton<String>(
      //     // Set the icon for the popup menu button
      //     // icon: const Icon(
      //     //   Icons.more_vert,
      //     //   color: Colors.white,
      //     // ),
      //     // Set the shape of the popup menu
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(15),
      //     ),
      //     // Handle the selection of a subject
      //     onSelected: _handleSubjectSelection,
      //     // Build the popup menu items
      //     itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
      //       const PopupMenuItem<String>(
      //         value: 'Enquire',
      //         child: Text('Enquire'),
      //       ),
      //       const PopupMenuItem<String>(
      //         value: 'Report',
      //         child: Text('Report'),
      //       ),
      //       const PopupMenuItem<String>(
      //         value: 'Request Meeting',
      //         child: Text('Request Meeting'),
      //       ),
      //     ],
      //   ),
      // ],
      // // Set the flexible space of the app bar
      flexibleSpace: Container(
        // Set the decoration of the flexible space
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Colors.black,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  // Build the subject container
  Widget _buildSubjectContainer() {
    return Container(
      // Set the padding of the subject container
      padding: const EdgeInsets.all(12.0),
      // Set the color of the subject container
      color: Colors.black.withOpacity(0.1),
      // Align the button to the top left
      alignment: Alignment.topLeft,
      // Build the button that triggers the subject selection popup
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Button background color
        ),
        onPressed: () {
          _showSubjectDialog();
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.more_vert, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              'Subject: $_selectedSubject',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

// Show the subject selection dialog
  void _showSubjectDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              RadioListTile<String>(
                title: const Text('Enquire'),
                value: 'Enquire',
                groupValue: _selectedSubject,
                onChanged: (String? value) {
                  setState(() {
                    _selectedSubject = value!;
                    Navigator.pop(context);
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Report'),
                value: 'Report',
                groupValue: _selectedSubject,
                onChanged: (String? value) {
                  setState(() {
                    _selectedSubject = value!;
                    Navigator.pop(context);
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Send Complaint'),
                value: 'Send Complaint',
                groupValue: _selectedSubject,
                onChanged: (String? value) {
                  setState(() {
                    _selectedSubject = value!;
                    Navigator.pop(context);
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

// Initialize the default selected subject
  @override
  void initState() {
    super.initState();
    _selectedSubject = 'Enquire'; // Default subject selection
  }

  // Build the list of chat messages
  Widget _buildMessagesList() {
    return Expanded(
      // Build the container for the chat messages
      child: Container(
        // Set the decoration of the container
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        // Build the list view for the chat messages
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: ListView.builder(
            // Reverse the order of the chat messages
            reverse: true,
            // Set the item count of the list view
            itemCount: _messages.length,
            // Build each chat message
            itemBuilder: (context, index) {
              return _messages[index];
            },
          ),
        ),
      ),
    );
  }

  // Build the message input field
  Widget _buildMessageInput() {
    return Container(
      // Set the padding of the message input field
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      // Set the decoration of the message input field
      // Set the decoration of the message input field
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      // Build the row for the message input field and send button
      child: Row(
        children: <Widget>[
          // Build the expanded container for the message input field
          Expanded(
            child: Container(
              // Set the decoration of the message input field
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              // Build the text field for the message input
              child: TextField(
                // Set the controller for the text field
                controller: _messageController,
                // Set the decoration of the text field
                decoration: const InputDecoration(
                  hintText: 'Type a message',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                // Handle the submission of the message
                onSubmitted: (_) => _handleSubmitted(),
              ),
            ),
          ),
          // Build the send button
          const SizedBox(width: 8),
          FloatingActionButton(
            // Set the mini property of the floating action button
            mini: true,
            // Handle the press of the send button
            onPressed: _handleSubmitted,
            // Set the background color of the floating action button
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            // Set the child of the floating action button
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  // Logic Methods

  // Handle the submission of a message
  void _handleSubmitted() {
    // Check if the message is not empty
    if (_messageController.text.isNotEmpty) {
      // Set the state to add the message to the list of messages
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: _messageController.text,
            isMe: true,
          ),
        );

        // Simulate a response from B
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                text: _generateResponse(_messageController.text),
                isMe: false,
              ),
            );
          });
        });
      });
      // Clear the message input field
      _messageController.clear();
    }
  }

  // Generate a response to a message
  String _generateResponse(String message) {
    // Check if the message contains "hello" or "hi"
    if (message.toLowerCase().contains('hello') ||
        message.toLowerCase().contains('hi')) {
      return "Hello! How can I assist you today?";
    }
    // Check if the message contains "how are you"
    else if (message.toLowerCase().contains('how are you')) {
      return "I'm doing well, thank you for asking. How about you?";
    }
    // Check if the message contains "bye" or "goodbye"
    else if (message.toLowerCase().contains('bye') ||
        message.toLowerCase().contains('goodbye')) {
      return "Goodbye! Have a great day!";
    }
    // Return a default response
    else {
      return "Thank you for texting. How can I help you?";
    }
  }
}

// Define a stateless widget for a chat message
class ChatMessage extends StatelessWidget {
  // The text of the chat message
  final String text;

  // Whether the chat message is from the current user
  final bool isMe;

  // Constructor for the ChatMessage widget
  const ChatMessage({
    super.key,
    required this.text,
    required this.isMe,
  });

  // Build the chat message UI
  @override
  Widget build(BuildContext context) {
    return Container(
      // Set the margin of the chat message
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      // Build the row for the chat message
      child: Row(
        // Set the main axis alignment of the row
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        // Set the cross axis alignment of the row
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // Check if the chat message is not from the current user
          if (!isMe)
            // Build the avatar for the other user
            const CircleAvatar(
              backgroundColor: Colors.grey,
              // Set the text of the avatar
              child: Text(
                'B',
                style: TextStyle(color: Colors.black),
              ),
            ),
          const SizedBox(width: 7),
          // Build the container for the chat message
          Flexible(
            child: Container(
              // Set the decoration of the chat message
              decoration: BoxDecoration(
                color: isMe ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              // Set the margin of the chat message
              padding: const EdgeInsets.all(10),
              // Build the text of the chat message
              child: Text(
                text,
                style: TextStyle(color: isMe ? Colors.white : Colors.black87),
              ),
            ),
          ),
          const SizedBox(width: 7),
          // Check if the chat message is from the current user
          if (isMe)
            // Build the checkmark for the sent message
            const Icon(
              Icons.done_all,
              size: 18,
              color: Colors.indigo,
            ),
        ],
      ),
    );
  }
}
