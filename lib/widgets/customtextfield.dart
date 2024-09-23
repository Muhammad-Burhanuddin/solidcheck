import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final Color borderColor;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.borderColor = const Color(0xFFC9C9C9),
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late Color currentFillColor;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    currentFillColor = const Color(0xFFFAF9F9);
    focusNode = FocusNode();

    // Listen to focus changes
    focusNode.addListener(() {
      setState(() {
        currentFillColor =
            focusNode.hasFocus ? Colors.white : const Color(0xFFFAF9F9);
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose(); // Dispose of the FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: focusNode, // Attach the FocusNode
      style: const TextStyle(color: Colors.black, fontSize: 14),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: widget.borderColor, width: 1.0),
        ),
        fillColor: currentFillColor,
        filled: true,
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String labelText;
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final Color borderColor;
  final Color fillColor;

  const CustomDropdown({
    Key? key,
    required this.labelText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.borderColor = const Color(0xFFC9C9C9),
    this.fillColor = const Color(0xFFFAF9F9),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Color(0xFFFAF9F9)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        fillColor: fillColor,
        filled: true,
      ),
      items: items,
      onChanged: onChanged,
      dropdownColor: Colors.white, // Dropdown items background color
      style: const TextStyle(color: Colors.black), // Style of the selected item
    );
  }
}
