import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
