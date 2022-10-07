import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/components/home_meeting_button.dart';
import 'package:zoom_clone/core/router/router.dart';
import 'package:zoom_clone/view/video_call/vidoe_call_view.dart';

import 'controller/home_cubit.dart';

class MeetingView extends StatelessWidget {
  const MeetingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    var random = Random();
    String roomName = (random.nextInt(1000000) + 1000000).toString();
    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {},
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              HomeMeetingButton(
                  onPressed: () {
                    cubit.createMeeting(roomName: roomName, isAudioMuted: true, isVideoMuted: true);
                  },
                  icon: Icons.videocam,
                  text: 'New Meeting'),
              HomeMeetingButton(
                onPressed: () => MagicRouter.navigateTo(const VideoCallView()),
                icon: Icons.add_box_rounded,
                text: 'Join Meeting',
              ),
              HomeMeetingButton(
                onPressed: () {},
                icon: Icons.calendar_today,
                text: 'Schedule',
              ),
              HomeMeetingButton(
                onPressed: () {},
                icon: Icons.arrow_upward_rounded,
                text: 'Share Screen',
              ),
            ],
          ),
          Expanded(
              child: Center(
                  child: Text('Create/Join Meetings with just a click',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold))))
        ],
      ),
    );
  }
}
