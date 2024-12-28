import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:projectmppl/login/Login.dart';
import 'package:projectmppl/profile/profile.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

enum FormType {
  ChangeProfileImage,
  ChangeUsername,
  ChangePassword,
}

class UbahProfile extends StatefulWidget {
  const UbahProfile({super.key});

  @override
  State<UbahProfile> createState() => _UbahProfileState();
}

class _UbahProfileState extends State<UbahProfile> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordlamaController = TextEditingController();
  FormType _selectedForm = FormType.ChangeProfileImage;
  File? _imageFile;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    GoogleSignInAccount? user = _googleSignIn.currentUser;
    if (user != null) {
      _usernameController.text = user.displayName ?? '';
      // Since password cannot be retrieved, it can be left empty
    }
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImageToFirebase() async {
    if (_imageFile == null) {
      return null;
    }

    // Generate a unique filename for the image
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();

    // Get the reference to the Firebase Storage bucket
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child('profil/$fileName');

    // Upload the image file to Firebase Storage
    await ref.putFile(_imageFile!);

    // Get the download URL of the uploaded image
    String? imageUrl = await ref.getDownloadURL();

    return imageUrl;
  }

  Widget _buildForm(FormType formType) {
    switch (formType) {
      case FormType.ChangeProfileImage:
        return Column(
          children: [
            const Text('Change Profile Image Form'),
            ElevatedButton(
              onPressed: _uploadImage,
              child: const Text('Upload Image'),
            ),
            if (_imageFile != null) Image.file(_imageFile!),
            ElevatedButton(
              onPressed: () async {
                // Upload the image to Firebase Storage
                String? imageUrl = await _uploadImageToFirebase();
                User? user = FirebaseAuth.instance.currentUser;

                if (imageUrl != null) {
                  if (user != null) {
                    // Update the photoURL property
                    try {
                      await user.updatePhotoURL(imageUrl);
                      // PhotoURL updated successfully
                      print('PhotoURL updated successfully');
                    } catch (e) {
                      // Failed to update photoURL
                      print('Failed to update PhotoURL: $e');
                    }
                  } else {
                    // User not signed in
                    print('User not signed in');
                  }
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                } else {
                  // Handle the case when image upload fails
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      case FormType.ChangeUsername:
        return Column(
          children: [
            const Text('Change Username Form'),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Username',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String newUsername = _usernameController.text;
                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  try {
                    await user.updateDisplayName(newUsername);
                    print('Username updated successfully');
                  } catch (e) {
                    print('Failed to update username: $e');
                  }
                } else {
                  // User not signed in
                  print('User not signed in');
                }
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const Profile()),
                );
              },
              child: const Text('Submit'),
            ),
          ],
        );
      case FormType.ChangePassword:
        return Column(
          children: [
            const Text('Change Password Form'),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _passwordlamaController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Password lama',
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  hintText: 'Password baru',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                String newPassword = _passwordController.text;
                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  try {
                    AuthCredential credential = EmailAuthProvider.credential(
                      email: user.email!,
                      password: _passwordlamaController.text,
                    );

                    await user.reauthenticateWithCredential(credential);
                    await user.updatePassword(newPassword);

                    // Logout pengguna setelah berhasil mengubah password
                    await FirebaseAuth.instance.signOut();

                    // Password berhasil diperbarui dan pengguna telah logout
                    print('Password berhasil diperbarui. Pengguna telah logout');

                    // Navigasi ke halaman login
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  } catch (e) {
                    // Gagal memperbarui password
                    print('Gagal memperbarui password: $e');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Gagal mengubah password.'),
                      ),
                    );

                    // Navigasi kembali ke halaman profil
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  }
                } else {
                  // Pengguna belum masuk
                  print('Pengguna belum masuk');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orangeAccent, Colors.orange],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
              size: 50.0,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Profile()),
              );
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DropdownButton<FormType>(
                  value: _selectedForm,
                  items: const [
                    DropdownMenuItem<FormType>(
                      value: FormType.ChangeProfileImage,
                      child: Text('Change Profile Image'),
                    ),
                    DropdownMenuItem<FormType>(
                      value: FormType.ChangeUsername,
                      child: Text('Change Username'),
                    ),
                    DropdownMenuItem<FormType>(
                      value: FormType.ChangePassword,
                      child: Text('Change Password'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedForm = value!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 0.0),
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildForm(_selectedForm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
