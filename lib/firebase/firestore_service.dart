import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twitter_clone/firebase/auth_service.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference reference = firestore.collection('tweets');

class DatabaseService {
  static Future<void> addTweet({
    required String title,
    required String description,
  }) async {
    User? user = AuthServices.auth.currentUser;
    String userId = user!.uid;
    DocumentReference documentReferencer =
        reference.doc(userId).collection('my-tweets').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .set(data)
        .whenComplete(
          () => print("Tweet added to the database"),
        )
        .catchError(
          (e) => print(e),
        );
  }

  static Future<void> updateItem({
    required String title,
    required String description,
    required String docId,
  }) async {
    User? user = AuthServices.auth.currentUser;
    String userId = user!.uid;
    DocumentReference documentReferencer =
        reference.doc(userId).collection('my-tweets').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(
          () => print("Note item updated in the database"),
        )
        .catchError(
          (e) => print(e),
        );
  }

  static Future<void> deleteItem({
    required String docId,
  }) async {
    User? user = AuthServices.auth.currentUser;
    String userId = user!.uid;
    DocumentReference documentReferencer =
        reference.doc(userId).collection('my-tweets').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(
          () => print('Note item deleted from the database'),
        )
        .catchError(
          (e) => print(e),
        );
  }
}
