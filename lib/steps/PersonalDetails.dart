import 'package:flutter/material.dart';

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({
    Key? key,
    required this.nameController,
    required this.cityController,
    required this.formGlobalKey,
  }) : super(key: key);

  final GlobalKey formGlobalKey;
  final TextEditingController nameController;
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        children: [
          const SizedBox(height: 8),
          TextFormField(
            controller: nameController,
            validator: (name) {
              if (name == null || name == "") {
                return 'Enter name';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Full Name',
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: cityController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'City',
            ),
            validator: (city) {
              if (city == null || city == "") {
                return 'Enter city';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
