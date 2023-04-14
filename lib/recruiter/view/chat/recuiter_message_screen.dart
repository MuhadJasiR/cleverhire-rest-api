import 'package:cleverhire/core/constraints/constraints.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class RecruiterMessageScreen extends StatefulWidget {
  RecruiterMessageScreen({super.key});

  @override
  State<RecruiterMessageScreen> createState() => _RecruiterMessageScreenState();
}

class _RecruiterMessageScreenState extends State<RecruiterMessageScreen> {
  final List<Message> message = [
    Message(
        text: "hy",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: "Hello",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true),
    Message(
        text: "how are you",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: false),
    Message(
        text: "Fine good",
        date: DateTime.now().subtract(const Duration(minutes: 1)),
        isSentByMe: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              child: Image.asset(
                "assets/profile.png",
              ),
            ),
            kWidth(10),
            Column(
              children: const [
                Text(
                  "Jasir",
                ),
                Text(
                  "Online",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: GroupedListView<Message, DateTime>(
            elements: message,
            reverse: true,
            order: GroupedListOrder.DESC,
            floatingHeader: true,
            groupBy: (message) => DateTime(
              message.date.year,
              message.date.month,
              message.date.day,
            ),
            groupHeaderBuilder: (Message message) => SizedBox(
              height: 35,
              child: Center(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(DateFormat.yMMMd().format(message.date)),
                  ),
                ),
              ),
            ),
            itemBuilder: (context, Message message) => Align(
              alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(message.text),
                ),
              ),
            ),
          )),
          Container(
              color: Colors.grey,
              child: TextField(
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Type something here"),
                onSubmitted: (value) {
                  final messages = Message(
                      text: value, date: DateTime.now(), isSentByMe: true);

                  setState(() {
                    message.add(messages);
                  });
                },
              ))
        ],
      ),
    );
  }
}

class Message {
  Message({required this.text, required this.date, required this.isSentByMe});
  String text;
  DateTime date;
  bool isSentByMe = false;
}
