import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/common/constants/color_constants.dart';
import 'package:flutter_app/presentation/widgets/app_drawer.dart';

const String _name = "Yao";

//Building Beautiful UIs with Flutter --- https://codelabs.developers.google.com/codelabs/flutter/index.html
class FriendlyChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorAppDarkGrey,
      drawer: AppDrawer(),
      body: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FriendlyChat"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: Container(
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200]!),
                ),
              )
            : null,
        child: Column(
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) => _messages[index],
                itemCount: _messages.length,
              ),
            ),
            const Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.isNotEmpty;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                    const InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                      child: Text("Send",
                          style: TextStyle(
                              color: _isComposing ? colorAppDarkGrey : null)),
                    )
                  : IconButton(
                icon: Icon(Icons.send,
                          color: _isComposing ? colorAppDarkGrey : null),
                      onPressed: _isComposing
                          ? () => _handleSubmitted(_textController.text)
                          : null,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    final ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        duration: const Duration(milliseconds: 700),
        vsync: this,
      ),
    );

    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }

  @override
  void dispose() {
    for (final ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({required this.text, required this.animationController});
  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: InkWell(
          onLongPress: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('LongTap'),
            ));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 14.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 12.0, top: 8.0),
                  child: CircleAvatar(
                      backgroundColor: colorAppDarkGrey,
                      child: Text(_name[0],
                          style: const TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 1.0)))),
                ),
                Flexible(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(_name,
                              style: Theme.of(context).textTheme.subtitle2),
//                        Container(
//                          margin: const EdgeInsets.only(top: 2.0),
//                          child: Text(text),
//                        ),
//                        Text("10:00 PM", style: TextStyle(color: Colors.lightBlue, fontSize: 8.0)),
                          Container(
                            constraints: const BoxConstraints(minWidth: 100),
                            child: Stack(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 58.0),
                                  child: Text(text),
                                ),
                                Positioned(
                                  bottom: 0.0,
                                  right: 0.0,
                                  child: Row(
                                    children: const <Widget>[
                                      Text("10:00 PM",
                                          style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 10.0,
                                          )),
//                                  SizedBox(width: 3.0),
//                                  Icon(
//                                    icon,
//                                    size: 12.0,
//                                    color: Colors.black38,
//                                  )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
