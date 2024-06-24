
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project12_clubbola/screen_page/service.dart';
import '../model/model_bola.dart';
import 'detail_event.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Event>> futureEvents;
  final UserService userService = UserService();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    futureEvents = userService.fetchEvents();
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Club'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: updateSearchQuery,
              decoration: InputDecoration(
                hintText: 'Search Events',
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Event>>(
        future: futureEvents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Snapshot error: ${snapshot.error}');
            return Center(child: Text('Failed to load events'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events found'));
          } else {
            List<Event> filteredEvents = snapshot.data!
                .where((event) =>
                event.strEvent.toLowerCase().contains(searchQuery.toLowerCase()))
                .toList();

            return ListView.builder(
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: ListTile(
                    leading: event.strPoster.isNotEmpty
                        ? Image.network(event.strPoster, width: 50, height: 50, fit: BoxFit.cover)
                        : Container(width: 50, height: 50, color: Colors.grey),
                    title: Text(event.strEvent),
                    subtitle: Text(event.dateEvent),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetailPage(event: event),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
