import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_app/providers/database.dart';
import 'package:my_app/providers/get_entries_activity.dart';
import 'package:my_app/model/entry.dart';
import 'package:my_app/page/common/error.dart';
import 'package:my_app/page/home/bottom_bar.dart';
import 'package:my_app/page/home/all_entries.dart';
import 'package:my_app/providers/providers.dart';
import 'package:my_app/providers/aws-auth.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<String> currentEmail = ref.watch(emailProvider);
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
          title: Text(currentEmail.when(
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
    final database = ref.watch(entriesProvider('123489839'));
    return database.when(
        data: (data) => AllEntriesView(entries: data),
        error: (e, st) => const ErrorView(),
        loading: () => const Align(
            alignment: Alignment.center, child: CircularProgressIndicator()));
  }

  void _pushSaved() {}
}
