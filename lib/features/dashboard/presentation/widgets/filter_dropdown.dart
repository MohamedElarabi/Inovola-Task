import 'package:flutter/material.dart';

class FilterDropdown extends StatelessWidget {
  const FilterDropdown({
    required this.selectedFilter,
    required this.onFilterChanged,
    super.key,
  });
  final String selectedFilter;
  final Function(String) onFilterChanged;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: selectedFilter,
            icon: const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black,
              size: 20,
            ),
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            dropdownColor: Colors.white,
            items: const [
              DropdownMenuItem(
                value: 'This month',
                child: Text('This month'),
              ),
              DropdownMenuItem(
                value: 'Last 7 days',
                child: Text('Last 7 days'),
              ),
              DropdownMenuItem(
                value: 'Last 30 days',
                child: Text('Last 30 days'),
              ),
              DropdownMenuItem(
                value: 'This year',
                child: Text('This year'),
              ),
              DropdownMenuItem(
                value: 'Last year',
                child: Text('Last year'),
              ),
              DropdownMenuItem(
                value: 'All time',
                child: Text('All time'),
              ),
            ],
            onChanged: (newValue) {
              if (newValue != null) {
                onFilterChanged(newValue);
              }
            },
          ),
        ),
      );
}
