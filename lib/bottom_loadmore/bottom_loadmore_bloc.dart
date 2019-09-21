import 'package:rxdart/rxdart.dart';

import 'loadmore_item.dart';

enum BlocState { loading, loaded }

class BottomLoadMoreBloc {
  List<LoadMoreItem> _listData = [];

  BehaviorSubject<List<LoadMoreItem>> _behaviorSubjectListItem;

  Observable<List<LoadMoreItem>> observableListItem;

  BlocState _blocState = BlocState.loading;

  BehaviorSubject<BlocState> _behaviorSubjectLoadState;

  Observable<BlocState> observableLoadState;

  BottomLoadMoreBloc() {
    _behaviorSubjectListItem = BehaviorSubject.seeded([]);
    observableListItem = _behaviorSubjectListItem.stream;

    _behaviorSubjectLoadState = BehaviorSubject.seeded(BlocState.loading);
    observableLoadState = _behaviorSubjectLoadState.stream;

    addData();
  }

  dispose() {
    _behaviorSubjectListItem.close();
    _behaviorSubjectLoadState.close();
  }

  generateList(int startIndex) => List.generate(10, (index) {
        return LoadMoreItem(
            username: 'index: ${startIndex + index}',
            status: 'status: ${startIndex + index}',
            imageUrl: 'https://picsum.photos/id/${startIndex + index}/500/500');
      });

  loadMore() {
    if (_blocState == BlocState.loaded) {
      _blocState = BlocState.loading;
      _behaviorSubjectLoadState.add(_blocState);
      Future.delayed(Duration(seconds: 5)).then((value) {
        addData();
      });
    }
  }

  addData() {
    _listData.addAll(generateList(_listData.length));

    _behaviorSubjectListItem.add(_listData);

    _blocState = BlocState.loaded;
    _behaviorSubjectLoadState.add(_blocState);
  }
}
