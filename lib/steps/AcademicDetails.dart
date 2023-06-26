// ignore: file_names
import 'package:flutter/material.dart';

class AcademicDetails extends StatelessWidget {
  AcademicDetails(
      {Key? key,
      required this.classController,
      required this.favSubject,
      required this.onChanged,
      required this.formGlobalKey})
      : super(key: key);

  final TextEditingController classController;
  final String favSubject;
  final ValueChanged<String?> onChanged;
  final GlobalKey formGlobalKey;
  // List of items in our dropdown menu
  final List<String> subjects = [
    'Maths',
    'Biology',
    'Commerce',
    'Accounts',
    'Economics',
    'Coading',
    'Agriculture',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        children: [
          const SizedBox(height: 8),
          TextFormField(
            controller: classController,
            maxLength: 2,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the Class';
              } else if (int.parse(value) < 8 || int.parse(value) > 12) {
                return 'Please enter the Class in range 8-12';
              }
              return null;
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Class',
            ),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField(
              value: favSubject,
              icon: const Icon(Icons.keyboard_arrow_down),
              validator: (name) {
                if (name == null || name == "") {
                  return 'Select subject';
                } else {
                  return null;
                }
              },
              items: subjects.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: onChanged),
        ],
      ),
    );
  }
}
