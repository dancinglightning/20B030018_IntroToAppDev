  Future SignOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      final googleSignIn = GoogleSignIn();
      await googleSignIn.disconnect();
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
 
    }
  }
 
  signInWithGoogle(BuildContext context) async{
    final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn =GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = (await _googleSignIn.signIn())!;
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    UserCredential result= await _firebaseAuth.signInWithCredential(credential);
    User userDetails = result.user!;
 
    if (result != null) {
      SharedPreferenceHelper().saveUserEmail(userDetails.email!);
      SharedPreferenceHelper().saveUserId(userDetails.uid);
      SharedPreferenceHelper()
          .saveUserName(userDetails.email!.replaceAll("@gmail.com", ""));
      SharedPreferenceHelper().saveDisplayName(userDetails.displayName!);
      SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL!);
 
      Map<String, dynamic> userInfoMap = {
        "email": userDetails.email,
        "username": (userDetails.email!.split("@"))[0],
        "name": userDetails.displayName,
        "imgUrl": userDetails.photoURL
      };
      DatabaseMethods().addUserInfoToDB(userDetails.uid, userInfoMap).then(
          (value){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
 
          }
      );
 
  }
    Map<String, dynamic> userInfoMap = {
      "email": userDetails.email,
      "username": (userDetails.email!.split("@"))[0],
      "name": userDetails.displayName,
      "imgUrl": userDetails.photoURL
    };
    await SharedPreferenceHelper().saveDisplayName(userInfoMap["name"]);
    await SharedPreferenceHelper().saveUserEmail(userInfoMap["email"]);
    await SharedPreferenceHelper().saveUserProfileUrl(userInfoMap["imgUrl"]);
    await SharedPreferenceHelper().saveUserName(userInfoMap["username"]);
  }
  getUserCred() async{
    final FirebaseAuth _firebaseAuth =FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn =GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount = (await _googleSignIn.signIn())!;
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    UserCredential result= await _firebaseAuth.signInWithCredential(credential);
    User userDetails = result.user!;
    Map<String, dynamic> userInfoMap = {
      "email": userDetails.email,
      "username": userDetails.email!.replaceAll("@gmail.com", ""),
      "name": userDetails.displayName,
      "imgUrl": userDetails.photoURL
    };
    return userInfoMap;
  }
 
 
  }