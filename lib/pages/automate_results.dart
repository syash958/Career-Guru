import 'package:chat_gpt_02/widgets/chatmessage.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AutomateResults extends StatefulWidget {
  const AutomateResults({super.key, required this.requestString});
  final String requestString;

  @override
  State<AutomateResults> createState() => _AutomateResultsState();
}

class _AutomateResultsState extends State<AutomateResults> {
  late OpenAI? chatGPT;
  bool _isLoading = true;

  String res = 'Generating the results. Please wait...';
  void _sendMessage() async {
    ChatMessage message = ChatMessage(
      text: widget.requestString,
      sender: "User",
    );

    final request =
        CompleteText(prompt: message.text, model: kTranslateModelV3);

    final response = await chatGPT!.onCompleteText(request: request);
    setState(() {
      res = response!.choices[0].text;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    chatGPT = OpenAI.instance.build(
      token: dotenv.env["API_KEY"],
      baseOption: HttpSetup(receiveTimeout: 100000),
    );
    _sendMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _isLoading
              ? Container()
              : const Text(
                  "Yay!! your wait is now over. Your automated results are generated according to latest trends.",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
          const SizedBox(height: 8),
          Text(
            res,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
