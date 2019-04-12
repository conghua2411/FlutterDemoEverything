import 'package:flutter/material.dart';
import 'package:flutter_app/widgetDemo/bloc/memriseBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Memrise extends StatefulWidget {
  @override
  State createState() => MemriseState();
}

class MemriseState extends State<Memrise> {
  final _memriseBloc = MemriseBloc();
  bool volume = true;

  int score = 0;

  @override
  void dispose() {
    _memriseBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderTree(
        blocProviders: [
          BlocProvider<MemriseBloc>(bloc: _memriseBloc),
        ],
        child: BlocBuilder(
            bloc: _memriseBloc,
            builder: (BuildContext context, MemriseBlocState state) {
              if (state is AnswerClickState) {
                _handleAnswer(state.answerData);
              }

              return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(
                        volume ? Icons.volume_up : Icons.volume_off,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          volume = !volume;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Center(
                          child: Text(
                            '$score',
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                body: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.volume_up,
                              size: 150.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment(1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Icon(
                              Icons.volume_up,
                              size: 50.0,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Pick the correct answer for the above'),
                      ),
                    ),
                    Container(
                      child: AnswerWidget(answer: [
                        'hello1',
                        'hello2',
                        'hello3',
                        'hello4',
                      ]),
                    )
                  ],
                ),
              );
            }));
  }

  Future _handleAnswer(String answerData) async {
    int answerScore = 0;
    switch (answerData) {
      case 'hello1':
        answerScore = 1;
        break;
      case 'hello2':
        answerScore = 2;
        break;
      case 'hello3':
        answerScore = 3;
        break;
      case 'hello4':
        answerScore = 4;
        break;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        score += answerScore;
      });
      _memriseBloc.dispatch(NormalMemrise());
    });
  }
}

class AnswerWidget extends StatelessWidget {
  final List<String> answer;

  AnswerWidget({this.answer}) : super();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
            mainAxisSize: MainAxisSize.max,
            children: List.generate(2, (index) {
              if (index == 0) {
                return AnswerColumn(
                    answers: answer.sublist(0, (answer.length / 2).round()));
              } else {
                return AnswerColumn(
                    answers: answer.sublist(
                        (answer.length / 2).round(), answer.length));
              }
            })),
      ),
    );
  }
}

class AnswerColumn extends StatelessWidget {
  final List<String> answers;

  AnswerColumn({this.answers}) : super();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(answers.length, (index) {
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  BlocProvider.of<MemriseBloc>(context)
                      .dispatch(AnswerClick(answerData: answers[index]));
                },
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Container(
                    color: Colors.primaries[index % Colors.primaries.length],
                    child: Center(
                        child: Text(
                      answers[index],
                      style: TextStyle(fontSize: 24.0),
                    )),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

typedef AnswerClickCallback = void Function(int index);
