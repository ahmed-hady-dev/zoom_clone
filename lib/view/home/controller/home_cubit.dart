import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:meta/meta.dart';
import 'package:zoom_clone/view/home/history_meeting_view.dart';

import '../meeting_view.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  //===============================================================
  static HomeCubit get(context) => BlocProvider.of(context);
  //===============================================================
  int _currentIndex = 0;
  final firebaseUser = FirebaseAuth.instance.currentUser!;
  int get currentIndex => _currentIndex;
  final List<Widget> _homePages = const [
    MeetingView(),
    HistoryMeetingView(),
    Text('Contacts'),
    Text('Settings'),
  ];

  List<Widget> get homePages => _homePages;

  void changePage(int index) {
    _currentIndex = index;
    emit(ChangeBottomBavBarIndex());
  }

  createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = firebaseUser.displayName
        ..userEmail = firebaseUser.email
        ..userAvatarURL = firebaseUser.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
