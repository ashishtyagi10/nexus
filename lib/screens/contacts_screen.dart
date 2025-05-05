import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact.dart';
import 'edit_contact_screen.dart';
import 'contact_detail_screen.dart';

class ContactsScreen extends StatefulWidget {
  final bool multiSelect;
  const ContactsScreen({super.key, this.multiSelect = false});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final List<Contact> _contacts = [
    Contact(
      id: '1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phone: '+1 234 567 8900',
      mobile: '+1 234 567 8901',
      company: 'Example Corp',
      jobTitle: 'Software Engineer',
      dateOfBirth: DateTime(1990, 1, 1),
      notes: 'Met at conference',
      streetAddress: '123 Main St',
      city: 'New York',
      state: 'NY',
      postalCode: '10001',
      country: 'USA',
      linkedIn: 'linkedin.com/in/johndoe',
      twitter: '@johndoe',
      facebook: 'facebook.com/johndoe',
      instagram: '@johndoe',
      website: 'johndoe.com',
      department: 'Engineering',
      assistantName: 'Jane Smith',
      assistantPhone: '+1 234 567 8902',
      relationship: 'Colleague',
      tags: ['Tech', 'Engineering'],
    ),
    Contact(
      id: '2',
      firstName: 'Jane',
      lastName: 'Smith',
      email: 'jane.smith@example.com',
      phone: '+1 234 567 8903',
      mobile: '+1 234 567 8904',
      company: 'Tech Corp',
      jobTitle: 'CTO',
      dateOfBirth: DateTime(1985, 5, 15),
      notes: 'Former colleague',
      streetAddress: '456 Tech Ave',
      city: 'San Francisco',
      state: 'CA',
      postalCode: '94105',
      country: 'USA',
      linkedIn: 'linkedin.com/in/janesmith',
      twitter: '@janesmith',
      facebook: 'facebook.com/janesmith',
      instagram: '@janesmith',
      website: 'janesmith.com',
      department: 'Technology',
      assistantName: 'Bob Johnson',
      assistantPhone: '+1 234 567 8905',
      relationship: 'Professional',
      tags: ['Tech', 'Partner'],
    ),
    Contact(
      id: '3',
      firstName: 'Bob',
      lastName: 'Johnson',
      email: 'bob.johnson@example.com',
      phone: '+1 234 567 8906',
      mobile: '+1 234 567 8907',
      company: 'Design Studio',
      jobTitle: 'Creative Director',
      dateOfBirth: DateTime(1990, 10, 20),
      notes: 'Met at design conference',
      streetAddress: '789 Design Blvd',
      city: 'Los Angeles',
      state: 'CA',
      postalCode: '90001',
      country: 'USA',
      linkedIn: 'linkedin.com/in/bobjohnson',
      twitter: '@bobjohnson',
      facebook: 'facebook.com/bobjohnson',
      instagram: '@bobjohnson',
      website: 'bobjohnson.com',
      department: 'Creative',
      assistantName: 'Alice Brown',
      assistantPhone: '+1 234 567 8908',
      relationship: 'Friend',
      tags: ['Design', 'Creative'],
    ),
  ];

  final Set<Contact> _selected = {};

  void _handleEditContact(Contact contact) async {
    final result = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(
        builder: (context) => EditContactScreen(contact: contact),
      ),
    );

    if (result != null) {
      setState(() {
        final index = _contacts.indexWhere((c) => c.id == result.id);
        if (index != -1) {
          _contacts[index] = result;
        }
      });
    }
  }

  void _handleAddContact() async {
    final newContact = Contact(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      firstName: '',
      lastName: '',
      email: '',
    );

    final result = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(
        builder: (context) => EditContactScreen(contact: newContact),
      ),
    );

    if (result != null) {
      setState(() {
        _contacts.add(result);
      });
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch phone dialer')),
        );
      }
    }
  }

  Future<void> _sendTextMessage(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch messaging app')),
        );
      }
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email app')),
        );
      }
    }
  }

  Widget _buildPhoneActions(String phoneNumber, {String? email}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.phone),
          tooltip: 'Call',
          onPressed: () => _makePhoneCall(phoneNumber),
          iconSize: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.message),
          tooltip: 'Text',
          onPressed: () => _sendTextMessage(phoneNumber),
          iconSize: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        if (email != null) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.email),
            tooltip: 'Email',
            onPressed: () => _sendEmail(email),
            iconSize: 20,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Contacts',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _contacts.isEmpty
                    ? const Center(
                        child: Text('No contacts yet'),
                      )
                    : ListView.builder(
                        itemCount: _contacts.length,
                        itemBuilder: (context, index) {
                          final contact = _contacts[index];
                          return GestureDetector(
                            onTap: () {
                              if (widget.multiSelect) {
                                setState(() {
                                  if (_selected.contains(contact)) {
                                    _selected.remove(contact);
                                  } else {
                                    _selected.add(contact);
                                  }
                                });
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactDetailScreen(
                                      contact: contact,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              color: widget.multiSelect &&
                                      _selected.contains(contact)
                                  ? Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.2)
                                  : null,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      child: Text(
                                        contact.initials,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            contact.fullName,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          if (contact.jobTitle != null || contact.company != null)
                                            Text(
                                              [
                                                if (contact.jobTitle != null) contact.jobTitle,
                                                if (contact.company != null) 'at ${contact.company}',
                                              ].join(' '),
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          if (contact.mobile != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    contact.mobile!,
                                                    style: TextStyle(
                                                      color: Colors.grey[600],
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 2),
                                                  _buildPhoneActions(contact.mobile!, email: contact.email),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (widget.multiSelect)
                                      Checkbox(
                                        value: _selected.contains(contact),
                                        onChanged: (val) {
                                          setState(() {
                                            if (val == true) {
                                              _selected.add(contact);
                                            } else {
                                              _selected.remove(contact);
                                            }
                                          });
                                        },
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
              if (widget.multiSelect)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _selected.isNotEmpty
                              ? () => Navigator.pop(context, _selected.toList())
                              : null,
                          child: const Text('Done'),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      floatingActionButton: widget.multiSelect
          ? null
          : FloatingActionButton(
              onPressed: _handleAddContact,
              tooltip: 'Add Contact',
              child: const Icon(Icons.add),
            ),
    );
  }

  Widget _buildContactInfo({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          Expanded(
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
