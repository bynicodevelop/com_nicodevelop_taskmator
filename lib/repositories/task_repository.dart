import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_taskmator/exceptions/standard_exception.dart";
import "package:com_nicodevelop_taskmator/utils/logger.dart";
import "package:firebase_auth/firebase_auth.dart";

class TaskRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  const TaskRepository({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Future<void> get() async {}

  Future<void> list() async {}

  Future<void> create(Map<String, dynamic> data) async {
    assert(data["taskName"] != null);

    info("$runtimeType - create", data: data);

    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      throw StandardException(
        "User not found",
        "user-not-found",
      );
    }

    final FieldValue timestamp = FieldValue.serverTimestamp();

    try {
      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .add({
        "taskName": data["taskName"],
        "createdAt": timestamp,
        "updatedAt": timestamp,
      });
    } on FirebaseException catch (e) {
      throw StandardException(
        e.message ?? "Unknown error",
        e.code,
      );
    }
  }

  Future<void> update(Map<String, dynamic> data) async {}

  Future<void> createOrUpdate(Map<String, dynamic> data) async {}

  Future<void> delete(Map<String, dynamic> data) async {}
}
