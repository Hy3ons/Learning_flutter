import 'dart:convert';
import 'dart:io';

import 'package:chat_app/screens/chat.dart';
import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:http/http.dart' as http;

final _firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLogin = true;
  final _formKey = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';
  var _enteredUsername = '';
  File? _pickedImageFile;

  bool _isAuthenticating = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    //회원가입시, 이미지 등록 필수.
    if (!_isLogin && _pickedImageFile == null) {
      //
      showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: Text('이미지를 등록해 주세요!'),
            content: Text('회원가입 시 이미지를 등록하셔야 합니다.'),

            actions: [
              CupertinoDialogAction(
                child: Text('이해했습니다.'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      return;
    }

    //_enteredEmail, _enteredPassword 변수에 Form 입력값 할당.
    _formKey.currentState!.save();

    setState(() {
      _isAuthenticating = true;
    });

    if (_isLogin) {
      try {
        final userCredentials = await _firebase.signInWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return const ChatScreen();
            },
          ),
        );
      } on FirebaseAuthException catch (error) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    } else {
      try {
        final EMAIL = _enteredEmail;
        final PASSWORD = _enteredPassword;
        final NAME = _enteredUsername;

        final userCredentials = await _firebase.createUserWithEmailAndPassword(
          email: _enteredEmail,
          password: _enteredPassword,
        );

        print(userCredentials.user!.uid);

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}_profile_image.jpg');

        final imageBytes = await _pickedImageFile!.readAsBytes();

        await storageRef.putData(
          imageBytes,
          SettableMetadata(contentType: 'image/jpeg'),
        );

        // await storageRef.putFile(
        //   _pickedImageFile!,
        //   SettableMetadata(contentType: 'image/jpeg'),
        // );

        final imageUrl = await storageRef.getDownloadURL();

        print(imageUrl);

        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // await _firestore
        //     .collection('test')
        //     .doc()
        //     .set({'hello': 'nice'})
        //     .timeout(Duration(seconds: 10));

        await firestore
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({'username': NAME, 'email': EMAIL, 'image_url': imageUrl})
            .timeout(Duration(seconds: 15));

        // final user = FirebaseAuth.instance.currentUser;
        // final idToken = await user!.getIdToken();

        // final url = Uri.parse(
        //   'https://firestore.googleapis.com/v1/projects/flutter-chat-app-d707f/databases/flutter-chat-app/documents/users/${user.uid}',
        // );

        // print(idToken);

        // final response = await http.post(
        //   url,
        //   headers: {
        //     'Authorization': 'Bearer $idToken',
        //     'Content-Type': 'application/json',
        //   },
        //   body: json.encode({
        //     "fields": {
        //       "username": {"stringValue": NAME},
        //       "email": {"stringValue": EMAIL},
        //       "image_url": {"stringValue": imageUrl},
        //     },
        //   }),
        // );

        // print(response.body);
      } on FirebaseAuthException catch (error) {
        if (error.code == 'email-already-in-use') {
          //...
        }

        print('FirebaseAuthException Occured');

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? 'Authentication Failed')),
        );

        setState(() {
          _isAuthenticating = false;
        });
      } catch (error) {
        print('🔥 Storage 업로드 실패: $error');
      }
    }

    if (mounted) {
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 30,
                  bottom: 20,
                  left: 20,
                  right: 20,
                ),

                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),

              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16),

                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!_isLogin)
                            UserImagePicker(
                              onPickImage: (pickedImage) {
                                _pickedImageFile = pickedImage;
                              },
                            ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Email Address',
                            ),

                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,

                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }

                              return null;
                            },

                            onSaved: (newValue) {
                              _enteredEmail = newValue!;
                            },
                          ),

                          if (!_isLogin)
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'UserName',
                              ),

                              enableSuggestions: false,

                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'Please enter a valid username (least 4 characters).';
                                }

                                return null;
                              },

                              onSaved: (newValue) {
                                _enteredUsername = newValue!;
                              },
                            ),

                          TextFormField(
                            decoration: InputDecoration(labelText: 'Password'),

                            keyboardType: TextInputType.emailAddress,
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }

                              return null;
                            },

                            onSaved: (newValue) {
                              _enteredPassword = newValue!;
                            },
                          ),

                          const SizedBox(height: 12),

                          if (_isAuthenticating)
                            const CircularProgressIndicator(),

                          if (!_isAuthenticating)
                            ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                              ),
                              child: Text(_isLogin ? 'Login' : 'SignUp'),
                            ),

                          if (!_isAuthenticating)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _isLogin ^= true;
                                });
                              },
                              child: Text(
                                _isLogin
                                    ? 'Create an account'
                                    : 'I already have an account',
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
