import 'package:flutter/material.dart';
// Add your necessary imports here (e.g., for calendar)
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  String _selectedService = 'Haircut';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Salon Booking'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Add Bookings'),
              Tab(text: 'View Bookings'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildAddBookingsTab(),
            _buildViewBookingsTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddBookingsTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Inside your _buildAddBookingsTab function
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Icon(Icons.calendar_today, color: Colors.blue),
                ],
              ),
            ),
          ),

          DropdownButton<String>(
            value: _selectedService,
            onChanged: (String? newValue) {
              setState(() {
                _selectedService = newValue!;
              });
            },
            items: <String>['Haircut', 'Coloring', 'Styling']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          ElevatedButton(
            onPressed: () {
              // Handle booking logic
            },
            child: Text('Book Appointment'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Widget _buildViewBookingsTab() {
    return Center(
      child: Text('View your bookings here'),
      // You would typically use a ListView or similar widget to show the bookings
    );
  }
}
