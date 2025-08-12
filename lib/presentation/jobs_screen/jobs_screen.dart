import 'package:flutter/material.dart';

import '../../core/app_export.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final jobs = [
      {'title': 'Möbel aufbauen', 'description': 'IKEA Kleiderschrank, ca. 2h'},
      {'title': 'Einkaufen', 'description': 'Wöchentlicher Einkauf übernehmen'},
      {'title': 'Hund ausführen', 'description': 'Golden Retriever Bruno, 1h täglich'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
      ),
      body: ListView.separated(
        itemCount: jobs.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final job = jobs[index];
          return ListTile(
            title: Text(job['title']!),
            subtitle: Text(job['description']!),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.jobDetails);
            },
          );
        },
      ),
    );
  }
}
