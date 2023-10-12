import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopmate/services/cloud/cloud_lists.dart';
import 'package:shopmate/services/cloud/cloud_storage_constants.dart';
import 'package:shopmate/utilities/exceptions/cloud_storage_exception.dart';

class FirebaseCloudStorage {
  final lists = FirebaseFirestore.instance.collection('lists');

  //delete lists
  Future<void> deleteList({required String documentId}) async {
    try {
      await lists.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteListException();
    }
  }

  //update lists
  Future<void> updateList({
    required String documentId,
    required String text,
  }) async {
    try {
      lists.doc(documentId).update({
        textFieldName: text,
      });
    } catch (e) {
      throw CouldNotUpdateListException();
    }
  }

  Stream<Iterable<CloudList>> allLists({required String ownerUserId}) =>
      lists.snapshots().map((event) => event.docs
          .map((doc) => CloudList.fromSnapshot(doc))
          .where((list) => list.ownerUserId == ownerUserId));

  Future<Iterable<CloudList>> getLists({required String ownerUserId}) async {
    try {
      return await lists
          .where(ownerUserIdFieldName, isEqualTo: ownerUserId)
          .get()
          .then(
            (value) => value.docs.map((doc) => CloudList.fromSnapshot(doc)
                // {
                //   return CloudList(
                //     documentId: doc.id,
                //     ownerUserId: doc.data()[ownerUserIdFieldName] as String,
                //     text: doc.data()[textFieldName] as String,
                //   );
                // },
                ),
          );
    } catch (e) {
      throw CouldNotGetAllListException();
    }
  }

  Future<CloudList> createNewList({required String ownerUserId}) async {
    final document = await lists.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: '',
    });
    final fetchedList = await document.get();
    return CloudList(
      documentId: fetchedList.id,
      ownerUserId: ownerUserId,
      text: '',
    );
  }

  // make singleton to avoid redundancy
  FirebaseCloudStorage._sharedInstance(); // private constructor
  factory FirebaseCloudStorage() => _shared;
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
}
