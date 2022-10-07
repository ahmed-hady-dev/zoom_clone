import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/components/custom_snackBar.dart';
import 'package:zoom_clone/components/meeting_option.dart';
import 'package:zoom_clone/view/video_call/widgets/video_call_text_field.dart';

import '../../constants/colors.dart';
import 'controller/video_call_cubit.dart';

class VideoCallView extends StatelessWidget {
  const VideoCallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VideoCallCubit()..onInit(),
      child: BlocBuilder<VideoCallCubit, VideoCallState>(
        builder: (context, state) {
          final cubit = VideoCallCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: const Text('Join a meeting'),
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: backgroundColor,
            ),
            body: Column(
              children: <Widget>[
                VideoCallTextField(
                  controller: cubit.meetingIdController,
                  hintText: 'Room ID',
                  keyboardType: TextInputType.number,
                ),
                VideoCallTextField(
                  controller: cubit.nameController,
                  hintText: 'Name',
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {
                      if (cubit.meetingIdController.text.isEmpty) {
                        showSnackBar(context: context, text: 'Make sure you enter the Meeting ID');
                        return;
                      } else if (cubit.meetingIdController.text.length < 3) {
                        showSnackBar(context: context, text: 'Make sure you entered a proper Meeting ID');
                        return;
                      }
                      cubit.joinMeeting(userName: cubit.nameController.text);
                    },
                    child: const Text(
                      'Join',
                      style: TextStyle(fontSize: 16.0),
                    )),
                MeetingOption(
                  text: 'Mute Audio',
                  isMute: cubit.isAudioMuted,
                  onChange: (value) {
                    cubit.changeAudioState();
                  },
                ),
                MeetingOption(
                  text: 'Turn off Video',
                  isMute: cubit.isVideoMuted,
                  onChange: (value) {
                    cubit.changeVideoState();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
