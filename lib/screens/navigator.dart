// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'join_meeting_screen.dart';
import 'meeting_schedule.dart';

class NavigationScreen extends StatefulWidget {
  int currentIndex;
  String url;
  NavigationScreen({
    Key? key,
    this.currentIndex = 0,
    this.url = "www.facebook.com",
  }) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _pages = [];

  bool isTimeInPast = false;

  @override
  void initState() {
    _pages.add(const ScheduleMeeting());
    _pages.add(const JoinMeeting());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[widget.currentIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: widget.currentIndex,
              backgroundColor: Colors.blueGrey,
              selectedItemColor: Colors.white,
              onTap: (index) {
                setState(() {
                  widget.currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.whatsapp), label: 'CreateMeet'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_call), label: 'JoinMeet')
              ],
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniStartDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: FloatingActionButton(
      //     child: const Icon(Icons.whatsapp),
      //     onPressed: () => setState(() {
      //       widget.currentIndex = 0;
      //     }),
      //   ),
      // ),
    );
  }
}
