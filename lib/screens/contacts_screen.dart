import 'package:flutter/material.dart';
import '../models/contact.dart';
import 'edit_contact_screen.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<Contact> _contacts = [
    Contact(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john@example.com',
      phone: '+1 234 567 8900',
      company: 'Tech Corp',
      jobTitle: 'Software Engineer',
    ),
    Contact(
      id: '2',
      firstName: 'Jane',
      lastName: 'Smith',
      email: 'jane@example.com',
      phone: '+1 234 567 8901',
      company: 'Design Studio',
      jobTitle: 'UX Designer',
    ),
    Contact(
      id: '3',
      firstName: 'Mike',
      lastName: 'Johnson',
      email: 'mike@example.com',
      phone: '+1 234 567 8902',
      company: 'Marketing Inc',
      jobTitle: 'Marketing Manager',
    ),
    Contact(
      id: '4',
      firstName: 'Sarah',
      lastName: 'Williams',
      email: 'sarah@example.com',
      phone: '+1 234 567 8903',
      company: 'Finance Co',
      jobTitle: 'Financial Analyst',
    ),
    Contact(
      id: '5',
      firstName: 'David',
      lastName: 'Brown',
      email: 'david@example.com',
      phone: '+1 234 567 8904',
      company: 'Consulting Group',
      jobTitle: 'Business Consultant',
    ),
  ];

  void _handleEditContact(Contact contact) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    
    if (isWeb) {
      showDialog(
        context: context,
        builder: (context) => EditContactScreen(
          contact: contact,
          onSave: (updatedContact) {
            setState(() {
              final index = _contacts.indexOf(contact);
              if (index != -1) {
                _contacts[index] = updatedContact;
              }
            });
          },
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditContactScreen(
            contact: contact,
            onSave: (updatedContact) {
              setState(() {
                final index = _contacts.indexOf(contact);
                if (index != -1) {
                  _contacts[index] = updatedContact;
                }
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    contact.initials,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 20,
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
                        contact.fullName,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        contact.email,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                      if (contact.company != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          '${contact.company}${contact.jobTitle != null ? ' • ${contact.jobTitle}' : ''}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                      if (contact.phone != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          contact.phone!,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.message_outlined),
                      onPressed: () {
                        // TODO: Implement message functionality
                      },
                      tooltip: 'Send Message',
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () => _handleEditContact(contact),
                      tooltip: 'Edit Contact',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
} 