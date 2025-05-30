import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_introduction/firebase_options.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/foundation.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    auth.FirebaseUIAuth.configureProviders([auth.EmailAuthProvider()]);

    FirebaseAuth.instance.userChanges().listen((user) {
      user != null ? _loggedIn = true : _loggedIn = false;
      notifyListeners();
    });
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception("Usuário não está logado.");
    }
    return FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
          'message': message,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
          'name': FirebaseAuth.instance.currentUser!.displayName,
          'userId': FirebaseAuth.instance.currentUser!.uid,
        });
  }
}
