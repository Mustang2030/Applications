import 'package:flutter/material.dart';

class ParentsAnnouncementsPage extends StatefulWidget {
  const ParentsAnnouncementsPage({Key? key}) : super(key: key);

  @override
  ParentsAnnouncementsPageState createState() =>
      ParentsAnnouncementsPageState();
}

class ParentsAnnouncementsPageState extends State<ParentsAnnouncementsPage> {
  final List<Map<String, String>> _announcements = [
    {'from': 'GENERAL ANNOUNCEMENTS', 'message': 'Tomorrow is sports day.'},
    {'from': 'MATHEMATICS', 'message': 'Upcoming exam schedule.'},
    {'from': 'PHYSICAL SCIENCES', 'message': 'New lab equipment installed.'},
    {'from': 'THCSA AL', 'message': 'New school policy announcement.'},
    {'from': 'LIFE ORIENTATION', 'message': 'Sports day preparation.'},
    {'from': 'LIFE SCIENCES', 'message': 'Biology class trip info.'},
    {'from': 'GENERAL ANNOUNCEMENTS', 'message': 'Parent-teacher meeting.'},
  ];

  List<Map<String, String>> _filteredAnnouncements = [];

  @override
  void initState() {
    super.initState();
    _filteredAnnouncements = List.from(_announcements);
  }

  void _filterAnnouncements(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredAnnouncements = List.from(_announcements);
      } else {
        _filteredAnnouncements = _announcements.where((announcement) {
          final from = announcement['from']!.toLowerCase();
          final message = announcement['message']!.toLowerCase();
          return from.contains(query.toLowerCase()) ||
              message.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _deleteAnnouncement(int index) {
    setState(() {
      _filteredAnnouncements.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcements'),
        backgroundColor: const Color(0xFF0F2E34),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SearchSection(onSearch: _filterAnnouncements),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredAnnouncements.length,
                itemBuilder: (context, index) {
                  final announcement = _filteredAnnouncements[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      _deleteAnnouncement(index);
                    },
                    child: AnnouncementTile(
                      from: announcement['from']!,
                      message: announcement['message']!,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchSection extends StatelessWidget {
  final ValueChanged<String> onSearch;

  const SearchSection({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Total: 12',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F2E34),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search, color: Color(0xFF0F2E34)),
              ),
              onChanged: onSearch,
            ),
          ),
        ),
      ],
    );
  }
}

class AnnouncementTile extends StatelessWidget {
  final String from;
  final String message;

  const AnnouncementTile({Key? key, required this.from, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.campaign,
            color: Color(0xFF0F2E34),
            size: 24,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  from,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
