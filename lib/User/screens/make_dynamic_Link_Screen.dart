import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/User/screens/regNumberVerification_Screen.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../Provider/user_provider.dart';

class FirebaseDynamicLinkService{

  final FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<String>createDynamicLink(bool short,String id) async {
    String linkMessage;

    FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://lioclub.page.link',
      link: Uri.parse('https://lioclub.page.link/29hQ/media/?id=$id'),
      androidParameters: const AndroidParameters(
        packageName: "com.spine.lio_club",
        minimumVersion: 1,

      ),

    );

    Uri url;

    if (short) {
      final ShortDynamicLink shortLink = await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
print("gggggggggggg $url");
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }
    linkMessage=url.toString();
    return linkMessage;


  }


  static Future<void>initDynamicLink(BuildContext context,String youTubeLink,String title,String description,String thumbnile,String id,String fromDate,String toDate) async {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    FirebaseDynamicLinks.instance.onLink.listen((PendingDynamicLinkData dynamicLinkData) {
      final Uri deepLink=dynamicLinkData.link;
      var isNews=deepLink.pathSegments.contains("news");
      if (isNews){
        id=deepLink.queryParameters["id"].toString() ;
      }

      if(deepLink!=null){


        try {

          userProvider.clearRegistrationField();
          callNext(RegistrationScreen(referralId: '',), context);

        }catch(e){
        }
      }
      else{
        return;
      }
    }).onError((error) {
    });


    //    final PendingDynamicLinkData data = FirebaseDynamicLinks.instance.getInitialLink() as PendingDynamicLinkData;
    //    final Uri deepLink = data.link;
    //
    //    var isNews = deepLink.pathSegments.contains("news");
    //    if(isNews){
    //       itemList.id = deepLink.queryParameters["id"].toString();
    //
    //       if(deepLink!= null){
    //         try{
    //           print("hegvdhhhuuhhyhhhhhhhhhhhh");
    //           Navigator.push(context, MaterialPageRoute(builder: (context) =>
    //               OpenNewsScreen(itemlist: itemList)));
    //
    //         }catch(e){
    //           print(e);
    //         }
    //       }
    //    }
    //
    //
  }
}