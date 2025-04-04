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
  bool _isCreatingGroup = false;
  final TextEditingController _groupNameController = TextEditingController();
  final List<Contact> _selectedContacts = [];

  @override
  void dispose() {
    _groupNameController.dispose();
    super.dispose();
  }

  void _startNewChat() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactsScreen(),
      ),
    ).then((selectedContact) {
      if (selectedContact != null && selectedContact is Contact) {
        setState(() {
          _chats.add(Chat(
            id: DateTime.now().toString(),
            name: selectedContact.fullName,
            isGroup: false,
            participants: [selectedContact],
            lastMessage: 'No messages yet',
            lastMessageTime: DateTime.now(),
          ));
        });
      }
    });
  }

  void _createNewGroup() {
    setState(() {
      _isCreatingGroup = true;
      _selectedContacts.clear();
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ContactsScreen(),
      ),
    ).then((selectedContacts) {
      if (selectedContacts != null && selectedContacts is List<Contact>) {
        setState(() {
          _selectedContacts.addAll(selectedContacts);
        });
        _showGroupNameDialog();
      } else {
        setState(() {
          _isCreatingGroup = false;
        });
      }
    });
  }

  void _showGroupNameDialog() {
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
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isCreatingGroup = false;
              });
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_groupNameController.text.isNotEmpty && _selectedContacts.isNotEmpty) {
                setState(() {
                  _chats.add(Chat(
                    id: DateTime.now().toString(),
                    name: _groupNameController.text,
                    isGroup: true,
                    participants: List.from(_selectedContacts),
                    lastMessage: 'Group created',
                    lastMessageTime: DateTime.now(),
                  ));
                  _groupNameController.clear();
                  _selectedContacts.clear();
                  _isCreatingGroup = false;
                });
                Navigator.pop(context);
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
      body: _chats.isEmpty
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
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _startNewChat,
                    icon: const Icon(Icons.person_add),
                    label: const Text('Start New Chat'),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _createNewGroup,
                    icon: const Icon(Icons.group_add),
                    label: const Text('Create Group'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return ListTile(
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
                );
              },
            ),
      floatingActionButton: _chats.isNotEmpty
          ? FloatingActionButton(
              onPressed: _startNewChat,
              child: const Icon(Icons.chat),
            )
          : null,
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