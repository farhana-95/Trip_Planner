import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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


class _UserImageState extends State<UserImage> {
   String imageUrl='';
  Future<String> uploadPic(FirebaseStorage storage, File imageTemporary) async {
    //Get the file from the image picker and store it
    // File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    String imageID= getCurrentUser();
    //Create a reference to the location you want to upload to in firebase
    Reference reference = storage.ref().child("images").child(imageID+"/");
    print("imageID:   $imageID");
    UploadTask uploadTask = reference.putFile(imageTemporary);

    // Waits till the file is uploaded then stores the download url
    //Uri location = (await uploadTask).storage;
    TaskSnapshot snapshot = await uploadTask;
     imageUrl = await snapshot.ref.getDownloadURL();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userimage', imageUrl);
    //returns the download url
    print('IMAGEURL  $imageUrl');

    return imageUrl;
  }
    printUrl() async {
      String imageID= getCurrentUser();
     Reference ref = FirebaseStorage.instance.ref().child("images/$imageID");
     String url = (await ref.getDownloadURL()).toString();
     print("printUrl  $url");

     return url;
   }
  String networkImageURL = '';
  // String networkURL ='';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var userData =
  FirebaseFirestore.instance.collection("/userdata").doc("uid").get();

  getCurrentUser() {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    final uemail = user.email;
    //final uname = user.name;
    //var text = Text('Mail: $uemail');
    print("EMAIL: $uemail");
    // _userInfo;
    // print(_userInfo);
    return uemail;

  }
static late var imgUrl;

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
    // print('imgURL $imgUrl');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(()  {
      networkImageURL = (prefs.getString('userimage') ?? '');
      // networkImageURL=imgUrl;
      print("network imageUrl  $networkImageURL");
      // networkURL = networkImageURL;
    });
  }
   @override
   void initState() {
     super.initState();
     _loadImageURl();
       // URL= URl();
     // printUrl();
     // imgUrl=printUrl();
     // print('newUrl   $imgUrl');
   }
  // Future<void> removeImageFromUrl(String url) async {
  //   try {
  //     url = networkURL;
  //     Reference ref = await FirebaseStorage.instance.refFromURL(url);
  //     await ref.delete();
  //   } catch (e) {
  //     print('Failed with error code: ');
  //     print('');
  //   }
  // }
  Widget bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height*0.2,
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
          Column(
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
              ),
              TextButton.icon(
                onPressed: () async {
                  // print("URL : $networkURL");
                   // FirebaseStorage.instance.refFromURL('$networkURL').delete();
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('userimage', "");


                },
                icon: Icon(
                  Icons.delete,
                ),
                label: Text('Delete Photo'),
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
          // CircleAvatar(
          //     radius: 70,
          //    child:
          //    CachedNetworkImage(
          //       fit: BoxFit.cover,
          //       imageUrl: imgUrl,
          //       placeholder: (context, url) => const CircularProgressIndicator(),
          //       errorWidget: (context, url, error) => const Icon(Icons.person,size: 60,),
          //     )
          // ),
          if (image != null) ...[
            CircleAvatar(
              backgroundColor: Colors.blueAccent,
              backgroundImage: FileImage(File(image?.path ?? '')),
              radius: 60,
            ),
          ] else ...[
            CircleAvatar(
              radius: 60.0,
              backgroundImage: NetworkImage(networkImageURL),
              backgroundColor: Colors.teal,
            )
          ],

          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: InkWell(
              child: Icon(Icons.camera_alt,color: Colors.grey,),
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
