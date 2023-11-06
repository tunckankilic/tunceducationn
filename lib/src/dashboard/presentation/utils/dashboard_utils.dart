import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tunceducationn/core/services/injection_container.dart';
import 'package:tunceducationn/src/auth/data/models/user_model.dart';

class DashboardUtils {
  const DashboardUtils._();

  static Stream<LocalUserModel> get userDataStream => s1<FirebaseFirestore>()
      .collection('users')
      .doc(s1<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));
}
