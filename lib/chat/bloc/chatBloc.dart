import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class ChatBlocEvent extends Equatable {
  ChatBlocEvent([List props = const []]) : super(props);
}

class ChatSendEvent extends ChatBlocEvent {
  final String chatData;

  ChatSendEvent({@required this.chatData})
      : assert(chatData != null),
        super([chatData]);
}

class ChatNormal extends ChatBlocEvent {}

abstract class ChatBlocState extends Equatable {
  ChatBlocState([List props = const []]) : super(props);
}

class ChatReceiveMsg extends ChatBlocState {
  final String chatData;

  ChatReceiveMsg({@required this.chatData})
      : assert(chatData != null),
        super([chatData]);
}

class ChatNormalState extends ChatBlocState {}

class ChatBloc extends Bloc<ChatBlocEvent, ChatBlocState> {

  @override
  ChatBlocState get initialState => ChatNormalState();

  @override
  Stream<ChatBlocState> mapEventToState(ChatBlocEvent event) async* {
    if (event is ChatSendEvent) {
      yield ChatReceiveMsg(chatData: event.chatData);
    } else {
      yield ChatNormalState();
    }
  }
}
