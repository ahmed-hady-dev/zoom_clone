import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:meta/meta.dart';

part 'video_call_state.dart';

class VideoCallCubit extends Cubit<VideoCallState> {
  VideoCallCubit() : super(VideoCallInitial());
  static VideoCallCubit get(context) => BlocProvider.of(context);
  //===============================================================

  final firebaseUser = FirebaseAuth.instance.currentUser!;
  TextEditingController meetingIdController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isAudioMuted = true;
  bool isVideoMuted = true;
  //===============================================================

  onInit() {
    nameController.text = firebaseUser.displayName!;
  }

  changeAudioState() {
    isAudioMuted = !isAudioMuted;
    emit(ChangeSwitchState());
  }

  changeVideoState() {
    isVideoMuted = !isVideoMuted;
    emit(ChangeSwitchState());
  }

  joinMeeting({required String userName}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

      String name;
      if (userName.isEmpty) {
        name = firebaseUser.displayName!;
      } else {
        name = userName;
      }

      var options = JitsiMeetingOptions(room: meetingIdController.text)
        ..userDisplayName = name
        ..userEmail = firebaseUser.email
        ..userAvatarURL = firebaseUser.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    meetingIdController.dispose();
    JitsiMeet.removeAllListeners();
    return super.close();
  }
}
