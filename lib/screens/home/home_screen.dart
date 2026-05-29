import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/mock_data.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../flag/flag_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialIndex != widget.initialIndex) {
      _selectedIndex = widget.initialIndex;
    }
  }

  String _getTitle() {
    switch (_selectedIndex) {
      case 0:
        return '📋 Tasks';
      case 1:
        return '🚩 Flags';
      case 2:
        return '👤 Profile';
      default:
        return '📋 Tasks';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTitle()),
        elevation: 0,
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onTap: (index) {
          _navigateToTab(index);
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildTaskList();
      case 1:
        return const FlagScreen();
      case 2:
        return const ProfileScreen();
      default:
        return _buildTaskList();
    }
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: MockData.tasks.length,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        final task = MockData.tasks[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: ListTile(
            leading: _getPriorityIcon(task.priority),
            title: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(task.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 4),
                Wrap(
                  spacing: 4,
                  children: task.tags
                      .map((tag) => Chip(label: Text(tag), labelStyle: const TextStyle(fontSize: 10)))
                      .toList(),
                ),
              ],
            ),
            trailing: _getStatusIcon(task.status),
            onTap: () {
              context.go('/task/${task.id}');
            },
          ),
        );
      },
    );
  }

  Widget _getPriorityIcon(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Icon(Icons.priority_high, color: Colors.red);
      case 'medium':
        return const Icon(Icons.priority_high, color: Colors.orange);
      case 'low':
        return const Icon(Icons.priority_high, color: Colors.green);
      default:
        return const Icon(Icons.priority_high);
    }
  }

  Widget _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Chip(label: Text('✅ Done'));
      case 'in_progress':
        return const Chip(label: Text('🔄 Progress'));
      case 'pending':
        return const Chip(label: Text('⏳ Pending'));
      default:
        return const Chip(label: Text('❓ Unknown'));
    }
  }

  void _navigateToTab(int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/flag');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }
}