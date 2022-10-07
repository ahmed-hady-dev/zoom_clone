part of 'video_call_cubit.dart';

@immutable
abstract class VideoCallState {}

class VideoCallInitial extends VideoCallState {}

class ChangeSwitchState extends VideoCallState {}
