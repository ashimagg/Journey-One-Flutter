import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  static const double listViewMargin = 10;
  static const listViewBackgroundColor = Colors.black87;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<String> currentEmail = ref.watch(emailProvider);

    return Scaffold(
      // backgroundColor: listViewBackgroundColor,
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
                final authAWSRepo = ref.read(authAWSRepositoryProvider);
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
    final AsyncValue<List<Entry>> database = ref.watch(entriesProvider);
    return database.when(
        data: (data) => Container(
            decoration: const BoxDecoration(color: listViewBackgroundColor),
            padding: const EdgeInsets.all(listViewMargin),
            child: AllEntriesView(entries: data)),
        error: (e, st) => const ErrorView(),
        loading: () => const Align(
            alignment: Alignment.center, child: CircularProgressIndicator()));
  }

  void _pushSaved() {}
}
