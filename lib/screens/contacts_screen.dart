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
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                        child: Text(
                                          contact.initials,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.onPrimary,
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
                                            if (contact.company != null)
                                              Text(
                                                contact.company!,
                                                style: TextStyle(
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.edit),
                                        tooltip: 'Edit Contact',
                                        onPressed: () => _handleEditContact(contact),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  _buildContactInfo(
                                    icon: Icons.email,
                                    label: 'Email',
                                    value: contact.email,
                                  ),
                                  if (contact.phone != null)
                                    _buildContactInfo(
                                      icon: Icons.phone,
                                      label: 'Phone',
                                      value: contact.phone!,
                                    ),
                                  if (contact.mobile != null)
                                    _buildContactInfo(
                                      icon: Icons.phone_android,
                                      label: 'Mobile',
                                      value: contact.mobile!,
                                    ),
                                  if (contact.jobTitle != null)
                                    _buildContactInfo(
                                      icon: Icons.work,
                                      label: 'Job Title',
                                      value: contact.jobTitle!,
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add contact
        },
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