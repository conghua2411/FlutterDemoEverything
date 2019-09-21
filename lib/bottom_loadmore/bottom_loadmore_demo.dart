import 'package:flutter/material.dart';

import 'bottom_loadmore_bloc.dart';
import 'loadmore_item.dart';

class BottomLoadMoreDemo extends StatefulWidget {
  @override
  State createState() => BottomLoadMoreState();
}

class BottomLoadMoreState extends State<BottomLoadMoreDemo> {
  BottomLoadMoreBloc _bottomLoadMoreBloc;

  @override
  void initState() {
    super.initState();
    _bottomLoadMoreBloc = BottomLoadMoreBloc();
  }

  @override
  void dispose() {
    _bottomLoadMoreBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom load more demo'),
      ),
      body: StreamBuilder<List<LoadMoreItem>>(
          initialData: [],
          stream: _bottomLoadMoreBloc.observableListItem,
          builder: (context, snapshot) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        _bottomLoadMoreBloc.loadMore();
                      }
                      return true;
                    },
                    child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(snapshot
                                                  .data[index].imageUrl))),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            'username: ${snapshot.data[index].username}'),
                                        Text(
                                            'status: ${snapshot.data[index].status}'),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                StreamBuilder<BlocState>(
                  initialData: BlocState.loading,
                  stream: _bottomLoadMoreBloc.observableLoadState,
                  builder: (context, snapshotState) {
                    switch (snapshotState.data) {
                      case BlocState.loading:
                        return Container(
                          child: CircularProgressIndicator(),
                        );
                      case BlocState.loaded:
                        return Container();
                      default:
                        return Container();
                    }
                  },
                ),
              ],
            );
          }),
    );
  }

  _buildList(List<LoadMoreItem> list) {
    return SliverList(
        delegate: SliverChildListDelegate([
      SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          return _buildItem(list[index]);
        }, childCount: list.length),
      ),
      Container(
        child: CircularProgressIndicator(),
      )
    ]));
  }

  _buildItem(LoadMoreItem item) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(image: NetworkImage(item.imageUrl))),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('username: ${item.username}'),
                  Text('status: ${item.status}'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
