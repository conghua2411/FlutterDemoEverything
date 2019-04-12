import 'package:flutter/material.dart';
import 'package:flutter_app/chat/bloc/chatBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart';

class ChatScreen extends StatefulWidget {
  @override
  State createState() => ChatState();
}

class ChatState extends State<ChatScreen> {
  final _chatBloc = ChatBloc();

  List<String> chatDataList = List();

  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _chatBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
        blocProviders: [BlocProvider<ChatBloc>(bloc: _chatBloc)],
        child: BlocBuilder(
            bloc: _chatBloc,
            builder: (BuildContext context, ChatBlocState state) {
              if (state is ChatReceiveMsg) {
                _addMessage(state.chatData);
              }

              return Scaffold(
                appBar: AppBar(
                  title: Text('room name'),
                  centerTitle: true,
                  backgroundColor: Colors.amber,
                ),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return ChatCell(message: chatDataList[index]);
                          },
                          itemCount: chatDataList.length,
                          controller: _scrollController,
                        ),
                      ),
                    ),
                    InputChatWidget(),
                  ],
                ),
              );
            }));
  }

  Future _addMessage(String chatData) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        chatDataList.add(chatData);
      });

      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
      _chatBloc.dispatch(ChatNormal());
    });
  }
}

class ChatCell extends StatelessWidget {
  final String message;

  ChatCell({@required this.message}) : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 20.0, top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '$message',
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.yellow,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class InputChatWidget extends StatefulWidget {
  @override
  State createState() => InputChatState();
}

class InputChatState extends State<InputChatWidget> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Flexible(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              controller: _textController,
              decoration: InputDecoration(
                hintText: 'message',
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.yellow, width: 2.0),
                ),
                contentPadding: EdgeInsets.only(
                    left: 35.0, right: 20.0, top: 10.0, bottom: 10.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: Colors.yellow,
            ),
            onPressed: () {
              if (_textController.text != "") {
                BlocProvider.of<ChatBloc>(context)
                    .dispatch(ChatSendEvent(chatData: _textController.text));

                _textController.text = "";
              }
            },
          )
        ],
      ),
    );
  }
}
