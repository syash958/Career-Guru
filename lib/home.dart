import 'package:chat_gpt_02/constants/string_constants.dart';
import 'package:chat_gpt_02/pages/Details.dart';
import 'package:chat_gpt_02/pages/ask_ai.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  String title = 'Careers';
  List<Widget> pages = [
    const Details(),
    const AskAI()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      appBar: AppBar(title: Text(title)),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 40),
          children: [
            ListTile(
              title: const Text(Screens.automateResults),
              selected: selectedIndex == 0,
              onTap: () {
                setState(() {
                  title = Screens.automateResults;
                  selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(Screens.askAi),
              selected: selectedIndex == 1,
              onTap: () {
                setState(() {
                  title = Screens.askAi;
                  selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
