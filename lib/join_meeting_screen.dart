import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class JoinMeeting extends StatefulWidget {
  const JoinMeeting({Key? key}) : super(key: key);
  static String id = 'schedule-meeting';

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  TextEditingController meetingKeyController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Join Meeting',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              child: Image.asset(
                "assets/images/img-3.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Meet key',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            CupertinoTextField(
              controller: meetingKeyController,
              style: Theme.of(context).textTheme.subtitle1,
              placeholder: 'Enther the meeting key',
              keyboardType: TextInputType.url,
              padding: const EdgeInsets.all(15),
              suffix: const Padding(
                padding: EdgeInsets.all(15),
                child: Icon(Icons.key),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () => context.go('/${meetingKeyController.text}'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.video_call,
                      size: 30,
                    ),
                    Text(
                      "JOIN",
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
