import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widget/SubCategoriesCollectionData/sub_categories_collections_datatable.dart';
import '../../Widget/islogged_widget.dart';

class SubCategoriesCollections extends StatefulWidget {
  const SubCategoriesCollections({Key? key}) : super(key: key);

  @override
  State<SubCategoriesCollections> createState() =>
      _SubCategoriesCollectionsState();
}

class _SubCategoriesCollectionsState extends State<SubCategoriesCollections> {
  DocumentReference? userRef;
  String fullname = 'Olivette Admin';
  String profilePic =
      'https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png';
  String email = 'admin123@gmail.com';

  @override
  void initState() {
    getFirebaseDetails();
    super.initState();
  }

  String adminImage = '';
  String oldPassword = '';
  String adminUsername = '';
  getFirebaseDetails() {
    FirebaseFirestore.instance
        .collection('Admin')
        .doc('Admin')
        .get()
        .then((value) {
      setState(() {
        adminImage = value['ProfilePic'];
        oldPassword = value['password'];
        adminUsername = value['username'];
      });
    });
  }

  bool? loggedIn;

  getSelectedRoute() {
    SharedPreferences.getInstance().then((prefs) {
      var log = prefs.getBool('logged in');
      setState(() {
        loggedIn = log!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getSelectedRoute();
    return loggedIn == false || loggedIn == null
        ? const IsLoggedWidget()
        : Scaffold(
            body: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(
                    flex: 5,
                    child: SubCategoriesCollectionsData(),
                  ),
                ],
              ),
            ),
          );
  }
}
