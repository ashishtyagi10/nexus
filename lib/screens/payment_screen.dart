import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  final String? recipientPhone;

  const PaymentScreen({super.key, this.recipientPhone});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<PaymentTransaction> _recentTransactions = [
    PaymentTransaction(
      id: '1',
      recipient: 'John Doe',
      amount: 125.50,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: TransactionType.sent,
    ),
    PaymentTransaction(
      id: '2',
      recipient: 'Jane Smith',
      amount: 75.25,
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.received,
    ),
    PaymentTransaction(
      id: '3',
      recipient: 'Bob Johnson',
      amount: 250.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
      type: TransactionType.sent,
    ),
  ];

  @override
  void initState() {
    super.initState();
    // If a recipient phone number was provided, automatically show the send money dialog
    if (widget.recipientPhone != null) {
      // Use Future.delayed to ensure the context is available
      Future.delayed(Duration.zero, () {
        _showSendMoneyDialog(context);
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
                'Payments',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildBalanceCard(),
              const SizedBox(height: 24),
              const Text(
                'Recent Transactions',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _recentTransactions.isEmpty
                    ? const Center(
                        child: Text('No transactions yet'),
                      )
                    : ListView.builder(
                        itemCount: _recentTransactions.length,
                        itemBuilder: (context, index) {
                          return _buildTransactionItem(
                              _recentTransactions[index]);
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showSendMoneyDialog(context);
        },
        tooltip: 'Send Money',
        child: const Icon(Icons.attach_money),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      color: Theme.of(context).colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$1,250.75',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    _showSendMoneyDialog(context);
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Send'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _showRequestMoneyDialog(context);
                  },
                  icon: const Icon(Icons.request_page),
                  label: const Text('Request'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    foregroundColor: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionItem(PaymentTransaction transaction) {
    final bool isSent = transaction.type == TransactionType.sent;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isSent
              ? Colors.red.withOpacity(0.2)
              : Colors.green.withOpacity(0.2),
          child: Icon(
            isSent ? Icons.arrow_upward : Icons.arrow_downward,
            color: isSent ? Colors.red : Colors.green,
          ),
        ),
        title: Text(transaction.recipient),
        subtitle: Text(
          _formatDate(transaction.date),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: Text(
          '${isSent ? '-' : '+'}\$${transaction.amount.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: isSent ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    // Simple date formatting
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  void _showSendMoneyDialog(BuildContext context) {
    // Create text editing controllers for the form fields
    final recipientController = TextEditingController(
      // Pre-fill with the recipient phone number if available
      text: widget.recipientPhone ?? '',
    );
    final amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Money'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: recipientController,
                decoration: const InputDecoration(
                  labelText: 'Recipient',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment sent successfully')),
                );
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void _showRequestMoneyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Request Money'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'From',
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                // Show success message
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request sent successfully')),
                );
              },
              child: const Text('Request'),
            ),
          ],
        );
      },
    );
  }
}

class PaymentTransaction {
  final String id;
  final String recipient;
  final double amount;
  final DateTime date;
  final TransactionType type;

  PaymentTransaction({
    required this.id,
    required this.recipient,
    required this.amount,
    required this.date,
    required this.type,
  });
}

enum TransactionType {
  sent,
  received,
}
