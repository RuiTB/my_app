import 'package:flutter/material.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final List<_Message> _messages = [
    _Message(
      id: '1',
      sender: 'Alice Johnson',
      content: 'Hey! How are you doing?',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      isRead: false,
      avatarColor: Colors.blue,
    ),
    _Message(
      id: '2',
      sender: 'Bob Smith',
      content: 'Can we schedule a meeting for tomorrow?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
      avatarColor: Colors.green,
    ),
    _Message(
      id: '3',
      sender: 'Carol Williams',
      content: 'Thanks for your help with the project!',
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      isRead: true,
      avatarColor: Colors.purple,
    ),
    _Message(
      id: '4',
      sender: 'David Brown',
      content: 'The presentation went great!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
      avatarColor: Colors.orange,
    ),
    _Message(
      id: '5',
      sender: 'Eva Davis',
      content: 'Let me know when you\'re available.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
      avatarColor: Colors.pink,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // More options
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: Row(
              children: [
                Expanded(
                  child: _FilterChip(
                    label: 'All',
                    isSelected: true,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _FilterChip(
                    label: 'Unread',
                    isSelected: false,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _FilterChip(
                    label: 'Archived',
                    isSelected: false,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _MessageTile(
                  message: message,
                  onTap: () {
                    _showMessageDetail(context, message);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewMessageDialog(context);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  void _showMessageDetail(BuildContext context, _Message message) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: message.avatarColor,
                    child: Text(
                      message.sender[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.sender,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          _formatTimestamp(message.timestamp),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Text(
                    message.content,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {},
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewMessageDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Message'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'To',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Message',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Message sent!')),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class _MessageTile extends StatelessWidget {
  const _MessageTile({
    required this.message,
    required this.onTap,
  });

  final _Message message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: message.avatarColor,
        child: Text(
          message.sender[0].toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              message.sender,
              style: TextStyle(
                fontWeight: message.isRead
                    ? FontWeight.normal
                    : FontWeight.bold,
              ),
            ),
          ),
          if (!message.isRead)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
      subtitle: Text(
        message.content,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: message.isRead ? Colors.grey : Colors.black87,
        ),
      ),
      trailing: Text(
        _formatTime(message.timestamp),
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 12,
        ),
      ),
      onTap: onTap,
    );
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour;
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class _Message {
  _Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.timestamp,
    required this.isRead,
    required this.avatarColor,
  });

  final String id;
  final String sender;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final Color avatarColor;
}
