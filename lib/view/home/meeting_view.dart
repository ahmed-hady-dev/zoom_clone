import 'package:flutter/material.dart';
import 'package:zoom_clone/components/home_meeting_button.dart';

class MeetingView extends StatelessWidget {
  const MeetingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            HomeMeetingButton(onPressed: () {}, icon: Icons.videocam, text: 'New Meeting'),
            HomeMeetingButton(onPressed: () {}, icon: Icons.add_box_rounded, text: 'Join Meeting'),
            HomeMeetingButton(onPressed: () {}, icon: Icons.calendar_today, text: 'Schedule'),
            HomeMeetingButton(onPressed: () {}, icon: Icons.arrow_upward_rounded, text: 'Share Screen'),
          ],
        ),
        Expanded(
            child: Center(
                child: Text('Create/Join Meetings with just a click',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold))))
      ],
    );
  }
}
