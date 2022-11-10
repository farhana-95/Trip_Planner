import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class UserImage extends StatefulWidget {
  const UserImage({Key? key}) : super(key: key);

  @override
  State<UserImage> createState() => _UserImageState();
}

Future<String> uploadPic(FirebaseStorage storage, File imageTemporary) async {
  //Get the file from the image picker and store it
  // File image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //Create a reference to the location you want to upload to in firebase
  Reference reference = storage.ref().child("images/");

  //Upload the file to firebase
  UploadTask uploadTask = reference.putFile(imageTemporary!);

  // Waits till the file is uploaded then stores the download url
  //Uri location = (await uploadTask).storage;
  TaskSnapshot snapshot = await uploadTask;
  String imageUrl = await snapshot.ref.getDownloadURL();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('userimage', imageUrl);
  //returns the download url
  return imageUrl;
}

class _UserImageState extends State<UserImage> {
  String networkImageURL = '';

  @override
  void initState() {
    super.initState();
    _loadImageURl();
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  File? image;

  Future pickImage() async {
    final photo = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (photo == null) return;
    File imageTemporary = File(photo.path);
    //imageTemporary = await imageTemporary.copy(imageTemporary.path);

    setState(() {
      image = imageTemporary;
    });
    uploadPic(storage, imageTemporary);
  }

  _loadImageURl() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      networkImageURL = (prefs.getString('userimage') ?? '');
      print("network imageUrl  $networkImageURL");
    });
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              /*TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.camera_alt_outlined,
                ),
                label: Text('Camera'),
              ),
              SizedBox(
                width: 55,
              ),*/
              TextButton.icon(
                onPressed: () {
                  pickImage();
                },
                icon: Icon(
                  Icons.photo_library,
                ),
                label: Text('Gallery'),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          if (image != null) ...[
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              backgroundImage: FileImage(File(image!.path)),
              radius: 60,
            ),
          ] else ...[
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(networkImageURL),
              backgroundColor: Colors.transparent,
            )
          ],
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              child: Icon(Icons.camera_alt),
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
