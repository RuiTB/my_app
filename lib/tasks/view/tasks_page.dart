import 'package:flutter/material.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final List<_Task> _tasks = [
    _Task(
      id: '1',
      title: 'Complete project proposal',
      description: 'Write and review the project proposal document',
      priority: _Priority.high,
      isCompleted: false,
      dueDate: DateTime.now().add(const Duration(days: 2)),
    ),
    _Task(
      id: '2',
      title: 'Team meeting',
      description: 'Weekly team sync meeting',
      priority: _Priority.medium,
      isCompleted: false,
      dueDate: DateTime.now().add(const Duration(days: 1)),
    ),
    _Task(
      id: '3',
      title: 'Code review',
      description: 'Review pull requests from team members',
      priority: _Priority.high,
      isCompleted: true,
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
    ),
    _Task(
      id: '4',
      title: 'Update documentation',
      description: 'Update API documentation',
      priority: _Priority.low,
      isCompleted: false,
      dueDate: DateTime.now().add(const Duration(days: 5)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final completedTasks = _tasks.where((t) => t.isCompleted).length;
    final totalTasks = _tasks.length;
    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Filter functionality
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Progress',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    Text(
                      '$completedTasks / $totalTasks',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return _TaskCard(
                  task: task,
                  onToggle: () {
                    setState(() {
                      task.isCompleted = !task.isCompleted;
                    });
                  },
                  onDelete: () {
                    setState(() {
                      _tasks.removeAt(index);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    _Priority selectedPriority = _Priority.medium;

    showDialog<void>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Add New Task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<_Priority>(
                  value: selectedPriority,
                  decoration: const InputDecoration(
                    labelText: 'Priority',
                    border: OutlineInputBorder(),
                  ),
                  items: _Priority.values.map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedPriority = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  setState(() {
                    _tasks.add(_Task(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: titleController.text,
                      description: descriptionController.text,
                      priority: selectedPriority,
                      isCompleted: false,
                      dueDate: DateTime.now().add(const Duration(days: 7)),
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    required this.task,
    required this.onToggle,
    required this.onDelete,
  });

  final _Task task;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  Color _getPriorityColor() {
    switch (task.priority) {
      case _Priority.high:
        return Colors.red;
      case _Priority.medium:
        return Colors.orange;
      case _Priority.low:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: ListTile(
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: task.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(task.description),
            ],
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getPriorityColor().withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    task.priority.name.toUpperCase(),
                    style: TextStyle(
                      color: _getPriorityColor(),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 4),
                Text(
                  'Due: ${_formatDate(task.dueDate)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: onDelete,
          color: Colors.red,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = date.difference(now).inDays;

    if (difference < 0) {
      return 'Overdue';
    } else if (difference == 0) {
      return 'Today';
    } else if (difference == 1) {
      return 'Tomorrow';
    } else {
      return 'In $difference days';
    }
  }
}

class _Task {
  _Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.isCompleted,
    required this.dueDate,
  });

  final String id;
  final String title;
  final String description;
  final _Priority priority;
  bool isCompleted;
  final DateTime dueDate;
}

enum _Priority {
  high,
  medium,
  low,
}
