import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact.dart';
import 'edit_contact_screen.dart';

class ContactDetailScreen extends StatefulWidget {
  final Contact contact;

  const ContactDetailScreen({super.key, required this.contact});

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  late Contact _contact;

  @override
  void initState() {
    super.initState();
    _contact = widget.contact;
  }

  void _handleEditContact() async {
    final result = await Navigator.push<Contact>(
      context,
      MaterialPageRoute(
        builder: (context) => EditContactScreen(contact: _contact),
      ),
    );

    if (result != null) {
      setState(() {
        _contact = result;
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

  Future<void> _openUrl(String url) async {
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'https://$url';
    }

    final Uri launchUri = Uri.parse(url);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open URL')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contact.fullName),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _handleEditContact,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with name and avatar
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    _contact.initials,
                    style: TextStyle(
                      fontSize: 36,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _contact.fullName,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_contact.jobTitle != null && _contact.company != null)
                        Text(
                          '${_contact.jobTitle} at ${_contact.company}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Contact Actions
            Wrap(
              spacing: 16,
              children: [
                if (_contact.mobile != null)
                  _buildActionButton(
                    icon: Icons.phone,
                    label: 'Call',
                    onTap: () => _makePhoneCall(_contact.mobile!),
                  ),
                if (_contact.mobile != null)
                  _buildActionButton(
                    icon: Icons.message,
                    label: 'Text',
                    onTap: () => _sendTextMessage(_contact.mobile!),
                  ),
                _buildActionButton(
                  icon: Icons.email,
                  label: 'Email',
                  onTap: () => _sendEmail(_contact.email),
                ),
              ],
            ),

            const SizedBox(height: 24),
            const Divider(),

            // Contact Details Section
            _buildSectionTitle('Contact Details'),

            if (_contact.phone != null)
              _buildDetailItem(
                icon: Icons.phone,
                label: 'Phone',
                value: _contact.phone!,
                trailing: IconButton(
                  icon: const Icon(Icons.call),
                  onPressed: () => _makePhoneCall(_contact.phone!),
                  iconSize: 20,
                ),
              ),

            if (_contact.mobile != null)
              _buildDetailItem(
                icon: Icons.smartphone,
                label: 'Mobile',
                value: _contact.mobile!,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.call),
                      onPressed: () => _makePhoneCall(_contact.mobile!),
                      iconSize: 20,
                    ),
                    IconButton(
                      icon: const Icon(Icons.message),
                      onPressed: () => _sendTextMessage(_contact.mobile!),
                      iconSize: 20,
                    ),
                  ],
                ),
              ),

            _buildDetailItem(
              icon: Icons.email,
              label: 'Email',
              value: _contact.email,
              trailing: IconButton(
                icon: const Icon(Icons.email),
                onPressed: () => _sendEmail(_contact.email),
                iconSize: 20,
              ),
            ),

            if (_contact.dateOfBirth != null)
              _buildDetailItem(
                icon: Icons.cake,
                label: 'Birthday',
                value:
                    '${_contact.dateOfBirth!.day}/${_contact.dateOfBirth!.month}/${_contact.dateOfBirth!.year}',
              ),

            const SizedBox(height: 16),
            const Divider(),

            // Work Details
            if (_contact.company != null ||
                _contact.jobTitle != null ||
                _contact.department != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Work'),
                  if (_contact.company != null)
                    _buildDetailItem(
                      icon: Icons.business,
                      label: 'Company',
                      value: _contact.company!,
                    ),
                  if (_contact.jobTitle != null)
                    _buildDetailItem(
                      icon: Icons.work,
                      label: 'Job Title',
                      value: _contact.jobTitle!,
                    ),
                  if (_contact.department != null)
                    _buildDetailItem(
                      icon: Icons.group,
                      label: 'Department',
                      value: _contact.department!,
                    ),
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),

            // Address
            if (_contact.streetAddress != null || _contact.city != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Address'),
                  ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_contact.streetAddress != null)
                          Text(
                            _contact.streetAddress!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        if (_contact.city != null &&
                            _contact.state != null &&
                            _contact.postalCode != null)
                          Text(
                            '${_contact.city}, ${_contact.state} ${_contact.postalCode}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        if (_contact.country != null) 
                          Text(
                            _contact.country!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.map),
                      onPressed: () {
                        // Open map with address
                        final address = [
                          _contact.streetAddress,
                          _contact.city,
                          _contact.state,
                          _contact.postalCode,
                          _contact.country,
                        ].where((item) => item != null).join(', ');

                        launchUrl(
                            Uri.parse('https://maps.google.com/?q=$address'),
                            mode: LaunchMode.externalApplication);
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),

            // Social Media
            if (_contact.linkedIn != null ||
                _contact.twitter != null ||
                _contact.facebook != null ||
                _contact.instagram != null ||
                _contact.website != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Online Profiles'),
                  if (_contact.website != null)
                    _buildDetailItem(
                      icon: Icons.language,
                      label: 'Website',
                      value: _contact.website!,
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => _openUrl(_contact.website!),
                        iconSize: 20,
                      ),
                    ),
                  if (_contact.linkedIn != null)
                    _buildDetailItem(
                      icon: Icons.link,
                      label: 'LinkedIn',
                      value: _contact.linkedIn!,
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => _openUrl(_contact.linkedIn!),
                        iconSize: 20,
                      ),
                    ),
                  if (_contact.twitter != null)
                    _buildDetailItem(
                      icon: Icons.link,
                      label: 'Twitter',
                      value: _contact.twitter!,
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => _openUrl(
                            'twitter.com/${_contact.twitter!.replaceAll('@', '')}'),
                        iconSize: 20,
                      ),
                    ),
                  if (_contact.facebook != null)
                    _buildDetailItem(
                      icon: Icons.link,
                      label: 'Facebook',
                      value: _contact.facebook!,
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => _openUrl(_contact.facebook!),
                        iconSize: 20,
                      ),
                    ),
                  if (_contact.instagram != null)
                    _buildDetailItem(
                      icon: Icons.link,
                      label: 'Instagram',
                      value: _contact.instagram!,
                      trailing: IconButton(
                        icon: const Icon(Icons.open_in_new),
                        onPressed: () => _openUrl(
                            'instagram.com/${_contact.instagram!.replaceAll('@', '')}'),
                        iconSize: 20,
                      ),
                    ),
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),

            // Notes
            if (_contact.notes != null && _contact.notes!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Notes'),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      _contact.notes!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                ],
              ),

            // Tags
            if (_contact.tags != null && _contact.tags!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('Tags'),
                  Wrap(
                    spacing: 8,
                    children: _contact.tags!
                        .map((tag) => Chip(
                              label: Text(tag),
                            ))
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      trailing: trailing,
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
