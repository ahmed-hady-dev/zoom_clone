import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/core/google_sign_in_helper/google_sign_in_helper.dart';

import '../../../components/custom_snackBar.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  //===============================================================
  static LoginCubit get(context) => BlocProvider.of(context);
  //===============================================================
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future<void> signInWithGoogle({required BuildContext context}) async {
    emit(GoogleSignInLoading());
    try {
      final userCredential = await GoogleSIgnInHelper.googleSignInMethod(_googleSignIn, _firebaseAuth);
      final User? user = userCredential.user;
      if (user != null) {
        final userMap = {
          'userName': user.displayName,
          'uid': user.uid,
          'profilePhoto': user.photoURL,
        };
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('users').doc(user.uid).set(userMap);
        }
      }
      emit(GoogleSignInSuccess());
    } on FirebaseAuthException catch (e) {
      debugPrint(e.code.toString());
      showSnackBar(text: e.code.toString(), context: context);
      emit(GoogleSignInFailed());
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());
      showSnackBar(text: e.toString(), context: context);
      emit(GoogleSignInFailed());
    }
  }
}
