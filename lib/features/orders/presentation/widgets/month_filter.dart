import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthFilter extends StatelessWidget {
  final String selectedMonth;
  final List<String> availableMonths;
  final ValueChanged<String> onMonthSelected;

  const MonthFilter({
    super.key,
    required this.selectedMonth,
    required this.availableMonths,
    required this.onMonthSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedMonth,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          elevation: 2,
          borderRadius: BorderRadius.circular(8),
          style: GoogleFonts.workSans(
            color: Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          items: availableMonths.map<DropdownMenuItem<String>>((String month) {
            return DropdownMenuItem<String>(
              value: month,
              child: Text(month),
            );
          }).toList(),
          onChanged: (String? value) {
            if (value != null) {
              onMonthSelected(value);
            }
          },
        ),
      ),
    );
  }
}
