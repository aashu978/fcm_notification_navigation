import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/mock_data.dart';

class FlagScreen extends StatelessWidget {
  const FlagScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: MockData.flags.length,
        itemBuilder: (context, index) {
          final flag = MockData.flags[index];
          return ListTile(
            title: Text(flag.title),
            subtitle: Text(flag.description),
            trailing: Text(flag.severity),
            onTap: () {
              context.go('/flag/${flag.id}');
            },
          );
        },
      ),
    );
  }
}
