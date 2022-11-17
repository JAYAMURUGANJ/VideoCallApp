import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'meeting_handler.dart';
import 'validation.dart';

class ScheduleMeeting extends StatefulWidget {
  const ScheduleMeeting({Key? key}) : super(key: key);
  static String id = 'schedule-meeting';

  @override
  State<ScheduleMeeting> createState() => _ScheduleMeetingState();
}

class _ScheduleMeetingState extends State<ScheduleMeeting> {
  List<String> durationList = [
    '15 minutes',
    '30 minutes',
    '1 hour',
    '1 hour 30 minutes',
    '2 hours',
    '2 hours 30 minutes',
    '3 hours',
    '3 hours 30 minutes'
  ];
  String duration = '30 minutes';
  DateFormat dateFormat = DateFormat('yMMMd');
  DateFormat timeFormat = DateFormat('jm');
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController whatsAppNumberController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  FocusNode focusNode = FocusNode();
  bool isTimeInPast = false;

  @override
  void initState() {
    dateController.text = dateFormat.format(DateTime.now());
    timeController.text = timeFormat.format(getNextStartTime());
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
                'Create Meeting',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: Image.asset(
                "assets/images/img-1.png",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'WhatsApp Number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            CupertinoTextField(
              controller: whatsAppNumberController,
              style: Theme.of(context).textTheme.subtitle1,
              placeholder: 'Enther the number want to share',
              keyboardType: TextInputType.number,
              maxLength: 10,
              padding: const EdgeInsets.all(15),
              suffix: const Padding(
                padding: EdgeInsets.all(15),
                child: Icon(Icons.whatsapp),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Moto of the Metting',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            CupertinoTextField(
              controller: subjectController,
              style: Theme.of(context).textTheme.subtitle1,
              keyboardType: TextInputType.text,
              placeholder: 'Metting for...',
              padding: const EdgeInsets.all(15),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 180,
                  child: Column(
                    children: [
                      const Text(
                        'Start Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CupertinoTextField(
                        onTap: () async {
                          DateTime selectedDate =
                              dateFormat.parse(dateController.text);
                          final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101));
                          if (picked != null && picked != selectedDate) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              dateController.text = dateFormat.format(picked);
                            });
                          }
                        },
                        controller: dateController,
                        keyboardType: TextInputType.none,
                        style: Theme.of(context).textTheme.subtitle1,
                        placeholder: 'Select start date',
                        padding: const EdgeInsets.all(15),
                        suffix: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.today),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    children: [
                      const Text(
                        'Start Time',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      CupertinoTextField(
                        onTap: () async {
                          TimeOfDay selectedTime = TimeOfDay.fromDateTime(
                              timeFormat.parse(timeController.text));
                          final TimeOfDay? picked = await showTimePicker(
                              context: context, initialTime: selectedTime);
                          if (picked != null && picked != selectedTime) {
                            FocusManager.instance.primaryFocus?.unfocus();
                            setState(() {
                              timeController.text = picked.format(context);
                              isTimeInPast = checkIfTimeInPast(picked);
                            });
                          }
                        },
                        controller: timeController,
                        keyboardType: TextInputType.none,
                        style: Theme.of(context).textTheme.subtitle1,
                        placeholder: 'Select start time',
                        padding: const EdgeInsets.all(15),
                        suffix: const Padding(
                          padding: EdgeInsets.all(15),
                          child: Icon(Icons.schedule),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            Visibility(
              visible: isTimeInPast,
              child: const Text('Cannot schedule a meeting in the past',
                  style: TextStyle(color: Colors.red)),
            ),
            const SizedBox(height: 10),
            const Text(
              'Duration',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            DropdownButton(
              isExpanded: true,
              value: duration,
              onChanged: (String? value) => setState(() => duration = value!),
              items: durationList.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                if (subjectController.text != "" &&
                    whatsAppNumberController.text != "" &&
                    whatsAppNumberController.text.length == 10) {
                  String meetingLinkScheduled = fetchScheduledMeetingUrl(
                      subjectController.text,
                      dateController.text,
                      timeController.text,
                      duration);

                  var whatsapp = "+91${whatsAppNumberController.text}";
                  var whatsappAndroid = Uri.parse(
                      "whatsapp://send?phone=$whatsapp&text=https://$meetingLinkScheduled");
                  if (await canLaunchUrl(whatsappAndroid)) {
                    await launchUrl(whatsappAndroid);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.amber,
                        content:
                            Text("WhatsApp is not installed on the device"),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Check out the Moto & WhatsApp Number!"),
                    ),
                  );
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.share_sharp,
                    size: 22,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "SHARE",
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
