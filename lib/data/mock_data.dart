import '../models/task_model.dart';
import '../models/flag_model.dart';

class MockData {
  static final List<Task> tasks = [
    Task(
      id: 'task_001',
      title: 'Complete Project Report',
      description: 'Write comprehensive project report with all metrics and insights from Q1 analysis',
      assignee: 'Raj Kumar',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      priority: 'high',
      status: 'in_progress',
      category: 'Documentation',
      estimatedHours: 8,
      tags: ['report', 'urgent', 'documentation'],
    ),
    Task(
      id: 'task_002',
      title: 'Code Review - Authentication Module',
      description: 'Review new authentication implementation for security vulnerabilities and best practices',
      assignee: 'Priya Singh',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      priority: 'high',
      status: 'pending',
      category: 'Code Review',
      estimatedHours: 4,
      tags: ['security', 'review', 'auth'],
    ),
    Task(
      id: 'task_003',
      title: 'Update Database Schema',
      description: 'Add new columns to user table for profile enhancements and feature expansion',
      assignee: 'Ahmed Hassan',
      dueDate: DateTime.now().add(const Duration(days: 5)),
      priority: 'medium',
      status: 'pending',
      category: 'Database',
      estimatedHours: 6,
      tags: ['database', 'schema'],
    ),
    Task(
      id: 'task_004',
      title: 'API Optimization',
      description: 'Optimize API response time and implement caching strategy',
      assignee: 'Priya Singh',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      priority: 'medium',
      status: 'pending',
      category: 'Performance',
      estimatedHours: 12,
      tags: ['api', 'performance', 'optimization'],
    ),
    Task(
      id: 'task_005',
      title: 'Unit Tests Implementation',
      description: 'Write comprehensive unit tests for authentication and payment modules',
      assignee: 'Raj Kumar',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      priority: 'high',
      status: 'in_progress',
      category: 'Testing',
      estimatedHours: 10,
      tags: ['testing', 'unit-tests'],
    ),
  ];

  static final List<Flag> flags = [
    Flag(
      id: 'flag_001',
      title: 'Critical: Database Connection Timeout',
      description: 'Production database experiencing connection timeouts every hour. Affecting 5% of users. Immediate investigation required.',
      severity: 'critical',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      status: 'active',
      category: 'Infrastructure',
    ),
    Flag(
      id: 'flag_002',
      title: 'Warning: High Memory Usage',
      description: 'API server memory usage at 85%, may cause OutOfMemory exception soon. Recommend restart or optimization.',
      severity: 'warning',
      createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      status: 'acknowledged',
      category: 'Performance',
    ),
    Flag(
      id: 'flag_003',
      title: 'Info: Deployment Ready',
      description: 'Version 2.1.0 is ready for deployment to production. All tests passing. Waiting for approval.',
      severity: 'info',
      createdAt: DateTime.now(),
      status: 'active',
      category: 'Deployment',
    ),
    Flag(
      id: 'flag_004',
      title: 'Warning: SSL Certificate Expiring',
      description: 'SSL certificate for api.example.com expires in 7 days. Plan renewal immediately.',
      severity: 'warning',
      createdAt: DateTime.now().subtract(const Duration(hours: 5)),
      status: 'active',
      category: 'Security',
    ),
    Flag(
      id: 'flag_005',
      title: 'Critical: Security Vulnerability Detected',
      description: 'XSS vulnerability found in user input validation. Patch released. Please update immediately.',
      severity: 'critical',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      status: 'resolved',
      category: 'Security',
    ),
  ];

  static Task? getTaskById(String id) {
    try {
      return tasks.firstWhere((task) => task.id == id);
    } catch (e) {
      return null;
    }
  }

  static Flag? getFlagById(String id) {
    try {
      return flags.firstWhere((flag) => flag.id == id);
    } catch (e) {
      return null;
    }
  }
}