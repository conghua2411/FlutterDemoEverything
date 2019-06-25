import 'package:flutter/material.dart';

class PageSlideDemo extends StatefulWidget {
  @override
  State createState() => PageSlideDemoState();
}

class PageSlideDemoState extends State<PageSlideDemo> {
  List<String> page = List.of({
    "123",
    "456",
    "789",
    "10jQ",
  });

  PageController pageController = PageController(viewportFraction: 0.8);

  int currentPage = 0;

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      int next = pageController.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: PageView.builder(
          controller: pageController,
          itemCount: page.length,
          itemBuilder: (context, int index) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutQuint,
              margin: EdgeInsets.only(
                  top: index == currentPage ? 100 : 200, bottom: 50, right: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20)
                ),
                color: Colors.primaries[index % Colors.primaries.length],
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87,
                      blurRadius: index == currentPage ? 30 : 5,
                      offset: Offset(index == currentPage ? 20 : 2,
                          index == currentPage ? 20 : 2))
                ],
              ),
              child: Center(
                child: Text(
                  page[index],
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
