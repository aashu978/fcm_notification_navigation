import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/mock_data.dart';

class FlagDetailScreen extends StatelessWidget {
  final String flagId;

  const FlagDetailScreen({Key? key, required this.flagId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final flag = MockData.getFlagById(flagId);

    if (flag == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flag Not Found')),
        body: const Center(child: Text('This flag does not exist')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flag Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title with severity badge
            Row(
              children: [
                Expanded(
                  child: Text(
                    flag.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getSeverityColor(flag.severity),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    flag.severity.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Status chips
            Row(
              children: [
                Chip(
                  label: Text(flag.status),
                  backgroundColor: _getStatusColor(flag.status),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(flag.category),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Description
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              flag.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Additional info
            Text(
              'Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Created At', _formatDate(flag.createdAt)),
            _buildInfoRow('Status', flag.status),
            _buildInfoRow('Category', flag.category),
            _buildInfoRow('Severity', flag.severity),
            const SizedBox(height: 32),

            // Action buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Flag marked as acknowledged!')),
                  );
                },
                icon: const Icon(Icons.done),
                label: const Text('Mark as Acknowledged'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'info':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.red;
      case 'acknowledged':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}