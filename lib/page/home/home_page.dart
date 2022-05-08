import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/activity/get_entries_activity.dart';
import 'package:my_app/model/entry.dart';
import 'package:my_app/page/common/error.dart';
import 'package:my_app/page/home/bottom_bar.dart';
import 'package:my_app/page/home/all_entries.dart';
import 'package:my_app/providers.dart';
import 'package:my_app/aws-auth.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late Future<List<Entry>> futureEntries;

  @override
  void initState() {
    super.initState();
    futureEntries = GetEntriesActivity.enact('123489839', 10);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(authUserProvider);
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 16),
              ),
              leading: const Icon(Icons.logout),
              onTap: () async {
                final authAWSRepo = ref.watch(authAWSRepositoryProvider);
                await authAWSRepo.logOut();
              })
        ],
      )),
      appBar: AppBar(
          title: Text(currentUser.when(
              data: (data) => data, error: (e, st) => '', loading: () => '')),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: _pushSaved,
              tooltip: 'Saved Suggestions',
            )
          ]),
      body: _body(),
      bottomNavigationBar: const BottomBar(),
    );
  }

  Widget _body() {
    return FutureBuilder<List<Entry>>(
        future: futureEntries,
        builder: (BuildContext context, AsyncSnapshot<List<Entry>> snapshot) {
          if (snapshot.hasData) {
            return AllEntriesView(entries: snapshot.data);
          } else if (snapshot.hasError) {
            return const ErrorView();
          }
          // By default, show a loading spinner.
          return const Align(
              alignment: Alignment.center, child: CircularProgressIndicator());
        });
  }

  void _pushSaved() {}
}
