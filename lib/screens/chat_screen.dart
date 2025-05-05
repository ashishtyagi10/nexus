import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'contacts_screen.dart';
import 'chat_detail_screen.dart';

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
        builder: (context) => const ContactsScreen(multiSelect: true),
      ),
    ).then((selectedContacts) {
      if (selectedContacts != null &&
          selectedContacts is List<Contact> &&
          selectedContacts.isNotEmpty) {
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
              if (_groupNameController.text.isNotEmpty &&
                  _selectedContacts.isNotEmpty) {
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
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline,
                            size: 64,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 16),
                          Text(
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
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              child: Text(
                                chat.isGroup
                                    ? 'G'
                                    : (chat.name.isNotEmpty
                                        ? chat.name[0]
                                        : '?'),
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ChatDetailScreen(chat: chat),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (context) => SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Start Chat'),
                    onTap: () {
                      Navigator.pop(context);
                      _startNewChat();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.group_add),
                    title: const Text('Create Group'),
                    onTap: () {
                      Navigator.pop(context);
                      _createNewGroup();
                    },
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
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
