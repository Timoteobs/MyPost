import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mypost/shared/models/post_model.dart';
import 'package:mypost/shared/models/user_model.dart';

class DatabaseService {
  CollectionReference postsReference =
      FirebaseFirestore.instance.collection("home");
  CollectionReference restrictedReference =
      FirebaseFirestore.instance.collection("restricted");
  final User? user = FirebaseAuth.instance.currentUser;

  Future createNewPost(String text) async {
    await postsReference.add({
      "text": text,
      "creatAt": DateTime.now(),
    });
  }

  List<Post> postFormFireStore(QuerySnapshot snapshot) {
    if (snapshot != null) {
      return snapshot.docs.map((e) {
        return Post(
          text: (e.data() as Map)["text"],
        );
      }).toList();
    } else {
      return [];
    }
  }

  Stream<List<Post>> listPosts() {
    return postsReference
        .orderBy('creatAt', descending: true)
        .snapshots()
        .map(postFormFireStore);
  }

  Stream<List<Post>> listrestRicted() {
    return restrictedReference.snapshots().map(postFormFireStore);
  }

  Future<void> checkEmail() async {
    await user?.sendEmailVerification().catchError((e) => print('deu ruim'));
  }

  getUSer() {
    final userModel = UserModel(
      name: user!.displayName!,
      email: user!.email!,
      photoURL: user?.photoURL,
      emailVerified: user?.emailVerified,
    );
    return userModel;
  }
}
