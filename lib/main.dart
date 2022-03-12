import 'package:flutter/material.dart';
import 'package:global_conference/models/conf_event.dart';
import 'package:global_conference/repositories/conference.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final ConferenceRepository _repo;

  @override
  void initState() {
    _repo = ConferenceRepository();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Testing')),
        body: Column(
          children: [
            // List a single event: QuHgttgdblkGVzxxYB4b
            FutureBuilder<ConfEvent>(
                future: _repo.getEvent('QuHgttgdblkGVzxxYB4b'),
                builder: ((context, snapshot) {
                  return Text(snapshot.data?.title ?? 'Unknown');
                })),
            // List all events!
            Expanded(
              child: FutureBuilder<List<ConfEvent>>(
                  future: _repo.getEvents(),
                  builder: (context, snap) {
                    if (snap.hasData) {
                      return ListView.builder(
                          itemCount: snap.data!.length,
                          itemBuilder: (context, index) {
                            return Text(snap.data![index].title);
                          });
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
