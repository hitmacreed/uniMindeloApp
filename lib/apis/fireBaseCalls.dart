import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uni_mindelo/utils/constants/errors.dart';
import 'package:uni_mindelo/utils/services/dialogService.dart';
import 'package:uni_mindelo/utils/services/loaderService.dart';
import 'package:uni_mindelo/utils/services/router.dart';
import 'package:uni_mindelo/utils/services/storage.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _auth = FirebaseAuth.instance;
final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
final userId = getData(user_uid);

login(email, password, BuildContext context) async {
  try {
    showLoader();

    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              saveData(user_uid, value.user!.uid),
              dismissLoader(),
              Navigator.pushNamed(context, homeRoute)
            });
  } on FirebaseAuthException catch (error) {
    dismissLoader();
    authErrorHandler(error.code, context);
  }
}

forgotPassword(email, BuildContext context) async {
  try {
    showLoader();
    await _auth.sendPasswordResetEmail(email: email).then((_value) => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return DialogService(
                    subTitle: 'FORGOT_PASSWORD.EMAIL_SEND',
                    title: 'DIALOG.HEADER.SUCCESS',
                    dismissOnPopLogin: true,
                    isCreditCard: false);
              }),
          dismissLoader()
        });
  } on FirebaseAuthException catch (error) {
    dismissLoader();
    authErrorHandler(error.code, context);
  }
}

getUserData() {
  return _fireStore.collection('Users').doc(userId).get();
}

getFeedData() {
  return _fireStore.collection('Feed').snapshots();
}

getUserClasses() {
  return _fireStore
      .collection('Classes')
      .where('classId', isEqualTo: 'sFUthBc3WpxBDaeNSsxS')
      .snapshots();
}

authErrorHandler(errorCode, context) {
  switch (errorCode) {
    case userDontExists:
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogService(
                subTitle: 'ERRORS.USER_DONT_EXISTS',
                title: 'DIALOG.HEADER.ERROR',
                dismissOnPopLogin: false,
                isCreditCard: false);
          });
      break;
    case wrongPassword:
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogService(
                subTitle: 'ERRORS.WRONG_PASSWORD',
                title: 'DIALOG.HEADER.ERROR',
                dismissOnPopLogin: false,
                isCreditCard: false);
          });
      break;
    case tooManyRequests:
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogService(
                subTitle: 'ERRORS.TOO_MANY_REQUESTS',
                title: 'DIALOG.HEADER.WARNING',
                dismissOnPopLogin: false,
                isCreditCard: false);
          });
      break;
    case invalidEmail:
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return DialogService(
                subTitle: 'ERRORS.INVALID_EMAIL',
                title: 'DIALOG.HEADER.ERROR',
                dismissOnPopLogin: false,
                isCreditCard: false);
          });
      break;
    default:
  }
}
