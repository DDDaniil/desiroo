import 'package:flutter/material.dart';

class StyledFilterDropdown extends StatefulWidget {
  const StyledFilterDropdown({
    super.key,
    required this.dropdownValue,
    required this.onDropdownChanged,
  });

  final String dropdownValue;
  final Function onDropdownChanged;

  @override
  State<StyledFilterDropdown> createState() => _StyledFilterDropdownState();
}

class _StyledFilterDropdownState extends State<StyledFilterDropdown> {
  String dropdownValue = 'Low';

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      ),
      value: widget.dropdownValue,
      items: <String>['Low', 'Medium', 'High']
            .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }).toList(),
      onChanged: (String? newValue) {
        widget.onDropdownChanged(newValue!);
        setState(() {
          dropdownValue = newValue;
        });
      },
    );
  }
}
