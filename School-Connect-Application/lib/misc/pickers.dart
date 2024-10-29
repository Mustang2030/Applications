import 'package:flutter/material.dart';

// Date Picker
class DatePickerM extends StatefulWidget {
  final DateTime? initialDate;

  const DatePickerM({super.key, this.initialDate});

  @override
  State<DatePickerM> createState() => _DatePickerMState();
}

class _DatePickerMState extends State<DatePickerM> {
  DateTime selectedDateTime =
      DateTime.now(); // Initialize with current date and time
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '${_selectedDate.toLocal()}'.split(' ')[0],
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 50,
          width: 120,
          child: FloatingActionButton(
            hoverElevation: 0,
            backgroundColor: const Color(0xFF0F2E34),
            onPressed: () => _selectDate(context),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Select date',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Time Picker
class TimePicker extends StatefulWidget {
  final DateTime? initialDateTime; // Nullable DateTime

  const TimePicker({super.key, this.initialDateTime});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialDateTime != null
        ? TimeOfDay.fromDateTime(
            widget.initialDateTime!) // Use passed DateTime if not null
        : TimeOfDay.now(); // Default to current time if null
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          _selectedTime.format(context),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 50,
          width: 120,
          child: FloatingActionButton(
            hoverElevation: 0,
            backgroundColor: const Color(0xFF0F2E34),
            onPressed: () => _selectTime(context),
            child: const Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.lock_clock,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Select Time',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
