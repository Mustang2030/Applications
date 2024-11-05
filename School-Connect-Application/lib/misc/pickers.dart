import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime? initialDateTime;
  final Function(DateTime) onDateTimeSelected; // Callback to return DateTime

  const DateTimePicker({
    super.key,
    this.initialDateTime,
    required this.onDateTimeSelected,
  });

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDateTime ?? DateTime.now();
    _selectedTime = widget.initialDateTime != null
        ? TimeOfDay.fromDateTime(widget.initialDateTime!)
        : TimeOfDay.now();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    // Select Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });

      // Select Time
      final TimeOfDay? pickedTime = await showTimePicker(
        initialTime: _selectedTime,
        context: context,
      );

      if (pickedTime != null) {
        setState(() {
          _selectedTime = pickedTime;
        });

        // Call the callback with the selected DateTime
        widget.onDateTimeSelected(selectedDateTime);
      }
    }
  }

  DateTime get selectedDateTime {
    // Combine selected date and time into a single DateTime
    return DateTime(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      _selectedTime.hour,
      _selectedTime.minute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Selected: ${selectedDateTime.toIso8601String()}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Center(
            child: SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F2E34),
                ),
                onPressed: () => _selectDateTime(context),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white),
                    SizedBox(width: 5),
                    Text(
                      'Select Date & Time',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
