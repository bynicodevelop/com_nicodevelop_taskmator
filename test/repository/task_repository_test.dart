import "package:cloud_firestore/cloud_firestore.dart";
import "package:com_nicodevelop_taskmator/exceptions/standard_exception.dart";
import "package:com_nicodevelop_taskmator/repositories/task_repository.dart";
import "package:fake_cloud_firestore/fake_cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_auth_mocks/firebase_auth_mocks.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  group("TaskRepository", () {
    test("Should add new task in Firestore", () async {
      final FirebaseAuth mockFirebaseAuth = MockFirebaseAuth(
        signedIn: true,
        mockUser: MockUser(
          uid: "1234567890",
        ),
      );

      final FirebaseFirestore mockFirebaseFirestore = FakeFirebaseFirestore();

      final TaskRepository taskRepository = TaskRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      await taskRepository.create({
        "taskName": "taskName",
      });

      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await mockFirebaseFirestore
              .collection("users")
              .doc("1234567890")
              .collection("tasks")
              .get();

      expect(
        querySnapshot.docs.length,
        1,
      );

      expect(
        querySnapshot.docs.first.data(),
        {
          "taskName": "taskName",
          "createdAt": isA<Timestamp>(),
          "updatedAt": isA<Timestamp>(),
        },
      );
    });

    test("Should expect an exception if user is unauthenticated", () async {
      final FirebaseAuth mockFirebaseAuth = MockFirebaseAuth(
        signedIn: false,
      );

      final FirebaseFirestore mockFirebaseFirestore = FakeFirebaseFirestore();

      final TaskRepository taskRepository = TaskRepository(
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
      );

      expect(
        () => taskRepository.create({
          "taskName": "taskName",
        }),
        throwsA(
          predicate(
            (e) => e is StandardException && e.code == "user-not-found",
          ),
        ),
      );
    });
  });
}
