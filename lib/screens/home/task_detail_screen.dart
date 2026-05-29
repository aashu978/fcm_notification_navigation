import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/mock_data.dart';

class TaskDetailScreen extends StatelessWidget {
  final String taskId;

  const TaskDetailScreen({Key? key, required this.taskId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final task = MockData.getTaskById(taskId);

    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Task Not Found')),
        body: const Center(child: Text('This task does not exist')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
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
            // Title
            Text(
              task.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            // Status and Priority chips
            Row(
              children: [
                Chip(
                  label: Text(task.status),
                  backgroundColor: _getStatusColor(task.status),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(task.priority),
                  backgroundColor: _getPriorityColor(task.priority),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Details section
            Text(
              'Details',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Description', task.description),
            _buildDetailRow('Assignee', task.assignee),
            _buildDetailRow('Category', task.category),
            _buildDetailRow('Estimated Hours', '${task.estimatedHours} hours'),
            _buildDetailRow('Due Date', _formatDate(task.dueDate)),
            const SizedBox(height: 24),

            // Tags
            Text(
              'Tags',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: task.tags
                  .map((tag) => Chip(label: Text(tag)))
                  .toList(),
            ),
            const SizedBox(height: 32),

            // Action buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task marked as complete!')),
                  );
                },
                child: const Text('Mark as Complete'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(value),
          const Divider(),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'in_progress':
        return Colors.blue;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}