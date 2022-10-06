import "package:com_nicodevelop_taskmator/config/constants.dart";
import "package:com_nicodevelop_taskmator/screens/settings_screen.dart";
import "package:com_nicodevelop_taskmator/screens/task_editor_screen.dart";
import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> _showBottomSheet(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            kDefaultPadding,
          ),
        ),
      ),
      builder: (context) {
        return const TaskEditorScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dot Messenger"),
        actions: [
          IconButton(
            onPressed: () async => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SettingsScreen(),
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ToDay",
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tomorrow",
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => _showBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
