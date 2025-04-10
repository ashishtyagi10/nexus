import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'contacts_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Chat> _chats = [];
  final TextEditingController _groupNameController = TextEditingController();

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  void _startNewChat() async {
    final result = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactsScreen(
          isSelectionMode: true,
          isMultiSelect: false,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        _chats.add(Chat(
          id: DateTime.now().toString(),
          name: result.fullName,
          isGroup: false,
          participants: [result],
          lastMessage: 'No messages yet',
          lastMessageTime: DateTime.now(),
        ));
      });
      // Navigate to the chat detail screen
      // TODO: Implement chat detail screen navigation
    }
  }

  void _createNewGroup() async {
    final result = await Navigator.push<List<Contact>>(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactsScreen(
          isSelectionMode: true,
          isMultiSelect: true,
        ),
      ),
    );

    if (result != null && result.isNotEmpty) {
      _showGroupNameDialog(result);
    }
  }

  void _showGroupNameDialog(List<Contact> selectedContacts) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Group'),
        content: TextField(
          controller: _groupNameController,
          decoration: const InputDecoration(
            labelText: 'Group Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _groupNameController.clear();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_groupNameController.text.isNotEmpty) {
                setState(() {
                  _chats.add(Chat(
                    id: DateTime.now().toString(),
                    name: _groupNameController.text,
                    isGroup: true,
                    participants: selectedContacts,
                    lastMessage: 'Group created',
                    lastMessageTime: DateTime.now(),
                  ));
                  _groupNameController.clear();
                });
                Navigator.pop(context);
                // Navigate to the chat detail screen
                // TODO: Implement chat detail screen navigation
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Chats',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _chats.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'No chats yet',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _chats.length,
                      itemBuilder: (context, index) {
                        final chat = _chats[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              child: Text(
                                chat.isGroup ? 'G' : (chat.name.isNotEmpty ? chat.name[0] : '?'),
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                            title: Text(chat.name),
                            subtitle: Text(chat.lastMessage),
                            trailing: Text(
                              _formatTime(chat.lastMessageTime),
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            onTap: () {
                              // TODO: Navigate to chat detail screen
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: PopupMenuButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(Icons.person_add),
                SizedBox(width: 8),
                Text('Start Chat'),
              ],
            ),
            onTap: _startNewChat,
          ),
          PopupMenuItem(
            child: const Row(
              children: [
                Icon(Icons.group_add),
                SizedBox(width: 8),
                Text('Create Group'),
              ],
            ),
            onTap: _createNewGroup,
          ),
        ],
        position: PopupMenuPosition.over,
        elevation: 4,
        child: const FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}

class Chat {
  final String id;
  final String name;
  final bool isGroup;
  final List<Contact> participants;
  final String lastMessage;
  final DateTime lastMessageTime;

  Chat({
    required this.id,
    required this.name,
    required this.isGroup,
    required this.participants,
    required this.lastMessage,
    required this.lastMessageTime,
  });
} 