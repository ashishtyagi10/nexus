import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/contact.dart';

class EditContactScreen extends StatefulWidget {
  final Contact contact;
  final Function(Contact)? onSave;

  const EditContactScreen({
    super.key,
    required this.contact,
    this.onSave,
  });

  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _mobileController;
  late final TextEditingController _companyController;
  late final TextEditingController _jobTitleController;
  late final TextEditingController _notesController;
  late final TextEditingController _streetAddressController;
  late final TextEditingController _cityController;
  late final TextEditingController _stateController;
  late final TextEditingController _postalCodeController;
  late final TextEditingController _countryController;
  late final TextEditingController _linkedInController;
  late final TextEditingController _twitterController;
  late final TextEditingController _facebookController;
  late final TextEditingController _instagramController;
  late final TextEditingController _websiteController;
  late final TextEditingController _departmentController;
  late final TextEditingController _assistantNameController;
  late final TextEditingController _assistantPhoneController;
  late final TextEditingController _relationshipController;
  late final TextEditingController _tagsController;

  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  DateTime? _selectedAnniversary;
  final _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.contact.firstName);
    _lastNameController = TextEditingController(text: widget.contact.lastName);
    _emailController = TextEditingController(text: widget.contact.email);
    _phoneController = TextEditingController(text: widget.contact.phone);
    _mobileController = TextEditingController(text: widget.contact.mobile);
    _companyController = TextEditingController(text: widget.contact.company);
    _jobTitleController = TextEditingController(text: widget.contact.jobTitle);
    _notesController = TextEditingController(text: widget.contact.notes);
    _streetAddressController = TextEditingController(text: widget.contact.streetAddress);
    _cityController = TextEditingController(text: widget.contact.city);
    _stateController = TextEditingController(text: widget.contact.state);
    _postalCodeController = TextEditingController(text: widget.contact.postalCode);
    _countryController = TextEditingController(text: widget.contact.country);
    _linkedInController = TextEditingController(text: widget.contact.linkedIn);
    _twitterController = TextEditingController(text: widget.contact.twitter);
    _facebookController = TextEditingController(text: widget.contact.facebook);
    _instagramController = TextEditingController(text: widget.contact.instagram);
    _websiteController = TextEditingController(text: widget.contact.website);
    _departmentController = TextEditingController(text: widget.contact.department);
    _assistantNameController = TextEditingController(text: widget.contact.assistantName);
    _assistantPhoneController = TextEditingController(text: widget.contact.assistantPhone);
    _relationshipController = TextEditingController(text: widget.contact.relationship);
    _tagsController = TextEditingController(text: widget.contact.tags?.join(', '));
    _selectedDate = widget.contact.dateOfBirth;
    _selectedAnniversary = widget.contact.anniversary;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _mobileController.dispose();
    _companyController.dispose();
    _jobTitleController.dispose();
    _notesController.dispose();
    _streetAddressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _postalCodeController.dispose();
    _countryController.dispose();
    _linkedInController.dispose();
    _twitterController.dispose();
    _facebookController.dispose();
    _instagramController.dispose();
    _websiteController.dispose();
    _departmentController.dispose();
    _assistantNameController.dispose();
    _assistantPhoneController.dispose();
    _relationshipController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isAnniversary) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: (isAnniversary ? _selectedAnniversary : _selectedDate) ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: isAnniversary ? DateTime.now().add(const Duration(days: 365 * 100)) : DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isAnniversary) {
          _selectedAnniversary = picked;
        } else {
          _selectedDate = picked;
        }
      });
    }
  }

  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedContact = widget.contact.copyWith(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        phone: _phoneController.text.isEmpty ? null : _phoneController.text,
        mobile: _mobileController.text.isEmpty ? null : _mobileController.text,
        company: _companyController.text.isEmpty ? null : _companyController.text,
        jobTitle: _jobTitleController.text.isEmpty ? null : _jobTitleController.text,
        dateOfBirth: _selectedDate,
        anniversary: _selectedAnniversary,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        streetAddress: _streetAddressController.text.isEmpty ? null : _streetAddressController.text,
        city: _cityController.text.isEmpty ? null : _cityController.text,
        state: _stateController.text.isEmpty ? null : _stateController.text,
        postalCode: _postalCodeController.text.isEmpty ? null : _postalCodeController.text,
        country: _countryController.text.isEmpty ? null : _countryController.text,
        linkedIn: _linkedInController.text.isEmpty ? null : _linkedInController.text,
        twitter: _twitterController.text.isEmpty ? null : _twitterController.text,
        facebook: _facebookController.text.isEmpty ? null : _facebookController.text,
        instagram: _instagramController.text.isEmpty ? null : _instagramController.text,
        website: _websiteController.text.isEmpty ? null : _websiteController.text,
        department: _departmentController.text.isEmpty ? null : _departmentController.text,
        assistantName: _assistantNameController.text.isEmpty ? null : _assistantNameController.text,
        assistantPhone: _assistantPhoneController.text.isEmpty ? null : _assistantPhoneController.text,
        relationship: _relationshipController.text.isEmpty ? null : _relationshipController.text,
        tags: _tagsController.text.isEmpty ? null : _tagsController.text.split(',').map((e) => e.trim()).toList(),
      );

      if (widget.onSave != null) {
        widget.onSave!(updatedContact);
      }
      
      Navigator.pop(context, updatedContact);
    }
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;
    
    if (isWeb) {
      return Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: _buildForm(),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.firstName.isEmpty ? 'Add Contact' : 'Edit Contact'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _handleSave,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSection('Basic Information', [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter email';
                }
                if (!value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _mobileController,
                    decoration: const InputDecoration(
                      labelText: 'Mobile',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _companyController,
                    decoration: const InputDecoration(
                      labelText: 'Company',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _jobTitleController,
                    decoration: const InputDecoration(
                      labelText: 'Job Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context, false),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        _selectedDate != null
                            ? _dateFormat.format(_selectedDate!)
                            : '',
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context, true),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Anniversary',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        _selectedAnniversary != null
                            ? _dateFormat.format(_selectedAnniversary!)
                            : '',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
          
          _buildSection('Address', [
            TextFormField(
              controller: _streetAddressController,
              decoration: const InputDecoration(
                labelText: 'Street Address',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _cityController,
                    decoration: const InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _stateController,
                    decoration: const InputDecoration(
                      labelText: 'State/Province',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _postalCodeController,
                    decoration: const InputDecoration(
                      labelText: 'Postal Code',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _countryController,
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
          ]),

          _buildSection('Social Media', [
            TextFormField(
              controller: _linkedInController,
              decoration: const InputDecoration(
                labelText: 'LinkedIn',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _twitterController,
              decoration: const InputDecoration(
                labelText: 'Twitter',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _facebookController,
              decoration: const InputDecoration(
                labelText: 'Facebook',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _instagramController,
              decoration: const InputDecoration(
                labelText: 'Instagram',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
          ]),

          _buildSection('Additional Information', [
            TextFormField(
              controller: _websiteController,
              decoration: const InputDecoration(
                labelText: 'Website',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.link),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _departmentController,
              decoration: const InputDecoration(
                labelText: 'Department',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _assistantNameController,
                    decoration: const InputDecoration(
                      labelText: 'Assistant Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _assistantPhoneController,
                    decoration: const InputDecoration(
                      labelText: 'Assistant Phone',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _relationshipController,
              decoration: const InputDecoration(
                labelText: 'Relationship',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tagsController,
              decoration: const InputDecoration(
                labelText: 'Tags (comma separated)',
                border: OutlineInputBorder(),
                helperText: 'Enter tags separated by commas',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ]),

          if (MediaQuery.of(context).size.width > 600)
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _handleSave,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
} 