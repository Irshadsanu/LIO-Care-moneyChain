import 'dart:async';
import 'dart:collection';
import 'dart:collection';
import 'dart:collection';
import 'dart:collection';
import 'dart:convert';
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

import 'package:intl/intl.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lio_care/Provider/admin_provider.dart';
import 'package:lio_care/Provider/login_provider.dart';
import 'package:lio_care/User/screens/messageSendRecieve.dart';
import 'package:lio_care/User/screens/newDistribution_screen.dart';
import 'package:lio_care/User/screens/payment_success_screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:lio_care/models/NewDistributionModel.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:unique_identifier/unique_identifier.dart';
import 'package:url_launcher/url_launcher.dart';

import '../LockScreen/Update_Screen.dart';
import '../Service/device_info.dart';
import '../User/screens/bottomNavigation.dart';
import '../User/screens/confirmation_screen.dart';
import '../User/screens/help_Screen.dart';
import '../User/screens/message_screen.dart';
import '../User/screens/prc_screen.dart';
import '../admin/screens/admin_login_fixed_screen.dart';
import '../admin/screens/admin_login_screen.dart';
import '../constants/my_colors.dart';
import '../help_tree/help_tree_model.dart';
import '../help_tree/tree_provider.dart';
import '../models/admin_trasnaction_historyModelClass.dart';
import '../models/basic_treeListModel.dart';
import '../models/distributionModel.dart';
import '../models/getMessageModel.dart';
import '../models/lastTrasactionModel.dart';
import '../models/notification_model.dart';
import '../models/paymentReportModelClass.dart';
import '../models/pmfDetail_model.dart';
import '../models/reference_model.dart';
import '../models/transactions_model.dart';
import '../models/userLatestModel.dart';
import '../models/userNotificationModel.dart';
import '../models/user_giveHelpModel.dart';
import '../models/user_in_model.dart';
import '../models/usersList_model.dart';
import '../splash_screen.dart';
import '../view/loginScreen.dart';
import 'donation_provider.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController userNameCT = TextEditingController();
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();

  void addAdminsFazil() {}

  //asif
  TextEditingController messageController = TextEditingController();
  TextEditingController messagePasteLinkController = TextEditingController();
  TextEditingController testControllerCT = TextEditingController();
  TextEditingController userEmailCT = TextEditingController();
  TextEditingController userReferralCT = TextEditingController();
  TextEditingController userUPICT = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController aadhaarNumberController = TextEditingController();
  TextEditingController panNumberController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ifscCodeController = TextEditingController();
  TextEditingController upiIDController = TextEditingController();
  TextEditingController nomineeController = TextEditingController();
  TextEditingController nomineeAgeController = TextEditingController();
  TextEditingController nomineePhoneNumberController = TextEditingController();
  final DateRangePickerController _userDateRangePickerController =
      DateRangePickerController();

  ///////MY PROFILE///////
  TextEditingController myProfileNAMEEditingController =
      TextEditingController();
  TextEditingController myProfileNUMBEREditingController =
      TextEditingController();
  TextEditingController myProfileUPIIDEditingController =
      TextEditingController();

  bool isChecked = false;

  void toggleCheckbox() {
    isChecked = !isChecked;
    notifyListeners();
  }

  ValueNotifier<int> bottomSelectedIndex = ValueNotifier(0);
  bool payckagebool = false;
  bool gatewayHider = false;
  String whichTree = 'MASTER_CLUB';
  bool showTick = false;
  int limit = 50;
  bool showContainer = false;
  bool isUpiSelected = false;
  bool editCheck = false;
  bool editCheck2 = false;
  String dropImage = "";
  String dropText = "";
  List<String> gender = [
    'Male',
    'Female',
  ];
  var outputFormat = DateFormat('dd/MM/yyyy');
  var outTimeFormat = DateFormat('hh:mm:a');
  var outTimeFormat543 = DateFormat('EEEE,MMM d,yyyy hh:mm a');

  DateTime startDateUser = DateTime.now();
  DateTime endDateUser = DateTime.now();
  DateTime firstDateUser = DateTime.now();
  DateTime secondDateUser = DateTime.now();
  DateTime endDate2User = DateTime.now();
  String startDateFormatUser = '';
  String endDateFormatUser = '';
  String showSelectedDateUser = '';
  PickerDateRange selectedRangeUser = const PickerDateRange(null, null);
  DateTime selectedFirstDateUser = DateTime.now();
  DateTime selectedLastDateUser = DateTime.now();

  final ImagePicker picker = ImagePicker();
  File? fileImage;
  File? fileAdhaarImage;
  File? fileAdhaarSeconodSideImage;
  File? filePanImage;
  File? offerFileImage;
  File? receiptFileImage;
  File? taskSubmitFileImage;
  File? MessageFileImage;

  /// fetch data lists
  List<PMCModel> pmcDetailsList = [];
  List<PMCModel> donationDetailsList = [];
  List<InvitationModel> invitationDetailsList = [];
  List<DonationModel> myDonationList = [];
  List<MyTaskModel> myPendingTaskList = [];
  List<MyTaskModel> myAttendTaskList = [];

  // List<PMFModel> pmfDetailsList = [];
  // List<PMFModel> donationDetailsList = [];
  // List<InvitationModel> invitationDetailsList = [];
  // List<DonationModel> myDonationList = [];
  gatewayHideFun() {
    gatewayHider = true;
    notifyListeners();
  }

  gatewayShowFun() {
    gatewayHider = false;
    notifyListeners();
  }

  /// DAILY TOPPER
  List<LastTransactionModel> lastTransactionList = [];
  List<TransactionDateModel> lastTransactionDateList = [];
  var dayNodeLastTransaction = DateFormat('dd/MM/yyyy');

  String selectedStageDropdownItem = 'All Stages';
  List<String> allStagesItems = [
    "All Stages",
    'VIOLET',
    'INDIGO',
    'BLUE',
    'GREEN',
    'YELLOW',
    "ORANGE",
    'RED',
    'STAR',
    '2 STAR',
    '3 STAR',
    '4 STAR',
    '5 STAR',
    '6 STAR',
    '7 STAR',
    'SILVER',
    'GOLD',
    'PLATINUM',
    'DIAMOND',
    'ROYAL',
    'CROWN',
  ];
  List<String> allCrownLevelItems = [
    "ALL LEVEL",
    'SILVER',
    'GOLD',
    'PLATINUM',
    'DIAMOND',
    'ROYAL',
    'CROWN',
  ];
  List<String> allStarLevelItems = [
    "ALL LEVEL",
    'STAR',
    '2 STAR',
    '3 STAR',
    '4 STAR',
    '5 STAR',
    '6 STAR',
    '7 STAR',
  ];
  List<String> allMasterlevelsItems = [
    'ALL LEVEL',
    'ENTRY HELP',
    'VIOLET',
    'INDIGO',
    'BLUE',
    'GREEN',
    'YELLOW',
    "ORANGE",
    'RED',
  ];
  List<String> alllStatusItems = [
    'ALL STATUS',
    'PAID',
    'PENDING',
    'PROCESSING',
    'REJECTED'
  ];

  List treelist = ['Master Club', 'Star Club', 'Crown Club'];

  UserProvider() {
    getAppVersion();
    fetchLastTransactionList();
    getAppNameForAlert();
    fetchDetails();
    fetchSupportDetails();
  }


  String? appBuildVersion;
  String buildNumber = "";
  String currentVersion = "";

  Future<void> getAppVersion() async {
    PackageInfo.fromPlatform().then((value) {
      currentVersion = value.version;
      buildNumber = value.buildNumber;
      appBuildVersion = buildNumber;
      notifyListeners();
    });
  }

  Future<bool> checkVersionExist() async {
    var dataSnapshot = await mRoot.child("0").child('AppVersion').once();
    List<String> versions = dataSnapshot.snapshot.value.toString().split(',');

    print("versions,  $versions");
    print("appBuildVersion,  $appBuildVersion");

    if (versions.contains(appBuildVersion)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> confirmLocking(BuildContext context) async {
    var dataSnapshot = await mRoot.child("0").child('AppVersion').once();
    List<String> versions = dataSnapshot.snapshot.value.toString().split(',');

    print("versions,  $versions");

    if (versions.contains(appBuildVersion)) {
        print("if versions $versions");
        print("if app version $appBuildVersion");
        callNextReplacement(SplashScreen(), context);
      }else{
        print("else app version $appBuildVersion");
        print("else versions $versions");
      }


  }


  void lockApp() {
    mRoot.child("0").onValue.listen((event) async {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['AppVersion'].toString().split(',');
        print("versions,  $versions");
        print("appBuildVersion,  $appBuildVersion");
        print("currentVersion,  $appBuildVersion");
        if (!versions.contains(appBuildVersion)) {
          bool versionStatus = await checkVersionExist();

          if (!versionStatus) {
          String address = map['ADDRESS'].toString();
          String button = map['BUTTON'].toString();
          String text = map['TEXT'].toString();
          runApp(
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => DonationProvider(),),
                  ChangeNotifierProvider(create: (context) => UserProvider()),
                  ChangeNotifierProvider(create: (context) => LoginProvider()),
                  ChangeNotifierProvider(create: (context) => AdminProvider()),
                  ChangeNotifierProvider(create: (context) => TreeProvider()),
                ],
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    useMaterial3: true,
                    primarySwatch: Colors.blue,
                  ),
                    home: UpdateScreen(
                      address: address,
                      button: button,
                      text: text,
                    )
                ),
              ));
        }
        }else{
          print("ellse printed  $appBuildVersion");
        }
      }
    });
  }

  attemptPrc(BuildContext context, String orderID, String amount, String fromId,
      String distributionId) async {
    DateTime now = DateTime.now();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;

    String? strDeviceID = "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }

    HashMap<String, Object> map = HashMap();
    map["PACKAGE_VERSION"] = packageVersion;
    map["PHONE_NUMBER"] = userPhone;
    map["TIME"] = now.millisecondsSinceEpoch.toString();
    map["PAYMENT_STATUS"] = "ATTEMPT";
    // String strDeviceID = await DeviceInfo().fun_initPlatformState();
    map["DEVICE_ID"] = strDeviceID!;
    map["AMOUNT"] = double.parse(amount);
    map["USER_NAME"] = userName;
    map["FROM_USER_ID"] = fromId;
    map["GRADE"] = "";
    map["TREE"] = "MASTER_CLUB";
    map["PAYMENT_MODE"] = "APP_PAYMENT";
    map["PAYMENT_TYPE"] = "PRC";
    map["PAYMENT_TIME"] = now;
    map["APP_VERSION"] = appBuildVersion.toString();
    map["DISTRIBUTION_ID"] = distributionId;
    map["INSTALLMENT"] = "1";
    db.collection("ATTEMPTS").doc(orderID).set(map, SetOptions(merge: true));
    notifyListeners();
  }

  attemptPmCmf(
      BuildContext context,
      String orderID,
      String amount,
      String type,
      String grade,
      String fromId,
      String tree,
      String distributionId,
      int installment) async {
    DateTime now = DateTime.now();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String packageVersion = packageInfo.version;
    String? strDeviceID = "";
    try {
      strDeviceID = await UniqueIdentifier.serial;
    } on PlatformException {
      strDeviceID = 'Failed to get Unique Identifier';
    }
    HashMap<String, Object> map = HashMap();
    map["PHONE_NUMBER"] = userPhone;
    map["TIME"] = now.millisecondsSinceEpoch.toString();
    map["PAYMENT_STATUS"] = "ATTEMPT";
    // String strDeviceID = await DeviceInfo().fun_initPlatformState();
    map["DEVICE_ID"] = strDeviceID!;
    map["PACKAGE_VERSION"] = packageVersion;
    map["AMOUNT"] = double.parse(amount);
    map["USER_NAME"] = userName;
    map["FROM_USER_ID"] = fromId;
    map["GRADE"] = grade;
    map["TREE"] = tree;
    map["PAYMENT_MODE"] = "APP_PAYMENT";
    map["PAYMENT_TYPE"] = type;
    map["PAYMENT_TIME"] = now;
    map["APP_VERSION"] = appBuildVersion.toString();
    map["DISTRIBUTION_ID"] = distributionId;
    map["INSTALLMENT"] = installment.toString();
    db.collection("ATTEMPTS").doc(orderID).set(map, SetOptions(merge: true));
    notifyListeners();
  }

  List<LastTransactionModel> removeProcessDuplicate(
      List<LastTransactionModel> processModal) {
    List<LastTransactionModel> temp = [];
    List<String> sampleStrings = [];

    for (var sample in processModal) {
      var sampleString =
          "${sample.transactionID} ${sample.topperName} ${sample.topperAmount} ${sample.topperDate} ${sample.topperImage}";
      if (!sampleStrings.contains(sampleString)) {
        sampleStrings.add(sampleString);
        temp.add(sample);
      }
    }

    return temp;
  }

  List<UserInModel> removeIncomeDuplicate(List<UserInModel> processModal) {
    List<UserInModel> temp = [];
    List<String> sampleStrings = [];

    for (var sample in processModal) {
      // var sampleString = " ${sample.name} "
      //     "${sample.number} ${sample.status}${sample.amount}${sample.grade}${sample.paymentType}";
      var sampleString = sample.id;

      if (!sampleStrings.contains(sampleString)) {
        sampleStrings.add(sampleString);
        temp.add(sample);
      }
    }

    return temp;
  }

  List<PrivilegeModel> removePmcDuplicate(List<PrivilegeModel> processModal) {
    List<PrivilegeModel> temp = [];
    List<String> sampleStrings = [];

    for (var sample in processModal) {
      var sampleString = " ${sample.item} "
          "${sample.select}";

      if (!sampleStrings.contains(sampleString)) {
        sampleStrings.add(sampleString);
        temp.add(sample);
      }
    }

    return temp;
  }

  List<DistributionModel> removeDistributionDuplicate(
      List<DistributionModel> processModal) {
    List<DistributionModel> temp = [];
    List<String> sampleStrings = [];

    for (var sample in processModal) {
      var sampleString = sample.distributionId;
      if (!sampleStrings.contains(sampleString)) {
        sampleStrings.add(sampleString);
        temp.add(sample);
      }

      // var sampleString = "${sample.amount} ${sample.toId} ${sample.distributionId} "
      //     "${sample.screenShot} ${sample.type} ${sample.status}${sample.fromGrade}${sample.tree}"
      //     "${sample.proImage}${sample.name}${sample.phoneNumber}${sample.upiId}${sample.fromId}${sample.date}${sample.installment}";
      // if(!sampleStrings.contains(sampleString)){
      //   sampleStrings.add(sampleString);
      //   temp.add(sample);
      // }
    }

    return temp;
  }

  List<UpgradeModel> removeHelpDuplicate(List<UpgradeModel> processModal) {
    List<UpgradeModel> temp = [];
    List<String> sampleStrings = [];

    for (var sample in processModal) {
      var sampleString = "${sample.name} ${sample.id} ${sample.phone} "
          "${sample.amount}";
      if (!sampleStrings.contains(sampleString)) {
        sampleStrings.add(sampleString);
        temp.add(sample);
      }
    }

    return temp;
  }

  int lastTransactionCount = 0;

  fetchLastTransactionList() async {
    String date = '';
    String toDayNow = "";
    DateTime today = DateTime.now();
    toDayNow = dayNodeLastTransaction.format(today).toString();
    lastTransactionCount = 0;
    // var collectionRef;

    // QuerySnapshot querySnapshot = await db
    //     .collection("TRANSACTIONS")
    //     .where('DAY_NOW', isEqualTo: toDayNow)
    //     .where('PAYMENT_TYPE',
    //         whereIn: ["REFERRAL", "HELP", "STAR_CLUB", "CROWN_CLUB"])
    //     .orderBy("PAYMENT_TIME", descending: true)
    //     .get();
    // lastTransactionCount = querySnapshot.size;
    // notifyListeners();

    // if (!firstFetch) {
    //   collectionRef = db
    //       .collection("TRANSACTIONS")
    //       .where('DAY_NOW', isEqualTo: toDayNow)
    //       .where('PAYMENT_TYPE',
    //           whereIn: ["REFERRAL", "HELP", "STAR_CLUB", "CROWN_CLUB"])
    //       .orderBy("PAYMENT_TIME", descending: true)
    //       .startAfter([lastDoc])
    //       .limit(limit);
    // } else {
    //   collectionRef = db
    //       .collection("TRANSACTIONS")
    //       .where('DAY_NOW', isEqualTo: toDayNow)
    //       .where('PAYMENT_TYPE',
    //           whereIn: ["REFERRAL", "HELP", "STAR_CLUB", "CROWN_CLUB"])
    //       .orderBy("PAYMENT_TIME", descending: true)
    //       .limit(limit);
    //   lastTransactionList.clear();
    // }
    String dateFormat = "";
    String timeFormat = "";

    db
          .collection("TRANSACTIONS")
          // .where('DAY_NOW', isEqualTo: toDayNow)
          .where('PAYMENT_TYPE',
              whereIn: ["REFERRAL", "HELP", "STAR_CLUB", "CROWN_CLUB"])
          .orderBy("PAYMENT_TIME", descending: true)
          .limit(limit).snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        for (var element in event.docs) {
          Map<dynamic, dynamic> map = element.data();
          // date = outTimeFormat.format(map["PAYMENT_TIME"].toDate());

          db.collection("USERS").doc(map["TO_USER_ID"]).get().then((value) {
            if (value.exists) {
              Map<dynamic, dynamic> map2 = value.data() as Map;
              dateFormat = outputDayNode
                  .format(map["PAYMENT_TIME"].toDate())
                  .toString();

              lastTransactionList.add(LastTransactionModel(
                  element.id,
                  map2["NAME"] ?? "",
                  map["USER_NAME"] ?? "",
                  map["AMOUNT"],
                  map2["ItemImage"] ?? "",
                  outputDayNode.format(map["PAYMENT_TIME"].toDate()),
                  map["PAYMENT_TIME"].toDate(),
                  map["PAYMENT_TYPE"]));
              lastTransactionList
                  .sort((a, b) => b.transactionID.compareTo(a.transactionID));
              notifyListeners();
              lastTransactionList = removeProcessDuplicate(lastTransactionList);
              if (!lastTransactionDateList
                  .map((item) => item.dateFormat)
                  .contains(dateFormat)) {
                lastTransactionDateList.add(
                    TransactionDateModel(dateFormat, map["PAYMENT_TIME"].toDate()));
              }
              lastTransactionDateList.sort((a, b) => b.date.compareTo(a.date));
              notifyListeners();
            }
          });
        }
      }
      // else{
      //
      //
      //   db.collection("TRANSACTIONS")
      //       .where('PAYMENT_TYPE', whereIn: ["REFERRAL","UPGRADE","STAR_CLUB","CROWN_CLUB"])
      //       .orderBy("PAYMENT_TIME",descending: true).limit(1).get().then((event) {
      //     if (event.docs.isNotEmpty) {
      //       Map<dynamic, dynamic> map = event.docs.first.data();
      //       db.collection("USERS").doc(map["TO_USER_ID"]).get().then((value) {
      //         if (value.exists) {
      //           Map<dynamic, dynamic> map2 = value.data() as Map;
      //           lastTransactionList.add(LastTransactionModel(event.docs.first.id,map["USER_NAME"], map["AMOUNT"], map2["ItemImage"] ?? "",  outTimeFormat.format(map["PAYMENT_TIME"].toDate()),map["PAYMENT_TIME"].toDate()));
      //
      //           lastTransactionList=  removeProcessDuplicate(lastTransactionList);
      //           notifyListeners();
      //         }
      //       });
      //     }
      //   });
      //
      // }
    });
  }

  String lastTransactionHomeName = "";
  String lastTransactionHomeAmount = "";
  String lastTransactionHomeProImage = "";

  StreamSubscription? _streamLastTransactions;

  fetchLastOneTransaction() {
    if (_streamLastTransactions != null) {
      _streamLastTransactions!.cancel();
    }
    _streamLastTransactions = db
        .collection("TRANSACTIONS")
        .where("PAYMENT_TYPE", whereIn: ["REFERRAL", "STAR_CLUB", "CROWN_CLUB", "HELP"])
        .orderBy("PAYMENT_TIME", descending: true)
        .limit(1)
        .snapshots()
        .listen((event) {
      if (event.docs.isNotEmpty) {
        Map<dynamic, dynamic> map = event.docs.first.data();

        db.collection("USERS").doc(map["TO_USER_ID"]).get().then((value) {
          if (value.exists) {
            Map<dynamic, dynamic> map2 = value.data() as Map;
            lastTransactionHomeName = map2["NAME"] ?? "";
            lastTransactionHomeAmount = map["AMOUNT"].toString();
            lastTransactionHomeProImage = map2["ItemImage"] ?? "";
            notifyListeners();
          } else {
            print("User document does not exist");
          }
        }).catchError((error) {
          print("Error fetching user document: $error");
        });

        notifyListeners();
      } else {
        print("No documents found for the transaction query");
      }
    }, onError: (error) {
      print("Error listening to transaction query: $error");
    });
  }

  void taskFIleImageNull() {
    taskSubmitFileImage = null;
    notifyListeners();
  }

  allStageSelection(String val) {
    selectedStageDropdownItem = val;
    notifyListeners();
  }

  editCheckFun() {
    if (editCheck) {
      editCheck = false;
    } else {
      editCheck = true;
    }
    notifyListeners();
  }

  editCheckFun2() {
    if (editCheck2) {
      editCheck2 = false;
    } else {
      editCheck2 = true;
    }
    notifyListeners();
  }

  bool taskIndicator = false;

  // StreamSubscription? _streamTasks;
  fetchMyTasks(String userID) {
    print("Start Length${myPendingTaskList.length}");
    // if(_streamTasks!=null) {
    //   _streamTasks!.cancel();
    // }
    String date = '';
    String duration = '';
    DateTime now = DateTime.now();
    DateTime today = now.subtract(
        Duration(hours: now.hour, minutes: now.minute, seconds: now.second));
    myAttendTaskList.clear();
    myPendingTaskList.clear();

    // _streamTasks =
    db
        .collection("TASKS")
        .where("END_DATE", isGreaterThanOrEqualTo: today)
        .snapshots()
        .listen((value) {
      taskIndicator = false;
      if (value.docs.isNotEmpty) {
        taskIndicator = false;
        myAttendTaskList.clear();
        myPendingTaskList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          db
              .collection("TASKS")
              .doc(element.id)
              .collection("MEMBERS")
              .doc(userID)
              .get()
              .then((event) {
            if (event.exists) {
              Map<dynamic, dynamic> uMap = event.data() as Map;
              DateTime addedTime =
                  DateTime.parse(element["ADDED_TIME"].toDate().toString());
              DateTime startDate =
                  DateTime.parse(element["START_DATE"].toDate().toString());
              DateTime endDate =
                  DateTime.parse(element["END_DATE"].toDate().toString());
              date = DateFormat('dd/MM/yyyy').format(addedTime);
              duration =
                  "${DateFormat('dd/MM/yyyy').format(startDate)}-${DateFormat('dd/MM/yyyy').format(endDate)}";

              myAttendTaskList.add(MyTaskModel(
                  element.id,
                  map["TASK_HEADING"],
                  map["TASK"],
                  map["TASK_LINK"],
                  duration,
                  date,
                  uMap["STATUS"]));
              notifyListeners();
            } else {
              taskIndicator = true;
              String status = "PENDING";
              DateTime addedTime =
                  DateTime.parse(element["ADDED_TIME"].toDate().toString());
              date = DateFormat('dd/MM/yyyy').format(addedTime);
              myPendingTaskList.add(MyTaskModel(element.id, map["TASK_HEADING"],
                  map["TASK"], map["TASK_LINK"], duration, date, status));

              print("End Length${myPendingTaskList.length}");
              notifyListeners();
            }
          });
        }
        // notifyListeners();
      }
    });
  }

  addMyTaskInToTaskCollection(String taskID, String userID) {
    HashMap<String, Object> taskMap = HashMap();

    taskMap['USER_ID'] = userID;
    taskMap['STATUS'] = "ATTEND";
    db
        .collection("TASKS")
        .doc(taskID)
        .collection("MEMBERS")
        .doc(userID)
        .set(taskMap, SetOptions(merge: true));

    fetchMyTasks(userID);

    notifyListeners();
  }

  String generateRandomString(int length) {
    final random = Random();
    const availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    final randomString = List.generate(length,
            (index) => availableChars[random.nextInt(availableChars.length)])
        .join();
    return randomString;
  }

  dropSelect(String image, String name) {
    dropImage = image;
    dropText = name;
    notifyListeners();
  }

  containerDrop() {
    if (showContainer) {
      showContainer = false;
    } else {
      showContainer = true;
    }
    notifyListeners();
  }

  clearRegistrationField() {
    phoneNumberController.clear();
    userReferralCT.clear();
    userNameCT.clear();
    userEmailCT.clear();
    userUPICT.clear();
    userReferralCT.clear();
    dropText = "";
    dropImage = "";
    isUpiSelected = false;
    notifyListeners();
  }

  void launchGooglePay(String from) async {
    String url;
    if (from == "GPAY") {
      url = "tez://upi/url";
    } else if (from == "PHONEPAY") {
      url = "phonepe://url";
    } else {
      url = "paytmmp://mini-app?";
    }

    //'upi://pay?pa=yourmerchantid@yourupiaddress&pn=Your%20Merchant%20Name&mc=yourmerchantcode&mr=yourtransactionreferenceid&tn=yourtransactionnote&am=transactionamount&cu=INR';
// "upi://url?";
    //"upi://pay?pa=&pn=%20&tr=%20&cu=INR";
    //     "upi://pay";
    // "upi://pay?pa=xyz&pn=pqr&tr=abc&am=1000";
    // tez://upi/url
    // phonepe://url

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Pay';
    }
  }

  double totalPmc = 0;
  double totalDon = 0;

  fetchPMCDetails(String id) {
    pmcDetailsList.clear();
    String date = '';
    String time = '';
    db
        .collection("PAYMENTS")
        .where("FROM_USER_ID", isEqualTo: id)
        .where("PAYMENT_TYPE", isEqualTo: "PMC")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        pmcDetailsList.clear();
        totalPmc = 0;
        totalDon = 0;
        for (var element in value.docs) {
          date = outputFormat.format(element["PAYMENT_TIME"].toDate());
          time = outTimeFormat.format(element["PAYMENT_TIME"].toDate());
          pmcDetailsList.add(PMCModel(
              element.id,
              date,
              element["PAYMENT_STATUS"],
              element["AMOUNT"].toString(),
              element["GRADE"],
              element["TREE"],
              time,
              element["INSTALLMENT"]));
          notifyListeners();
        }
        totalPmc = pmcDetailsList.fold(
            0,
            (previousValue, element) =>
                previousValue + double.parse(element.amount));
        notifyListeners();
        // else{
        //   totalDon = pmfDetailsList.fold(0, (previousValue, element) => previousValue + double.parse(element.amount));
        //   notifyListeners();
        // }
      }
    });
  }

  fetchDonationDetails(String id) {
    donationDetailsList.clear();
    String date = '';
    String time = '';
    db
        .collection("PAYMENTS")
        .where("FROM_USER_ID", isEqualTo: id)
        .where("PAYMENT_TYPE", isEqualTo: "CMF")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        donationDetailsList.clear();
        totalDon = 0;
        for (var element in value.docs) {
          date = outputFormat.format(element["PAYMENT_TIME"].toDate());
          time = outTimeFormat.format(element["PAYMENT_TIME"].toDate());
          donationDetailsList.add(PMCModel(
              element.id,
              date,
              element["PAYMENT_STATUS"],
              element["AMOUNT"].toString(),
              element["GRADE"],
              element["TREE"],
              time,
              element["INSTALLMENT"]));
          notifyListeners();
        }
        totalDon = donationDetailsList.fold(
            0,
            (previousValue, element) =>
                previousValue + double.parse(element.amount));
        notifyListeners();
      }
    });
  }

  fetchMyInvitations(String fromID) {
    invitationDetailsList.clear();
    db
        .collection("DISTRIBUTION_TEST")
        .where("FROM_ID", isEqualTo: fromID)
        .where("TYPE", isEqualTo: "REFERRAL")
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        invitationDetailsList.clear();
        for (var element in value.docs) {
          invitationDetailsList.add(InvitationModel(
              element["NAME"],
              element.id,
              element["PHONE"],
              element["DATE"],
              element["STATUS"],
              element["AMOUNT"]));
        }
      }
      notifyListeners();
    });
  }

  Future<bool> checkNumberExist(String phone) async {
    var D = await db.collection("USERS").where("PHONE", isEqualTo: phone).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkMailExist(String mail) async {
    var D = await db.collection("USERS").where("EMAIL", isEqualTo: mail).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkUpiExist(String upi) async {
    var D = await db.collection("USERS").where("UPI_ID", isEqualTo: upi).get();
    if (D.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkLevelStatus(
      String fromLevel,
      String toLevel,
      String userStatus,
      String toUserId,
      String toUserType,
      BuildContext context2) async {
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    restrictionBool = false;
    userStatusBool = false;
    userGradeBool = false;
    print(
        "values : from - $fromLevel to - $toLevel status - $userStatus   user id - $toUserId   user type - $toUserType");

    if (toUserType != "ADMIN LEADER") {
      if (userStatus == "ACTIVE") {
        if (fromLevel == "") {
          if (toLevel == "") {
            userGradeBool = true;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            finish(context2);
            return true;
          }
        } else if (fromLevel == "VIOLET") {
          if (toLevel == "" || toLevel == "VIOLET") {
            userGradeBool = true;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            finish(context2);
            return true;
          }
        } else if (fromLevel == "INDIGO") {
          if (toLevel == "" || toLevel == "VIOLET" || toLevel == "INDIGO") {
            userGradeBool = true;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            finish(context2);
            return true;
          }
        } else if (fromLevel == "BLUE") {
          if (toLevel == "" ||
              toLevel == "VIOLET" ||
              toLevel == "INDIGO" ||
              toLevel == "BLUE") {
            userGradeBool = true;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            bool distCheck = await checkBlue3StarInstallment(
                toUserId, fromLevel, "GREEN", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          }
        } else if (fromLevel == "GREEN") {
          if (toLevel == "YELLOW" ||
              toLevel == "ORANGE" ||
              toLevel == "RED" ||
              toLevel == "MASTER ACHIEVER") {
            bool distCheck = await checkGreenInstallment(
                toUserId, fromLevel, "YELLOW", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          } else {
            userGradeBool = true;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "YELLOW") {
          if (toLevel == "ORANGE" ||
              toLevel == "RED" ||
              toLevel == "MASTER ACHIEVER") {
            bool distCheck = await checkYellow5StarInstallment(
                toUserId, fromLevel, "ORANGE", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "ORANGE") {
          if (toLevel == "RED" || toLevel == "MASTER ACHIEVER") {
            bool distCheck = await checkOrangeInstallment(
                toUserId, fromLevel, "RED", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "RED") {
          if (toLevel == "MASTER ACHIEVER") {
            finish(context2);
            return true;
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "STAR") {
          if (toLevel == "" || toLevel == "STAR") {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            finish(context2);
            return true;
          }
        } else if (fromLevel == "2 STAR") {
          if (toLevel == "" || toLevel == "STAR" || toLevel == "2 STAR") {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            finish(context2);
            return true;
          }
        } else if (fromLevel == "3 STAR") {
          if (toLevel == "" ||
              toLevel == "STAR" ||
              toLevel == "2 STAR" ||
              toLevel == "3 STAR") {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            bool distCheck = await checkBlue3StarInstallment(
                toUserId, fromLevel, "4 STAR", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          }
        } else if (fromLevel == "4 STAR") {
          if (toLevel == "5 STAR" ||
              toLevel == "6 STAR" ||
              toLevel == "7 STAR" ||
              toLevel == "STAR CLUB ACHIEVER") {
            bool distCheck = await check4StarInstallment(
                toUserId, fromLevel, "5 STAR", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "5 STAR") {
          if (toLevel == "6 STAR" ||
              toLevel == "7 STAR" ||
              toLevel == "STAR CLUB ACHIEVER") {
            bool distCheck = await checkYellow5StarInstallment(
                toUserId, fromLevel, "6 STAR", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "6 STAR") {
          if (toLevel == "7 STAR" || toLevel == "STAR CLUB ACHIEVER") {
            bool distCheck = await check6StarInstallment(
                toUserId, fromLevel, "7 STAR", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "7 STAR") {
          if (toLevel == "STAR CLUB ACHIEVER") {
            finish(context2);
            return true;
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "SILVER") {
          if (toLevel == "" || toLevel == "SILVER") {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            finish(context2);
            return true;
          }
        } else if (fromLevel == "GOLD") {
          if (toLevel == "" || toLevel == "SILVER" || toLevel == "GOLD") {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            bool distCheck = await checkGoldInstallment(
                toUserId, fromLevel, "PLATINUM", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          }
        } else if (fromLevel == "PLATINUM") {
          if (toLevel == "" ||
              toLevel == "SILVER" ||
              toLevel == "GOLD" ||
              toLevel == "PLATINUM") {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          } else {
            bool distCheck = await checkPlatinumInstallment(
                toUserId, fromLevel, "DIAMOND", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          }
        } else if (fromLevel == "DIAMOND") {
          if (toLevel == "ROYAL" ||
              toLevel == "CROWN" ||
              toLevel == "CROWN CLUB ACHIEVER") {
            bool distCheck = await checkDiamondInstallment(
                toUserId, fromLevel, "ROYAL", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "ROYAL") {
          if (toLevel == "CROWN" || toLevel == "CROWN CLUB ACHIEVER") {
            bool distCheck = await checkRoyalInstallment(
                toUserId, fromLevel, "CROWN", context2);
            if (distCheck) {
              finish(context2);
              return true;
            } else {
              restrictionBool = true;
              notifyListeners();
              finish(context2);
              return false;
            }
          } else {
            userGradeBool = false;
            notifyListeners();
            finish(context2);
            return false;
          }
        } else if (fromLevel == "CROWN") {
          if (toLevel == "CROWN CLUB ACHIEVER") {
            finish(context2);
            return true;
          } else {
            finish(context2);
            return false;
          }
        } else {
          userGradeBool = false;
          notifyListeners();
          finish(context2);
          return false;
        }
      } else {
        print("kkkxkkkxkskxks");
        userStatusBool = true;
        notifyListeners();
        finish(context2);
        return false;
      }
    } else {
      finish(context2);
      return true;
    }
  }

  String restrictionCheck = '';
  String restrictionCheck2 = '';
  bool restrictionBool = false;
  bool restrictionBool2 = false;
  bool userStatusBool = false;
  bool userGradeBool = false;

  Future<bool> checkBlue3StarInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", whereIn: ["PAID", "PROCESSING"])
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;
    if (distIncomeLength < 10) {
      return true;
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "PMC 1";
        restrictionBool = true;
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "CMF 1";
        restrictionBool = true;
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "PMC 2";
        restrictionBool = true;
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 13) {
      if (distCMFExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "CMF 2";
        restrictionBool = true;
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength > 13) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkGreenInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", whereIn: ["PAID", "PROCESSING"])
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;

    if (distIncomeLength < 10) {
      return true;
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "PMC 1";
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "CMF 1";
        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "PMC 2";
        return false;
      }
    } else if (distIncomeLength == 13) {
      if (distCMFExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "CMF 2";

        return false;
      }
    } else if (distIncomeLength == 14) {
      if (distPMCExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "PMC 3";
        return false;
      }
    } else if (distIncomeLength == 15) {
      if (distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "CMF 3";

        return false;
      }
    } else if (distIncomeLength == 16) {
      if (distPMCExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "PMC 4";

        return false;
      }
    } else if (distIncomeLength == 17) {
      if (distCMFExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "CMF 4";

        return false;
      }
    } else if (distIncomeLength == 18) {
      if (distPMCExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "PMC 5";
        return false;
      }
    } else if (distIncomeLength == 19) {
      if (distCMFExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "CMF 5";

        return false;
      }
    } else if (distIncomeLength > 19) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkYellow5StarInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;

    if (distIncomeLength < 10) {
      return true;
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "PMC 1";
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "CMF 1";

        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "PMC 2";
        return false;
      }
    } else if (distIncomeLength == 13) {
      if (distCMFExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "CMF 2";

        return false;
      }
    } else if (distIncomeLength == 14) {
      if (distPMCExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "PMC 3";
        return false;
      }
    } else if (distIncomeLength == 15) {
      if (distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "CMF 3";

        return false;
      }
    } else if (distIncomeLength == 16) {
      if (distPMCExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "PMC 4";
        return false;
      }
    } else if (distIncomeLength == 17) {
      if (distCMFExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "CMF 4";

        return false;
      }
    } else if (distIncomeLength == 18) {
      if (distPMCExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "PMC 5";
        return false;
      }
    } else if (distIncomeLength == 19) {
      if (distCMFExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "CMF 5";

        return false;
      }
    } else if (distIncomeLength == 20) {
      if (distPMCExpenseLength > 5) {
        return true;
      } else {
        restrictionCheck = "PMC 6";
        return false;
      }
    } else if (distIncomeLength == 21) {
      if (distCMFExpenseLength > 5) {
        return true;
      } else {
        restrictionCheck = "CMF 6";

        return false;
      }
    } else if (distIncomeLength == 22) {
      if (distPMCExpenseLength > 6) {
        return true;
      } else {
        restrictionCheck = "PMC 7";
        return false;
      }
    } else if (distIncomeLength == 23) {
      if (distCMFExpenseLength > 6) {
        return true;
      } else {
        restrictionCheck = "CMF 7";
        return false;
      }
    } else if (distIncomeLength == 24) {
      if (distPMCExpenseLength > 7) {
        return true;
      } else {
        restrictionCheck = "PMC 8";
        return false;
      }
    } else if (distIncomeLength == 25) {
      if (distCMFExpenseLength > 7) {
        return true;
      } else {
        restrictionCheck = "CMF 8";
        return false;
      }
    } else if (distIncomeLength == 26) {
      if (distPMCExpenseLength > 8) {
        return true;
      } else {
        restrictionCheck = "PMC 9";
        return false;
      }
    } else if (distIncomeLength == 27) {
      if (distCMFExpenseLength > 8) {
        return true;
      } else {
        restrictionCheck = "CMF 9";

        return false;
      }
    } else if (distIncomeLength == 28) {
      if (distPMCExpenseLength > 9) {
        return true;
      } else {
        restrictionCheck = "PMC 10";
        return false;
      }
    } else if (distIncomeLength == 29) {
      if (distCMFExpenseLength > 9) {
        return true;
      } else {
        restrictionCheck = "CMF 10";

        return false;
      }
    } else if (distIncomeLength == 30) {
      if (distPMCExpenseLength > 10) {
        return true;
      } else {
        restrictionCheck = "PMC 11";
        return false;
      }
    } else if (distIncomeLength == 31) {
      if (distCMFExpenseLength > 10) {
        return true;
      } else {
        restrictionCheck = "CMF 11";

        return false;
      }
    } else if (distIncomeLength == 32) {
      if (distPMCExpenseLength > 11) {
        return true;
      } else {
        restrictionCheck = "PMC 12";
        return false;
      }
    } else if (distIncomeLength == 33) {
      if (distCMFExpenseLength > 11) {
        return true;
      } else {
        restrictionCheck = "CMF 12";

        return false;
      }
    } else if (distIncomeLength == 34) {
      if (distPMCExpenseLength > 12) {
        return true;
      } else {
        restrictionCheck = "PMC 13";
        return false;
      }
    } else if (distIncomeLength == 35) {
      if (distCMFExpenseLength > 12) {
        return true;
      } else {
        restrictionCheck = "CMF 13";

        return false;
      }
    } else if (distIncomeLength == 36) {
      if (distPMCExpenseLength > 13) {
        return true;
      } else {
        restrictionCheck = "PMC 14";
        return false;
      }
    } else if (distIncomeLength == 37) {
      if (distCMFExpenseLength > 13) {
        return true;
      } else {
        restrictionCheck = "CMF 14";

        return false;
      }
    } else if (distIncomeLength == 38) {
      if (distPMCExpenseLength > 14) {
        return true;
      } else {
        restrictionCheck = "PMC 15";
        return false;
      }
    } else if (distIncomeLength == 39) {
      if (distCMFExpenseLength > 14) {
        return true;
      } else {
        restrictionCheck = "CMF 15";

        return false;
      }
    } else if (distIncomeLength == 40) {
      if (distPMCExpenseLength > 15) {
        return true;
      } else {
        restrictionCheck = "PMC 16";
        return false;
      }
    } else if (distIncomeLength == 41) {
      if (distCMFExpenseLength > 15) {
        return true;
      } else {
        restrictionCheck = "CMF 16";

        return false;
      }
    } else if (distIncomeLength == 42) {
      if (distPMCExpenseLength > 16) {
        return true;
      } else {
        restrictionCheck = "PMC 17";
        return false;
      }
    } else if (distIncomeLength == 43) {
      if (distCMFExpenseLength > 16) {
        return true;
      } else {
        restrictionCheck = "CMF 17";
        return false;
      }
    } else if (distIncomeLength == 44) {
      if (distPMCExpenseLength > 17) {
        return true;
      } else {
        restrictionCheck = "PMC 18";
        return false;
      }
    } else if (distIncomeLength == 45) {
      if (distCMFExpenseLength > 17) {
        return true;
      } else {
        restrictionCheck = "CMF 18";
        return false;
      }
    } else if (distIncomeLength == 46) {
      if (distPMCExpenseLength > 18) {
        return true;
      } else {
        restrictionCheck = "PMC 19";
        return false;
      }
    } else if (distIncomeLength == 47) {
      if (distCMFExpenseLength > 18) {
        return true;
      } else {
        restrictionCheck = "CMF 19";
        return false;
      }
    } else if (distIncomeLength == 48) {
      if (distPMCExpenseLength > 19) {
        return true;
      } else {
        restrictionCheck = "PMC 20";
        return false;
      }
    } else if (distIncomeLength == 49) {
      if (distCMFExpenseLength > 19) {
        return true;
      } else {
        restrictionCheck = "CMF 20";
        return false;
      }
    } else if (distIncomeLength > 49) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkOrangeInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();
    QuerySnapshot distSponsorExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "REFERRAL")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;
    int distSponsorExpenseLength = distSponsorExpense.size;

    if (distIncomeLength < 9) {
      return true;
    } else if (distIncomeLength == 9) {
      if (distSponsorExpenseLength > 0) {
        return true;
      } else {
        return false;
      }
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "PMC 1";
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "CMF 1";
        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "PMC 2";
        return false;
      }
    } else if (distIncomeLength == 13) {
      if (distCMFExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "CMF 2";
        return false;
      }
    } else if (distIncomeLength == 14) {
      if (distPMCExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "PMC 3";
        return false;
      }
    } else if (distIncomeLength == 15) {
      if (distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "CMF 3";
        return false;
      }
    } else if (distIncomeLength == 16) {
      if (distPMCExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "PMC 4";
        return false;
      }
    } else if (distIncomeLength == 17) {
      if (distCMFExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "CMF 4";
        return false;
      }
    } else if (distIncomeLength == 18) {
      if (distPMCExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "PMC 5";
        return false;
      }
    } else if (distIncomeLength == 19) {
      if (distCMFExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "CMF 5";
        return false;
      }
    } else if (distIncomeLength == 20) {
      if (distPMCExpenseLength > 5) {
        return true;
      } else {
        restrictionCheck = "PMC 6";
        return false;
      }
    } else if (distIncomeLength == 21) {
      if (distCMFExpenseLength > 5) {
        return true;
      } else {
        restrictionCheck = "CMF 6";
        return false;
      }
    } else if (distIncomeLength == 22) {
      if (distPMCExpenseLength > 6) {
        return true;
      } else {
        restrictionCheck = "PMC 7";
        return false;
      }
    } else if (distIncomeLength == 23) {
      if (distCMFExpenseLength > 6) {
        return true;
      } else {
        restrictionCheck = "CMF 7";
        return false;
      }
    } else if (distIncomeLength == 24) {
      if (distPMCExpenseLength > 7) {
        return true;
      } else {
        restrictionCheck = "PMC 8";
        return false;
      }
    } else if (distIncomeLength == 25) {
      if (distCMFExpenseLength > 7) {
        return true;
      } else {
        restrictionCheck = "CMF 8";
        return false;
      }
    } else if (distIncomeLength == 26) {
      if (distPMCExpenseLength > 8) {
        return true;
      } else {
        restrictionCheck = "PMC 9";
        return false;
      }
    } else if (distIncomeLength == 27) {
      if (distCMFExpenseLength > 8) {
        return true;
      } else {
        restrictionCheck = "CMF 9";
        return false;
      }
    } else if (distIncomeLength == 28) {
      if (distPMCExpenseLength > 9) {
        return true;
      } else {
        restrictionCheck = "PMC 10";
        return false;
      }
    } else if (distIncomeLength == 29) {
      if (distCMFExpenseLength > 9) {
        return true;
      } else {
        restrictionCheck = "CMF 10";
        return false;
      }
    } else if (distIncomeLength == 30) {
      if (distPMCExpenseLength > 10) {
        return true;
      } else {
        restrictionCheck = "PMC 11";
        return false;
      }
    } else if (distIncomeLength == 31) {
      if (distCMFExpenseLength > 10) {
        return true;
      } else {
        restrictionCheck = "CMF 11";
        return false;
      }
    } else if (distIncomeLength == 32) {
      if (distPMCExpenseLength > 11) {
        return true;
      } else {
        restrictionCheck = "PMC 12";
        return false;
      }
    } else if (distIncomeLength == 33) {
      if (distCMFExpenseLength > 11) {
        return true;
      } else {
        restrictionCheck = "CMF 12";
        return false;
      }
    } else if (distIncomeLength == 34) {
      if (distPMCExpenseLength > 12) {
        return true;
      } else {
        restrictionCheck = "PMC 13";
        return false;
      }
    } else if (distIncomeLength == 35) {
      if (distCMFExpenseLength > 12) {
        return true;
      } else {
        restrictionCheck = "CMF 13";
        return false;
      }
    } else if (distIncomeLength == 36) {
      if (distPMCExpenseLength > 13) {
        return true;
      } else {
        restrictionCheck = "PMC 14";
        return false;
      }
    } else if (distIncomeLength == 37) {
      if (distCMFExpenseLength > 13) {
        return true;
      } else {
        restrictionCheck = "CMF 14";
        return false;
      }
    } else if (distIncomeLength == 38) {
      if (distPMCExpenseLength > 14) {
        return true;
      } else {
        restrictionCheck = "PMC 15";
        return false;
      }
    } else if (distIncomeLength == 39) {
      if (distCMFExpenseLength > 14) {
        return true;
      } else {
        restrictionCheck = "CMF 15";
        return false;
      }
    } else if (distIncomeLength == 40) {
      if (distPMCExpenseLength > 15) {
        return true;
      } else {
        restrictionCheck = "PMC 16";
        return false;
      }
    } else if (distIncomeLength == 41) {
      if (distCMFExpenseLength > 15) {
        return true;
      } else {
        restrictionCheck = "CMF 16";
        return false;
      }
    } else if (distIncomeLength == 42) {
      if (distPMCExpenseLength > 16) {
        return true;
      } else {
        restrictionCheck = "PMC 17";
        return false;
      }
    } else if (distIncomeLength == 43) {
      if (distCMFExpenseLength > 16) {
        return true;
      } else {
        restrictionCheck = "CMF 17";
        return false;
      }
    } else if (distIncomeLength == 44) {
      if (distPMCExpenseLength > 17) {
        return true;
      } else {
        restrictionCheck = "PMC 18";
        return false;
      }
    } else if (distIncomeLength == 45) {
      if (distCMFExpenseLength > 17) {
        return true;
      } else {
        restrictionCheck = "CMF 18";
        return false;
      }
    } else if (distIncomeLength == 46) {
      if (distPMCExpenseLength > 18) {
        return true;
      } else {
        restrictionCheck = "PMC 19";
        return false;
      }
    } else if (distIncomeLength == 47) {
      if (distCMFExpenseLength > 18) {
        return true;
      } else {
        restrictionCheck = "CMF 19";
        return false;
      }
    } else if (distIncomeLength == 48) {
      if (distPMCExpenseLength > 19) {
        return true;
      } else {
        restrictionCheck = "PMC 20";
        return false;
      }
    } else if (distIncomeLength == 49) {
      if (distCMFExpenseLength > 19) {
        return true;
      } else {
        restrictionCheck = "CMF 20";
        return false;
      }
    } else if (distIncomeLength == 50) {
      if (distPMCExpenseLength > 20) {
        return true;
      } else {
        restrictionCheck = "PMC 21";
        return false;
      }
    } else if (distIncomeLength == 51) {
      if (distCMFExpenseLength > 20) {
        return true;
      } else {
        restrictionCheck = "CMF 21";
        return false;
      }
    } else if (distIncomeLength == 52) {
      if (distPMCExpenseLength > 21) {
        return true;
      } else {
        restrictionCheck = "PMC 22";
        return false;
      }
    } else if (distIncomeLength == 53) {
      if (distCMFExpenseLength > 21) {
        return true;
      } else {
        restrictionCheck = "CMF 22";
        return false;
      }
    } else if (distIncomeLength == 54) {
      if (distPMCExpenseLength > 22) {
        return true;
      } else {
        restrictionCheck = "PMC 23";
        return false;
      }
    } else if (distIncomeLength == 55) {
      if (distCMFExpenseLength > 22) {
        return true;
      } else {
        restrictionCheck = "CMF 23";
        return false;
      }
    } else if (distIncomeLength == 56) {
      if (distPMCExpenseLength > 23) {
        return true;
      } else {
        restrictionCheck = "PMC 24";
        return false;
      }
    } else if (distIncomeLength == 57) {
      if (distCMFExpenseLength > 23) {
        return true;
      } else {
        restrictionCheck = "CMF 24";
        return false;
      }
    } else if (distIncomeLength == 58) {
      if (distPMCExpenseLength > 24) {
        return true;
      } else {
        restrictionCheck = "PMC 25";
        return false;
      }
    } else if (distIncomeLength == 59) {
      if (distCMFExpenseLength > 24) {
        return true;
      } else {
        restrictionCheck = "CMF 24";
        return false;
      }
    } else if (distIncomeLength > 59) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> check4StarInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;

    if (distIncomeLength < 10) {
      return true;
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "PMC 1";
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "CMF 1";
        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "PMC 2";
        return false;
      }
    } else if (distIncomeLength == 13) {
      if (distCMFExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "CMF 2";
        return false;
      }
    } else if (distIncomeLength == 14) {
      if (distPMCExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "PMC 3";
        return false;
      }
    } else if (distIncomeLength == 15) {
      if (distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "CMF 3";
        return false;
      }
    } else if (distIncomeLength == 16) {
      if (distPMCExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "PMC 4";
        return false;
      }
    } else if (distIncomeLength == 17) {
      if (distCMFExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "CMF 4";
        return false;
      }
    } else if (distIncomeLength == 18) {
      if (distPMCExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "PMC 5";
        return false;
      }
    } else if (distIncomeLength == 19) {
      if (distCMFExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "CMF 5";
        return false;
      }
    } else if (distIncomeLength == 20) {
      if (distPMCExpenseLength > 5) {
        return true;
      } else {
        restrictionCheck = "PMC 6";
        return false;
      }
    } else if (distIncomeLength == 21) {
      if (distCMFExpenseLength > 5) {
        return true;
      } else {
        restrictionCheck = "CMF 6";
        return false;
      }
    } else if (distIncomeLength == 22) {
      if (distPMCExpenseLength > 6) {
        return true;
      } else {
        restrictionCheck = "PMC 7";
        return false;
      }
    } else if (distIncomeLength == 23) {
      if (distCMFExpenseLength > 6) {
        return true;
      } else {
        restrictionCheck = "CMF 7";
        return false;
      }
    } else if (distIncomeLength == 24) {
      if (distPMCExpenseLength > 7) {
        return true;
      } else {
        restrictionCheck = "PMC 8";
        return false;
      }
    } else if (distIncomeLength == 25) {
      if (distCMFExpenseLength > 7) {
        return true;
      } else {
        restrictionCheck = "CMF 8";
        return false;
      }
    } else if (distIncomeLength == 26) {
      if (distPMCExpenseLength > 8) {
        return true;
      } else {
        restrictionCheck = "PMC 9";
        return false;
      }
    } else if (distIncomeLength == 27) {
      if (distCMFExpenseLength > 8) {
        return true;
      } else {
        restrictionCheck = "CMF 9";
        return false;
      }
    } else if (distIncomeLength == 28) {
      if (distPMCExpenseLength > 9) {
        return true;
      } else {
        restrictionCheck = "PMC 10";
        return false;
      }
    } else if (distIncomeLength == 29) {
      if (distCMFExpenseLength > 9) {
        return true;
      } else {
        restrictionCheck = "CMF 10";
        return false;
      }
    } else if (distIncomeLength > 29) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> check6StarInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;

    if (distIncomeLength < 10) {
      return true;
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "PMC 1";
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionCheck = "CMF 1";
        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "PMC 2";
        return false;
      }
    } else if (distIncomeLength == 13) {
      if (distCMFExpenseLength > 1) {
        return true;
      } else {
        restrictionCheck = "CMF 2";
        return false;
      }
    } else if (distIncomeLength == 14) {
      if (distPMCExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "PMC 3";
        return false;
      }
    } else if (distIncomeLength == 15) {
      if (distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck = "CMF 3";
        return false;
      }
    } else if (distIncomeLength == 16) {
      if (distPMCExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "PMC 4";
        return false;
      }
    } else if (distIncomeLength == 17) {
      if (distCMFExpenseLength > 3) {
        return true;
      } else {
        restrictionCheck = "CMF 4";
        return false;
      }
    } else if (distIncomeLength == 18) {
      if (distPMCExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "PMC 5";
        return false;
      }
    } else if (distIncomeLength == 19) {
      if (distCMFExpenseLength > 4) {
        return true;
      } else {
        restrictionCheck = "CMF 5";
        return false;
      }
    } else if (distIncomeLength == 20) {
      if (distPMCExpenseLength > 5) {
        return true;
      } else {
        restrictionCheck = "PMC 6";
        return false;
      }
    } else if (distIncomeLength == 21) {
      if (distCMFExpenseLength > 5) {
        return true;
      } else {
        restrictionCheck = "CMF 6";
        return false;
      }
    } else if (distIncomeLength == 22) {
      if (distPMCExpenseLength > 6) {
        return true;
      } else {
        restrictionCheck = "PMC 7";
        return false;
      }
    } else if (distIncomeLength == 23) {
      if (distCMFExpenseLength > 6) {
        return true;
      } else {
        restrictionCheck = "CMF 7";
        return false;
      }
    } else if (distIncomeLength == 24) {
      if (distPMCExpenseLength > 7) {
        return true;
      } else {
        restrictionCheck = "PMC 8";
        return false;
      }
    } else if (distIncomeLength == 25) {
      if (distCMFExpenseLength > 7) {
        return true;
      } else {
        restrictionCheck = "CMF 8";
        return false;
      }
    } else if (distIncomeLength == 26) {
      if (distPMCExpenseLength > 8) {
        return true;
      } else {
        restrictionCheck = "PMC 9";
        return false;
      }
    } else if (distIncomeLength == 27) {
      if (distCMFExpenseLength > 8) {
        return true;
      } else {
        restrictionCheck = "CMF 9";
        return false;
      }
    } else if (distIncomeLength == 28) {
      if (distPMCExpenseLength > 9) {
        return true;
      } else {
        restrictionCheck = "PMC 10";
        return false;
      }
    } else if (distIncomeLength == 29) {
      if (distCMFExpenseLength > 9) {
        return true;
      } else {
        restrictionCheck = "CMF 10";
        return false;
      }
    } else if (distIncomeLength == 30) {
      if (distPMCExpenseLength > 10) {
        return true;
      } else {
        restrictionCheck = "PMC 11";
        return false;
      }
    } else if (distIncomeLength == 31) {
      if (distCMFExpenseLength > 10) {
        return true;
      } else {
        restrictionCheck = "CMF 11";
        return false;
      }
    } else if (distIncomeLength == 32) {
      if (distPMCExpenseLength > 11) {
        return true;
      } else {
        restrictionCheck = "PMC 12";
        return false;
      }
    } else if (distIncomeLength == 33) {
      if (distCMFExpenseLength > 11) {
        return true;
      } else {
        restrictionCheck = "CMF 12";
        return false;
      }
    } else if (distIncomeLength == 34) {
      if (distPMCExpenseLength > 12) {
        return true;
      } else {
        restrictionCheck = "PMC 13";
        return false;
      }
    } else if (distIncomeLength == 35) {
      if (distCMFExpenseLength > 12) {
        return true;
      } else {
        restrictionCheck = "CMF 13";
        return false;
      }
    } else if (distIncomeLength == 36) {
      if (distPMCExpenseLength > 13) {
        return true;
      } else {
        restrictionCheck = "PMC 14";
        return false;
      }
    } else if (distIncomeLength == 37) {
      if (distCMFExpenseLength > 13) {
        return true;
      } else {
        restrictionCheck = "CMF 14";
        return false;
      }
    } else if (distIncomeLength == 38) {
      if (distPMCExpenseLength > 14) {
        return true;
      } else {
        restrictionCheck = "PMC 15";
        return false;
      }
    } else if (distIncomeLength == 39) {
      if (distCMFExpenseLength > 14) {
        return true;
      } else {
        restrictionCheck = "CMF 15";
        return false;
      }
    } else if (distIncomeLength == 40) {
      if (distPMCExpenseLength > 15) {
        return true;
      } else {
        restrictionCheck = "PMC 16";
        return false;
      }
    } else if (distIncomeLength == 41) {
      if (distCMFExpenseLength > 15) {
        return true;
      } else {
        restrictionCheck = "CMF 16";
        return false;
      }
    } else if (distIncomeLength == 42) {
      if (distPMCExpenseLength > 16) {
        return true;
      } else {
        restrictionCheck = "PMC 17";
        return false;
      }
    } else if (distIncomeLength == 43) {
      if (distCMFExpenseLength > 16) {
        return true;
      } else {
        restrictionCheck = "CMF 17";
        return false;
      }
    } else if (distIncomeLength == 44) {
      if (distPMCExpenseLength > 17) {
        return true;
      } else {
        restrictionCheck = "PMC 18";
        return false;
      }
    } else if (distIncomeLength == 45) {
      if (distCMFExpenseLength > 17) {
        return true;
      } else {
        restrictionCheck = "CMF 18";
        return false;
      }
    } else if (distIncomeLength == 46) {
      if (distPMCExpenseLength > 18) {
        return true;
      } else {
        restrictionCheck = "PMC 19";
        return false;
      }
    } else if (distIncomeLength == 47) {
      if (distCMFExpenseLength > 18) {
        return true;
      } else {
        restrictionCheck = "CMF 19";
        return false;
      }
    } else if (distIncomeLength == 48) {
      if (distPMCExpenseLength > 19) {
        return true;
      } else {
        restrictionCheck = "PMC 20";
        return false;
      }
    } else if (distIncomeLength == 49) {
      if (distCMFExpenseLength > 19) {
        return true;
      } else {
        restrictionCheck = "CMF 20";
        return false;
      }
    } else if (distIncomeLength == 50) {
      if (distPMCExpenseLength > 20) {
        return true;
      } else {
        restrictionCheck = "PMC 21";
        return false;
      }
    } else if (distIncomeLength == 51) {
      if (distCMFExpenseLength > 20) {
        return true;
      } else {
        restrictionCheck = "CMF 21";
        return false;
      }
    } else if (distIncomeLength == 52) {
      if (distPMCExpenseLength > 21) {
        return true;
      } else {
        restrictionCheck = "PMC 22";
        return false;
      }
    } else if (distIncomeLength == 53) {
      if (distCMFExpenseLength > 21) {
        return true;
      } else {
        restrictionCheck = "CMF 22";
        return false;
      }
    } else if (distIncomeLength == 54) {
      if (distPMCExpenseLength > 22) {
        return true;
      } else {
        restrictionCheck = "PMC 23";
        return false;
      }
    } else if (distIncomeLength == 55) {
      if (distCMFExpenseLength > 22) {
        return true;
      } else {
        restrictionCheck = "CMF 23";
        return false;
      }
    } else if (distIncomeLength == 56) {
      if (distPMCExpenseLength > 23) {
        return true;
      } else {
        restrictionCheck = "PMC 24";
        return false;
      }
    } else if (distIncomeLength == 57) {
      if (distCMFExpenseLength > 23) {
        return true;
      } else {
        restrictionCheck = "CMF 24";
        return false;
      }
    } else if (distIncomeLength == 58) {
      if (distPMCExpenseLength > 24) {
        return true;
      } else {
        restrictionCheck = "PMC 25";
        return false;
      }
    } else if (distIncomeLength == 59) {
      if (distCMFExpenseLength > 24) {
        return true;
      } else {
        restrictionCheck = "CMF 25";
        return false;
      }
    } else if (distIncomeLength == 60) {
      if (distPMCExpenseLength > 25) {
        return true;
      } else {
        restrictionCheck = "PMC 26";
        return false;
      }
    } else if (distIncomeLength == 61) {
      if (distCMFExpenseLength > 25) {
        return true;
      } else {
        restrictionCheck = "CMF 26";
        return false;
      }
    } else if (distIncomeLength == 62) {
      if (distPMCExpenseLength > 26) {
        return true;
      } else {
        restrictionCheck = "PMC 27";
        return false;
      }
    } else if (distIncomeLength == 63) {
      if (distCMFExpenseLength > 26) {
        return true;
      } else {
        restrictionCheck = "CMF 27";
        return false;
      }
    } else if (distIncomeLength == 64) {
      if (distPMCExpenseLength > 27) {
        return true;
      } else {
        restrictionCheck = "PMC 28";
        return false;
      }
    } else if (distIncomeLength == 65) {
      if (distCMFExpenseLength > 27) {
        return true;
      } else {
        restrictionCheck = "CMF 28";
        return false;
      }
    } else if (distIncomeLength == 66) {
      if (distPMCExpenseLength > 28) {
        return true;
      } else {
        restrictionCheck = "PMC 29";
        return false;
      }
    } else if (distIncomeLength == 67) {
      if (distCMFExpenseLength > 28) {
        return true;
      } else {
        restrictionCheck = "CMF 29";
        return false;
      }
    } else if (distIncomeLength == 68) {
      if (distPMCExpenseLength > 29) {
        return true;
      } else {
        restrictionCheck = "PMC 30";
        return false;
      }
    } else if (distIncomeLength == 69) {
      if (distCMFExpenseLength > 29) {
        return true;
      } else {
        restrictionCheck = "CMF 30";
        return false;
      }
    } else if (distIncomeLength > 69) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkGoldInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;

    if (distIncomeLength < 4) {
      return true;
    } else if (distIncomeLength == 4) {
      if (distPMCExpenseLength > 0 && distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 1";
        restrictionCheck = "PMC 1";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 5) {
      if (distCMFExpenseLength > 1 && distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 2";
        restrictionCheck = "PMC 2";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 6) {
      if (distPMCExpenseLength > 2 && distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionCheck2 = "CMF 3";
        restrictionCheck = "PMC 3";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength > 6) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkPlatinumInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;

    if (distIncomeLength < 4) {
      return true;
    } else if (distIncomeLength == 4) {
      if (distPMCExpenseLength > 0 && distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 1";
        restrictionCheck = "PMC 1";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 5) {
      if (distCMFExpenseLength > 1 && distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 2";
        restrictionCheck = "PMC 2";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 6) {
      if (distPMCExpenseLength > 2 && distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 3";
        restrictionCheck = "PMC 3";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 7) {
      if (distPMCExpenseLength > 3 && distCMFExpenseLength > 3) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 4";
        restrictionCheck = "PMC 4";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 8) {
      if (distPMCExpenseLength > 4 && distCMFExpenseLength > 4) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 5";
        restrictionCheck = "PMC 5";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 9) {
      if (distPMCExpenseLength > 5 && distCMFExpenseLength > 5) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 6";
        restrictionCheck = "PMC 6";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 6 && distCMFExpenseLength > 6) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 7";
        restrictionCheck = "PMC 7";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distPMCExpenseLength > 7 && distCMFExpenseLength > 7) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 8";
        restrictionCheck = "PMC 8";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 8 && distCMFExpenseLength > 8) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 9";
        restrictionCheck = "PMC 9";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 13) {
      if (distPMCExpenseLength > 9 && distCMFExpenseLength > 9) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 10";
        restrictionCheck = "PMC 10";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength > 13) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkDiamondInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;

    if (distIncomeLength < 4) {
      return true;
    } else if (distIncomeLength == 4) {
      if (distPMCExpenseLength > 0 && distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 1";
        restrictionCheck = "PMC 1";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 5) {
      if (distCMFExpenseLength > 1 && distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 2";
        restrictionCheck = "PMC 2";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 6) {
      if (distPMCExpenseLength > 2 && distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 3";
        restrictionCheck = "PMC 3";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 7) {
      if (distPMCExpenseLength > 3 && distCMFExpenseLength > 3) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 4";
        restrictionCheck = "PMC 4";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 8) {
      if (distPMCExpenseLength > 4 && distCMFExpenseLength > 4) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 5";
        restrictionCheck = "PMC 5";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 9) {
      if (distPMCExpenseLength > 5 && distCMFExpenseLength > 5) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 6";
        restrictionCheck = "PMC 6";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 6 && distCMFExpenseLength > 6) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 7";
        restrictionCheck = "PMC 7";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distPMCExpenseLength > 7 && distCMFExpenseLength > 7) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 8";
        restrictionCheck = "PMC 8";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 8 && distCMFExpenseLength > 8) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 9";
        restrictionCheck = "PMC 9";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 14) {
      if (distPMCExpenseLength > 10 && distCMFExpenseLength > 10) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 11";
        restrictionCheck = "PMC 11";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 15) {
      if (distPMCExpenseLength > 11 && distCMFExpenseLength > 11) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 12";
        restrictionCheck = "PMC 12";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 16) {
      if (distPMCExpenseLength > 12 && distCMFExpenseLength > 12) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 13";
        restrictionCheck = "PMC 13";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 17) {
      if (distPMCExpenseLength > 13 && distCMFExpenseLength > 13) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 14";
        restrictionCheck = "PMC 14";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 18) {
      if (distPMCExpenseLength > 14 && distCMFExpenseLength > 14) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 15";
        restrictionCheck = "PMC 15";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength > 18) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkRoyalInstallment(String toUserId, String fromLevel,
      String toLevel, BuildContext context2) async {
    QuerySnapshot distIncome = await db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: fromLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "HELP")
        .get();

    QuerySnapshot distPMCExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "PMC")
        .get();

    QuerySnapshot distCMFExpense = await db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: toUserId)
        .where("GRADE", isEqualTo: toLevel)
        .where("STATUS", isEqualTo: "PAID")
        .where("TYPE", isEqualTo: "CMF")
        .get();

    int distIncomeLength = distIncome.size;
    int distCMFExpenseLength = distCMFExpense.size;
    int distPMCExpenseLength = distPMCExpense.size;

    if (distIncomeLength < 4) {
      return true;
    } else if (distIncomeLength == 4) {
      if (distPMCExpenseLength > 0 && distCMFExpenseLength > 0) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 1";
        restrictionCheck = "PMC 1";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 5) {
      if (distCMFExpenseLength > 1 && distPMCExpenseLength > 1) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 2";
        restrictionCheck = "PMC 2";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 6) {
      if (distPMCExpenseLength > 2 && distCMFExpenseLength > 2) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 3";
        restrictionCheck = "PMC 3";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 7) {
      if (distPMCExpenseLength > 3 && distCMFExpenseLength > 3) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 4";
        restrictionCheck = "PMC 4";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 8) {
      if (distPMCExpenseLength > 4 && distCMFExpenseLength > 4) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 5";
        restrictionCheck = "PMC 5";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 9) {
      if (distPMCExpenseLength > 5 && distCMFExpenseLength > 5) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 6";
        restrictionCheck = "PMC 6";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 10) {
      if (distPMCExpenseLength > 6 && distCMFExpenseLength > 6) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 7";
        restrictionCheck = "PMC 7";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 11) {
      if (distPMCExpenseLength > 7 && distCMFExpenseLength > 7) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 8";
        restrictionCheck = "PMC 8";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 12) {
      if (distPMCExpenseLength > 8 && distCMFExpenseLength > 8) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 9";
        restrictionCheck = "PMC 9";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 14) {
      if (distPMCExpenseLength > 10 && distCMFExpenseLength > 10) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 11";
        restrictionCheck = "PMC 11";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 15) {
      if (distPMCExpenseLength > 11 && distCMFExpenseLength > 11) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 12";
        restrictionCheck = "PMC 12";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 16) {
      if (distPMCExpenseLength > 12 && distCMFExpenseLength > 12) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 13";
        restrictionCheck = "PMC 13";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 17) {
      if (distPMCExpenseLength > 13 && distCMFExpenseLength > 13) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 14";
        restrictionCheck = "PMC 14";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 18) {
      if (distPMCExpenseLength > 14 && distCMFExpenseLength > 14) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 15";
        restrictionCheck = "PMC 15";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 19) {
      if (distPMCExpenseLength > 15 && distCMFExpenseLength > 15) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 16";
        restrictionCheck = "PMC 16";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 20) {
      if (distPMCExpenseLength > 16 && distCMFExpenseLength > 16) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 17";
        restrictionCheck = "PMC 17";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 21) {
      if (distPMCExpenseLength > 17 && distCMFExpenseLength > 17) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 18";
        restrictionCheck = "PMC 18";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 22) {
      if (distPMCExpenseLength > 18 && distCMFExpenseLength > 18) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 19";
        restrictionCheck = "PMC 19";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 23) {
      if (distPMCExpenseLength > 19 && distCMFExpenseLength > 19) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 20";
        restrictionCheck = "PMC 20";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 24) {
      if (distPMCExpenseLength > 20 && distCMFExpenseLength > 20) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 21";
        restrictionCheck = "PMC 21";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 25) {
      if (distPMCExpenseLength > 21 && distCMFExpenseLength > 21) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 22";
        restrictionCheck = "PMC 22";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 26) {
      if (distPMCExpenseLength > 22 && distCMFExpenseLength > 22) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 23";
        restrictionCheck = "PMC 23";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 27) {
      if (distPMCExpenseLength > 23 && distCMFExpenseLength > 23) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 24";
        restrictionCheck = "PMC 24";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength == 28) {
      if (distPMCExpenseLength > 24 && distCMFExpenseLength > 24) {
        return true;
      } else {
        restrictionBool2 = true;
        restrictionCheck2 = "CMF 25";
        restrictionCheck = "PMC 25";
        notifyListeners();
        return false;
      }
    } else if (distIncomeLength > 28) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkAutoLevelStatus(String fromLevel, String toLevel,
      String userStatus, BuildContext context2) async {
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });

    if (fromLevel != "" && toLevel != "" && userStatus == "ACTIVE") {
      if (fromLevel == "STARTER") {
        if (toLevel == "STARTER") {
          finish(context2);
          return false;
        } else {
          finish(context2);
          return true;
        }
      } else if (fromLevel == "VIOLET") {
        if (toLevel == "STARTER" || toLevel == "VIOLET") {
          finish(context2);
          return false;
        } else {
          finish(context2);
          return true;
        }
      } else if (fromLevel == "INDIGO") {
        if (toLevel == "STARTER" ||
            toLevel == "VIOLET" ||
            toLevel == "INDIGO") {
          finish(context2);
          return false;
        } else {
          finish(context2);
          return true;
        }
      } else if (fromLevel == "BLUE") {
        if (toLevel == "STARTER" ||
            toLevel == "VIOLET" ||
            toLevel == "INDIGO" ||
            toLevel == "BLUE") {
          finish(context2);
          return false;
        } else {
          finish(context2);
          return true;
        }
      } else if (fromLevel == "GREEN") {
        if (toLevel == "YELLOW" ||
            toLevel == "ORANGE" ||
            toLevel == "RED" ||
            toLevel == "MASTER") {
          finish(context2);
          return true;
        } else {
          finish(context2);
          return false;
        }
      } else if (fromLevel == "YELLOW") {
        if (toLevel == "ORANGE" || toLevel == "RED" || toLevel == "MASTER") {
          finish(context2);
          return true;
        } else {
          finish(context2);
          return false;
        }
      } else if (fromLevel == "ORANGE") {
        if (toLevel == "RED" || toLevel == "MASTER") {
          finish(context2);
          return true;
        } else {
          finish(context2);
          return false;
        }
      } else if (fromLevel == "RED") {
        if (toLevel == "MASTER") {
          finish(context2);
          return true;
        } else {
          finish(context2);
          return false;
        }
      } else {
        finish(context2);
        return false;
      }
    } else {
      finish(context2);
      return false;
    }
  }

  bool kycBool = false;
  bool childCountBool = false;
  bool distClear = false;
  bool incomeClear = false;

  Future<bool> checkKycStatusAndChild(
      String kycStatus, String grade,String clubName, BuildContext context2) async {
    kycBool = false;
    childCountBool = false;
    distClear = false;
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });

    var distributionSnapshot = await db.collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: registerID)
        .where("GRADE", isEqualTo: grade)
        .where("STATUS", whereIn: ["PENDING","PROCESSING","REJECTED",]).count().get();

    var querySnapshot = await db.collection("USERS")
        .where("REFERENCE", isEqualTo: registerID)
        .where("STATUS", isEqualTo: "ACTIVE").count().get();

    String incomeLevel = clubName == "STAR_CLUB"?"INDIGO":"BLUE";
    var incomeSnapshot = await db.collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: registerID)
        .where("GRADE", isEqualTo: incomeLevel)
        .where("STATUS", isEqualTo: "PAID").count().get();


    int clubCount = clubName == "STAR_CLUB"?8:16;
    int childCount = querySnapshot.count;
    int distCount = distributionSnapshot.count;
    int incomeCount = incomeSnapshot.count;

    distClear = distCount < 2;
    kycBool = kycStatus == "VERIFIED";
    childCountBool = childCount > 1;
    incomeClear = incomeCount == clubCount;
    notifyListeners();
    if(distClear && kycBool && childCountBool && incomeClear){
      finish(context2);
      return true;
    }else{
      finish(context2);
      return false;
    }
  }

  Future<bool> checkKycIdExist(
      String idNumber, String memberId, BuildContext context2) async {
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    var D = await db
        .collection("USERS")
        .where("ID_NUMBER", isEqualTo: idNumber)
        .where("MEMBER_ID", isNotEqualTo: memberId)
        .get();

    if (D.docs.isNotEmpty) {
      finish(context2);
      return true;
    } else {
      finish(context2);
      return false;
    }
  }

  Future<bool> checkKycPanExist(
      String panNumber, String memberId, BuildContext context2) async {
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    var D = await db
        .collection("USERS")
        .where("PAN_NUMBER", isEqualTo: panNumber)
        .where("MEMBER_ID", isNotEqualTo: memberId)
        .get();

    if (D.docs.isNotEmpty) {
      finish(context2);
      return true;
    } else {
      finish(context2);
      return false;
    }
  }

  Future<bool> checkKycAccountExist(
      String accountNumber, String memberId, BuildContext context2) async {
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    var D = await db
        .collection("USERS")
        .where("ACCOUNT_NUMBER", isEqualTo: accountNumber)
        .where("MEMBER_ID", isNotEqualTo: memberId)
        .get();

    if (D.docs.isNotEmpty) {
      finish(context2);
      return true;
    } else {
      finish(context2);
      return false;
    }
  }

  Future<bool> checkKycUpiIdExist(
      String upiIdNumber, String memberId, BuildContext context2) async {
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    var D = await db
        .collection("USERS")
        .where("UPI_Id", isEqualTo: upiIdNumber)
        .where("MEMBER_ID", isNotEqualTo: memberId)
        .get();

    if (D.docs.isNotEmpty) {
      finish(context2);
      return true;
    } else {
      finish(context2);
      return false;
    }
  }

  Future<bool> checkRefIdExist(String refId, BuildContext context2) async {
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    await db
        .collection("USERS")
        .where("REFERRAL_ID", isEqualTo: refId)
        .where("STATUS", isEqualTo: "ACTIVE")
        .get()
        .then((refValue) {
      if (refValue.docs.isNotEmpty) {
        Map<dynamic, dynamic> memberValueMap = refValue.docs.first.data() as Map;
        refereeId = memberValueMap["MEMBER_ID"].toString();
        refereeRegName = memberValueMap["NAME"].toString();

        notifyListeners();
      }
    });
    var D = await db
        .collection("USERS")
        .where("REFERRAL_ID", isEqualTo: refId)
        .where("STATUS", isEqualTo: "ACTIVE")
        .get();

    if (D.docs.isNotEmpty) {
      finish(context2);
      return true;
    } else {
      finish(context2);
      return false;
    }
  }

  findNextLevel(String currentLevel, String memberId, String tree) async {
    if (tree == "MASTER_CLUB") {
      if (currentLevel == "") {
        return "VIOLET";
      } else if (currentLevel == "VIOLET") {
        return "INDIGO";
      } else if (currentLevel == "INDIGO") {
        return "BLUE";
      } else if (currentLevel == "BLUE") {
        return "GREEN";
      } else if (currentLevel == "GREEN") {
        return "YELLOW";
      } else if (currentLevel == "YELLOW") {
        return "ORANGE";
      } else if (currentLevel == "ORANGE") {
        return "RED";
      } else if (currentLevel == "RED") {
        return "MASTER ACHIEVER";
      }
    } else if (tree == "STAR_CLUB") {
      if (currentLevel == "") {
        return "STAR";
      } else if (currentLevel == "STAR") {
        return "2 STAR";
      } else if (currentLevel == "2 STAR") {
        return "3 STAR";
      } else if (currentLevel == "3 STAR") {
        return "4 STAR";
      } else if (currentLevel == "4 STAR") {
        return "5 STAR";
      } else if (currentLevel == "5 STAR") {
        return "6 STAR";
      } else if (currentLevel == "6 STAR") {
        return "7 STAR";
      } else if (currentLevel == "7 STAR") {
        return "STAR CLUB ACHIEVER";
      }
    } else if (tree == "CROWN_CLUB") {
      if (currentLevel == "") {
        return "SILVER";
      } else if (currentLevel == "SILVER") {
        return "GOLD";
      } else if (currentLevel == "GOLD") {
        return "PLATINUM";
      } else if (currentLevel == "PLATINUM") {
        return "DIAMOND";
      } else if (currentLevel == "DIAMOND") {
        return "ROYAL";
      } else if (currentLevel == "ROYAL") {
        return "CROWN";
      } else if (currentLevel == "CROWN") {
        return "CROWN CLUB ACHIEVER";
      }
    }
  }

  generateNextBasicDistributions(String currentLevel, String memberId,
      String tree, String userDocId) async {
    if (currentLevel == "") {
      await generateVioletDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "VIOLET") {
      await generateIndigoDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "INDIGO") {
      await generateBlueDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "BLUE") {
      await generateGreenDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "GREEN") {
      await generateYellowDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "YELLOW") {
      await generateOrangeDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "ORANGE") {
      await generateRedDistributions(memberId, tree);
    }
  }

  generateNextOneDistributions(String currentLevel, String memberId,
      String tree, String userDocId) async {
    if (currentLevel == "") {
      await generateStarDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "STAR") {
      await generate2StarDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "2 STAR") {
      await generate3StarDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "3 STAR") {
      await generate4StarDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "4 STAR") {
      await generate5StarDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "5 STAR") {
      await generate6StarDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "6 STAR") {
      await generate7StarDistributions(memberId, tree);
    }
  }

  generateNextTwoDistributions(String currentLevel, String memberId,
      String tree, String userDocId) async {
    if (currentLevel == "") {
      await generateSilverDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "SILVER") {
      await generateGoldDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "GOLD") {
      await generatePlatinumDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "PLATINUM") {
      await generateDiamondDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "DIAMOND") {
      await generateRoyalDistributions(memberId, tree, userDocId);
    } else if (currentLevel == "ROYAL") {
      await generateCrownDistributions(memberId, tree);
    }
  }

  var outputDayNode = DateFormat('dd/MM/yyyy');
  var outputDayNode2 = DateFormat('h:mm a');

  String refereeId = '';
  String refereeRegName = '';

  clearOnRegistration() {
    // clearDistributions();
    // clearFunction();
    notificationLength = 0;
    filterUpgradeParentsList.clear();
    notificationList.clear();
    tranactionDateList.clear();
    haveNotification = false;
    userReferenceList.clear();
    userInList.clear();
    totaluserReferralTransaction = 0;
    userReferralTransactionList.clear();
    userClearedReferralTransactionList.clear();
    myAttendTaskList.clear();
    getMessageList.clear();
    messageDateList.clear();
    notifyListeners();
  }

  addOnRegistration(
    String distId,
    String upiCt,
    String phone,
    String name,
    String memberId,
  ) {
    DateTime now = DateTime.now();
    userPmcBool = true;
    userPmcStatus = "PENDING";
    userPmcAmount = "100";
    userPmcGrade = "STARTER";
    userPmcTree = "MASTER_CLUB";
    userPmcDistributionId = distId;
    upiIDController.text = upiCt;
    userPhone = phone;
    userName = name;
    userGrade = "STARTER";
    registerID = memberId;
    Duration difference = currentDate.difference(now);
    leftDays = totalDays - (joinDate = difference.inDays);
    notifyListeners();
  }

  userRegistration(String refMember, var token, BuildContext context) async {
    print("irshad");
    bool numberStatus = await checkNumberExist(phoneNumberController.text);
    bool refStatus = await checkRefIdExist(refMember, context);
    bool mailStatus = await checkMailExist(userEmailCT.text.trim());
    bool upiStatus = await checkUpiExist(userUPICT.text.trim());
    if (!mailStatus) {
      if (!upiStatus) {
        if (refStatus) {
          if (!numberStatus) {
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                });
            AdminProvider adminProvider =
                Provider.of<AdminProvider>(context, listen: false);
            List<String> fcmList = [];

            FirebaseMessaging.instance.getToken().then((fcmValue) async {
              print(fcmValue.toString() + "effawxwefrvasweefv");
              DateTime now = DateTime.now();
              String memberId = now.millisecondsSinceEpoch.toString() +
                  generateRandomString(2);
              String documentId = now.microsecondsSinceEpoch.toString() +
                  generateRandomString(2);
              HashMap<String, Object> userMap = HashMap();

              String userRegName = userNameCT.text.trim();
              String userRegMail = userEmailCT.text.trim();
              String userRegNumber = phoneNumberController.text.trim();
              String userRegUpi = userUPICT.text.trim();

              userMap['NAME'] = userRegName;
              userMap['EMAIL'] = userRegMail;
              userMap['PHONE'] = userRegNumber;
              userMap["TOTAL_EARNINGS"] = 0;
              userMap["TOTAL_REFERRAL_AMOUNT"] = 0;
              userMap["TOTAL_REFERRAL_COUNT"] = 0;
              userMap["TOTAL_PMC"] = 0;
              userMap["TOTAL_CMF"] = 0;
              userMap["TOTAL_HELP"] = 0;
              userMap['REG_DATE'] = now;
              userMap['MEMBER_ID'] = memberId;
              userMap['DOCUMENT_ID'] = documentId;
              userMap["STATUS"] = "IN_ACTIVE";
              userMap["KYC_STATUS"] = "PENDING";
              userMap["TYPE"] = "MEMBER";
              userMap["ItemImage"] = "";
              userMap["FCM_ID"] = fcmValue.toString();
              userMap["UPI_Id"] = userRegUpi;
              userMap["UPI_App"] = dropText;
              userMap["UPI_Image"] = dropImage;
              userMap["GRADE"] = "";
              userMap["CHILD_COUNT"] = 0;
              userMap["REFERENCE"] = refereeId;
              userMap["REFERENCE_NAME"] = refereeRegName;
              userMap["REFERENCE_NUMBER"] = refMember;
              userMap["REFERRAL_ID"] = userRegNumber;

              await db.collection('USERS').doc(memberId).set(userMap);

              HashMap<String, Object> pmcMap = HashMap();
              pmcMap["AMOUNT"] = "100";
              pmcMap["DATE"] = now;
              pmcMap["INSTALLMENT"] = 1;
              pmcMap["FROM_ID"] = memberId;
              pmcMap["TYPE"] = "PRC";
              pmcMap["STATUS"] = "PENDING";
              pmcMap["GRADE"] = "";
              pmcMap["TREE"] = "MASTER_CLUB";

              String distributionId =
                  DateTime.now().millisecondsSinceEpoch.toString() +
                      generateRandomString(4);
              await db
                  .collection("DISTRIBUTIONS")
                  .doc(distributionId)
                  .set(pmcMap, SetOptions(merge: true));

              List<String> toIdList = [refereeId];

              HashMap<String, Object> notificationMap = HashMap();
              notificationMap["CONTENT"] =
                  "$userRegName ($userRegNumber) Joined By Your Link, Assist him with proper guidance to be an active member.";
              notificationMap["FROM_ID"] = memberId;
              notificationMap["TO_ID"] = toIdList;
              notificationMap["NOTIFICATION_ID"] = memberId;
              notificationMap['REG_DATE'] = now;
              notificationMap["VIEWERS"] = [];
              notificationMap["DATE"] = outputDayNode.format(now).toString();
              notificationMap["TIME"] = outputDayNode2.format(now).toString();

              db.collection('NOTIFICATIONS').doc(memberId).set(notificationMap);

              db.collection("REFERENCES").doc(memberId).set({
                "REFERRED_ID": memberId,
                "REFERER_ID": refereeId,
              }, SetOptions(merge: true));

              // userPmcBool=true;
              // userPmcStatus = "PENDING";
              // userPmcAmount = "100";
              // userPmcGrade = "STARTER";
              // userPmcTree = "MASTER_CLUB";
              // userPmcDistributionId = distributionId;
              // upiIDController.text = userUPICT.text.trim();
              // userPhone = phoneNumberController.text.trim();
              // userName = userNameCT.text.trim();
              // userGrade = "STARTER";
              // registerID = memberId;
              // Duration difference = currentDate.difference(now);
              // leftDays = totalDays - (joinDate = difference.inDays);

              // fetchFirstNotification(memberId);
              // fetchUserReferences(memberId);
              // fetchInTransactions(memberId,"MASTER_CLUB");
              // userReferenceList.clear();
              // fetchReferralTransactions(memberId);
              // getMessages(memberId);

              isFirstTime = true;
              // getUserDetails(memberId);

              notifyListeners();
              clearRegistrationField();

              // callNextReplacement(LoginScreen(referralId: ''), context);
              registrationAlert(context, memberId, userRegNumber, userRegMail,
                  refMember, userRegName, userRegUpi);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('appwrite_token', token);
              prefs.setString('phone_number', '+91$userRegNumber');
            });
            finish(context);
          } else {
            warningAlert(context, "Phone Number already exist.");
          }
        } else {
          warningAlert(context, "Invalid Reference Id.");
        }
      } else {
        warningAlert(context, "UPI id already exist.");
      }
    } else {
      warningAlert(context, "Mail id already exist.");
    }
  }

  registrationAlert(BuildContext context, String memberID, String phone,
      String mail, String referral, String name, String upiId) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.all(39),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: clF8FAFF,
      scrollable: true,
      //alertContent
      title: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff16B200))),
            child: const Icon(
              Icons.check,
              color: Color(0xff16B200),
              size: 28,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Registration Success",
            style: TextStyle(
              color: Color(0xff16B200),
              fontSize: 16,
              fontFamily: 'PoppinsMedium',
              fontWeight: FontWeight.w600,
              // height: 1,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Opacity(
            opacity: 0.80,
            child: Text(
              "Registration completed. Kindly pay PRC amount to become an active member",
              style: TextStyle(
                color: cl252525,
                fontSize: 15,
                fontFamily: 'PoppinsMedium',
                fontWeight: FontWeight.w400,
                height: 1.33,
              ),
            ),
          ),
          const SizedBox(height: 15),
          InkWell(
            onTap: () async {
              await clearOnRegistration();
              fetchPrcPayment(memberID);
              // callNextReplacement(BottomNavigationScreen(Userid: memberID,), context);
              callNextReplacement(
                  PRCScreen(
                      userName: name,
                      phoneNumber: phone,
                      email: mail,
                      upiId: upiId,
                      referral: referral),
                  context);
            },
            child: Container(
              width: 130,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: const BoxDecoration(
                color: Color(0xff2F7DC1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: const Text(
                'Ok',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () async => false, child: alert);
      },
    );
  }

  prcIssuePlaceMemberInTree(
      String memberId, String userFcmId, BuildContext context) async {
    print("reached 21");
    db.collection("USERS").doc(memberId).get().then((memberValue11) async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          });
      Map<dynamic, dynamic> memberValueMap = memberValue11.data() as Map;
      AdminProvider adminProvider =
          Provider.of<AdminProvider>(context, listen: false);
      List<String> fcmList = [];
      userReferenceList.clear();
      print("reached 21fgfgfghhhhhhhhh");

      print("reached 21fgfgfg");
      DateTime now = DateTime.now();
      String notificationId =
          now.millisecondsSinceEpoch.toString() + generateRandomString(2);
      String documentId = memberValueMap["DOCUMENT_ID"].toString();
      String refMember = memberValueMap["REFERENCE"].toString();
      String memberName = memberValueMap["NAME"].toString();
      String memberPhone = memberValueMap["PHONE"].toString();
      String memberImage = memberValueMap["ItemImage"] ?? "";
      String memberUpiId = memberValueMap["UPI_Id"].toString();

      HashMap<String, Object> userMap = HashMap();

      HashMap<String, Object> treeMap = HashMap();
      treeMap["DOCUMENT_ID"] = documentId;
      treeMap["FCM_ID"] = userFcmId;
      treeMap['NAME'] = memberName;
      treeMap['PHONE'] = memberPhone;
      treeMap["MEMBER_ID"] = memberId;
      treeMap['REG_DATE'] = now;
      treeMap["GRADE"] = "";
      treeMap["CHILD_COUNT"] = 0;
      treeMap["REFERENCE"] = refMember;
      treeMap["ItemImage"] = memberImage;
      treeMap["UPI_Id"] = memberUpiId;
      treeMap["STATUS"] = "ACTIVE";
      treeMap["TYPE"] = "MEMBER";

      List<String> toIdList = [refMember];

      HashMap<String, Object> notificationMap = HashMap();
      notificationMap["CONTENT"] =
          "$memberName completed PRC payment and placed in Master Club.";
      notificationMap["FROM_ID"] = memberId;
      notificationMap["NOTIFICATION_ID"] = memberId;
      notificationMap['REG_DATE'] = now;
      notificationMap["VIEWERS"] = [];
      notificationMap["DATE"] = outputDayNode.format(now).toString();
      notificationMap["TIME"] = outputDayNode2.format(now).toString();

      // await db.collection("MASTER_CLUB").doc(documentId).set(treeMap);

      dynamic databasePointer;
      dynamic databasePointer2;
      dynamic databasePointer3;
      dynamic databasePointer4;
      dynamic databasePointer5;
      var refMemberValue = await db.collection("USERS").doc(refMember).get();
          // .then((refMemberValue) async {
        if (refMemberValue.exists) {
          Map<dynamic, dynamic> refMemberMap = refMemberValue.data() as Map;
          String refDocId = refMemberMap["DOCUMENT_ID"];
          fcmList.add(refMemberMap["FCM_ID"]);
          databasePointer = db.collection("MASTER_CLUB");
          databasePointer4 = await databasePointer
              .where("MEMBER_ID", isEqualTo: refMember)
              .where("CHILD_COUNT", isLessThan: 2);
          var refParent = await databasePointer4.get();
              // .then((refParent) {
            if (refParent.docs.isNotEmpty) {
              Map<dynamic, dynamic> parentMap = refParent.docs.first.data();
              int stepId = parentMap["STEP_ID"] + 1;
              String directParentDocId = parentMap["DOCUMENT_ID"].toString();
              List<dynamic> parentList = [];
              List<dynamic> parentList2 = parentMap["PARENTS"];
              List<dynamic> childList = parentMap["CHILDREN"] ?? [];
              childList.add(documentId);
              treeMap["STEP_ID"] = stepId;
              treeMap["DIRECT_PARENT_ID"] = refMember;
              treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
              userMap["STEP_ID"] = stepId;
              userMap["DIRECT_PARENT_ID"] = refMember;
              parentList.add(directParentDocId);
              parentList = parentList + parentList2;
              if (parentList.length < 128) {
                treeMap["PARENTS"] = parentList;
              } else {
                parentList.removeAt(parentList.length - 1);
                treeMap["PARENTS"] = parentList;
              }
              await databasePointer
                  .doc(documentId)
                  .set(treeMap, SetOptions(merge: true));
              await db
                  .collection('USERS')
                  .doc(memberId)
                  .set(userMap, SetOptions(merge: true));
              notificationMap["TO_ID"] = toIdList;
              await db
                  .collection('NOTIFICATIONS')
                  .doc(notificationId)
                  .set(notificationMap);

              HashMap<String, Object> upgradeMap = HashMap();
              upgradeMap["AMOUNT"] = "200";
              upgradeMap["DATE"] = now;
              upgradeMap["TO_ID"] = refMember;
              upgradeMap["FROM_ID"] = memberId;
              upgradeMap["SCREENSHOT"] = "";
              upgradeMap["TYPE"] = "HELP";
              upgradeMap["STATUS"] = "PENDING";
              upgradeMap["GRADE"] = "";
              upgradeMap["TREE"] = "MASTER_CLUB";
              upgradeMap["IN_TREE"] = "MASTER_CLUB";

              await db
                  .collection("DISTRIBUTIONS")
                  .doc(DateTime.now().millisecondsSinceEpoch.toString() +
                      generateRandomString(4))
                  .set(upgradeMap, SetOptions(merge: true));

              await databasePointer.doc(directParentDocId).set({
                "CHILD_COUNT": FieldValue.increment(1),
                "CHILDREN": childList,
              }, SetOptions(merge: true));
              print("reached 23");
              await db.collection('USERS').doc(refMember).set(
                  {"CHILD_COUNT": FieldValue.increment(1),"TOTAL_INVITEES_COUNT":FieldValue.increment(1)},
                  SetOptions(merge: true));
              print("reached 24");
              callOnFcmApiSendPushNotifications(
                  title: 'New Master Club Member',
                  body:
                      '$memberName completed PRC payment and placed in Master Club.\n'
                      'Phone: $memberPhone',
                  fcmList: fcmList,
                  imageLink: '');
              print("reached 25");
              notifyListeners();
            }
            else {
              databasePointer3 = databasePointer
                  .where("PARENTS", arrayContains: refDocId)
                  .where("CHILD_COUNT", isEqualTo: 1)
                  .orderBy("STEP_ID")
                  .limit(1);
              var parentValue2 = await databasePointer3.get();
                  // .then((parentValue2) {
                if (parentValue2.docs.isNotEmpty) {
                  Map<dynamic, dynamic> parentMap3 = parentValue2.docs.first.data();

                  databasePointer5 = databasePointer
                      .where("PARENTS", arrayContains: refDocId)
                      .where("CHILD_COUNT", isEqualTo: 0)
                      .orderBy("STEP_ID")
                      .limit(1);
                  var parentValue2263 = await databasePointer5.get();

                  if (parentValue2263.docs.isNotEmpty) {
                    Map<dynamic, dynamic> parent0childMap3 = parentValue2263.docs.first.data();
                    int child0StepId = parent0childMap3["STEP_ID"]??0;
                    int child1StepId = parentMap3["STEP_ID"]??0;
                    if(child0StepId<=child1StepId){
                      List<String> fcmList2 = [parent0childMap3["FCM_ID"] ?? ""];
                      String directParentId =
                      parent0childMap3["MEMBER_ID"].toString();
                      String directParentDocId =
                      parent0childMap3["DOCUMENT_ID"].toString();
                      int stepId = parent0childMap3["STEP_ID"] + 1;
                      List<dynamic> parentList = [];
                      List<dynamic> parentList2 = parent0childMap3["PARENTS"];
                      List<dynamic> childList = [documentId];
                      treeMap["STEP_ID"] = stepId;
                      treeMap["DIRECT_PARENT_ID"] = directParentId;
                      treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                      userMap["STEP_ID"] = stepId;
                      userMap["DIRECT_PARENT_ID"] = directParentId;
                      parentList.add(directParentDocId);
                      parentList = parentList + parentList2;
                      if (parentList.length < 128) {
                        treeMap["PARENTS"] = parentList;
                      } else {
                        parentList.removeAt(parentList.length - 1);
                        treeMap["PARENTS"] = parentList;
                      }
                      databasePointer
                          .doc(documentId)
                          .set(treeMap, SetOptions(merge: true));
                      db
                          .collection('USERS')
                          .doc(memberId)
                          .set(userMap, SetOptions(merge: true));
                      db
                          .collection('USERS')
                          .doc(refMember)
                          .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));

                      toIdList.add(directParentId);
                      notificationMap["TO_ID"] = toIdList;
                      db
                          .collection('NOTIFICATIONS')
                          .doc(notificationId)
                          .set(notificationMap);

                      HashMap<String, Object> upgradeMap = HashMap();
                      upgradeMap["AMOUNT"] = "200";
                      upgradeMap["DATE"] = now;
                      upgradeMap["TO_ID"] = directParentId;
                      upgradeMap["FROM_ID"] = memberId;
                      upgradeMap["SCREENSHOT"] = "";
                      upgradeMap["TYPE"] = "HELP";
                      upgradeMap["STATUS"] = "PENDING";
                      upgradeMap["GRADE"] = "";
                      upgradeMap["TREE"] = "MASTER_CLUB";
                      upgradeMap["IN_TREE"] = "MASTER_CLUB";

                      db
                          .collection("DISTRIBUTIONS")
                          .doc(
                          DateTime.now().millisecondsSinceEpoch.toString() +
                              generateRandomString(4))
                          .set(upgradeMap, SetOptions(merge: true));

                      databasePointer.doc(directParentDocId).set({
                        "CHILD_COUNT": FieldValue.increment(1),
                        "CHILDREN": childList,
                      }, SetOptions(merge: true));
                      db.collection('USERS').doc(directParentId).set(
                          {"CHILD_COUNT": FieldValue.increment(1)},
                          SetOptions(merge: true));
                      callOnFcmApiSendPushNotifications(
                          title: 'New Master Club Member',
                          body:
                          '$memberName completed PRC payment and placed in Master Club.\n'
                              'Phone: $memberPhone',
                          fcmList: fcmList + fcmList2,
                          imageLink: '');
                    }
                    else{
                      String directParentId = parentMap3["MEMBER_ID"].toString();
                      String directParentDocId =
                      parentMap3["DOCUMENT_ID"].toString();
                      int stepId = parentMap3["STEP_ID"] + 1;
                      List<String> fcmList2 = [parentMap3["FCM_ID"] ?? ""];
                      List<dynamic> parentList = [];
                      List<dynamic> parentList2 = parentMap3["PARENTS"];
                      List<dynamic> childList = parentMap3["CHILDREN"];
                      childList.add(documentId);
                      treeMap["STEP_ID"] = stepId;
                      treeMap["DIRECT_PARENT_ID"] = directParentId;
                      treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                      userMap["STEP_ID"] = stepId;
                      userMap["DIRECT_PARENT_ID"] = directParentId;
                      parentList.add(directParentDocId);
                      parentList = parentList + parentList2;
                      if (parentList.length < 128) {
                        treeMap["PARENTS"] = parentList;
                      } else {
                        parentList.removeAt(parentList.length - 1);
                        treeMap["PARENTS"] = parentList;
                      }
                      databasePointer
                          .doc(documentId)
                          .set(treeMap, SetOptions(merge: true));
                      db
                          .collection('USERS')
                          .doc(memberId)
                          .set(userMap, SetOptions(merge: true));
                      db
                          .collection('USERS')
                          .doc(refMember)
                          .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));
                      toIdList.add(directParentId);
                      notificationMap["TO_ID"] = toIdList;
                      db
                          .collection('NOTIFICATIONS')
                          .doc(notificationId)
                          .set(notificationMap);

                      HashMap<String, Object> upgradeMap = HashMap();
                      upgradeMap["AMOUNT"] = "200";
                      upgradeMap["DATE"] = now;
                      upgradeMap["TO_ID"] = directParentId;
                      upgradeMap["FROM_ID"] = memberId;
                      upgradeMap["SCREENSHOT"] = "";
                      upgradeMap["TYPE"] = "HELP";
                      upgradeMap["STATUS"] = "PENDING";
                      upgradeMap["GRADE"] = "";
                      upgradeMap["TREE"] = "MASTER_CLUB";
                      upgradeMap["IN_TREE"] = "MASTER_CLUB";

                      db
                          .collection("DISTRIBUTIONS")
                          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
                          generateRandomString(4))
                          .set(upgradeMap, SetOptions(merge: true));

                      databasePointer.doc(directParentDocId).set({
                        "CHILD_COUNT": FieldValue.increment(1),
                        "CHILDREN": childList,
                      }, SetOptions(merge: true));
                      db.collection('USERS').doc(directParentId).set(
                          {"CHILD_COUNT": FieldValue.increment(1)},
                          SetOptions(merge: true));
                      callOnFcmApiSendPushNotifications(
                          title: 'New Master Club Member',
                          body:
                          '$memberName completed PRC payment and placed in Master Club.\n'
                              'Phone: $memberPhone',
                          fcmList: fcmList + fcmList2,
                          imageLink: '');
                      notifyListeners();
                    }
                  } else{
                    String directParentId = parentMap3["MEMBER_ID"].toString();
                    String directParentDocId =
                    parentMap3["DOCUMENT_ID"].toString();
                    int stepId = parentMap3["STEP_ID"] + 1;
                    List<String> fcmList2 = [parentMap3["FCM_ID"] ?? ""];
                    List<dynamic> parentList = [];
                    List<dynamic> parentList2 = parentMap3["PARENTS"];
                    List<dynamic> childList = parentMap3["CHILDREN"];
                    childList.add(documentId);
                    treeMap["STEP_ID"] = stepId;
                    treeMap["DIRECT_PARENT_ID"] = directParentId;
                    treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                    userMap["STEP_ID"] = stepId;
                    userMap["DIRECT_PARENT_ID"] = directParentId;
                    parentList.add(directParentDocId);
                    parentList = parentList + parentList2;
                    if (parentList.length < 128) {
                      treeMap["PARENTS"] = parentList;
                    } else {
                      parentList.removeAt(parentList.length - 1);
                      treeMap["PARENTS"] = parentList;
                    }
                    databasePointer
                        .doc(documentId)
                        .set(treeMap, SetOptions(merge: true));
                    db
                        .collection('USERS')
                        .doc(memberId)
                        .set(userMap, SetOptions(merge: true));
                    db
                        .collection('USERS')
                        .doc(refMember)
                        .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));
                    toIdList.add(directParentId);
                    notificationMap["TO_ID"] = toIdList;
                    db
                        .collection('NOTIFICATIONS')
                        .doc(notificationId)
                        .set(notificationMap);

                    HashMap<String, Object> upgradeMap = HashMap();
                    upgradeMap["AMOUNT"] = "200";
                    upgradeMap["DATE"] = now;
                    upgradeMap["TO_ID"] = directParentId;
                    upgradeMap["FROM_ID"] = memberId;
                    upgradeMap["SCREENSHOT"] = "";
                    upgradeMap["TYPE"] = "HELP";
                    upgradeMap["STATUS"] = "PENDING";
                    upgradeMap["GRADE"] = "";
                    upgradeMap["TREE"] = "MASTER_CLUB";
                    upgradeMap["IN_TREE"] = "MASTER_CLUB";

                    db
                        .collection("DISTRIBUTIONS")
                        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
                        generateRandomString(4))
                        .set(upgradeMap, SetOptions(merge: true));

                    databasePointer.doc(directParentDocId).set({
                      "CHILD_COUNT": FieldValue.increment(1),
                      "CHILDREN": childList,
                    }, SetOptions(merge: true));
                    db.collection('USERS').doc(directParentId).set(
                        {"CHILD_COUNT": FieldValue.increment(1)},
                        SetOptions(merge: true));
                    callOnFcmApiSendPushNotifications(
                        title: 'New Master Club Member',
                        body:
                        '$memberName completed PRC payment and placed in Master Club.\n'
                            'Phone: $memberPhone',
                        fcmList: fcmList + fcmList2,
                        imageLink: '');
                    notifyListeners();
                  }
                }
                else {
                  databasePointer5 = databasePointer
                      .where("PARENTS", arrayContains: refDocId)
                      .where("CHILD_COUNT", isEqualTo: 0)
                      .orderBy("STEP_ID")
                      .limit(1);
                  var parentValue22 = await databasePointer5.get();
                      // .then((parentValue22) {
                    if (parentValue22.docs.isNotEmpty) {
                      Map<dynamic, dynamic> parentMap3 =
                          parentValue22.docs.first.data();
                      List<String> fcmList2 = [parentMap3["FCM_ID"] ?? ""];
                      String directParentId =
                          parentMap3["MEMBER_ID"].toString();
                      String directParentDocId =
                          parentMap3["DOCUMENT_ID"].toString();
                      int stepId = parentMap3["STEP_ID"] + 1;
                      List<dynamic> parentList = [];
                      List<dynamic> parentList2 = parentMap3["PARENTS"];
                      List<dynamic> childList = [documentId];
                      treeMap["STEP_ID"] = stepId;
                      treeMap["DIRECT_PARENT_ID"] = directParentId;
                      treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                      userMap["STEP_ID"] = stepId;
                      userMap["DIRECT_PARENT_ID"] = directParentId;
                      parentList.add(directParentDocId);
                      parentList = parentList + parentList2;
                      if (parentList.length < 128) {
                        treeMap["PARENTS"] = parentList;
                      } else {
                        parentList.removeAt(parentList.length - 1);
                        treeMap["PARENTS"] = parentList;
                      }
                      databasePointer
                          .doc(documentId)
                          .set(treeMap, SetOptions(merge: true));
                      db
                          .collection('USERS')
                          .doc(memberId)
                          .set(userMap, SetOptions(merge: true));
                      db
                          .collection('USERS')
                          .doc(refMember)
                          .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));

                      toIdList.add(directParentId);
                      notificationMap["TO_ID"] = toIdList;
                      db
                          .collection('NOTIFICATIONS')
                          .doc(notificationId)
                          .set(notificationMap);

                      HashMap<String, Object> upgradeMap = HashMap();
                      upgradeMap["AMOUNT"] = "200";
                      upgradeMap["DATE"] = now;
                      upgradeMap["TO_ID"] = directParentId;
                      upgradeMap["FROM_ID"] = memberId;
                      upgradeMap["SCREENSHOT"] = "";
                      upgradeMap["TYPE"] = "HELP";
                      upgradeMap["STATUS"] = "PENDING";
                      upgradeMap["GRADE"] = "";
                      upgradeMap["TREE"] = "MASTER_CLUB";
                      upgradeMap["IN_TREE"] = "MASTER_CLUB";

                      db
                          .collection("DISTRIBUTIONS")
                          .doc(
                              DateTime.now().millisecondsSinceEpoch.toString() +
                                  generateRandomString(4))
                          .set(upgradeMap, SetOptions(merge: true));

                      databasePointer.doc(directParentDocId).set({
                        "CHILD_COUNT": FieldValue.increment(1),
                        "CHILDREN": childList,
                      }, SetOptions(merge: true));
                      db.collection('USERS').doc(directParentId).set(
                          {"CHILD_COUNT": FieldValue.increment(1)},
                          SetOptions(merge: true));
                      callOnFcmApiSendPushNotifications(
                          title: 'New Master Club Member',
                          body:
                              '$memberName completed PRC payment and placed in Master Club.\n'
                              'Phone: $memberPhone',
                          fcmList: fcmList + fcmList2,
                          imageLink: '');
                    }
                    else {
                      var parentValue3 = await databasePointer
                          .where("CHILD_COUNT", isEqualTo: 1)
                          .orderBy("STEP_ID")
                          .limit(1)
                          .get();
                          // .then((parentValue3) {
                        if (parentValue3.docs.isNotEmpty) {
                          Map<dynamic, dynamic> parentMap2 = parentValue3.docs.first.data();

                          var parentValue0child33 = await databasePointer
                              .where("CHILD_COUNT", isEqualTo: 0)
                              .orderBy("STEP_ID")
                              .limit(1)
                              .get();

                          if (parentValue0child33.docs.isNotEmpty) {
                            Map<dynamic, dynamic> parent0childMap2 = parentValue0child33.docs.first.data();

                            int child0StepId = parent0childMap2["STEP_ID"]??0;
                            int child1StepId = parentMap2["STEP_ID"]??0;
                            if(child0StepId<=child1StepId){
                              List<String> fcmList2 = [parent0childMap2["FCM_ID"]];
                              String directParentId =
                              parent0childMap2["MEMBER_ID"].toString();
                              String directParentDocId =
                              parent0childMap2["DOCUMENT_ID"].toString();
                              int stepId = parent0childMap2["STEP_ID"] + 1;
                              List<dynamic> parentList = [];
                              List<dynamic> parentList2 = parent0childMap2["PARENTS"];
                              List<dynamic> childList = [documentId];
                              treeMap["STEP_ID"] = stepId;
                              treeMap["DIRECT_PARENT_ID"] = directParentId;
                              treeMap["DIRECT_PARENT_DOC_ID"] =
                                  directParentDocId;
                              userMap["STEP_ID"] = stepId;
                              userMap["DIRECT_PARENT_ID"] = directParentId;
                              if (parentList.length < 128) {
                                parentList.add(directParentDocId);
                                treeMap["PARENTS"] = parentList;
                              } else {
                                parentList.removeAt(0);
                                parentList.add(directParentDocId);
                                treeMap["PARENTS"] = parentList;
                              }
                              databasePointer
                                  .doc(documentId)
                                  .set(treeMap, SetOptions(merge: true));
                              db
                                  .collection('USERS')
                                  .doc(memberId)
                                  .set(userMap, SetOptions(merge: true));
                              db
                                  .collection('USERS')
                                  .doc(refMember)
                                  .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));
                              toIdList.add(directParentId);
                              notificationMap["TO_ID"] = toIdList;
                              db
                                  .collection('NOTIFICATIONS')
                                  .doc(notificationId)
                                  .set(notificationMap);

                              HashMap<String, Object> upgradeMap = HashMap();
                              upgradeMap["AMOUNT"] = "200";
                              upgradeMap["DATE"] = now;
                              upgradeMap["TO_ID"] = directParentId;
                              upgradeMap["FROM_ID"] = memberId;
                              upgradeMap["SCREENSHOT"] = "";
                              upgradeMap["TYPE"] = "HELP";
                              upgradeMap["STATUS"] = "PENDING";
                              upgradeMap["GRADE"] = "";
                              upgradeMap["TREE"] = "MASTER_CLUB";
                              upgradeMap["IN_TREE"] = "MASTER_CLUB";

                              db
                                  .collection("DISTRIBUTIONS")
                                  .doc(DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString() +
                                  generateRandomString(4))
                                  .set(upgradeMap, SetOptions(merge: true));

                              databasePointer.doc(directParentDocId).set({
                                "CHILD_COUNT": FieldValue.increment(1),
                                "CHILDREN": childList,
                              }, SetOptions(merge: true));
                              db.collection('USERS').doc(directParentId).set(
                                  {"CHILD_COUNT": FieldValue.increment(1)},
                                  SetOptions(merge: true));
                              callOnFcmApiSendPushNotifications(
                                  title: 'New Master Club Member',
                                  body:
                                  '$memberName completed PRC payment and placed in Master Club.\n'
                                      'Phone: $memberPhone',
                                  fcmList: fcmList + fcmList2,
                                  imageLink: '');
                              notifyListeners();
                            }
                            else{
                              List<String> fcmList2 = [parentMap2["FCM_ID"]];
                              String directParentId =
                              parentMap2["MEMBER_ID"].toString();
                              String directParentDocId =
                              parentMap2["DOCUMENT_ID"].toString();
                              int stepId = parentMap2["STEP_ID"] + 1;
                              List<dynamic> parentList = [];
                              List<dynamic> parentList2 = parentMap2["PARENTS"];
                              List<dynamic> childList = parentMap2["CHILDREN"];
                              childList.add(documentId);
                              treeMap["STEP_ID"] = stepId;
                              treeMap["DIRECT_PARENT_ID"] = directParentId;
                              treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                              userMap["STEP_ID"] = stepId;
                              userMap["DIRECT_PARENT_ID"] = directParentId;
                              parentList.add(directParentDocId);
                              parentList = parentList + parentList2;
                              if (parentList.length < 128) {
                                treeMap["PARENTS"] = parentList;
                              } else {
                                parentList.removeAt(parentList.length - 1);
                                treeMap["PARENTS"] = parentList;
                              }
                              databasePointer
                                  .doc(documentId)
                                  .set(treeMap, SetOptions(merge: true));
                              db
                                  .collection('USERS')
                                  .doc(memberId)
                                  .set(userMap, SetOptions(merge: true));
                              db
                                  .collection('USERS')
                                  .doc(refMember)
                                  .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));
                              toIdList.add(directParentId);
                              notificationMap["TO_ID"] = toIdList;
                              db
                                  .collection('NOTIFICATIONS')
                                  .doc(notificationId)
                                  .set(notificationMap);

                              HashMap<String, Object> upgradeMap = HashMap();
                              upgradeMap["AMOUNT"] = "200";
                              upgradeMap["DATE"] = now;
                              upgradeMap["TO_ID"] = directParentId;
                              upgradeMap["FROM_ID"] = memberId;
                              upgradeMap["SCREENSHOT"] = "";
                              upgradeMap["TYPE"] = "HELP";
                              upgradeMap["STATUS"] = "PENDING";
                              upgradeMap["GRADE"] = "";
                              upgradeMap["TREE"] = "MASTER_CLUB";
                              upgradeMap["IN_TREE"] = "MASTER_CLUB";

                              db
                                  .collection("DISTRIBUTIONS")
                                  .doc(DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString() +
                                  generateRandomString(4))
                                  .set(upgradeMap, SetOptions(merge: true));

                              databasePointer.doc(directParentDocId).set({
                                "CHILD_COUNT": FieldValue.increment(1),
                                "CHILDREN": childList,
                              }, SetOptions(merge: true));
                              db.collection('USERS').doc(directParentId).set(
                                  {"CHILD_COUNT": FieldValue.increment(1)},
                                  SetOptions(merge: true));
                              callOnFcmApiSendPushNotifications(
                                  title: 'New Master Club Member',
                                  body:
                                  '$memberName completed PRC payment and placed in Master Club.\n'
                                      'Phone: $memberPhone',
                                  fcmList: fcmList + fcmList2,
                                  imageLink: '');
                              notifyListeners();
                            }
                          }else{
                            List<String> fcmList2 = [parentMap2["FCM_ID"]];
                            String directParentId =
                            parentMap2["MEMBER_ID"].toString();
                            String directParentDocId =
                            parentMap2["DOCUMENT_ID"].toString();
                            int stepId = parentMap2["STEP_ID"] + 1;
                            List<dynamic> parentList = [];
                            List<dynamic> parentList2 = parentMap2["PARENTS"];
                            List<dynamic> childList = parentMap2["CHILDREN"];
                            childList.add(documentId);
                            treeMap["STEP_ID"] = stepId;
                            treeMap["DIRECT_PARENT_ID"] = directParentId;
                            treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                            userMap["STEP_ID"] = stepId;
                            userMap["DIRECT_PARENT_ID"] = directParentId;
                            parentList.add(directParentDocId);
                            parentList = parentList + parentList2;
                            if (parentList.length < 128) {
                              treeMap["PARENTS"] = parentList;
                            } else {
                              parentList.removeAt(parentList.length - 1);
                              treeMap["PARENTS"] = parentList;
                            }
                            databasePointer
                                .doc(documentId)
                                .set(treeMap, SetOptions(merge: true));
                            db
                                .collection('USERS')
                                .doc(memberId)
                                .set(userMap, SetOptions(merge: true));
                            db
                                .collection('USERS')
                                .doc(refMember)
                                .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));
                            toIdList.add(directParentId);
                            notificationMap["TO_ID"] = toIdList;
                            db
                                .collection('NOTIFICATIONS')
                                .doc(notificationId)
                                .set(notificationMap);

                            HashMap<String, Object> upgradeMap = HashMap();
                            upgradeMap["AMOUNT"] = "200";
                            upgradeMap["DATE"] = now;
                            upgradeMap["TO_ID"] = directParentId;
                            upgradeMap["FROM_ID"] = memberId;
                            upgradeMap["SCREENSHOT"] = "";
                            upgradeMap["TYPE"] = "HELP";
                            upgradeMap["STATUS"] = "PENDING";
                            upgradeMap["GRADE"] = "";
                            upgradeMap["TREE"] = "MASTER_CLUB";
                            upgradeMap["IN_TREE"] = "MASTER_CLUB";

                            db
                                .collection("DISTRIBUTIONS")
                                .doc(DateTime.now()
                                .millisecondsSinceEpoch
                                .toString() +
                                generateRandomString(4))
                                .set(upgradeMap, SetOptions(merge: true));

                            databasePointer.doc(directParentDocId).set({
                              "CHILD_COUNT": FieldValue.increment(1),
                              "CHILDREN": childList,
                            }, SetOptions(merge: true));
                            db.collection('USERS').doc(directParentId).set(
                                {"CHILD_COUNT": FieldValue.increment(1)},
                                SetOptions(merge: true));
                            callOnFcmApiSendPushNotifications(
                                title: 'New Master Club Member',
                                body:
                                '$memberName completed PRC payment and placed in Master Club.\n'
                                    'Phone: $memberPhone',
                                fcmList: fcmList + fcmList2,
                                imageLink: '');
                            notifyListeners();
                          }
                        }
                        else {
                          var parentValue33 = await databasePointer
                              .where("CHILD_COUNT", isEqualTo: 0)
                              .orderBy("STEP_ID")
                              .limit(1)
                              .get();
                              // .then((parentValue33) {
                            if (parentValue33.docs.isNotEmpty) {
                              Map<dynamic, dynamic> parentMap2 =
                                  parentValue33.docs.first.data();
                              List<String> fcmList2 = [parentMap2["FCM_ID"]];
                              String directParentId =
                                  parentMap2["MEMBER_ID"].toString();
                              String directParentDocId =
                                  parentMap2["DOCUMENT_ID"].toString();
                              int stepId = parentMap2["STEP_ID"] + 1;
                              List<dynamic> parentList = [];
                              List<dynamic> parentList2 = parentMap2["PARENTS"];
                              List<dynamic> childList = [documentId];
                              treeMap["STEP_ID"] = stepId;
                              treeMap["DIRECT_PARENT_ID"] = directParentId;
                              treeMap["DIRECT_PARENT_DOC_ID"] =
                                  directParentDocId;
                              userMap["STEP_ID"] = stepId;
                              userMap["DIRECT_PARENT_ID"] = directParentId;
                              if (parentList.length < 128) {
                                parentList.add(directParentDocId);
                                treeMap["PARENTS"] = parentList;
                              } else {
                                parentList.removeAt(0);
                                parentList.add(directParentDocId);
                                treeMap["PARENTS"] = parentList;
                              }
                              databasePointer
                                  .doc(documentId)
                                  .set(treeMap, SetOptions(merge: true));
                              db
                                  .collection('USERS')
                                  .doc(memberId)
                                  .set(userMap, SetOptions(merge: true));
                              db
                                  .collection('USERS')
                                  .doc(refMember)
                                  .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));
                              toIdList.add(directParentId);
                              notificationMap["TO_ID"] = toIdList;
                              db
                                  .collection('NOTIFICATIONS')
                                  .doc(notificationId)
                                  .set(notificationMap);

                              HashMap<String, Object> upgradeMap = HashMap();
                              upgradeMap["AMOUNT"] = "200";
                              upgradeMap["DATE"] = now;
                              upgradeMap["TO_ID"] = directParentId;
                              upgradeMap["FROM_ID"] = memberId;
                              upgradeMap["SCREENSHOT"] = "";
                              upgradeMap["TYPE"] = "HELP";
                              upgradeMap["STATUS"] = "PENDING";
                              upgradeMap["GRADE"] = "";
                              upgradeMap["TREE"] = "MASTER_CLUB";
                              upgradeMap["IN_TREE"] = "MASTER_CLUB";

                              db
                                  .collection("DISTRIBUTIONS")
                                  .doc(DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString() +
                                      generateRandomString(4))
                                  .set(upgradeMap, SetOptions(merge: true));

                              databasePointer.doc(directParentDocId).set({
                                "CHILD_COUNT": FieldValue.increment(1),
                                "CHILDREN": childList,
                              }, SetOptions(merge: true));
                              db.collection('USERS').doc(directParentId).set(
                                  {"CHILD_COUNT": FieldValue.increment(1)},
                                  SetOptions(merge: true));
                              callOnFcmApiSendPushNotifications(
                                  title: 'New Master Club Member',
                                  body:
                                      '$memberName completed PRC payment and placed in Master Club.\n'
                                      'Phone: $memberPhone',
                                  fcmList: fcmList + fcmList2,
                                  imageLink: '');
                            }
                          // });
                        }
                      // });
                    }
                  // });
                }
              // });
            }
          // });
        }
      // });
      notifyListeners();

      print("reachedttfgbdfbh 21");
      finish(context);
    });
  }

  placeMemberInTree(String memberId, BuildContext context) async {
    print("reached 21");
    db.collection("USERS").doc(memberId).get().then((memberValue11) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          });
      Map<dynamic, dynamic> memberValueMap = memberValue11.data() as Map;
      AdminProvider adminProvider =
      Provider.of<AdminProvider>(context, listen: false);
      List<String> fcmList = [];
      userReferenceList.clear();
      print("reached 21fgfgfghhhhhhhhh");
      FirebaseMessaging.instance.getToken().then((fcmValue) async {
        print("reached 21fgfgfg");
        DateTime now = DateTime.now();
        String notificationId =
            now.millisecondsSinceEpoch.toString() + generateRandomString(2);
        String documentId = memberValueMap["DOCUMENT_ID"].toString();
        String refMember = memberValueMap["REFERENCE"].toString();
        String memberName = memberValueMap["NAME"].toString();
        String memberPhone = memberValueMap["PHONE"].toString();
        String memberImage = memberValueMap["ItemImage"] ?? "";
        String memberUpiId = memberValueMap["UPI_Id"].toString();

        HashMap<String, Object> userMap = HashMap();

        HashMap<String, Object> treeMap = HashMap();
        treeMap["DOCUMENT_ID"] = documentId;
        treeMap["FCM_ID"] = fcmValue.toString();
        treeMap['NAME'] = memberName;
        treeMap['PHONE'] = memberPhone;
        treeMap["MEMBER_ID"] = memberId;
        treeMap['REG_DATE'] = now;
        treeMap["GRADE"] = "";
        treeMap["CHILD_COUNT"] = 0;
        treeMap["REFERENCE"] = refMember;
        treeMap["ItemImage"] = memberImage;
        treeMap["UPI_Id"] = memberUpiId;
        treeMap["STATUS"] = "ACTIVE";
        treeMap["TYPE"] = "MEMBER";

        List<String> toIdList = [refMember];

        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] =
        "$memberName completed PRC payment and placed in Master Club.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["NOTIFICATION_ID"] = memberId;
        notificationMap['REG_DATE'] = now;
        notificationMap["VIEWERS"] = [];
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();

        // await db.collection("MASTER_CLUB").doc(documentId).set(treeMap);

        dynamic databasePointer;
        dynamic databasePointer2;
        dynamic databasePointer3;
        dynamic databasePointer4;
        dynamic databasePointer5;
        var refMemberValue = await db
            .collection("USERS")
            .doc(refMember)
            .get();
        // .then((refMemberValue) async {
        if (refMemberValue.exists) {
          Map<dynamic, dynamic> refMemberMap = refMemberValue.data() as Map;
          String refDocId = refMemberMap["DOCUMENT_ID"];
          fcmList.add(refMemberMap["FCM_ID"]);
          databasePointer = db.collection("MASTER_CLUB");
          databasePointer4 = await databasePointer
              .where("MEMBER_ID", isEqualTo: refMember)
              .where("CHILD_COUNT", isLessThan: 2);
          var refParent = await databasePointer4.get();
          // .then((refParent) {
          if (refParent.docs.isNotEmpty) {
            Map<dynamic, dynamic> parentMap = refParent.docs.first.data();
            int stepId = parentMap["STEP_ID"] + 1;
            String directParentDocId = parentMap["DOCUMENT_ID"].toString();
            List<dynamic> parentList = [];
            List<dynamic> parentList2 = parentMap["PARENTS"];
            List<dynamic> childList = parentMap["CHILDREN"] ?? [];
            childList.add(documentId);
            treeMap["STEP_ID"] = stepId;
            treeMap["DIRECT_PARENT_ID"] = refMember;
            treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
            userMap["STEP_ID"] = stepId;
            userMap["DIRECT_PARENT_ID"] = refMember;
            parentList.add(directParentDocId);
            parentList = parentList + parentList2;
            if (parentList.length < 128) {
              treeMap["PARENTS"] = parentList;
            } else {
              parentList.removeAt(parentList.length - 1);
              treeMap["PARENTS"] = parentList;
            }
            databasePointer
                .doc(documentId)
                .set(treeMap, SetOptions(merge: true));
            await db
                .collection('USERS')
                .doc(memberId)
                .set(userMap, SetOptions(merge: true));

            notificationMap["TO_ID"] = toIdList;
            await db
                .collection('NOTIFICATIONS')
                .doc(notificationId)
                .set(notificationMap);

            HashMap<String, Object> upgradeMap = HashMap();
            upgradeMap["AMOUNT"] = "200";
            upgradeMap["DATE"] = now;
            upgradeMap["TO_ID"] = refMember;
            upgradeMap["FROM_ID"] = memberId;
            upgradeMap["SCREENSHOT"] = "";
            upgradeMap["TYPE"] = "HELP";
            upgradeMap["STATUS"] = "PENDING";
            upgradeMap["GRADE"] = "";
            upgradeMap["TREE"] = "MASTER_CLUB";
            upgradeMap["IN_TREE"] = "MASTER_CLUB";

            await db
                .collection("DISTRIBUTIONS")
                .doc(DateTime.now().millisecondsSinceEpoch.toString() +
                generateRandomString(4))
                .set(upgradeMap, SetOptions(merge: true));

            databasePointer.doc(directParentDocId).set({
              "CHILD_COUNT": FieldValue.increment(1),
              "CHILDREN": childList,
            }, SetOptions(merge: true));
            print("reached 23");
            await db.collection('USERS').doc(refMember).set(
                {"CHILD_COUNT": FieldValue.increment(1),
                  "TOTAL_INVITEES_COUNT":FieldValue.increment(1)},
                SetOptions(merge: true));
            print("reached 24");
            callOnFcmApiSendPushNotifications(
                title: 'New Master Club Member',
                body:
                '$memberName completed PRC payment and placed in Master Club.\n'
                    'Phone: $memberPhone',
                fcmList: fcmList,
                imageLink: '');
            print("reached 25");
          }
          else {
            databasePointer3 = databasePointer
                .where("PARENTS", arrayContains: refDocId)
                .where("CHILD_COUNT", isEqualTo: 1)
                .orderBy("STEP_ID")
                .limit(1);
            var parentValue2 = await databasePointer3.get();
            // .then((parentValue2) async {
            if (parentValue2.docs.isNotEmpty) {
              Map<dynamic, dynamic> parentMap3 = parentValue2.docs.first.data();

              databasePointer5 = databasePointer
                  .where("PARENTS", arrayContains: refDocId)
                  .where("CHILD_COUNT", isEqualTo: 0)
                  .orderBy("STEP_ID")
                  .limit(1);
              var parentValue0Child = await databasePointer5.get();
              if (parentValue0Child.docs.isNotEmpty) {
                Map<dynamic, dynamic> parent0childMap = parentValue0Child.docs.first.data();
                int child0StepId = parent0childMap["STEP_ID"]??0;
                int child1StepId = parentMap3["STEP_ID"]??0;
                if(child0StepId<=child1StepId){

                  List<String> fcmList2 = [parent0childMap["FCM_ID"] ?? ""];
                  String directParentId =
                  parent0childMap["MEMBER_ID"].toString();
                  String directParentDocId =
                  parent0childMap["DOCUMENT_ID"].toString();
                  int stepId = parent0childMap["STEP_ID"] + 1;
                  List<dynamic> parentList = [];
                  List<dynamic> parentList2 = parent0childMap["PARENTS"];
                  List<dynamic> childList = [documentId];
                  treeMap["STEP_ID"] = stepId;
                  treeMap["DIRECT_PARENT_ID"] = directParentId;
                  treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                  userMap["STEP_ID"] = stepId;
                  userMap["DIRECT_PARENT_ID"] = directParentId;
                  parentList.add(directParentDocId);
                  parentList = parentList + parentList2;
                  if (parentList.length < 128) {
                    treeMap["PARENTS"] = parentList;
                  } else {
                    parentList.removeAt(parentList.length - 1);
                    treeMap["PARENTS"] = parentList;
                  }
                  await databasePointer
                      .doc(documentId)
                      .set(treeMap, SetOptions(merge: true));
                  await db
                      .collection('USERS')
                      .doc(memberId)
                      .set(userMap, SetOptions(merge: true));

                  await db
                      .collection('USERS')
                      .doc(refMember)
                      .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));

                  toIdList.add(directParentId);
                  notificationMap["TO_ID"] = toIdList;
                  await db
                      .collection('NOTIFICATIONS')
                      .doc(notificationId)
                      .set(notificationMap);

                  HashMap<String, Object> upgradeMap = HashMap();
                  upgradeMap["AMOUNT"] = "200";
                  upgradeMap["DATE"] = now;
                  upgradeMap["TO_ID"] = directParentId;
                  upgradeMap["FROM_ID"] = memberId;
                  upgradeMap["SCREENSHOT"] = "";
                  upgradeMap["TYPE"] = "HELP";
                  upgradeMap["STATUS"] = "PENDING";
                  upgradeMap["GRADE"] = "";
                  upgradeMap["TREE"] = "MASTER_CLUB";
                  upgradeMap["IN_TREE"] = "MASTER_CLUB";

                  await db
                      .collection("DISTRIBUTIONS")
                      .doc(DateTime.now()
                      .millisecondsSinceEpoch
                      .toString() +
                      generateRandomString(4))
                      .set(upgradeMap, SetOptions(merge: true));

                  await databasePointer.doc(directParentDocId).set({
                    "CHILD_COUNT": FieldValue.increment(1),
                    "CHILDREN": childList,
                  }, SetOptions(merge: true));
                  await db.collection('USERS').doc(directParentId).set(
                      {"CHILD_COUNT": FieldValue.increment(1)},
                      SetOptions(merge: true));
                  callOnFcmApiSendPushNotifications(
                      title: 'New Master Club Member',
                      body:
                      '$memberName completed PRC payment and placed in Master Club.\n'
                          'Phone: $memberPhone',
                      fcmList: fcmList + fcmList2,
                      imageLink: '');


                }
                else{
                  String directParentId = parentMap3["MEMBER_ID"].toString();
                  String directParentDocId =
                  parentMap3["DOCUMENT_ID"].toString();
                  int stepId = parentMap3["STEP_ID"] + 1;
                  List<String> fcmList2 = [parentMap3["FCM_ID"] ?? ""];
                  List<dynamic> parentList = [];
                  List<dynamic> parentList2 = parentMap3["PARENTS"];
                  List<dynamic> childList = parentMap3["CHILDREN"];
                  childList.add(documentId);
                  treeMap["STEP_ID"] = stepId;
                  treeMap["DIRECT_PARENT_ID"] = directParentId;
                  treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                  userMap["STEP_ID"] = stepId;
                  userMap["DIRECT_PARENT_ID"] = directParentId;
                  parentList.add(directParentDocId);
                  parentList = parentList + parentList2;
                  if (parentList.length < 128) {
                    treeMap["PARENTS"] = parentList;
                  } else {
                    parentList.removeAt(parentList.length - 1);
                    treeMap["PARENTS"] = parentList;
                  }
                  databasePointer
                      .doc(documentId)
                      .set(treeMap, SetOptions(merge: true));
                  await db
                      .collection('USERS')
                      .doc(memberId)
                      .set(userMap, SetOptions(merge: true));

                  await db
                      .collection('USERS')
                      .doc(refMember)
                      .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));

                  toIdList.add(directParentId);
                  notificationMap["TO_ID"] = toIdList;
                  await db
                      .collection('NOTIFICATIONS')
                      .doc(notificationId)
                      .set(notificationMap);

                  HashMap<String, Object> upgradeMap = HashMap();
                  upgradeMap["AMOUNT"] = "200";
                  upgradeMap["DATE"] = now;
                  upgradeMap["TO_ID"] = directParentId;
                  upgradeMap["FROM_ID"] = memberId;
                  upgradeMap["SCREENSHOT"] = "";
                  upgradeMap["TYPE"] = "HELP";
                  upgradeMap["STATUS"] = "PENDING";
                  upgradeMap["GRADE"] = "";
                  upgradeMap["TREE"] = "MASTER_CLUB";
                  upgradeMap["IN_TREE"] = "MASTER_CLUB";

                  await db
                      .collection("DISTRIBUTIONS")
                      .doc(DateTime.now().millisecondsSinceEpoch.toString() +
                      generateRandomString(4))
                      .set(upgradeMap, SetOptions(merge: true));

                  await databasePointer.doc(directParentDocId).set({
                    "CHILD_COUNT": FieldValue.increment(1),
                    "CHILDREN": childList,
                  }, SetOptions(merge: true));
                  await db.collection('USERS').doc(directParentId).set(
                      {"CHILD_COUNT": FieldValue.increment(1)},
                      SetOptions(merge: true));
                  callOnFcmApiSendPushNotifications(
                      title: 'New Master Club Member',
                      body:
                      '$memberName completed PRC payment and placed in Master Club.\n'
                          'Phone: $memberPhone',
                      fcmList: fcmList + fcmList2,
                      imageLink: '');
                  notifyListeners();
                }
              }else{
                String directParentId = parentMap3["MEMBER_ID"].toString();
                String directParentDocId =
                parentMap3["DOCUMENT_ID"].toString();
                int stepId = parentMap3["STEP_ID"] + 1;
                List<String> fcmList2 = [parentMap3["FCM_ID"] ?? ""];
                List<dynamic> parentList = [];
                List<dynamic> parentList2 = parentMap3["PARENTS"];
                List<dynamic> childList = parentMap3["CHILDREN"];
                childList.add(documentId);
                treeMap["STEP_ID"] = stepId;
                treeMap["DIRECT_PARENT_ID"] = directParentId;
                treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                userMap["STEP_ID"] = stepId;
                userMap["DIRECT_PARENT_ID"] = directParentId;
                parentList.add(directParentDocId);
                parentList = parentList + parentList2;
                if (parentList.length < 128) {
                  treeMap["PARENTS"] = parentList;
                } else {
                  parentList.removeAt(parentList.length - 1);
                  treeMap["PARENTS"] = parentList;
                }
                databasePointer
                    .doc(documentId)
                    .set(treeMap, SetOptions(merge: true));
                await db
                    .collection('USERS')
                    .doc(memberId)
                    .set(userMap, SetOptions(merge: true));

                await db
                    .collection('USERS')
                    .doc(refMember)
                    .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));

                toIdList.add(directParentId);
                notificationMap["TO_ID"] = toIdList;
                await db
                    .collection('NOTIFICATIONS')
                    .doc(notificationId)
                    .set(notificationMap);

                HashMap<String, Object> upgradeMap = HashMap();
                upgradeMap["AMOUNT"] = "200";
                upgradeMap["DATE"] = now;
                upgradeMap["TO_ID"] = directParentId;
                upgradeMap["FROM_ID"] = memberId;
                upgradeMap["SCREENSHOT"] = "";
                upgradeMap["TYPE"] = "HELP";
                upgradeMap["STATUS"] = "PENDING";
                upgradeMap["GRADE"] = "";
                upgradeMap["TREE"] = "MASTER_CLUB";
                upgradeMap["IN_TREE"] = "MASTER_CLUB";

                await db
                    .collection("DISTRIBUTIONS")
                    .doc(DateTime.now().millisecondsSinceEpoch.toString() +
                    generateRandomString(4))
                    .set(upgradeMap, SetOptions(merge: true));

                await databasePointer.doc(directParentDocId).set({
                  "CHILD_COUNT": FieldValue.increment(1),
                  "CHILDREN": childList,
                }, SetOptions(merge: true));
                await db.collection('USERS').doc(directParentId).set(
                    {"CHILD_COUNT": FieldValue.increment(1)},
                    SetOptions(merge: true));
                callOnFcmApiSendPushNotifications(
                    title: 'New Master Club Member',
                    body:
                    '$memberName completed PRC payment and placed in Master Club.\n'
                        'Phone: $memberPhone',
                    fcmList: fcmList + fcmList2,
                    imageLink: '');
                notifyListeners();
              }
            }
            else {
              databasePointer5 = databasePointer
                  .where("PARENTS", arrayContains: refDocId)
                  .where("CHILD_COUNT", isEqualTo: 0)
                  .orderBy("STEP_ID")
                  .limit(1);
              var parentValue22 = await databasePointer5.get();
              // .then((parentValue22) {
              if (parentValue22.docs.isNotEmpty) {
                Map<dynamic, dynamic> parentMap3 =
                parentValue22.docs.first.data();
                List<String> fcmList2 = [parentMap3["FCM_ID"] ?? ""];
                String directParentId =
                parentMap3["MEMBER_ID"].toString();
                String directParentDocId =
                parentMap3["DOCUMENT_ID"].toString();
                int stepId = parentMap3["STEP_ID"] + 1;
                List<dynamic> parentList = [];
                List<dynamic> parentList2 = parentMap3["PARENTS"];
                List<dynamic> childList = [documentId];
                treeMap["STEP_ID"] = stepId;
                treeMap["DIRECT_PARENT_ID"] = directParentId;
                treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                userMap["STEP_ID"] = stepId;
                userMap["DIRECT_PARENT_ID"] = directParentId;
                parentList.add(directParentDocId);
                parentList = parentList + parentList2;
                if (parentList.length < 128) {
                  treeMap["PARENTS"] = parentList;
                } else {
                  parentList.removeAt(parentList.length - 1);
                  treeMap["PARENTS"] = parentList;
                }
                await databasePointer
                    .doc(documentId)
                    .set(treeMap, SetOptions(merge: true));
                await db
                    .collection('USERS')
                    .doc(memberId)
                    .set(userMap, SetOptions(merge: true));

                await db
                    .collection('USERS')
                    .doc(refMember)
                    .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));

                toIdList.add(directParentId);
                notificationMap["TO_ID"] = toIdList;
                await db
                    .collection('NOTIFICATIONS')
                    .doc(notificationId)
                    .set(notificationMap);

                HashMap<String, Object> upgradeMap = HashMap();
                upgradeMap["AMOUNT"] = "200";
                upgradeMap["DATE"] = now;
                upgradeMap["TO_ID"] = directParentId;
                upgradeMap["FROM_ID"] = memberId;
                upgradeMap["SCREENSHOT"] = "";
                upgradeMap["TYPE"] = "HELP";
                upgradeMap["STATUS"] = "PENDING";
                upgradeMap["GRADE"] = "";
                upgradeMap["TREE"] = "MASTER_CLUB";
                upgradeMap["IN_TREE"] = "MASTER_CLUB";

                await db
                    .collection("DISTRIBUTIONS")
                    .doc(DateTime.now()
                    .millisecondsSinceEpoch
                    .toString() +
                    generateRandomString(4))
                    .set(upgradeMap, SetOptions(merge: true));

                await databasePointer.doc(directParentDocId).set({
                  "CHILD_COUNT": FieldValue.increment(1),
                  "CHILDREN": childList,
                }, SetOptions(merge: true));
                await db.collection('USERS').doc(directParentId).set(
                    {"CHILD_COUNT": FieldValue.increment(1)},
                    SetOptions(merge: true));
                callOnFcmApiSendPushNotifications(
                    title: 'New Master Club Member',
                    body:
                    '$memberName completed PRC payment and placed in Master Club.\n'
                        'Phone: $memberPhone',
                    fcmList: fcmList + fcmList2,
                    imageLink: '');
              }
              else {
                var parentValue3 = await databasePointer
                    .where("CHILD_COUNT", isEqualTo: 1)
                    .orderBy("STEP_ID")
                    .limit(1)
                    .get();
                // .then((parentValue3) {
                if (parentValue3.docs.isNotEmpty) {
                  Map<dynamic, dynamic> parentMap2 = parentValue3.docs.first.data();

                  var parent0childValue33 = await databasePointer
                      .where("CHILD_COUNT", isEqualTo: 0)
                      .orderBy("STEP_ID")
                      .limit(1)
                      .get();
                  if (parent0childValue33.docs.isNotEmpty) {
                    Map<dynamic, dynamic> parent0childMap2 = parent0childValue33.docs.first.data();
                    int child0StepId = parent0childMap2["STEP_ID"]??0;
                    int child1StepId = parentMap2["STEP_ID"]??0;
                    if(child0StepId<=child1StepId){
                      List<String> fcmList2 = [parent0childMap2["FCM_ID"]];
                      String directParentId =
                      parent0childMap2["MEMBER_ID"].toString();
                      String directParentDocId =
                      parent0childMap2["DOCUMENT_ID"].toString();
                      int stepId = parent0childMap2["STEP_ID"] + 1;
                      List<dynamic> parentList = [];
                      List<dynamic> parentList2 =
                      parent0childMap2["PARENTS"];
                      List<dynamic> childList = [documentId];
                      treeMap["STEP_ID"] = stepId;
                      treeMap["DIRECT_PARENT_ID"] = directParentId;
                      treeMap["DIRECT_PARENT_DOC_ID"] =
                          directParentDocId;
                      userMap["STEP_ID"] = stepId;
                      userMap["DIRECT_PARENT_ID"] = directParentId;
                      if (parentList.length < 128) {
                        parentList.add(directParentDocId);
                        treeMap["PARENTS"] = parentList;
                      } else {
                        parentList.removeAt(0);
                        parentList.add(directParentDocId);
                        treeMap["PARENTS"] = parentList;
                      }
                      await databasePointer
                          .doc(documentId)
                          .set(treeMap, SetOptions(merge: true));
                      await db
                          .collection('USERS')
                          .doc(memberId)
                          .set(userMap, SetOptions(merge: true));
                      await db
                          .collection('USERS')
                          .doc(refMember)
                          .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));
                      toIdList.add(directParentId);
                      notificationMap["TO_ID"] = toIdList;
                      await db
                          .collection('NOTIFICATIONS')
                          .doc(notificationId)
                          .set(notificationMap);

                      HashMap<String, Object> upgradeMap = HashMap();
                      upgradeMap["AMOUNT"] = "200";
                      upgradeMap["DATE"] = now;
                      upgradeMap["TO_ID"] = directParentId;
                      upgradeMap["FROM_ID"] = memberId;
                      upgradeMap["SCREENSHOT"] = "";
                      upgradeMap["TYPE"] = "HELP";
                      upgradeMap["STATUS"] = "PENDING";
                      upgradeMap["GRADE"] = "";
                      upgradeMap["TREE"] = "MASTER_CLUB";
                      upgradeMap["IN_TREE"] = "MASTER_CLUB";

                      await db
                          .collection("DISTRIBUTIONS")
                          .doc(DateTime.now()
                          .millisecondsSinceEpoch
                          .toString() +
                          generateRandomString(4))
                          .set(upgradeMap, SetOptions(merge: true));

                      await databasePointer.doc(directParentDocId).set({
                        "CHILD_COUNT": FieldValue.increment(1),
                        "CHILDREN": childList,
                      }, SetOptions(merge: true));
                      await db.collection('USERS').doc(directParentId).set(
                          {"CHILD_COUNT": FieldValue.increment(1)},
                          SetOptions(merge: true));
                      callOnFcmApiSendPushNotifications(
                          title: 'New Master Club Member',
                          body:
                          '$memberName completed PRC payment and placed in Master Club.\n'
                              'Phone: $memberPhone',
                          fcmList: fcmList + fcmList2,
                          imageLink: '');
                    }
                    else{
                      List<String> fcmList2 = [parentMap2["FCM_ID"]];
                      String directParentId =
                      parentMap2["MEMBER_ID"].toString();
                      String directParentDocId =
                      parentMap2["DOCUMENT_ID"].toString();
                      int stepId = parentMap2["STEP_ID"] + 1;
                      List<dynamic> parentList = [];
                      List<dynamic> parentList2 = parentMap2["PARENTS"];
                      List<dynamic> childList = parentMap2["CHILDREN"];
                      childList.add(documentId);
                      treeMap["STEP_ID"] = stepId;
                      treeMap["DIRECT_PARENT_ID"] = directParentId;
                      treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                      userMap["STEP_ID"] = stepId;
                      userMap["DIRECT_PARENT_ID"] = directParentId;
                      parentList.add(directParentDocId);
                      parentList = parentList + parentList2;
                      if (parentList.length < 128) {
                        treeMap["PARENTS"] = parentList;
                      } else {
                        parentList.removeAt(parentList.length - 1);
                        treeMap["PARENTS"] = parentList;
                      }
                      await databasePointer
                          .doc(documentId)
                          .set(treeMap, SetOptions(merge: true));
                      await db
                          .collection('USERS')
                          .doc(memberId)
                          .set(userMap, SetOptions(merge: true));
                      await db
                          .collection('USERS')
                          .doc(refMember)
                          .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));

                      toIdList.add(directParentId);
                      notificationMap["TO_ID"] = toIdList;
                      await db
                          .collection('NOTIFICATIONS')
                          .doc(notificationId)
                          .set(notificationMap);

                      HashMap<String, Object> upgradeMap = HashMap();
                      upgradeMap["AMOUNT"] = "200";
                      upgradeMap["DATE"] = now;
                      upgradeMap["TO_ID"] = directParentId;
                      upgradeMap["FROM_ID"] = memberId;
                      upgradeMap["SCREENSHOT"] = "";
                      upgradeMap["TYPE"] = "HELP";
                      upgradeMap["STATUS"] = "PENDING";
                      upgradeMap["GRADE"] = "";
                      upgradeMap["TREE"] = "MASTER_CLUB";
                      upgradeMap["IN_TREE"] = "MASTER_CLUB";

                      await db
                          .collection("DISTRIBUTIONS")
                          .doc(DateTime.now()
                          .millisecondsSinceEpoch
                          .toString() +
                          generateRandomString(4))
                          .set(upgradeMap, SetOptions(merge: true));

                      await databasePointer.doc(directParentDocId).set({
                        "CHILD_COUNT": FieldValue.increment(1),
                        "CHILDREN": childList,
                      }, SetOptions(merge: true));
                      await db.collection('USERS').doc(directParentId).set(
                          {"CHILD_COUNT": FieldValue.increment(1)},
                          SetOptions(merge: true));
                      callOnFcmApiSendPushNotifications(
                          title: 'New Master Club Member',
                          body:
                          '$memberName completed PRC payment and placed in Master Club.\n'
                              'Phone: $memberPhone',
                          fcmList: fcmList + fcmList2,
                          imageLink: '');
                    }
                  }else{
                    List<String> fcmList2 = [parentMap2["FCM_ID"]];
                    String directParentId =
                    parentMap2["MEMBER_ID"].toString();
                    String directParentDocId =
                    parentMap2["DOCUMENT_ID"].toString();
                    int stepId = parentMap2["STEP_ID"] + 1;
                    List<dynamic> parentList = [];
                    List<dynamic> parentList2 = parentMap2["PARENTS"];
                    List<dynamic> childList = parentMap2["CHILDREN"];
                    childList.add(documentId);
                    treeMap["STEP_ID"] = stepId;
                    treeMap["DIRECT_PARENT_ID"] = directParentId;
                    treeMap["DIRECT_PARENT_DOC_ID"] = directParentDocId;
                    userMap["STEP_ID"] = stepId;
                    userMap["DIRECT_PARENT_ID"] = directParentId;
                    parentList.add(directParentDocId);
                    parentList = parentList + parentList2;
                    if (parentList.length < 128) {
                      treeMap["PARENTS"] = parentList;
                    } else {
                      parentList.removeAt(parentList.length - 1);
                      treeMap["PARENTS"] = parentList;
                    }
                    await databasePointer
                        .doc(documentId)
                        .set(treeMap, SetOptions(merge: true));
                    await db
                        .collection('USERS')
                        .doc(memberId)
                        .set(userMap, SetOptions(merge: true));
                    await db
                        .collection('USERS')
                        .doc(refMember)
                        .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));

                    toIdList.add(directParentId);
                    notificationMap["TO_ID"] = toIdList;
                    await db
                        .collection('NOTIFICATIONS')
                        .doc(notificationId)
                        .set(notificationMap);

                    HashMap<String, Object> upgradeMap = HashMap();
                    upgradeMap["AMOUNT"] = "200";
                    upgradeMap["DATE"] = now;
                    upgradeMap["TO_ID"] = directParentId;
                    upgradeMap["FROM_ID"] = memberId;
                    upgradeMap["SCREENSHOT"] = "";
                    upgradeMap["TYPE"] = "HELP";
                    upgradeMap["STATUS"] = "PENDING";
                    upgradeMap["GRADE"] = "";
                    upgradeMap["TREE"] = "MASTER_CLUB";
                    upgradeMap["IN_TREE"] = "MASTER_CLUB";

                    await db
                        .collection("DISTRIBUTIONS")
                        .doc(DateTime.now()
                        .millisecondsSinceEpoch
                        .toString() +
                        generateRandomString(4))
                        .set(upgradeMap, SetOptions(merge: true));

                    await databasePointer.doc(directParentDocId).set({
                      "CHILD_COUNT": FieldValue.increment(1),
                      "CHILDREN": childList,
                    }, SetOptions(merge: true));
                    await db.collection('USERS').doc(directParentId).set(
                        {"CHILD_COUNT": FieldValue.increment(1)},
                        SetOptions(merge: true));
                    callOnFcmApiSendPushNotifications(
                        title: 'New Master Club Member',
                        body:
                        '$memberName completed PRC payment and placed in Master Club.\n'
                            'Phone: $memberPhone',
                        fcmList: fcmList + fcmList2,
                        imageLink: '');
                  }
                }
                else {
                  var parentValue33 = await databasePointer
                      .where("CHILD_COUNT", isEqualTo: 0)
                      .orderBy("STEP_ID")
                      .limit(1)
                      .get();
                  // .then((parentValue33) {
                  if (parentValue33.docs.isNotEmpty) {
                    Map<dynamic, dynamic> parentMap2 =
                    parentValue33.docs.first.data();
                    List<String> fcmList2 = [parentMap2["FCM_ID"]];
                    String directParentId =
                    parentMap2["MEMBER_ID"].toString();
                    String directParentDocId =
                    parentMap2["DOCUMENT_ID"].toString();
                    int stepId = parentMap2["STEP_ID"] + 1;
                    List<dynamic> parentList = [];
                    List<dynamic> parentList2 =
                    parentMap2["PARENTS"];
                    List<dynamic> childList = [documentId];
                    treeMap["STEP_ID"] = stepId;
                    treeMap["DIRECT_PARENT_ID"] = directParentId;
                    treeMap["DIRECT_PARENT_DOC_ID"] =
                        directParentDocId;
                    userMap["STEP_ID"] = stepId;
                    userMap["DIRECT_PARENT_ID"] = directParentId;
                    if (parentList.length < 128) {
                      parentList.add(directParentDocId);
                      treeMap["PARENTS"] = parentList;
                    } else {
                      parentList.removeAt(0);
                      parentList.add(directParentDocId);
                      treeMap["PARENTS"] = parentList;
                    }
                    await databasePointer
                        .doc(documentId)
                        .set(treeMap, SetOptions(merge: true));
                    await db
                        .collection('USERS')
                        .doc(memberId)
                        .set(userMap, SetOptions(merge: true));
                    await db
                        .collection('USERS')
                        .doc(refMember)
                        .set({"TOTAL_INVITEES_COUNT":FieldValue.increment(1)}, SetOptions(merge: true));
                    toIdList.add(directParentId);
                    notificationMap["TO_ID"] = toIdList;
                    await db
                        .collection('NOTIFICATIONS')
                        .doc(notificationId)
                        .set(notificationMap);

                    HashMap<String, Object> upgradeMap = HashMap();
                    upgradeMap["AMOUNT"] = "200";
                    upgradeMap["DATE"] = now;
                    upgradeMap["TO_ID"] = directParentId;
                    upgradeMap["FROM_ID"] = memberId;
                    upgradeMap["SCREENSHOT"] = "";
                    upgradeMap["TYPE"] = "HELP";
                    upgradeMap["STATUS"] = "PENDING";
                    upgradeMap["GRADE"] = "";
                    upgradeMap["TREE"] = "MASTER_CLUB";
                    upgradeMap["IN_TREE"] = "MASTER_CLUB";

                    await db
                        .collection("DISTRIBUTIONS")
                        .doc(DateTime.now()
                        .millisecondsSinceEpoch
                        .toString() +
                        generateRandomString(4))
                        .set(upgradeMap, SetOptions(merge: true));

                    await databasePointer.doc(directParentDocId).set({
                      "CHILD_COUNT": FieldValue.increment(1),
                      "CHILDREN": childList,
                    }, SetOptions(merge: true));
                    await db.collection('USERS').doc(directParentId).set(
                        {"CHILD_COUNT": FieldValue.increment(1)},
                        SetOptions(merge: true));
                    callOnFcmApiSendPushNotifications(
                        title: 'New Master Club Member',
                        body:
                        '$memberName completed PRC payment and placed in Master Club.\n'
                            'Phone: $memberPhone',
                        fcmList: fcmList + fcmList2,
                        imageLink: '');
                  }
                  // });
                }

                // });
              }
              // });
            }
            // });
          }
          // });
        }
        // });
        notifyListeners();
      });
      print("reachedttfgbdfbh 21");
      finish(context);
    });
  }

  warningAlert(BuildContext context, String alertContent) {
    AlertDialog alert = AlertDialog(
      backgroundColor: clF8FAFF,
      scrollable: true,
      title: Text(
        alertContent,
        style: const TextStyle(
            fontFamily: 'BarlowCondensed',
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
      content: InkWell(
        onTap: () {
          finish(context);
        },
        child: SizedBox(
          height: 50,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                          color: clFF731D,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          "OK",
                          style: TextStyle(
                              color: clF8FAFF,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'BarlowCondensed',
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  kycChildCountAlert(BuildContext context, String phone, String from) {
    String club = "";
    if (from == "STAR_CLUB") {
      club = "Star Club";
    } else {
      club = "Crown Club";
    }

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      backgroundColor: clF8FAFF,
      scrollable: true,
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      content: InkWell(
        onTap: () {
          finish(context);
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15),
          // height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "You're currently ineligible for $club upgrade due to:",
                style: const TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                  fontFamily: 'PoppinsMedium',
                  fontWeight: FontWeight.w400,
                  height: 1,
                ),
              ),
              const SizedBox(height: 8),
              kycBool
                  ? const Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  Text(
                    '  KYC verified.',
                    style: TextStyle(color: cl252525, fontSize: 13),
                  )
                ],
              )
                  : const Row(
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  Text(
                    '  KYC verification pending.',
                    style: TextStyle(color: cl252525, fontSize: 13),
                  )
                ],
              ),
              const SizedBox(height: 8),
              childCountBool
                  ? const Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  Text(
                    '  Mandatory referrals completed.',
                    style: TextStyle(color: cl252525, fontSize: 13),
                  )
                ],
              )
                  : const Row(
                children: [
                  Icon(Icons.close, color: Colors.red),
                  Text(
                    '  Mandatory referrals are incomplete.',
                    style: TextStyle(color: cl252525, fontSize: 13),
                  )
                ],
              ),
              const SizedBox(height: 8),
              distClear
                  ? const Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  Text(
                    '  All distributions are cleared.',
                    style: TextStyle(color: cl252525, fontSize: 13),
                  )
                ],
              )
                  : const Row(
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  Text(
                    '  Pending distributions are at this level.',
                    style: TextStyle(color: cl252525, fontSize: 13),
                  )
                ],
              ),
              const SizedBox(height: 8),
              incomeClear
                  ? const Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  Text(
                    '  All help amounts have been gathered.',
                    style: TextStyle(color: cl252525, fontSize: 13),
                  )
                ],
              )
                  : const Row(
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  Text(
                    '  Should gather all the help amounts',
                    style: TextStyle(color: cl252525, fontSize: 13),
                  )
                ],
              ),
              const SizedBox(height: 8),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Complete all tasks for eligibility.")),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        finish(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        decoration: BoxDecoration(
                            color: cl1848A3,
                            border: Border.all(color: cl1848A3),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height:5),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  restrictionAlert(BuildContext context, String userName) {
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      backgroundColor: clF8FAFF,
      scrollable: true,
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      content: InkWell(
        onTap: () {
          finish(context);
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 15),
          // height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "$userName ,",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    // fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w600,
                    height: 1,
                  ),
                ),
                const TextSpan(
                  text: "not eligible to accept help",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w400,
                    // height: 1,
                  ),
                )
              ])),
              const SizedBox(height: 8),
              userStatusBool
                  ? const Row(
                      children: [
                        Icon(Icons.close, color: Colors.red),
                        Text(
                          '  Not an Active member',
                          style: TextStyle(color: cl252525, fontSize: 13),
                        )
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 8),
              userGradeBool
                  ? const Row(
                      children: [
                        Icon(Icons.close, color: Colors.red),
                        Text(
                          '  Level Mismatch',
                          style: TextStyle(color: cl252525, fontSize: 13),
                        )
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 8),
              restrictionBool
                  ? Row(
                      children: [
                        const Icon(Icons.close, color: Colors.red),
                        Text(
                          '   Not yet paid $restrictionCheck',
                          style: const TextStyle(color: cl252525, fontSize: 14),
                        )
                      ],
                    )
                  : const SizedBox(),
              restrictionBool2
                  ? Row(
                      children: [
                        const Icon(Icons.close, color: Colors.red),
                        Text(
                          '   Not yet paid $restrictionCheck2',
                          style: const TextStyle(color: cl252525, fontSize: 14),
                        )
                      ],
                    )
                  : const SizedBox(),

              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        finish(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        decoration: BoxDecoration(
                            color: cl1848A3,
                            border: Border.all(color: cl1848A3),
                            borderRadius: BorderRadius.circular(15)),
                        child: const Text(
                          'Ok',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height:5),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  warningAlertHome(BuildContext context, String userName, String alertContent,
      String phone) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      backgroundColor: clF8FAFF,
      scrollable: true,
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      //alertContent
      title: Text(
        userName,
        maxLines: 2,
        style: const TextStyle(
          color: cl252525,
          fontSize: 17,
          fontFamily: 'PoppinsMedium',
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
      content: InkWell(
        onTap: () {
          finish(context);
        },
        child: Container(
          alignment: Alignment.center,
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Opacity(
                opacity: 0.70,
                child: Text(
                  alertContent,
                  style: const TextStyle(
                    color: cl252525,
                    fontSize: 16,
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w400,
                    height: 1,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        launch("tel://$phone");
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            color: grdintclr2,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Icon(
                          Icons.call,
                          color: Colors.black,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        launch('whatsapp://send?phone=$phone');
                      },
                      child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                              color: grdintclr2,
                              borderRadius: BorderRadius.circular(20)),
                          child: const Image(
                              image: AssetImage("assets/whatsapp.png"))),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        finish(context);
                      },
                      child: const Text(
                        'Ok',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: cl1848A3,
                          fontSize: 17,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height:5),
            ],
          ),
        ),
      ),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  clearFunction() {
    userProfileImage = "";
    userGrade = "STARTER";
    userName = "";
    userTotalEarnings = "0";
    userTotalDonation = "0";
    userTotalAmf = "0";
    userPhone = "";
    userDob = "";
    userGender = "";
    userAadhaarNumber = "";
    userAadhaarImage = "";
    userPanNumber = "";
    userPanImage = "";
    userAccountNumber = "";
    userIfscCode = "";
    userUpiId = "";
    registerID = "";
    registerDocID = "";
    dropdownValue = 'Male';
    kycDropdownID = 'Aadhaar';
    userAddress = "";
    kycStatus = "PENDING";
    registrationDate = "";
    directInvitesCount = "0";
    currentDate = DateTime.now();
    totalDays = 30;
    threeDays = 3;
    joinDate = 0;
    leftDays = 0;
    leftPmcDays = 0;
  }

  String userProfileImage = "";
  String userGrade = "";
  String userAutoOneGrade = "";
  String userAutoTwoGrade = "";
  String userName = "";
  String userTotalEarnings = "0";
  String userTotalDonation = "0";
  String userTotalAmf = "0";
  String userPhone = "";
  String userDob = "";
  String userGender = "";
  String userAadhaarNumber = "";
  String userAadhaarImage = "";
  String userAadhaarSecondSideImage = "";
  String userPanNumber = "";
  String userPanImage = "";
  String userAccountNumber = "";
  String userIfscCode = "";
  String userUpiId = "";
  String registerID = "";
  String registerDocID = "";
  String dropdownValue = 'Male';
  String nomineeDropDownValue = '';
  String kycDropdownID = 'Aadhaar';
  String userAddress = "";
  String kycStatus = "PENDING";
  String registrationDate = "";
  String directInvitesCount = "0";
  String userType = "";
  String userReferredBy = "";
  String userReferenceAmount = "0";
  String starClubEnter = "";
  String crownClubEnter = "";
  DateTime currentDate = DateTime.now();
  int totalDays = 30;
  int threeDays = 3;
  int joinDate = 0;
  int leftDays = 0;
  int leftPmcDays = 0;
  StreamSubscription? _streamUserDetails;

  void getUserDetails(String memberId) {
    if (_streamUserDetails != null) {
      _streamUserDetails!.cancel();
    }
    _streamUserDetails = db
        .collection("USERS")
        .doc(memberId)
        .snapshots()
        .listen((userValue) async {
      Map<dynamic, dynamic> userMap = userValue.data() as Map;

      registerID = memberId;
      registerDocID = userMap["DOCUMENT_ID"] ?? "";
      userProfileImage = userMap["ItemImage"] ?? "";
      userName = userMap["NAME"] ?? "";
      userGrade = userMap["GRADE"] ?? "";
      userAutoOneGrade = userMap["AUTO_ONE_GRADE"] ?? "";
      userAutoTwoGrade = userMap["AUTO_TWO_GRADE"] ?? "";
      userTotalEarnings = userMap["TOTAL_EARNINGS"].toString();
      userTotalDonation = userMap["TOTAL_HELP"].toString();
      userTotalAmf = userMap["TOTAL_PMC"].toString();
      userPhone = userMap["PHONE"] ?? "";
      userDob = userMap["DOB"] ?? "";
      dropdownValue = userMap["GENDER"] ?? "";
      aadhaarNumberController.text = userMap["ID_NUMBER"] ?? "";
      userAadhaarImage = userMap["ID_IMAGE"] ?? "";
      userAadhaarSecondSideImage = userMap["'ID_SECOND_IMAGE'"] ?? "";
      panNumberController.text = userMap["PAN_NUMBER"] ?? "";
      userPanImage = userMap["PAN_IMAGE"] ?? "";
      accountNumberController.text = userMap["ACCOUNT_NUMBER"] ?? "";
      ifscCodeController.text = userMap["IFSC_CODE"] ?? "";
      upiIDController.text = userMap["UPI_Id"] ?? "";
      adressController.text = userMap["ADDRESS"] ?? "";
      kycStatus = userMap["KYC_STATUS"] ?? "";
      kycDropdownID = userMap["ID_PROOF"] ?? "";
      directInvitesCount = userMap["CHILD_COUNT"].toString();
      pinCodeController.text = userMap["PIN_CODE"] ?? "";
      userType = userMap["TYPE"] ?? "";
      registrationDate = outputFormat.format(userMap["REG_DATE"].toDate());
      Duration difference =
      currentDate.difference(userMap["REG_DATE"].toDate());
      leftDays = totalDays - (joinDate = difference.inDays);
      nomineeController.text = userMap["NOMINEE_NAME"] ?? "";
      nomineePhoneNumberController.text = userMap["NOMINEE_PHONE_NUMBER"] ?? "";
      userReferredBy = userMap["REFERENCE_NAME"] ?? "";
      starClubEnter = userMap["STAR_ENTRY"] ?? "";
      crownClubEnter = userMap["CROWN_ENTRY"] ?? "";
      userReferenceAmount = userMap["TOTAL_REFERRAL_AMOUNT"].toString() ;
      if (userMap["NOMINEE_YEAR_OF_BIRTH"] != null) {
        nomineeAgeController.text = userMap["NOMINEE_YEAR_OF_BIRTH"].toString();
      } else {
        if(userMap["NOMINEE_AGE"]!=null){
          int age = int.parse(userMap["NOMINEE_AGE"].toString());

          nomineeAgeController.text = "${2024 - age}";
          db.collection("USERS").doc(memberId).set(
              {"NOMINEE_YEAR_OF_BIRTH": "${2024 - age}"},
              SetOptions(merge: true));}
      }

      nomineeDropDownValue = userMap["NOMINEE_RELATION"] ?? "";

      notifyListeners();
      // fetchDistributionsNEW(memberId,userGrade,"MASTER_CLUB");
      fetchDirectDistributions(memberId, userGrade, "MASTER_CLUB");
      fetchCompanyDistributions(memberId, userGrade, "MASTER_CLUB");
    });
  }

  void assignFunction() {
    myProfileNAMEEditingController.text = userName;
    myProfileNUMBEREditingController.text = userPhone;
    myProfileUPIIDEditingController.text = upiIDController.text;
    notifyListeners();
  }

  Reference ref = FirebaseStorage.instance.ref("ID_IMAGE");
  Reference ref2 = FirebaseStorage.instance.ref("PAN_IMAGE");
  Reference ref3 = FirebaseStorage.instance.ref("ItemImage");

  Future<void> editUserAccount(BuildContext context, String memberId) async {
    bool userIdNumber = await checkKycIdExist(
        aadhaarNumberController.text.trim(), memberId, context);
    bool userPanNumber = await checkKycPanExist(
        panNumberController.text.trim(), memberId, context);
    bool userAccountNumber = await checkKycAccountExist(
        accountNumberController.text.trim(), memberId, context);
    bool userUpiId = await checkKycUpiIdExist(
        upiIDController.text.trim(), memberId, context);
    if (!userIdNumber) {
      if (!userPanNumber) {
        if (!userAccountNumber) {
          if (!userUpiId) {
            HashMap<String, Object> editUserAcc = HashMap();
            editUserAcc["DOB"] = selectedDateTime.toString();
            editUserAcc["GENDER"] = dropdownValue.toString();
            editUserAcc["ADDRESS"] = adressController.text.trim();

            editUserAcc["PAN_NUMBER"] = panNumberController.text.trim();
            editUserAcc["ACCOUNT_NUMBER"] = accountNumberController.text.trim();

            editUserAcc["IFSC_CODE"] = ifscCodeController.text.trim();
            editUserAcc["UPI_Id"] = upiIDController.text.trim();
            editUserAcc["ID_PROOF"] = kycDropdownID;
            editUserAcc["ID_NUMBER"] = aadhaarNumberController.text.trim();
            editUserAcc["PIN_CODE"] = pinCodeController.text.trim();
            editUserAcc["KYC_STATUS"] = "SUBMITTED";
            editUserAcc["KYC_SUBMITTED_DATE"] = DateTime.now();
            editUserAcc["NOMINEE_NAME"] = nomineeController.text.trim();
            editUserAcc["NOMINEE_PHONE_NUMBER"] =
                nomineePhoneNumberController.text.trim();
            editUserAcc["NOMINEE_YEAR_OF_BIRTH"] =
                nomineeAgeController.text.trim();
            editUserAcc["NOMINEE_RELATION"] = nomineeDropDownValue;

            if (fileAdhaarSeconodSideImage != null) {
              String time = DateTime.now().millisecondsSinceEpoch.toString();
              ref = FirebaseStorage.instance.ref().child(time);
              await ref.putFile(fileAdhaarSeconodSideImage!).whenComplete(() async {
                await ref.getDownloadURL().then((value1) {
                  editUserAcc['ID_SECOND_IMAGE'] = value1;
                  notifyListeners();
                });
                notifyListeners();
              });
              notifyListeners();
            } else {
              editUserAcc['ID_SECOND_IMAGE'] = userAadhaarSecondSideImage;
            }
            if (fileAdhaarImage != null) {
              String time = DateTime.now().millisecondsSinceEpoch.toString();
              ref = FirebaseStorage.instance.ref().child(time);
              await ref.putFile(fileAdhaarImage!).whenComplete(() async {
                await ref.getDownloadURL().then((value1) {
                  editUserAcc['ID_IMAGE'] = value1;
                  notifyListeners();
                });
                notifyListeners();
              });
              notifyListeners();
            } else {
              editUserAcc['ID_IMAGE'] = userAadhaarImage;
            }
            if (filePanImage != null) {
              String time = DateTime.now().millisecondsSinceEpoch.toString();
              ref2 = FirebaseStorage.instance.ref().child(time);
              await ref2.putFile(filePanImage!).whenComplete(() async {
                await ref2.getDownloadURL().then((value2) {
                  editUserAcc['PAN_IMAGE'] = value2;
                  notifyListeners();
                });
                notifyListeners();
              });
              notifyListeners();
            } else {
              editUserAcc['PAN_IMAGE'] = userPanImage;
            }

            db
                .collection("USERS")
                .doc(memberId)
                .set(editUserAcc, SetOptions(merge: true));

            editCheck = false;
            notifyListeners();
            clearUserControllers();

            getUserDetails(memberId);

            List<String> fcmList = [];
            List<String> toList = [];
            DateTime now = DateTime.now();
            String newId =
                now.millisecondsSinceEpoch.toString() + generateRandomString(2);
            await db.collection("ADMINS").get().then((value) {
              if (value.docs.isNotEmpty) {
                for (var element in value.docs) {
                  Map<dynamic, dynamic> map = element.data();
                  toList.add(element.id);
                  if (map["FCM_ID"] != null) {
                    fcmList.add(map["FCM_ID"].toString());
                  }
                }
              }
            });
            HashMap<String, Object> notificationMap = HashMap();
            notificationMap["CONTENT"] = "$userName has uploaded KYC details.";
            notificationMap["FROM_ID"] = memberId;
            notificationMap["TO_ID"] = toList;
            notificationMap["NOTIFICATION_ID"] = newId;
            notificationMap['REG_DATE'] = now;
            notificationMap["VIEWERS"] = [];
            notificationMap["DATE"] = outputDayNode.format(now).toString();
            notificationMap["TIME"] = outputDayNode2.format(now).toString();
            db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
            callOnFcmApiSendPushNotifications(
                title: 'KYC VERIFICATION',
                body: 'New KYC details uploaded.'
                    '\n  Name:$userName \n Phone:$userPhone',
                fcmList: fcmList,
                imageLink: '');
            // finish(context);
            // finish(context);
            // finish(context);
          } else {
            warningAlert(
                context, upiIDController.text + " Number already exist.");
          }
        } else {
          warningAlert(
              context, accountNumberController.text + " Number already exist.");
        }
      } else {
        warningAlert(context,
            panNumberController.text + " kycDropdownID Number already exist.");
      }
    } else {
      warningAlert(
          context, aadhaarNumberController.text + " Number already exist.");
    }
  }

  bool upiCopyBool = false;

  notifyCopyBool() {
    upiCopyBool = true;
    notifyListeners();
  }

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String title,
      required String body,
      required List fcmList,
      required String imageLink}) async {
    Uri posturlGroup = Uri.parse('https://fcm.googleapis.com/fcm/notification');

    final headersGroup = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAGbRL5hg:APA91bHQn0lQ-0HiGw4it6Jz15Pmb0D7TPES4p-Y-0Zauwck-VFB-pB-P4ecqZMR7OYReVIMyZA1DcLb6jXCqevBwBUa3KxqNQ-zi7tkPDHCbW6cJhfJDTnrOhNU81rtcOeLKaG7c4q-',
      // '
      // key=YOUR_SERVER_KEY'
      'project_id': '110399055384'
    };
    final dataGroup = {
      "operation": "create",
      "notification_key_name": DateTime.now().toString(),
      "registration_ids": fcmList,
    };

    final response1 = await http.post(posturlGroup,
        body: json.encode(dataGroup),
        encoding: Encoding.getByName('utf-8'),
        headers: headersGroup);

    final Map parsed = json.decode(response1.body);
    var notificaitonKey = parsed["notification_key"];

    Uri postUrl = Uri.parse('https://fcm.googleapis.com/fcm/send');
    final data = {
      "to": notificaitonKey,
      "notification": {"title": title, "body": body, "image": imageLink},
      "data": {
        "type": '0rder',
        "id": '28',
        "click_action": 'FLUTTER_NOTIFICATION_CLICK',
      }
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAGbRL5hg:APA91bHQn0lQ-0HiGw4it6Jz15Pmb0D7TPES4p-Y-0Zauwck-VFB-pB-P4ecqZMR7OYReVIMyZA1DcLb6jXCqevBwBUa3KxqNQ-zi7tkPDHCbW6cJhfJDTnrOhNU81rtcOeLKaG7c4q-',
      // 'key=YOUR_SERVER_KEY'
      'project_id': '110399055384'
    };

    final response = await http.post(postUrl,
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);
    print("${response.body} (response)");

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }

  Future<void> editMyProfile(
      BuildContext context1, String memberId, String docID) async {
    bool numberStatus =
        await checkNumberExist(myProfileNUMBEREditingController.text);
    bool upiIdStatus = await checkKycUpiIdExist(
        myProfileUPIIDEditingController.text.trim(), memberId, context1);
    if (!numberStatus || myProfileNUMBEREditingController.text == userPhone) {
      if (!upiIdStatus) {
        showDialog(
            context: context1,
            builder: (context) {
              return const Center(
                child: CircularProgressIndicator(color: myWhite),
              );
            });
        HashMap<String, Object> editMyProfile = HashMap();
        HashMap<String, Object> editImageMap = HashMap();
        editMyProfile["NAME"] = myProfileNAMEEditingController.text;
        editMyProfile["UPI_Id"] = myProfileUPIIDEditingController.text;
        if (fileImage != null) {
          String time = DateTime.now().millisecondsSinceEpoch.toString();
          ref3 = FirebaseStorage.instance.ref().child(time);
          await ref3.putFile(fileImage!).whenComplete(() async {
            await ref3.getDownloadURL().then((value3) {
              editMyProfile['ItemImage'] = value3;
              editImageMap['ItemImage'] = value3;
              userProfileImage = value3;
              notifyListeners();
            });
            notifyListeners();
          });
          notifyListeners();
        } else {
          editMyProfile['ItemImage'] = userProfileImage;
          editImageMap['ItemImage'] = userProfileImage;
        }

        db
            .collection("USERS")
            .doc(memberId)
            .set(editMyProfile, SetOptions(merge: true));
        db
            .collection("MASTER_CLUB")
            .doc(docID)
            .set(editImageMap, SetOptions(merge: true));
        db.collection("STAR_CLUB").doc(docID).get().then((autoPollOne) {
          db.collection("CROWN_CLUB").doc(docID).get().then((autoPollTwo) {
            if (autoPollOne.exists) {
              db
                  .collection("STAR_CLUB")
                  .doc(docID)
                  .set(editImageMap, SetOptions(merge: true));
            }

            if (autoPollTwo.exists) {
              db
                  .collection("CROWN_CLUB")
                  .doc(docID)
                  .set(editImageMap, SetOptions(merge: true));
            }
          });
        });
        finish(context1);
        notifyListeners();
        editCheck2 = false;
        notifyListeners();

        final snackBar = SnackBar(
          backgroundColor: myWhite,
          duration: const Duration(seconds: 1),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(79),
          ),
          behavior: SnackBarBehavior.floating,
          content: const Text(
            "Profile has been edited successfully...",
            style: TextStyle(color: Color(0xFF2FC1BC)),
          ),
        );
        ScaffoldMessenger.of(context1).showSnackBar(snackBar);
      } else {
        const snackBar = SnackBar(
          elevation: 6.0,
          backgroundColor: myWhite,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Text(
            "Upi Id Already Exist...",
            style: TextStyle(color: Colors.red),
          ),
        );
        ScaffoldMessenger.of(context1).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(
        elevation: 6.0,
        backgroundColor: myWhite,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        content: Text(
          "Number Already Exist...",
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context1).showSnackBar(snackBar);
    }
  }

  void clearUserControllers() {
    dateOfBirthController.clear();
    dropdownValue = "";
    adressController.clear();
    aadhaarNumberController.clear();
    panNumberController.clear();
    accountNumberController.clear();
    ifscCodeController.clear();
    upiIDController.clear();
    fileAdhaarImage = null;
    fileImage = null;
    filePanImage = null;
    userPanImage = "";
    userAadhaarImage = "";
    notifyListeners();
  }

  void dropDown(changeValue) {
    dropdownValue = changeValue.toString();
    notifyListeners();
  }

  void nomineeRelationDropDown(changeValue) {
    nomineeDropDownValue = changeValue.toString();
    notifyListeners();
  }

  void dropDownId(changeValue) {
    kycDropdownID = changeValue.toString();
    notifyListeners();
  }

  void getUserDetailsOnRegistration(String memberPhone, String memberName) {
    userProfileImage = "";
    userName = memberName;
    userTotalEarnings = "0";
    userTotalDonation = "0";
    userTotalAmf = "0";
    userPhone = memberPhone;
    userDob = "";
    userGender = "";
    userAadhaarNumber = "";
    userAadhaarImage = "";
    userPanNumber = "";
    userPanImage = "";
    userAccountNumber = "";
    userIfscCode = "";
    userUpiId = "";
    notifyListeners();
  }

  List<ReferenceModel> userReferenceList = [];
  StreamSubscription? _streamReferences;

  // void fetchUserReferences(String memberId) {
  //   if(_streamReferences!=null) {
  //     _streamReferences!.cancel();
  //   }
  //   userReferenceList.clear();
  //   String name = '';
  //   String image = '';
  //   String number = '';
  //
  //   _streamReferences = db.collection("REFERENCES")
  //       .where("REFERER_ID", isEqualTo: memberId)
  //       .snapshots()
  //       .listen((referEvent) {
  //
  //
  //     if (referEvent.docs.isNotEmpty) {
  //       userReferenceList.clear();
  //       for (var elements in referEvent.docs) {
  //         db.collection("USERS")
  //             .doc(elements.get("REFERRED_ID").toString())
  //             .get()
  //             .then((referredValue) {
  //           if(referredValue.exists) {
  //             Map<dynamic, dynamic> referredMap = referredValue
  //                 .data() as Map;
  //             image = referredMap["ItemImage"] ?? "";
  //             name = referredMap["NAME"].toString();
  //             number = referredMap["PHONE"].toString();
  //             userReferenceList.add(ReferenceModel(
  //               name,
  //               image,
  //               elements.get("REFERRED_ID").toString(),
  //               number,
  //               elements.id,
  //             ));
  //             notifyListeners();
  //           } });
  //       }
  //     }
  //     else {
  //
  //       userReferenceList.clear();
  //       notifyListeners();
  //     }
  //   });
  // }
  void fetchUserReferences(String refPhoneNumber) {
    if (_streamReferences != null) {
      _streamReferences!.cancel();
    }
    userReferenceList.clear();
    String name = '';
    String image = '';
    String number = '';
    String referenceNumber = '';

    _streamReferences = db
        .collection("USERS")
        .where("REFERENCE_NUMBER", isEqualTo: refPhoneNumber)
        .snapshots()
        .listen((referEvent) {
      if (referEvent.docs.isNotEmpty) {
        userReferenceList.clear();
        for (var elements in referEvent.docs) {
          Map<dynamic, dynamic> referredMap = elements.data();
          image = referredMap["ItemImage"] ?? "";
          name = referredMap["NAME"].toString();
          number = referredMap["PHONE"].toString();
          referenceNumber = referredMap["REFERENCE"].toString();
          userReferenceList.add(ReferenceModel(
            name,
            image,
            elements.id,
            number,
            referenceNumber,
          ));
          notifyListeners();
        }
      } else {
        userReferenceList.clear();
        notifyListeners();
      }
    });
  }

  String userUpgradeId = "";
  String userUpgradeDistributionId = "";
  String userUpgradeProfileImage = "";
  String userUpgradeScreenShot = "";
  String userUpgradeName = "";
  String userUpgradeUpiID = "";
  String userUpgradeNumber = "";
  String userUpgradeStatus = "";
  String userUpgradeAmount = "";
  String userUpgradeGrade = "";
  String upgradeUserStatus = "";
  String upgradeUserChildCount = "";
  String referralUserChildCount = "";
  String autoPollOneUserChildCount = "";
  String autoPollTwoUserChildCount = "";
  int upgradeUserLeftDays = 0;
  int referralUserLeftDays = 0;
  int autoPollOneUserLeftDays = 0;
  int autoPollTwoUserLeftDays = 0;
  String referralUserStatus = "";
  String userUpgradeTree = "";
  bool userUpgradeBool = false;

  bool userPmcBool = false;
  bool userReferralBool = false;

  bool userDonationBool = false;

  bool userAuto1Bool = false;

  bool userAuto2Bool = false;

  String userReferralId = "";
  String userReferralDistributionId = "";
  String userReferralProfileImage = "";
  String userReferralScreenShot = "";
  String userReferralName = "";
  String userReferralUpiID = "";
  String userReferralNumber = "";
  String userReferralStatus = "";
  String userReferralAmount = "";
  String userReferralGrade = "";
  String userReferralTree = "";
  String userAutoPollOneId = "";
  String userAutoPollOneDistributionId = "";
  String userAutoPollOneProfileImage = "";
  String userAutoPollOneScreenShot = "";
  String userAutoPollOneName = "";
  String userAutoPollOneNumber = "";
  String userAutoPollOneStatus = "";
  String userAutoPollOneAmount = "";
  String userAutoPollOneGrade = "";
  String userAutoPollOneTree = "";
  String userAutoPollOneUpiID = "";
  String userAutoPollTwoId = "";
  String userAutoPollTwoDistributionId = "";
  String userAutoPollTwoProfileImage = "";
  String userAutoPollTwoScreenShot = "";
  String userAutoPollTwoName = "";
  String userAutoPollTwoNumber = "";
  String userAutoPollTwoStatus = "";
  String autoPollTwoUserStatus = "";
  String autoPollOneUserStatus = "";
  String userAutoPollTwoAmount = "";
  String userAutoPollTwoGrade = "";
  String userAutoPollTwoTree = "";
  String userAutoPollTwoUpiID = "";
  String userSponsorName = "";
  String userSponsorNumber = "";
  String userSponsorId = "";
  String userSponsorProfileImage = "";
  String userSponsorScreenShot = "";
  String userSponsorStatus = "";
  String userSponsorAmount = "";
  String userPmcAmount = "";
  String userPmcStatus = "";
  String userPmcGrade = "";
  String userPmcTree = "";
  String userPmcDate = "";
  String userPmcDistributionId = "";
  String userDonationAmount = "";
  String userDonationStatus = "";
  String userDonationGrade = "";
  String userDonationTree = "";
  String userDonationDistributionId = "";

  clearDistributions() {
    sortDistributionList.clear();
    distributionList.clear();
    homeDistributionList.clear();
    pmcDistributionList.clear();
    masterDistributionList.clear();
    starDistributionList.clear();
    crownDistributionList.clear();
    masterAllDistributionList.clear();
    starAllDistributionList.clear();
    crownAllDistributionList.clear();
    notifyListeners();
  }

  String distributeAmount = '';
  String distributeToId = '';
  String distributeFromId = '';
  String distributeScreenShot = '';
  String distributeType = '';
  String distributeStatus = '';
  String distributeGrade = '';
  String distributeTree = '';
  String distributeProfileImage = '';
  String distributeName = '';
  String distributeNumber = '';
  String distributeUpiId = '';

  String userTreeGrade = "";

  void fetchUserTreeGrade(String tree, String memberDoc) {
    db.collection(tree).doc(memberDoc).get().then((userDocValue) {
      if (userDocValue.exists) {
        userTreeGrade = userDocValue.get("GRADE");
        notifyListeners();
      }
    });
  }

  bool isFirstTime = true;
  bool hidePmcBool = true;
  StreamSubscription? _streamDirectDistributions;
  StreamSubscription? _streamCompanyDistributions;
  StreamSubscription? _streamUserGradeDistribution;

  List<DistributionModel> distributionList = [];
  List<DistributionModel> sortDistributionList = [];
  List<DistributionModel> masterDistributionList = [];
  List<DistributionModel> masterAllDistributionList = [];
  List<DistributionModel> starDistributionList = [];
  List<DistributionModel> starAllDistributionList = [];
  List<DistributionModel> crownDistributionList = [];
  List<DistributionModel> crownAllDistributionList = [];
  List<PrivilegeModel> totalPmcList = [];
  List<DistributionModel> homeDistributionList = [];
  List<DistributionModel> pmcDistributionList = [];
  List<DistributionModel> sortStatusDistributionList = [];
  List<DistributionModel> sortGradeDistributionList = [];

  filterPmc(String grade, int index) {
    sortStatusDistributionList = distributionList
        .where((element) => element.fromGrade == grade)
        .toSet()
        .toList();

    if (totalPmcList[index].select == true) {
      totalPmcList[index].select = false;
    } else {
      totalPmcList[index].select = true;
    }
    for (var element in totalPmcList) {
      if (element.item != grade) {
        element.select = false;
      }
    }

    notifyListeners();
  }

  hideFilterPmc(int index) {
    totalPmcList[index].select = true;
    hidePmcBool = true;
    notifyListeners();
    sortStatusDistributionList.clear();
  }

  filterDistributionList(String tree) {
    sortDistributionList = distributionList
        .where((element) => element.tree == tree)
        .toSet()
        .toList();
    sortStatusDistributionList = sortDistributionList;
    notifyListeners();
  }

  clearBooleans() {
    editCheck = false;
    hideFilterBool = false;
    lessBool = false;
    hideHelpFilterBool = false;
    hideIncomeFilterBool = false;
    lessIncomeBool = false;
    notifyListeners();
  }

  filterStatusDistList(List statusList, int index, String tree, String level,
      String status, BuildContext context) {
    if (level != "ALL") {
      statusList[index].color = false;
      for (var element in statusList) {
        if (element.levelName != status) {
          element.color = true;
        }
      }
      if (status == "ALL") {
        sortDistributionList = distributionList
            .where(
                (element) => element.tree == tree && element.fromGrade == level)
            .toSet()
            .toList();
      } else {
        sortDistributionList = distributionList
            .where((element) =>
                element.tree == tree &&
                element.fromGrade == level &&
                element.status == status)
            .toSet()
            .toList();
      }

      notifyListeners();
    } else {
      statusList[index].color = false;
      for (var element in statusList) {
        if (element.levelName != status) {
          element.color = true;
        }
      }
      if (level == "ALL" && status != "ALL") {
        sortDistributionList = distributionList
            .where(
                (element) => element.tree == tree && element.status == status)
            .toSet()
            .toList();
      } else {
        sortDistributionList = distributionList
            .where((element) => element.tree == tree)
            .toSet()
            .toList();
      }
    }
    notifyListeners();
  }

  filterStatusIncomeList(List incomeStatusList, int index, String tree,
      String level, String status, BuildContext context) {
    if (level != "ALL") {
      incomeStatusList[index].color = false;
      for (var element in incomeStatusList) {
        if (element.levelName != status) {
          element.color = true;
        }
      }

      if (status == "ALL") {
        filterIncomeList = userInList
            .where((element) => element.tree == tree && element.grade == level)
            .toSet()
            .toList();
      } else {
        filterIncomeList = userInList
            .where((element) =>
                element.tree == tree &&
                element.grade == level &&
                element.status == status)
            .toSet()
            .toList();
      }
      notifyListeners();
    } else {
      incomeStatusList[index].color = false;

      for (var element in incomeStatusList) {
        if (element.levelName != status) {
          element.color = true;
        }
      }
      if (level == "ALL" && status != "ALL") {
        filterIncomeList = userInList
            .where(
                (element) => element.tree == tree && element.status == status)
            .toSet()
            .toList();
      } else {
        filterIncomeList = userInList
            .where((element) => element.tree == tree)
            .toSet()
            .toList();
      }
    }
    notifyListeners();
  }

  filterGradeDistList(String tree, String level, String from) {
    if (from == "Distribution") {
      for (var element in statusList) {
        element.color = true;
      }
      if (level != "ALL") {
        sortDistributionList = distributionList
            .where(
                (element) => element.tree == tree && element.fromGrade == level)
            .toSet()
            .toList();
      } else {
        sortDistributionList = distributionList
            .where((element) => element.tree == tree)
            .toSet()
            .toList();
      }
    } else {
      for (var element in incomeStatusListNew) {
        element.color = true;
      }
      if (level != "ALL") {
        filterIncomeList = userInList
            .where((element) => element.tree == tree && element.grade == level)
            .toSet()
            .toList();
      } else {
        filterIncomeList = userInList
            .where((element) => element.tree == tree)
            .toSet()
            .toList();
      }
    }
    notifyListeners();
  }

  clearStreamSubscriptions() {
    if (_streamInTransactions != null) {
      _streamInTransactions!.cancel();
    }
    if (_streamMessages != null) {
      _streamMessages!.cancel();
    }
    if (_streamNotifications != null) {
      _streamNotifications!.cancel();
    }
    if (_streamAutoTwoParents != null) {
      _streamAutoTwoParents!.cancel();
    }
    if (_streamAutoOneParents != null) {
      _streamAutoOneParents!.cancel();
    }
    if (_streamBasicParents != null) {
      _streamBasicParents!.cancel();
    }
    if (_streamAutoTwoGrade != null) {
      _streamAutoTwoGrade!.cancel();
    }
    if (_streamAutoOneGrade != null) {
      _streamAutoOneGrade!.cancel();
    }
    if (_streamBasicGrade != null) {
      _streamBasicGrade!.cancel();
    }
    if (_streamDirectDistributions != null) {
      _streamDirectDistributions!.cancel();
    }
    if (_streamCompanyDistributions != null) {
      _streamCompanyDistributions!.cancel();
    }
    if (_streamReferences != null) {
      _streamReferences!.cancel();
    }
    if (_streamUserDetails != null) {
      _streamUserDetails!.cancel();
    }
    if (_streamLastTransactions != null) {
      _streamLastTransactions!.cancel();
    }
    notifyListeners();
  }

  List<UserInModel> userInList = [];
  List<UserInModel> filterIncomeList = [];
  List<UserInModel> filterIncomeMasterList = [];
  List<UserInModel> filterIncomeStarList = [];
  List<UserInModel> filterIncomeCrownList = [];

  // List<UserInModel> sortIncomeList = [];
  List<UserInModel> userReferralTransactionList = [];
  List<UserInModel> userClearedReferralTransactionList = [];
  List<UserInModel> referralList = [];
  double totaluserReferralTransaction = 0;
  double totaluserReferralOutTransaction = 0;
  StreamSubscription? _streamInTransactions;
  StreamSubscription? _streamInReferralTransactions;

  void fetchInTransactions(
    String memberId,
  ) {
    if (_streamInTransactions != null) {
      _streamInTransactions!.cancel();
    }
    userInList.clear();
    filterIncomeList.clear();
    referralList.clear();
    filterIncomeCrownList.clear();
    filterIncomeStarList.clear();
    filterIncomeMasterList.clear();
    String userIncomeId = "";
    String userIncomeProfileImage = "";
    String userIncomeScreenShot = "";
    String userIncomeName = "";
    String userIncomeNumber = "";
    String userIncomeStatus = "";
    String userIncomeAmount = "";
    String userIncomeGrade = "";
    String userIncomeTree = "";
    String userIncomeInTree = "";
    String userIncomePayment = "";
    String userDocId = "";
    String addScrDate = '';
    String addScrTime = '';
    _streamInTransactions = db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: memberId)
        .where("TYPE", whereIn: ["STAR_CLUB", "CROWN_CLUB", "HELP"])
        .snapshots()
        .listen((inValue) {
          if (inValue.docs.isNotEmpty) {
            for (var elements in inValue.docs) {
              Map<dynamic, dynamic> inMap = elements.data();
              db
                  .collection("USERS")
                  .doc(inMap["FROM_ID"].toString())
                  .get()
                  .then((uValue) {
                if (uValue.exists) {
                  Map<dynamic, dynamic> uMap = uValue.data() as Map;
                  userIncomeId = inMap["FROM_ID"].toString();
                  userIncomeProfileImage = uMap["ItemImage"] ?? "";
                  userIncomeScreenShot = inMap["SCREENSHOT"].toString();
                  userIncomeName = uMap["NAME"].toString();
                  userIncomeNumber = uMap["PHONE"].toString();
                  userDocId = uMap["DOCUMENT_ID"].toString();
                  userIncomeStatus = inMap["STATUS"].toString();
                  userIncomeAmount = inMap["AMOUNT"].toString();
                  userIncomeGrade = inMap["GRADE"].toString();
                  userIncomeTree = inMap["TREE"].toString();
                  userIncomeInTree = inMap["IN_TREE"] ?? "";
                  userIncomePayment = inMap["TYPE"].toString();
                  if (inMap["SCREENSHOT_ADD_DATE"] != null) {
                    addScrDate = outputFormat
                        .format(inMap["SCREENSHOT_ADD_DATE"].toDate());
                    addScrTime = outTimeFormat
                        .format(inMap["SCREENSHOT_ADD_DATE"].toDate());
                  }
                  userInList.add(UserInModel(
                      elements.id,
                      userIncomeId,
                      userIncomeProfileImage,
                      userIncomeScreenShot,
                      userIncomeName,
                      userIncomeNumber,
                      userIncomeStatus,
                      userIncomeStatus,
                      userIncomeAmount,
                      addScrDate,
                      addScrTime,
                      userIncomeGrade,
                      userIncomeTree,
                      userIncomeInTree,
                      userIncomePayment,
                      userDocId,
                      ""));
                  userInList = removeIncomeDuplicate(userInList);
                  // filterIncomeList =  userInList.where((element) => element.status!="PAID").toSet().toList();

                  userInList.sort((a, b) => [
                        'PENDING',
                        'REJECTED',
                        'PROCESSING',
                        'PAID'
                      ].indexOf(a.status).compareTo([
                            'PENDING',
                            'REJECTED',
                            'PROCESSING',
                            'PAID'
                          ].indexOf(b.status)));

                  filterIncomeList = userInList
                      .where((item) =>
                          item.paymentType != "REFERRAL" &&
                          (item.status == "PENDING" ||
                              item.status == "REJECTED"))
                      .take(2)
                      .toSet()
                      .toList();
                  // =>item.paymentType!="REFERRAL" && item.status=="PENDING"||item.status=="REJECTED").take(2).toSet().toList();
                  if (filterIncomeList.isEmpty) {
                    filterIncomeList = userInList
                        .where((item) => item.paymentType != "REFERRAL")
                        .take(2)
                        .toSet()
                        .toList();
                  }

                  // referralList =  userInList.where((element) => element.paymentType=="REFERRAL").toSet().toList();
                  filterIncomeMasterList = userInList
                      .where((element) =>
                          element.inTree == "MASTER_CLUB" &&
                          element.paymentType != "REFERRAL")
                      .toSet()
                      .toList();
                  filterIncomeStarList = userInList
                      .where((element) => element.inTree == "STAR_CLUB")
                      .toSet()
                      .toList();
                  filterIncomeCrownList = userInList
                      .where((element) => element.inTree == "CROWN_CLUB")
                      .toSet()
                      .toList();
                  notifyListeners();
                }
              });
            }
            notifyListeners();
          }
        });
  }

  void fetchInReferralTransactions(
    String memberId,
  ) {
    if (_streamInReferralTransactions != null) {
      _streamInReferralTransactions!.cancel();
    }

    referralList.clear();
    String userIncomeId = "";
    String userIncomeProfileImage = "";
    String userIncomeScreenShot = "";
    String userIncomeName = "";
    String userIncomeNumber = "";
    String userIncomeStatus = "";
    String userIncomeAmount = "";
    String userIncomeGrade = "";
    String userIncomeTree = "";
    String userIncomeInTree = "";
    String userIncomePayment = "";
    String userDocId = "";
    String addScrDate = '';
    String addScrTime = '';
    _streamInTransactions = db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: memberId)
        .where("TYPE", isEqualTo: "REFERRAL")
        .snapshots()
        .listen((inValue) {
      if (inValue.docs.isNotEmpty) {
        for (var elements in inValue.docs) {
          Map<dynamic, dynamic> inMap = elements.data();
          db
              .collection("USERS")
              .doc(inMap["FROM_ID"].toString())
              .get()
              .then((uValue) {
            if (uValue.exists) {
              Map<dynamic, dynamic> uMap = uValue.data() as Map;
              userIncomeId = inMap["FROM_ID"].toString();
              userIncomeProfileImage = uMap["ItemImage"] ?? "";
              userIncomeScreenShot = inMap["SCREENSHOT"].toString();
              userIncomeName = uMap["NAME"].toString();
              userIncomeNumber = uMap["PHONE"].toString();
              userDocId = uMap["DOCUMENT_ID"].toString();
              userIncomeStatus = inMap["STATUS"].toString();
              userIncomeAmount = inMap["AMOUNT"].toString();
              userIncomeGrade = inMap["GRADE"].toString();
              userIncomeTree = inMap["TREE"].toString();
              userIncomeInTree = inMap["IN_TREE"] ?? "";
              userIncomePayment = inMap["TYPE"].toString();
              if (inMap["SCREENSHOT_ADD_DATE"] != null) {
                addScrDate =
                    outputFormat.format(inMap["SCREENSHOT_ADD_DATE"].toDate());
                addScrTime =
                    outTimeFormat.format(inMap["SCREENSHOT_ADD_DATE"].toDate());
              }
              referralList.add(UserInModel(
                  elements.id,
                  userIncomeId,
                  userIncomeProfileImage,
                  userIncomeScreenShot,
                  userIncomeName,
                  userIncomeNumber,
                  userIncomeStatus,
                  userIncomeStatus,
                  userIncomeAmount,
                  addScrDate,
                  addScrTime,
                  userIncomeGrade,
                  userIncomeTree,
                  userIncomeInTree,
                  userIncomePayment,
                  userDocId,
                  ""));
              referralList = removeIncomeDuplicate(referralList);
              referralList.sort((a, b) => [
                    'PROCESSING',
                    'PENDING',
                    'REJECTED',
                    'PAID'
                  ].indexOf(a.status).compareTo([
                        'PROCESSING',
                        'PENDING',
                        'REJECTED',
                        'PAID'
                      ].indexOf(b.status)));
              notifyListeners();
            }
          });
        }
        notifyListeners();
      }
    });
  }

  void fetchReferralTransactions(String memberId) {
    String userReferralId = "";
    String userReferralProfileImage = "";
    String userReferralScreenShot = "";
    String userReferralName = "";
    String userReferralNumber = "";
    String userReferralStatus = "";
    String userReferralShowStatus = "";
    String userReferralAmount = "";
    String userReferralType = "";
    String userReferralGrade = "";
    String userReferralTree = "";

    db
        .collection("DISTRIBUTIONS")
        .where("TO_ID", isEqualTo: memberId)
        .where("TYPE", isEqualTo: "REFERRAL")
        .get()
        .then((inValue) {
      db
          .collection("DISTRIBUTIONS")
          .where("FROM_ID", isEqualTo: memberId)
          .where("TYPE", isEqualTo: "REFERRAL")
          .get()
          .then((outValue) {
        userReferralTransactionList.clear();
        userClearedReferralTransactionList.clear();
        if (inValue.docs.isNotEmpty) {
          for (var elements in inValue.docs) {
            Map<dynamic, dynamic> inMap = elements.data();

            db
                .collection("USERS")
                .doc(inMap["FROM_ID"].toString())
                .get()
                .then((uValue) {
              if (uValue.exists) {
                Map<dynamic, dynamic> uMap = uValue.data() as Map;
                userReferralId = inMap["FROM_ID"].toString();
                userReferralProfileImage = uMap["ItemImage"] ?? "";
                userReferralScreenShot = inMap["SCREENSHOT"].toString();
                userReferralName = uMap["NAME"].toString();
                userReferralNumber = uMap["PHONE"].toString();
                userReferralStatus = inMap["STATUS"].toString();
                userReferralShowStatus = userReferralStatus == "PAID"
                    ? "RECEIVED"
                    : userReferralStatus;
                userReferralAmount = inMap["AMOUNT"].toString();
                userReferralType = inMap["TYPE"].toString();
                userReferralGrade = inMap["GRADE"].toString();
                userReferralTree = inMap["TREE"].toString();

                userReferralTransactionList.add(UserInModel(
                    elements.id,
                    userReferralId,
                    userReferralProfileImage,
                    userReferralScreenShot,
                    userReferralName,
                    userReferralNumber,
                    userReferralStatus,
                    userReferralShowStatus,
                    userReferralAmount,
                    "",
                    "",
                    userReferralGrade,
                    userReferralTree,
                    "",
                    userReferralType,
                    "",
                    "IN"));
                userClearedReferralTransactionList = userReferralTransactionList
                    .where((element) => element.showStatus == "PAID")
                    .toSet()
                    .toList();

                ///    Add All Amount
                // totaluserReferralTransaction =
                //     userReferralTransactionList.fold(0, (previousValue, element) => previousVaelue + double.parse(element.amount));}

                totaluserReferralTransaction = userReferralTransactionList
                    .fold(0, (previousValue, element) {
                  if (element.showStatus == 'RECEIVED') {
                    return previousValue + double.parse(element.amount);
                  } else {
                    return previousValue;
                  }
                });
                print(
                    "totaluserReferralTransaction  :$totaluserReferralTransaction");
                notifyListeners();
              }
            });
          }
        }
        if (outValue.docs.isNotEmpty) {
          for (var elements in outValue.docs) {
            Map<dynamic, dynamic> inMap = elements.data();

            db
                .collection("USERS")
                .doc(inMap["TO_ID"].toString())
                .get()
                .then((uValue) {
              if (uValue.exists) {
                Map<dynamic, dynamic> uMap = uValue.data() as Map;
                userReferralId = inMap["TO_ID"].toString();
                userReferralProfileImage = uMap["ItemImage"] ?? "";
                userReferralScreenShot = inMap["SCREENSHOT"].toString();
                userReferralName = uMap["NAME"].toString();
                userReferralNumber = uMap["PHONE"].toString();
                userReferralStatus = inMap["STATUS"].toString();
                userReferralShowStatus = userReferralStatus;
                userReferralAmount = inMap["AMOUNT"].toString();
                userReferralType = inMap["TYPE"].toString();
                userReferralGrade = inMap["GRADE"].toString();
                userReferralTree = inMap["TREE"].toString();

                userReferralTransactionList.add(UserInModel(
                    elements.id,
                    userReferralId,
                    userReferralProfileImage,
                    userReferralScreenShot,
                    userReferralName,
                    userReferralNumber,
                    userReferralStatus,
                    userReferralShowStatus,
                    userReferralAmount,
                    "",
                    "",
                    userReferralGrade,
                    userReferralTree,
                    "",
                    userReferralType,
                    "",
                    "OUT"));
                userClearedReferralTransactionList = userReferralTransactionList
                    .where((element) => element.showStatus == "PAID")
                    .toSet()
                    .toList();

                ///    Add All Amount
                // totaluserReferralTransaction =
                //     userReferralTransactionList.fold(0, (previousValue, element) => previousVaelue + double.parse(element.amount));}

                totaluserReferralOutTransaction = userReferralTransactionList
                    .fold(0, (previousValue, element) {
                  if (element.showStatus == 'PAID') {
                    return previousValue + double.parse(element.amount);
                  } else {
                    return previousValue;
                  }
                });
                print(
                    "totaluserReferralTransaction  :$totaluserReferralTransaction");
                notifyListeners();
              }
            });
          }
        }
      });
    });
  }

  void showBottomSheet(BuildContext context, String from) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.camera_enhance_sharp,
                    // color: cl172f55,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () => {imageFromCamera(from), Navigator.pop(context)}),
              ListTile(
                  leading: const Icon(
                    Icons.photo,
                    //color: cl172f55
                  ),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () =>
                      {imageFromGallery(from), Navigator.pop(context)}),
            ],
          );
        });
    // ImageSource
  }

  imageFromCamera(String from) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      _cropImage(pickedFile.path, from);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData(from);

    notifyListeners();
  }

  imageFromGallery(String from) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage(pickedFile.path, from);
    } else {}
    if (pickedFile!.path.isEmpty) {
      retrieveLostData(from);
    }

    notifyListeners();
  }

  Future<void> retrieveLostData(String from) async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileImage = File(response.file!.path);
      filePanImage = File(response.file!.path);
      fileAdhaarImage = File(response.file!.path);
      receiptFileImage = File(response.file!.path);

      notifyListeners();
    }
  }

  Future<void> _cropImage(String path, String from) async {
    print("hai$path");
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    print("hello$path");

    if (croppedFile != null) {
      if (from == "PAN") {
        filePanImage = File(croppedFile.path);
      } else if (from == "AADHAAR") {
        fileAdhaarImage = File(croppedFile.path);
      } else if (from == "PROFILE") {
        fileImage = File(croppedFile.path);
      } else if (from == "TASK_SUBMIT") {
        taskSubmitFileImage = File(croppedFile.path);
      } else if (from == "MessageSend") {
        MessageFileImage = File(croppedFile!.path);
        // taskSubmitFileImage = File(croppedFile!.path);
      }else if(from == "SECON_SIDE"){
        fileAdhaarSeconodSideImage=File(croppedFile!.path);
      }
      // imgCheck = true;
      notifyListeners();
    }
  }

////////////////////////////// SECOND IMAGE PICKER //////////////////////////////////////////

  void showBottomSheet2(
    BuildContext context,
    String distributionId22,
    String from,
    String name,
    String phoneNumber,
    String date,
    String time,
    String regId,
    String image,
    String screenShot,
    String paymentType,
    String tree,
    String Grade,
  ) {
    showModalBottomSheet(
        elevation: 10,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        )),
        context: context,
        builder: (BuildContext bc) {
          return Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(
                    Icons.camera_enhance_sharp,
                    // color: cl172f55,
                  ),
                  title: const Text(
                    'Camera',
                  ),
                  onTap: () => {
                        imageFromCamera2(
                            context,
                            distributionId22,
                            from,
                            name,
                            phoneNumber,
                            date,
                            time,
                            regId,
                            image,
                            screenShot,
                            paymentType,
                            tree,
                            Grade,
                            name),
                        Navigator.pop(context)
                      }),
              ListTile(
                  leading: const Icon(
                    Icons.photo,
                    //color: cl172f55
                  ),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () => {
                        imageFromGallery2(
                          context,
                          distributionId22,
                          from,
                          name,
                          phoneNumber,
                          date,
                          time,
                          regId,
                          image,
                          screenShot,
                          paymentType,
                          tree,
                          Grade,
                        ),
                        Navigator.pop(context)
                      }),
            ],
          );
        });
    // ImageSource
  }

  imageFromCamera2(
    BuildContext context,
    String distributionId22,
    String from,
    String name,
    String phoneNumber,
    String date,
    String time,
    String regId,
    String image,
    String screenShot,
    String paymentType,
    String tree,
    String Grade,
    String fromName,
  ) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      _cropImage2(
        context,
        distributionId22,
        pickedFile.path,
        from,
        name,
        phoneNumber,
        date,
        time,
        regId,
        image,
        screenShot,
        paymentType,
        tree,
        Grade,
      );
    } else {}
    if (pickedFile!.path.isEmpty) {
      retrieveLostData2(context, from, name, phoneNumber, date, time, regId,
          image, screenShot, tree, Grade);
    }

    notifyListeners();
  }

  imageFromGallery2(
    BuildContext context,
    String distributionId22,
    String from,
    String name,
    String phoneNumber,
    String date,
    String time,
    String regId,
    String image,
    String screenShot,
    String paymentType,
    String tree,
    String Grade,
  ) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage2(
        context,
        distributionId22,
        pickedFile.path,
        from,
        name,
        phoneNumber,
        date,
        time,
        regId,
        image,
        screenShot,
        paymentType,
        tree,
        Grade,
      );
    } else {}
    if (pickedFile!.path.isEmpty)
      retrieveLostData2(context, from, name, phoneNumber, date, time, regId,
          image, screenShot, tree, Grade);

    notifyListeners();
  }

  Future<void> retrieveLostData2(
      BuildContext context,
      String from,
      String name,
      String phoneNumber,
      String date,
      String time,
      String regId,
      String image,
      String screenShot,
      String tree,
      String Grade) async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      receiptFileImage = File(response.file!.path);

      notifyListeners();
    }
  }

  Future<void> _cropImage2(
    BuildContext context,
    String distributionId22,
    String path,
    String from,
    String name,
    String phoneNumber,
    String date,
    String time,
    String regId,
    String image,
    String screenShot,
    String paymentType,
    String tree,
    String Grade,
  ) async {
    print("hai$path");
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9,
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.ratio16x9
            ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.white,
            toolbarWidgetColor: Colors.black,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        )
      ],
    );
    print("hello$path");

    if (croppedFile != null) {
      receiptFileImage = File(croppedFile.path);
      callNext(
          ConfirmationScreen(
            name: name,
            phoneNumber: phoneNumber,
            date: '',
            time: '',
            regId: regId,
            image: image,
            screenShot: "",
            receiptImage: receiptFileImage,
            from: "UPLOAD",
            paymentType: paymentType,
            tree: tree,
            grade: Grade,
            distributionId: distributionId22,
          ),
          context);
      notifyListeners();
    }
  }

  String selectedDateTime = "";

  Future<void> selectDOB(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now());

    selectedDateTime = DateFormat('dd-MM-yyyy').format(pickedDate!);
    //pickedDate.toString();
    dateOfBirthController.text = selectedDateTime;
    notifyListeners();
  }

  List<TransactionsModel> userTransactionsList = [];
  double totalTransactionHelp = 0.0;
  bool historyLoader = false;

  void getTransactions(String memberId) {
    historyLoader = true;
    userTransactionsList.clear();
    historyDateList.clear();
    reportDateList.clear();
    String dateFormat = "";
    String timeFormat = "";
    totalTransactionHelp = 0;
    db
        .collection("TRANSACTIONS")
        .where("FROM_USER_ID", isEqualTo: memberId)
        .get()
        .then((pValue) {
      db
          .collection("TRANSACTIONS")
          .where("TO_USER_ID", isEqualTo: memberId)
          .get()
          .then((tValue) {
        if (pValue.docs.isNotEmpty) {
          for (var elements in pValue.docs) {
            Map<dynamic, dynamic> pMap = elements.data();
            if (pMap["TO_USER_ID"] != null) {
              db
                  .collection("USERS")
                  .doc(pMap["TO_USER_ID"])
                  .get()
                  .then((toValue) {
                dateFormat = outputDayNode
                    .format(pMap["PAYMENT_TIME"].toDate())
                    .toString();
                timeFormat = outputDayNode2
                    .format(pMap["PAYMENT_TIME"].toDate())
                    .toString();
                userTransactionsList.add(TransactionsModel(
                    elements.id,
                    toValue.get("NAME").toString(),
                    toValue.get("PHONE").toString(),
                    pMap["PAYMENT_TYPE"].toString(),
                    dateFormat,
                    timeFormat,
                    pMap["AMOUNT"].toString(),
                    "OUT",
                    pMap["TREE"].toString(),
                    pMap["GRADE"].toString(),
                    pMap["PAYMENT_TIME"].toDate(),
                    ""));
                notifyListeners();

                ///edit
                if (!historyDateList
                    .map((item) => item.dateFormat)
                    .contains(dateFormat)) {
                  historyDateList.add(
                    TransactionDateModel(
                        dateFormat, pMap["PAYMENT_TIME"].toDate()),
                  );
                  historyDateList.sort((a, b) => b.date.compareTo(a.date));
                  notifyListeners();

                  ///edit
                }
              });
            } else {
              dateFormat = outputDayNode
                  .format(pMap["PAYMENT_TIME"].toDate())
                  .toString();
              timeFormat = outputDayNode2
                  .format(pMap["PAYMENT_TIME"].toDate())
                  .toString();
              userTransactionsList.add(TransactionsModel(
                  elements.id,
                  "LIO CLUB",
                  "",
                  pMap["PAYMENT_TYPE"].toString(),
                  dateFormat,
                  timeFormat,
                  pMap["AMOUNT"].toString(),
                  "OUT",
                  pMap["TREE"].toString(),
                  pMap["GRADE"].toString(),
                  pMap["PAYMENT_TIME"].toDate(),
                  pMap["INSTALLMENT"] ?? "1"));
              if (!historyDateList
                  .map((item) => item.dateFormat)
                  .contains(dateFormat)) {
                historyDateList.add(
                  TransactionDateModel(
                      dateFormat, pMap["PAYMENT_TIME"].toDate()),
                );
                historyDateList.sort((a, b) => b.date.compareTo(a.date));
                notifyListeners();
              }
            }
            notifyListeners();
          }
          if (tValue.docs.isNotEmpty) {
            for (var elements in tValue.docs) {
              Map<dynamic, dynamic> tuMap = elements.data();
              dateFormat = outputDayNode
                  .format(tuMap["PAYMENT_TIME"].toDate())
                  .toString();
              timeFormat = outputDayNode2
                  .format(tuMap["PAYMENT_TIME"].toDate())
                  .toString();
              userTransactionsList.add(TransactionsModel(
                  elements.id,
                  tuMap["USER_NAME"].toString(),
                  tuMap["PHONE_NUMBER"].toString(),
                  tuMap["PAYMENT_TYPE"].toString(),
                  dateFormat,
                  timeFormat,
                  tuMap["AMOUNT"].toString(),
                  "IN",
                  tuMap["TREE"].toString(),
                  tuMap["GRADE"].toString(),
                  tuMap["PAYMENT_TIME"].toDate(),
                  ""));
              if (!historyDateList
                  .map((item) => item.dateFormat)
                  .contains(dateFormat)) {
                historyDateList.add(
                  TransactionDateModel(
                      dateFormat, tuMap["PAYMENT_TIME"].toDate()),
                );
                historyDateList.sort((a, b) => b.date.compareTo(a.date));
                notifyListeners();
              }
            }
            historyDateList.sort((a, b) => b.date.compareTo(a.date));
            notifyListeners();
          }
          historyDateList.sort((a, b) => b.date.compareTo(a.date));
          historyLoader = false;
          notifyListeners();
        } else {
          if (tValue.docs.isNotEmpty) {
            for (var elements in tValue.docs) {
              Map<dynamic, dynamic> tuMap = elements.data();
              dateFormat = outputDayNode
                  .format(tuMap["PAYMENT_TIME"].toDate())
                  .toString();
              timeFormat = outputDayNode2
                  .format(tuMap["PAYMENT_TIME"].toDate())
                  .toString();
              userTransactionsList.add(TransactionsModel(
                  elements.id,
                  tuMap["USER_NAME"].toString(),
                  tuMap["PHONE_NUMBER"].toString(),
                  tuMap["PAYMENT_TYPE"].toString(),
                  dateFormat,
                  timeFormat,
                  tuMap["AMOUNT"].toString(),
                  "IN",
                  tuMap["TREE"].toString(),
                  tuMap["GRADE"].toString(),
                  tuMap["PAYMENT_TIME"].toDate(),
                  ""));
              if (!historyDateList
                  .map((item) => item.dateFormat)
                  .contains(dateFormat)) {
                historyDateList.add(
                  TransactionDateModel(
                      dateFormat, tuMap["PAYMENT_TIME"].toDate()),
                );
                historyDateList.sort((a, b) => b.date.compareTo(a.date));
                notifyListeners();
              }
            }
            historyDateList.sort((a, b) => b.date.compareTo(a.date));
            historyLoader = false;
            notifyListeners();
          } else {
            historyLoader = false;
            notifyListeners();
          }
        }
      });
    });
  }

  List<NotificationModel> userNotificationsList = [];

  void getNotifications(String memberId) {
    db
        .collection("NOTIFICATIONS")
        .where("TO_ID", isEqualTo: memberId)
        .get()
        .then((toValue) {
      db
          .collection("NOTIFICATIONS")
          .where("TO_ID_2", isEqualTo: memberId)
          .get()
          .then((toValue2) {
        userNotificationsList.clear();
        if (toValue.docs.isNotEmpty) {
          for (var elements in toValue.docs) {
            Map<dynamic, dynamic> notificationMap = elements.data();
            db
                .collection("USERS")
                .doc(notificationMap["FROM_ID"].toString())
                .get()
                .then((userValue) {
              if (userValue.exists) {
                Map<dynamic, dynamic> userMap = userValue.data() as Map;
                userNotificationsList.add(NotificationModel(
                    notificationMap["CONTENT"].toString(),
                    userMap['NAME'].toString(),
                    userMap['PHONE'].toString(),
                    notificationMap["NOTIFICATION_ID"].toString(),
                    notificationMap["DATE"].toString(),
                    notificationMap["TIME"].toString(),
                    notificationMap['REG_DATE'].toDate(),
                    userMap["ItemImage"] ?? ""));
                notifyListeners();
              }
            });
          }
        }
        if (toValue2.docs.isNotEmpty) {
          for (var elements in toValue2.docs) {
            Map<dynamic, dynamic> notificationMap = elements.data();
            db
                .collection("USERS")
                .doc(notificationMap["FROM_ID"].toString())
                .get()
                .then((userValue) {
              if (userValue.exists) {
                Map<dynamic, dynamic> userMap = userValue.data() as Map;
                userNotificationsList.add(NotificationModel(
                    notificationMap["CONTENT"].toString(),
                    userMap['NAME'].toString(),
                    userMap['PHONE'].toString(),
                    notificationMap["NOTIFICATION_ID"].toString(),
                    notificationMap["DATE"].toString(),
                    notificationMap["TIME"].toString(),
                    notificationMap['REG_DATE'].toDate(),
                    userMap["ItemImage"] ?? ""));
                notifyListeners();
              }
            });
          }
        }
      });
    });
  }

  Reference ref4 = FirebaseStorage.instance.ref("SCREENSHOT");

  screenShotUpload(String distributionId, String memberId, String paymentType,
      String name, String level, BuildContext context4) {
    showDialog(
        context: context4,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context4, listen: false);
    List<String> fcmList = [];
    List<String> toList = [];
    DateTime now = DateTime.now();
    String newId =
        now.millisecondsSinceEpoch.toString() + generateRandomString(2);
    homeDistributionList.clear();
    distributionList.clear();
    sortDistributionList.clear();
    HashMap<String, Object> addData = HashMap();
    String time;

    db.collection("DISTRIBUTIONS").doc(distributionId).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        db
            .collection("USERS")
            .doc(map["TO_ID"].toString())
            .get()
            .then((userValue) async {
          Map<dynamic, dynamic> userMap = userValue.data() as Map;
          if (receiptFileImage != null) {
            time = now.millisecondsSinceEpoch.toString();
            ref4 = FirebaseStorage.instance.ref().child(time);
            await ref4.putFile(receiptFileImage!).whenComplete(() async {
              await ref4.getDownloadURL().then((value2) {
                addData['SCREENSHOT'] = value2;
                notifyListeners();
              });
              notifyListeners();
            });
          } else {
            addData['SCREENSHOT'] = "";
          }
          addData["STATUS"] = "PROCESSING";
          addData["SCREENSHOT_ADD_DATE"] = now;
          await db
              .collection("DISTRIBUTIONS")
              .doc(distributionId)
              .set(addData, SetOptions(merge: true));

          notifyListeners();

          print("dmkdmedkmedkem");
          toList.add(map["TO_ID"].toString());
          HashMap<String, Object> notificationMap = HashMap();
          notificationMap["CONTENT"] =
              "New $level level $paymentType payment received from $userName, Please verify and inform him.";
          notificationMap["FROM_ID"] = memberId;
          notificationMap["TO_ID"] = toList;
          notificationMap["NOTIFICATION_ID"] = newId;
          notificationMap['REG_DATE'] = now;
          notificationMap["VIEWERS"] = [];
          notificationMap["DATE"] = outputDayNode.format(now).toString();
          notificationMap["TIME"] = outputDayNode2.format(now).toString();
          db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
          if (userMap["FCM_ID"] != null) {
            fcmList.add(userMap["FCM_ID"].toString());
            callOnFcmApiSendPushNotifications(
                title: 'New $paymentType payment received',
                body: 'Name :- $userName\n'
                    'Level :- $level level',
                fcmList: fcmList,
                imageLink: '');
          }
          finish(context4);
          finish(context4);
          finish(context4);
          callNextReplacement(
              BottomNavigationScreen(Userid: memberId), context4);
        });
      }
    });
  }

  updatePmc(String memberId, String grade, String tree) {
    db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: memberId)
        .where("TREE", isEqualTo: tree)
        .where("TYPE", isEqualTo: "PMC")
        .where("GRADE", isEqualTo: grade)
        .get()
        .then((pmcValue) async => {
              if (pmcValue.docs.isNotEmpty)
                {
                  db
                      .collection("DISTRIBUTIONS")
                      .doc(pmcValue.docs.first.id)
                      .set({"STATUS": "SUCCESS"}, SetOptions(merge: true)),
                  db
                      .collection("USERS")
                      .doc(memberId)
                      .set({"STATUS": "ACTIVE"}, SetOptions(merge: true)),
                  notifyListeners()
                }
            });
  }

  void rejectPayments(String distributionId, String userId, String fromLevel,
      String paymentType) {
    DateTime now = DateTime.now();
    String newId =
        now.millisecondsSinceEpoch.toString() + generateRandomString(2);
    userInList.removeWhere((element) =>
        element.id == distributionId && element.status == "PROCESSING");
    notifyListeners();
    db
        .collection("DISTRIBUTIONS")
        .doc(distributionId)
        .set({"STATUS": "REJECTED"}, SetOptions(merge: true));
    HashMap<String, Object> notificationMap = HashMap();
    notificationMap["CONTENT"] =
        "We're sorry, but your $fromLevel level $paymentType payment to $userName has been rejected.";
    notificationMap["FROM_ID"] = userId;
    notificationMap["TO_ID"] = [userId];
    notificationMap["NOTIFICATION_ID"] = newId;
    notificationMap['REG_DATE'] = now;
    notificationMap["VIEWERS"] = [];
    notificationMap["DATE"] = outputDayNode.format(now).toString();
    notificationMap["TIME"] = outputDayNode2.format(now).toString();
    db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
    notifyListeners();
  }

  bool approveWaitingBool = false;

  Future<void> approveBasicUpgradePayments(
      String distributionId,
      String memberId,
      String grade,
      String amount,
      String paymentType,
      String tree,
      String userDocId) async {
    approveWaitingBool = true;
    notifyListeners();

    var distExistValue = await db.collection("DISTRIBUTIONS").doc(distributionId).get();
    Map<dynamic, dynamic> distExistMap = distExistValue.data() as Map;
    String distExistStatus = distExistMap["STATUS"].toString();
    print("distExistStatus  $distExistStatus");
    if (distExistStatus == "PROCESSING") {
      print("irshad885858");
      DateTime now = DateTime.now();
      String transactionId =
          now.millisecondsSinceEpoch.toString() + generateRandomString(2);
      String toDayNow = "";
      toDayNow = dayNodeLastTransaction.format(now).toString();
      HashMap<String, Object> approveMap = HashMap();
      approveMap["DAY_NOW"] = toDayNow;
      approveMap["FROM_USER_ID"] = memberId;
      approveMap["TO_USER_ID"] = registerID;
      approveMap["GRADE"] = grade;
      approveMap["TREE"] = tree;
      approveMap["AMOUNT"] = amount;
      approveMap["PAYMENT_MODE"] = "DIRECT_PAYMENT";
      approveMap["PAYMENT_TYPE"] = paymentType;
      approveMap["PAYMENT_TIME"] = DateTime.now();
      approveMap["PAYMENT_STATUS"] = "SUCCESS";
      approveMap["APP_VERSION"] = appBuildVersion.toString();

      var userValue = await db.collection("USERS").doc(memberId).get();
      Map<dynamic, dynamic> userMap = userValue.data() as Map;

      approveMap["USER_NAME"] = userMap["NAME"];
      approveMap["PHONE_NUMBER"] = userMap["PHONE"];

      var gradeValue = await db
          .collection("DISTRIBUTIONS")
          .where("FROM_ID", isEqualTo: memberId)
          .where("GRADE", isEqualTo: grade)
          .where("TREE", isEqualTo: tree)
          .where("STATUS", whereNotIn: ["PAID"])
          .get();
      print("irshadTes79789");
      if (gradeValue.docs.length == 1) {
        print("irshadTest00000000");
        String newGrade = await findNextLevel(grade, memberId, tree);
        if (paymentType == "STAR_CLUB") {
          await generateNextBasicDistributions(
              grade, memberId, tree, userDocId);
          // await generateNextOneDistributions("", memberId, "STAR_CLUB", userDocId);
          String newAutoOneGrade =
          await findNextLevel("", memberId, "STAR_CLUB");
          db
              .collection("STAR_CLUB")
              .doc(userMap["DOCUMENT_ID"].toString())
              .set({"GRADE": newAutoOneGrade}, SetOptions(merge: true));
          db.collection("USERS").doc(memberId).set({
            "AUTO_ONE_GRADE": newAutoOneGrade,
            "GRADE": newGrade,
            "TREES": ["MASTER_CLUB", "STAR_CLUB"],
            "TOTAL_AUTO_ONE_HELP": double.parse(amount),
            "TOTAL_HELP": FieldValue.increment(double.parse(amount))
          }, SetOptions(merge: true));
          db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
            "GIVE_HELP": FieldValue.increment(double.parse(amount)),
            "GIVE_HELP_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("USERS").doc(registerID).set({
            "TOTAL_EARNINGS": FieldValue.increment(double.parse(amount)),
          }, SetOptions(merge: true));
        }
        else if (paymentType == "CROWN_CLUB") {
          await generateNextBasicDistributions(
              grade, memberId, tree, userDocId);
          // await generateNextTwoDistributions("", memberId, "CROWN_CLUB", userDocId);
          String newAutoTwoGrade =
          await findNextLevel("", memberId, "CROWN_CLUB");
          db
              .collection("CROWN_CLUB")
              .doc(userMap["DOCUMENT_ID"].toString())
              .set({"GRADE": newAutoTwoGrade}, SetOptions(merge: true));
          db.collection("USERS").doc(memberId).set({
            "AUTO_TWO_GRADE": newAutoTwoGrade,
            "GRADE": newGrade,
            "TREES": ["MASTER_CLUB", "STAR_CLUB", "CROWN_CLUB"],
            "TOTAL_AUTO_TWO_HELP": double.parse(amount),
            "TOTAL_HELP": FieldValue.increment(double.parse(amount))
          }, SetOptions(merge: true));
          db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
            "GIVE_HELP": FieldValue.increment(double.parse(amount)),
            "GIVE_HELP_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("USERS").doc(registerID).set({
            "TOTAL_EARNINGS": FieldValue.increment(double.parse(amount)),
          }, SetOptions(merge: true));
        }
        else if (paymentType == "REFERRAL") {
          await generateNextBasicDistributions(
              grade, memberId, tree, userDocId);
          db.collection("USERS").doc(registerID).set({
            "TOTAL_REFERRAL_AMOUNT":
            FieldValue.increment(double.parse(amount)),
            "TOTAL_REFERRAL_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
            "REFERRAL": FieldValue.increment(double.parse(amount)),
            "REFERRAL_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("USERS").doc(memberId).set({
            "GRADE": newGrade,
          }, SetOptions(merge: true));
        }
        else {
          await generateNextBasicDistributions(
              grade, memberId, tree, userDocId);
          db.collection("USERS").doc(memberId).set({
            "GRADE": newGrade,
            "TOTAL_HELP": FieldValue.increment(double.parse(amount)),
          }, SetOptions(merge: true));
          db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
            "GIVE_HELP": FieldValue.increment(double.parse(amount)),
            "GIVE_HELP_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("USERS").doc(registerID).set({
            "TOTAL_EARNINGS": FieldValue.increment(double.parse(amount)),
          }, SetOptions(merge: true));
        }

        db
            .collection(tree)
            .doc(userMap["DOCUMENT_ID"].toString())
            .set({"GRADE": newGrade}, SetOptions(merge: true));

        String newId = now.millisecondsSinceEpoch.toString() +
            generateRandomString(2);
        // toList.add(map["TO_ID"].toString());
        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] =
        "Well done! You've been promoted to $newGrade level.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["TO_ID"] = [memberId];
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap['REG_DATE'] = now;
        notificationMap["VIEWERS"] = [];
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();
        db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);

        userInList.removeWhere((element) =>
        element.id == distributionId &&
            element.status == "PROCESSING");
        notifyListeners();
        db.collection("DISTRIBUTIONS").doc(distributionId).set({
          "STATUS": "PAID",
        }, SetOptions(merge: true));
        db
            .collection("TRANSACTIONS")
            .doc(transactionId)
            .set(approveMap, SetOptions(merge: true));

        List<String> fcmList = [];
        print("irshadTest11111");
        if (userMap["FCM_ID"] != null) {
          print("irshadTest");
          fcmList.add(userMap["FCM_ID"].toString());
          callOnFcmApiSendPushNotifications(
              title: 'Screenshot Approved & Level Upgrade',
              body: "Well done! You've been promoted to $newGrade level.",
              fcmList: fcmList,
              imageLink: '');
        }
        approveWaitingBool = false;
        notifyListeners();
      }
      else {
        if (paymentType == "STAR_CLUB") {
          String newAutoOneGrade =
          await findNextLevel("", memberId, "STAR_CLUB");
          db
              .collection("STAR_CLUB")
              .doc(userMap["DOCUMENT_ID"].toString())
              .set({"GRADE": newAutoOneGrade}, SetOptions(merge: true));
          db.collection("USERS").doc(memberId).set({
            "AUTO_ONE_GRADE": newAutoOneGrade,
            "TREES": ["MASTER_CLUB", "STAR_CLUB"],
            "TOTAL_AUTO_ONE_HELP": double.parse(amount),
            "TOTAL_HELP": FieldValue.increment(double.parse(amount))
          }, SetOptions(merge: true));
          db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
            "GIVE_HELP": FieldValue.increment(double.parse(amount)),
            "GIVE_HELP_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("USERS").doc(registerID).set({
            "TOTAL_EARNINGS": FieldValue.increment(double.parse(amount)),
          }, SetOptions(merge: true));
          await generateNextOneDistributions(
              "", memberId, "STAR_CLUB", userDocId);
        }
        else if (paymentType == "CROWN_CLUB") {
          String newAutoTwoGrade = await findNextLevel("", memberId, "CROWN_CLUB");
          db
              .collection("CROWN_CLUB")
              .doc(userMap["DOCUMENT_ID"].toString())
              .set({"GRADE": newAutoTwoGrade}, SetOptions(merge: true));
          db.collection("USERS").doc(memberId).set({
            "AUTO_TWO_GRADE": newAutoTwoGrade,
            "TREES": ["MASTER_CLUB", "STAR_CLUB", "CROWN_CLUB"],
            "TOTAL_AUTO_TWO_HELP": double.parse(amount),
            "TOTAL_HELP": FieldValue.increment(double.parse(amount))
          }, SetOptions(merge: true));
          db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
            "GIVE_HELP": FieldValue.increment(double.parse(amount)),
            "GIVE_HELP_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("USERS").doc(registerID).set({
            "TOTAL_EARNINGS": FieldValue.increment(double.parse(amount)),
          }, SetOptions(merge: true));
          await generateNextTwoDistributions(
              "", memberId, "CROWN_CLUB", userDocId);
        }
        else if (paymentType == "REFERRAL") {
          db.collection("USERS").doc(registerID).set({
            "TOTAL_REFERRAL_AMOUNT":
            FieldValue.increment(double.parse(amount)),
            "TOTAL_REFERRAL_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
            "REFERRAL": FieldValue.increment(double.parse(amount)),
            "REFERRAL_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
        }
        else {
          db.collection("USERS").doc(memberId).set({
            "TOTAL_HELP": FieldValue.increment(double.parse(amount)),
          }, SetOptions(merge: true));
          db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
            "GIVE_HELP": FieldValue.increment(double.parse(amount)),
            "GIVE_HELP_COUNT": FieldValue.increment(1),
          }, SetOptions(merge: true));
          db.collection("USERS").doc(registerID).set({
            "TOTAL_EARNINGS": FieldValue.increment(double.parse(amount)),
          }, SetOptions(merge: true));
        }

        String newId = now.millisecondsSinceEpoch.toString() +
            generateRandomString(2);
        // toList.add(map["TO_ID"].toString());
        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] =
        "Bravo! Your $grade level $paymentType payment to $userName has been authorized successfully.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["TO_ID"] = [memberId];
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap['REG_DATE'] = now;
        notificationMap["VIEWERS"] = [];
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();
        db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
        userInList.removeWhere((element) =>
        element.id == distributionId &&
            element.status == "PROCESSING");
        notifyListeners();
        db.collection("DISTRIBUTIONS").doc(distributionId).set({
          "STATUS": "PAID",
        }, SetOptions(merge: true));
        db
            .collection("TRANSACTIONS")
            .doc(transactionId)
            .set(approveMap, SetOptions(merge: true));

        List<String> fcmList = [];
        print("irshadTes31254698");
        if (userMap["FCM_ID"] != null) {
          print("irshadTestvbnhgfyi");
          fcmList.add(userMap["FCM_ID"].toString());
          callOnFcmApiSendPushNotifications(
              title: 'Payment Approved',
              body:
              "Bravo! Your $grade level $paymentType payment to $userName has been authorized successfully.",
              fcmList: fcmList,
              imageLink: '');
        }
        approveWaitingBool = false;
        notifyListeners();
      }

      hideFilterBool = false;
      notifyListeners();
    }else{
      print("else , distExistStatus  $distExistStatus");
      approveWaitingBool = false;
      hideFilterBool = false;
      notifyListeners();
    }

  }

  Future<void> approveAutoUpgradePayments(
      String distributionId,
      String memberId,
      String grade,
      String amount,
      String paymentType,
      String tree,
      String treeNum,
      String userDocId) async {
    approveWaitingBool = true;
    notifyListeners();
    var distExistValue = await db.collection("DISTRIBUTIONS").doc(distributionId).get();
    Map<dynamic, dynamic> distExistMap = distExistValue.data() as Map;
    String distExistStatus = distExistMap["STATUS"].toString();
    print("distExistStatus  $distExistStatus");
    if (distExistStatus == "PROCESSING") {
      DateTime now = DateTime.now();
      String transactionId =
          now.millisecondsSinceEpoch.toString() + generateRandomString(2);
      String toDayNow = "";
      toDayNow = dayNodeLastTransaction.format(now).toString();
      HashMap<String, Object> approveMap = HashMap();
      approveMap["DAY_NOW"] = toDayNow;
      approveMap["FROM_USER_ID"] = memberId;
      approveMap["TO_USER_ID"] = registerID;
      approveMap["GRADE"] = grade;
      approveMap["TREE"] = tree;
      approveMap["AMOUNT"] = amount;
      approveMap["PAYMENT_MODE"] = "DIRECT_PAYMENT";
      approveMap["PAYMENT_TYPE"] = paymentType;
      approveMap["PAYMENT_TIME"] = DateTime.now();
      approveMap["PAYMENT_STATUS"] = "SUCCESS";
      approveMap["APP_VERSION"] = appBuildVersion.toString();

      var userValue = await db.collection("USERS").doc(memberId).get();
      Map<dynamic, dynamic> userMap = userValue.data() as Map;

      approveMap["USER_NAME"] = userMap["NAME"];
      approveMap["PHONE_NUMBER"] = userMap["PHONE"];

      var gradeValue = await db
          .collection("DISTRIBUTIONS")
          .where("FROM_ID", isEqualTo: memberId)
          .where("GRADE", isEqualTo: grade)
          .where("TREE", isEqualTo: tree)
          .where("STATUS", whereNotIn: ["PAID"])
          .get();
      if (gradeValue.docs.length == 1) {
        String newGrade = await findNextLevel(grade, memberId, tree);

        db.collection("USERS").doc(memberId).set({
          "AUTO_${treeNum}_GRADE": newGrade,
          "TOTAL_AUTO_${treeNum}_HELP":
          FieldValue.increment(double.parse(amount)),
          "TOTAL_HELP": FieldValue.increment(double.parse(amount))
        }, SetOptions(merge: true));
        db.collection("USERS").doc(registerID).set({
          "TOTAL_EARNINGS": FieldValue.increment(double.parse(amount)),
        }, SetOptions(merge: true));
        db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
          "GIVE_HELP": FieldValue.increment(double.parse(amount)),
          "GIVE_HELP_COUNT": FieldValue.increment(1),
        }, SetOptions(merge: true));

        db
            .collection(tree)
            .doc(userMap["DOCUMENT_ID"].toString())
            .set({"GRADE": newGrade}, SetOptions(merge: true));

        String newId = now.millisecondsSinceEpoch.toString() +
            generateRandomString(2);
        // toList.add(map["TO_ID"].toString());
        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] =
        "Well done! You've been promoted to $newGrade level.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["TO_ID"] = [memberId];
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap['REG_DATE'] = now;
        notificationMap["VIEWERS"] = [];
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();
        db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
        userInList.removeWhere((element) =>
        element.id == distributionId &&
            element.status == "PROCESSING");
        notifyListeners();
        db.collection("DISTRIBUTIONS").doc(distributionId).set({
          "STATUS": "PAID",
        }, SetOptions(merge: true));
        db
            .collection("TRANSACTIONS")
            .doc(transactionId)
            .set(approveMap, SetOptions(merge: true));
        if (treeNum == "ONE") {
          await generateNextOneDistributions(grade, memberId, tree, userDocId);
        } else {
          await generateNextTwoDistributions(grade, memberId, tree, userDocId);
        }

        List<String> fcmList = [];
        if (userMap["FCM_ID"] != null) {
          fcmList.add(userMap["FCM_ID"].toString());
          callOnFcmApiSendPushNotifications(
              title: 'Payment Approved',
              body: "Well done! You've been promoted to $newGrade level.",
              fcmList: fcmList,
              imageLink: '');
        }
        approveWaitingBool = false;
        notifyListeners();
      }
      else {
        db.collection("USERS").doc(memberId).set({
          "TOTAL_AUTO_${treeNum}_HELP":
          FieldValue.increment(double.parse(amount)),
          "TOTAL_HELP": FieldValue.increment(double.parse(amount))
        }, SetOptions(merge: true));
        db.collection("USERS").doc(registerID).set({
          "TOTAL_EARNINGS": FieldValue.increment(double.parse(amount)),
        }, SetOptions(merge: true));
        db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set({
          "GIVE_HELP": FieldValue.increment(double.parse(amount)),
          "GIVE_HELP_COUNT": FieldValue.increment(1),
        }, SetOptions(merge: true));

        String newId = now.millisecondsSinceEpoch.toString() +
            generateRandomString(2);
        // toList.add(map["TO_ID"].toString());
        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] =
        "Bravo! Your $grade level $paymentType payment to $userName has been authorized successfully.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["TO_ID"] = [memberId];
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap['REG_DATE'] = now;
        notificationMap["VIEWERS"] = [];
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();
        db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
        userInList.removeWhere((element) =>
        element.id == distributionId &&
            element.status == "PROCESSING");
        notifyListeners();
        db.collection("DISTRIBUTIONS").doc(distributionId).set({
          "STATUS": "PAID",
        }, SetOptions(merge: true));
        db
            .collection("TRANSACTIONS")
            .doc(transactionId)
            .set(approveMap, SetOptions(merge: true));

        List<String> fcmList = [];
        if (userMap["FCM_ID"] != null) {
          fcmList.add(userMap["FCM_ID"].toString());
          callOnFcmApiSendPushNotifications(
              title: 'Payment Approved',
              body:
              "Bravo! Your $grade level $paymentType payment to $userName has been authorized successfully.",
              fcmList: fcmList,
              imageLink: '');
        }
        approveWaitingBool = false;
        notifyListeners();
      }


      hideFilterBool = false;
      notifyListeners();
    }else{
      print("else , distExistStatus  $distExistStatus");
      approveWaitingBool = false;
      hideFilterBool = false;
      notifyListeners();
    }
  }

  generateVioletDistributions(
      String memberId, String tree, String userVioletDocId) async {
    var memberValue = await db.collection(tree).doc(userVioletDocId).get();
    // .then((memberValue)   {
    if (memberValue.exists) {
      Map<dynamic, dynamic> parentMap = memberValue.data() as Map;
      List<dynamic> upgradeParentList = parentMap["PARENTS"];
      var parentValue = await db
          .collection("USERS")
          .where("DOCUMENT_ID", isEqualTo: upgradeParentList[1])
          .get();
      // .then((parentValue) {
      HashMap<String, Object> upgradeMap = HashMap();
      upgradeMap["DATE"] = DateTime.now();
      upgradeMap["AMOUNT"] = "200";
      upgradeMap["TO_ID"] = parentValue.docs.first.id;
      upgradeMap["FROM_ID"] = memberId;
      upgradeMap["SCREENSHOT"] = "";
      upgradeMap["TYPE"] = "HELP";
      upgradeMap["STATUS"] = "PENDING";
      upgradeMap["GRADE"] = "VIOLET";
      upgradeMap["TREE"] = tree;
      upgradeMap["IN_TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(upgradeMap, SetOptions(merge: true));
      // });
    }

    // });
  }

  generateStarDistributions(
      String memberId, String tree, String userStarDocId) async {
    print(
        "membid : $memberId , tree : $tree , userStarDocId : $userStarDocId , ");

    var memberValue = await db.collection(tree).doc(userStarDocId).get();
    // .then((memberValue)  async {
    Map<dynamic, dynamic> parentMap = memberValue.data() as Map;
    List<dynamic> upgradeParentList = await parentMap["PARENTS"];

    var parentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeParentList[1])
        .get();
    // .then((parentValue) {

    HashMap<String, Object> upgradeMap = HashMap();

    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["AMOUNT"] = "200";
    upgradeMap["TO_ID"] = parentValue.docs.first.id;
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "STAR";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    // });
    // });
  }

  generateIndigoDistributions(
      String memberId, String tree, String userIndigoDocId) async {
    var memberValue = await db.collection(tree).doc(userIndigoDocId).get();
    // .then((memberValue)  {
    Map<dynamic, dynamic> parentMap = memberValue.data() as Map;
    List<dynamic> upgradeParentList = parentMap["PARENTS"];

    var parentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeParentList[2])
        .get();
    // .then((parentValue) {

    HashMap<String, Object> pmcMap = HashMap();
    pmcMap["DATE"] = DateTime.now();
    pmcMap["AMOUNT"] = "100";
    pmcMap["INSTALLMENT"] = 1;
    pmcMap["FROM_ID"] = memberId;
    pmcMap["TYPE"] = "PMC";
    pmcMap["STATUS"] = "PENDING";
    pmcMap["GRADE"] = "INDIGO";
    pmcMap["TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(pmcMap, SetOptions(merge: true));

    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = parentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "400";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "INDIGO";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    HashMap<String, Object> sponsorMap = HashMap();
    sponsorMap["DATE"] = DateTime.now();
    sponsorMap["AMOUNT"] = "100";
    sponsorMap["TO_ID"] = parentMap["REFERENCE"].toString();
    sponsorMap["FROM_ID"] = memberId;
    sponsorMap["SCREENSHOT"] = "";
    sponsorMap["TYPE"] = "REFERRAL";
    sponsorMap["STATUS"] = "PENDING";
    sponsorMap["GRADE"] = "INDIGO";
    sponsorMap["TREE"] = "MASTER_CLUB";
    sponsorMap["IN_TREE"] = "MASTER_CLUB";

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(sponsorMap, SetOptions(merge: true));
    // });

    // });
  }

  generate2StarDistributions(
      String memberId, String tree, String user2StarDocId) async {
    var memberValue = await db.collection(tree).doc(user2StarDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> parentMap = memberValue.data() as Map;
    List<dynamic> upgradeParentList = parentMap["PARENTS"];

    var parentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeParentList[2])
        .get();
    // .then((parentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = parentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "400";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "2 STAR";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    HashMap<String, Object> pmcMap = HashMap();
    pmcMap["DATE"] = DateTime.now();
    pmcMap["AMOUNT"] = "100";
    pmcMap["INSTALLMENT"] = 1;
    pmcMap["FROM_ID"] = memberId;
    pmcMap["TYPE"] = "PMC";
    pmcMap["STATUS"] = "PENDING";
    pmcMap["GRADE"] = "2 STAR";
    pmcMap["TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(pmcMap, SetOptions(merge: true));

    HashMap<String, Object> donationMap = HashMap();
    donationMap["DATE"] = DateTime.now();
    donationMap["AMOUNT"] = "100";
    donationMap["INSTALLMENT"] = 1;
    donationMap["FROM_ID"] = memberId;
    donationMap["TYPE"] = "CMF";
    donationMap["STATUS"] = "PENDING";
    donationMap["GRADE"] = "2 STAR";
    donationMap["TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(donationMap, SetOptions(merge: true));
    // });

    // });
  }

  generateSilverDistributions(
      String memberId, String tree, String userSilverDocId) async {
    var memberValue = await db.collection(tree).doc(userSilverDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> parentMap = memberValue.data() as Map;
    List<dynamic> upgradeParentList = parentMap["PARENTS"];

    var parentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeParentList[1])
        .get();
    // .then((parentValue) {

    HashMap<String, Object> upgradeMap = HashMap();

    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["AMOUNT"] = "2000";
    upgradeMap["TO_ID"] = parentValue.docs.first.id;
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "SILVER";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    // });
    // });
  }

  generateBlueDistributions(
      String memberId, String tree, String userBlueDocId) async {
    var memberValue = await db.collection(tree).doc(userBlueDocId).get();
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];
    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[3])
        .get();

      HashMap<String, Object> upgradeMap = HashMap();
      upgradeMap["DATE"] = DateTime.now();
      upgradeMap["AMOUNT"] = "1000";
      upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
      upgradeMap["FROM_ID"] = memberId;
      upgradeMap["SCREENSHOT"] = "";
      upgradeMap["TYPE"] = "HELP";
      upgradeMap["STATUS"] = "PENDING";
      upgradeMap["GRADE"] = "BLUE";
      upgradeMap["TREE"] = "MASTER_CLUB";
      upgradeMap["IN_TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
          generateRandomString(4))
          .set(upgradeMap, SetOptions(merge: true));

      HashMap<String, Object> autoPollMap = HashMap();
      autoPollMap["DATE"] = DateTime.now();
      autoPollMap["AMOUNT"] = "200";
      autoPollMap["TO_ID"] = "1707799788939te";
      autoPollMap["FROM_ID"] = memberId;
      autoPollMap["SCREENSHOT"] = "";
      autoPollMap["TYPE"] = "STAR_CLUB";
      autoPollMap["STATUS"] = "PENDING";
      autoPollMap["GRADE"] = "BLUE";
      autoPollMap["TREE"] = tree;
      autoPollMap["IN_TREE"] = "STAR_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
          generateRandomString(4))
          .set(autoPollMap, SetOptions(merge: true));

      HashMap<String, Object> sponsorMap = HashMap();
      sponsorMap["DATE"] = DateTime.now();
      sponsorMap["AMOUNT"] = "300";
      sponsorMap["TO_ID"] = memberMap1["REFERENCE"].toString();
      sponsorMap["FROM_ID"] = memberId;
      sponsorMap["SCREENSHOT"] = "";
      sponsorMap["TYPE"] = "REFERRAL";
      sponsorMap["STATUS"] = "PENDING";
      sponsorMap["GRADE"] = "BLUE";
      sponsorMap["TREE"] = "MASTER_CLUB";
      sponsorMap["IN_TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
          generateRandomString(4))
          .set(sponsorMap, SetOptions(merge: true));

      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "300";
      pmcMap["INSTALLMENT"] = 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "BLUE";
      pmcMap["TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
          generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));

      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "400";
      donationMap["INSTALLMENT"] = 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "BLUE";
      donationMap["TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
          generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));

  }

  bool waitingBool = false;

  placeInStarClub(
      String memberId, String tree, String userBlueDocId, String starDistributionId,
      String userDistName, String userDistNumber, String userDistImage,BuildContext ctx) async {
    waitingBool = true;
    notifyListeners();
    DateTime now = DateTime.now();
    String newId =
        now.millisecondsSinceEpoch.toString() + generateRandomString(2);

    var starValue = await db.collection("STAR_CLUB").doc(userBlueDocId).get();


    // .then((autoValue) async {
    if(!starValue.exists){

      var autoValue = await db
          .collection("STAR_CLUB")
          .where("CHILD_COUNT", isEqualTo: 1)
          .orderBy("STEP_ID")
          .limit(1)
          .get();

      if (autoValue.docs.isNotEmpty) {
        String toParentId = autoValue.docs.first.get("MEMBER_ID");
        String toParentDocId = autoValue.docs.first.id;
        List<dynamic> parentList = [];
        List<dynamic> parentList2 = autoValue.docs.first.get("PARENTS");
        List<dynamic> childList = autoValue.docs.first.get("CHILDREN");
        childList.add(userBlueDocId);

        db
            .collection("DISTRIBUTIONS")
            .doc(starDistributionId)
            .set({"TO_ID":toParentId}, SetOptions(merge: true));

        db.collection("STAR_CLUB").doc(toParentDocId).set({
          "CHILD_COUNT": FieldValue.increment(1),
          "CHILDREN": childList,
        }, SetOptions(merge: true));

        db.collection("MASTER_CLUB").doc(userBlueDocId).set({
          "TREES": ["MASTER_CLUB", "STAR_CLUB"],
        }, SetOptions(merge: true));

        db.collection("USERS").doc(memberId).set({
          "AUTO_ONE_GRADE": "",
          "STAR_ENTRY": "SUCCESS",
          "TREES": ["MASTER_CLUB", "STAR_CLUB"],
          "TOTAL_AUTO_ONE_HELP": 0,
        }, SetOptions(merge: true));

        HashMap<String, Object> treeMap = HashMap();
        treeMap["DOCUMENT_ID"] = userBlueDocId;
        treeMap["MEMBER_ID"] = memberId;
        treeMap["STEP_ID"] = autoValue.docs.first.get("STEP_ID") + 1;
        treeMap["DIRECT_PARENT_ID"] = toParentId;
        treeMap["DIRECT_PARENT_DOC_ID"] = toParentDocId;
        treeMap["GRADE"] = "";
        treeMap["CHILD_COUNT"] = 0;
        treeMap['REG_DATE'] = now;
        treeMap['NAME'] = userDistName;
        treeMap['PHONE'] = userDistNumber;
        treeMap['ItemImage'] =userDistImage;
        treeMap["STATUS"] = "ACTIVE";
        treeMap["TYPE"] = "MEMBER";

        parentList.add(toParentDocId);
        parentList = parentList + parentList2;
        if (parentList.length < 128) {
          treeMap["PARENTS"] = parentList;
        } else {
          parentList.removeAt(parentList.length - 1);
          treeMap["PARENTS"] = parentList;
        }

        db.collection("STAR_CLUB").doc(userBlueDocId).set(treeMap);

        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] =
        "$userDistName has attained STAR CLUB status.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["TO_ID"] = [toParentId];
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap["VIEWERS"] = [];
        notificationMap['REG_DATE'] = DateTime.now();
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();

        db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);

        waitingBool = false;
        finish(ctx);
        notifyListeners();


      }
      else {
        var autoValue2 = await db
            .collection("STAR_CLUB")
            .where("CHILD_COUNT", isEqualTo: 0)
            .orderBy("STEP_ID")
            .limit(1)
            .get();
        // .then((autoValue2) {
        String toParentId = autoValue2.docs.first.get("MEMBER_ID");
        String toParentDocId = autoValue2.docs.first.id;

        List<dynamic> parentList = [];
        List<dynamic> parentList2 = autoValue2.docs.first.get("PARENTS");
        List<dynamic> childList = [userBlueDocId];

        db
            .collection("DISTRIBUTIONS")
            .doc(starDistributionId)
            .set({"TO_ID":toParentId}, SetOptions(merge: true));


        db.collection("STAR_CLUB").doc(toParentDocId).set({
          "CHILD_COUNT": FieldValue.increment(1),
          "CHILDREN": childList,
        }, SetOptions(merge: true));

        HashMap<String, Object> treeMap = HashMap();
        treeMap["DOCUMENT_ID"] = userBlueDocId;
        treeMap["MEMBER_ID"] = memberId;
        treeMap["STEP_ID"] = autoValue2.docs.first.get("STEP_ID") + 1;
        treeMap["DIRECT_PARENT_ID"] = toParentId;
        treeMap["DIRECT_PARENT_DOC_ID"] = toParentDocId;
        treeMap["GRADE"] = "";
        treeMap["CHILD_COUNT"] = 0;
        treeMap['REG_DATE'] = now;
        treeMap['NAME'] = userDistName;
        treeMap['PHONE'] = userDistNumber;
        treeMap['ItemImage'] =userDistImage;
        treeMap["STATUS"] = "ACTIVE";
        treeMap["TYPE"] = "MEMBER";

        parentList.add(toParentDocId);
        parentList = parentList + parentList2;
        if (parentList.length < 128) {
          treeMap["PARENTS"] = parentList;
        } else {
          parentList.removeAt(parentList.length - 1);
          treeMap["PARENTS"] = parentList;
        }

        db.collection("STAR_CLUB").doc(userBlueDocId).set(treeMap);

        db.collection("MASTER_CLUB").doc(userBlueDocId).set({
          "TREES": ["MASTER_CLUB", "STAR_CLUB"],
        }, SetOptions(merge: true));

        db.collection("USERS").doc(memberId).set({
          "AUTO_ONE_GRADE": "",
          "STAR_ENTRY": "SUCCESS",
          "TREES": ["MASTER_CLUB", "STAR_CLUB"],
          "TOTAL_AUTO_ONE_HELP": 0,
        }, SetOptions(merge: true));

        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] =
        "$userDistName has attained STAR CLUB status.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["TO_ID"] = [toParentId];
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap["VIEWERS"] = [];
        notificationMap['REG_DATE'] = DateTime.now();
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();


        waitingBool = false;
        finish(ctx);
        notifyListeners();

      }
    }else{
      db.collection("USERS").doc(memberId).set({
        "STAR_ENTRY": "SUCCESS",
      }, SetOptions(merge: true));
      waitingBool = false;
      finish(ctx);
      notifyListeners();
    }


  }

  generate3StarDistributions(
      String memberId, String tree, String user3StarDocId) async {
    var memberValue = await db.collection(tree).doc(user3StarDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];
    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[3])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "1000";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "3 STAR";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    HashMap<String, Object> donationMap = HashMap();
    donationMap["DATE"] = DateTime.now();
    donationMap["AMOUNT"] = "350";
    donationMap["INSTALLMENT"] = 1;
    donationMap["FROM_ID"] = memberId;
    donationMap["TYPE"] = "CMF";
    donationMap["STATUS"] = "PENDING";
    donationMap["GRADE"] = "3 STAR";
    donationMap["TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(donationMap, SetOptions(merge: true));

    HashMap<String, Object> pmcMap = HashMap();
    pmcMap["DATE"] = DateTime.now();
    pmcMap["AMOUNT"] = "350";
    pmcMap["INSTALLMENT"] = 1;
    pmcMap["FROM_ID"] = memberId;
    pmcMap["TYPE"] = "PMC";
    pmcMap["STATUS"] = "PENDING";
    pmcMap["GRADE"] = "3 STAR";
    pmcMap["TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(pmcMap, SetOptions(merge: true));
    // });

    // });
  }

  generateGoldDistributions(
      String memberId, String tree, String userGoldDocId) async {
    var memberValue = await db.collection(tree).doc(userGoldDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> parentMap = memberValue.data() as Map;
    List<dynamic> upgradeParentList = parentMap["PARENTS"];

    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeParentList[2])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "4000";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "GOLD";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    HashMap<String, Object> donationMap = HashMap();
    donationMap["DATE"] = DateTime.now();
    donationMap["AMOUNT"] = "500";
    donationMap["INSTALLMENT"] = 1;
    donationMap["FROM_ID"] = memberId;
    donationMap["TYPE"] = "CMF";
    donationMap["STATUS"] = "PENDING";
    donationMap["GRADE"] = "GOLD";
    donationMap["TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(donationMap, SetOptions(merge: true));

    HashMap<String, Object> pmcMap = HashMap();
    pmcMap["DATE"] = DateTime.now();
    pmcMap["AMOUNT"] = "500";
    pmcMap["INSTALLMENT"] = 1;
    pmcMap["FROM_ID"] = memberId;
    pmcMap["TYPE"] = "PMC";
    pmcMap["STATUS"] = "PENDING";
    pmcMap["GRADE"] = "GOLD";
    pmcMap["TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(pmcMap, SetOptions(merge: true));
    // });

    // });
  }

  generateGreenDistributions2(
      String memberId, String tree, String userGreenDocId) async {

    var memberValue = await db.collection(tree).doc(userGreenDocId).get();

    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];
    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[4])
        .get();

      HashMap<String, Object> upgradeMap = HashMap();
      upgradeMap["DATE"] = DateTime.now();
      upgradeMap["AMOUNT"] = "2000";
      upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
      upgradeMap["FROM_ID"] = memberId;
      upgradeMap["SCREENSHOT"] = "";
      upgradeMap["TYPE"] = "HELP";
      upgradeMap["STATUS"] = "PENDING";
      upgradeMap["GRADE"] = "GREEN";
      upgradeMap["TREE"] = "MASTER_CLUB";
      upgradeMap["IN_TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(upgradeMap, SetOptions(merge: true));

      HashMap<String, Object> autoPollMap = HashMap();
      autoPollMap["DATE"] = DateTime.now();
      autoPollMap["AMOUNT"] = "2000";
      autoPollMap["TO_ID"] = "PENDING";
      autoPollMap["FROM_ID"] = memberId;
      autoPollMap["SCREENSHOT"] = "";
      autoPollMap["TYPE"] = "CROWN_CLUB";
      autoPollMap["STATUS"] = "PENDING";
      autoPollMap["GRADE"] = "GREEN";
      autoPollMap["TREE"] = "MASTER_CLUB";
      autoPollMap["IN_TREE"] = "CROWN_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(autoPollMap, SetOptions(merge: true));

      HashMap<String, Object> sponsorMap = HashMap();
      sponsorMap["DATE"] = DateTime.now();
      sponsorMap["AMOUNT"] = "1000";
      sponsorMap["TO_ID"] = memberMap1["REFERENCE"].toString();
      sponsorMap["FROM_ID"] = memberId;
      sponsorMap["SCREENSHOT"] = "";
      sponsorMap["TYPE"] = "REFERRAL";
      sponsorMap["STATUS"] = "PENDING";
      sponsorMap["GRADE"] = "GREEN";
      sponsorMap["TREE"] = "MASTER_CLUB";
      sponsorMap["IN_TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(sponsorMap, SetOptions(merge: true));

      int i = 0;
      for (i = 0; i <= 1; i++) {
        HashMap<String, Object> pmcMap = HashMap();
        pmcMap["DATE"] = DateTime.now();
        pmcMap["AMOUNT"] = "700";
        pmcMap["INSTALLMENT"] = i + 1;
        pmcMap["FROM_ID"] = memberId;
        pmcMap["TYPE"] = "PMC";
        pmcMap["STATUS"] = "PENDING";
        pmcMap["GRADE"] = "GREEN";
        pmcMap["TREE"] = "MASTER_CLUB";
        db
            .collection("DISTRIBUTIONS")
            .doc(DateTime.now().millisecondsSinceEpoch.toString() +
                generateRandomString(4))
            .set(pmcMap, SetOptions(merge: true));
      }

      int j = 0;
      for (j = 0; j <= 1; j++) {
        HashMap<String, Object> donationMap = HashMap();
        donationMap["DATE"] = DateTime.now();
        donationMap["AMOUNT"] = "700";
        donationMap["INSTALLMENT"] = j + 1;
        donationMap["FROM_ID"] = memberId;
        donationMap["TYPE"] = "CMF";
        donationMap["STATUS"] = "PENDING";
        donationMap["GRADE"] = "GREEN";
        donationMap["TREE"] = "MASTER_CLUB";
        db
            .collection("DISTRIBUTIONS")
            .doc(DateTime.now().millisecondsSinceEpoch.toString() +
                generateRandomString(4))
            .set(donationMap, SetOptions(merge: true));
      }

  }


  generateGreenDistributions(
      String memberId, String tree, String userGreenDocId) async {

    var memberValue = await db.collection(tree).doc(userGreenDocId).get();

    var starMemberValue = await db.collection("STAR_CLUB").doc(userGreenDocId).get();

    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];
    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[4])
        .get();

      HashMap<String, Object> upgradeMap = HashMap();
      upgradeMap["DATE"] = DateTime.now();
      upgradeMap["AMOUNT"] = "2000";
      upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
      upgradeMap["FROM_ID"] = memberId;
      upgradeMap["SCREENSHOT"] = "";
      upgradeMap["TYPE"] = "HELP";
      upgradeMap["STATUS"] = "PENDING";
      upgradeMap["GRADE"] = "GREEN";
      upgradeMap["TREE"] = "MASTER_CLUB";
      upgradeMap["IN_TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
          generateRandomString(4))
          .set(upgradeMap, SetOptions(merge: true));

    HashMap<String, Object> autoPollMap = HashMap();
    autoPollMap["DATE"] = DateTime.now();
    autoPollMap["AMOUNT"] = "2000";
    autoPollMap["TO_ID"] = "1707799788939te";
    autoPollMap["FROM_ID"] = memberId;
    autoPollMap["SCREENSHOT"] = "";
    autoPollMap["TYPE"] = "CROWN_CLUB";
    autoPollMap["STATUS"] = "PENDING";
    autoPollMap["GRADE"] = "GREEN";
    autoPollMap["TREE"] = "MASTER_CLUB";
    autoPollMap["IN_TREE"] = "CROWN_CLUB";
    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
        generateRandomString(4))
        .set(autoPollMap, SetOptions(merge: true));

      HashMap<String, Object> sponsorMap = HashMap();
      sponsorMap["DATE"] = DateTime.now();
      sponsorMap["AMOUNT"] = "1000";
      sponsorMap["TO_ID"] = memberMap1["REFERENCE"].toString();
      sponsorMap["FROM_ID"] = memberId;
      sponsorMap["SCREENSHOT"] = "";
      sponsorMap["TYPE"] = "REFERRAL";
      sponsorMap["STATUS"] = "PENDING";
      sponsorMap["GRADE"] = "GREEN";
      sponsorMap["TREE"] = "MASTER_CLUB";
      sponsorMap["IN_TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
          generateRandomString(4))
          .set(sponsorMap, SetOptions(merge: true));

      int i = 0;
      for (i = 0; i <= 1; i++) {
        HashMap<String, Object> pmcMap = HashMap();
        pmcMap["DATE"] = DateTime.now();
        pmcMap["AMOUNT"] = "700";
        pmcMap["INSTALLMENT"] = i + 1;
        pmcMap["FROM_ID"] = memberId;
        pmcMap["TYPE"] = "PMC";
        pmcMap["STATUS"] = "PENDING";
        pmcMap["GRADE"] = "GREEN";
        pmcMap["TREE"] = "MASTER_CLUB";
        db
            .collection("DISTRIBUTIONS")
            .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
            .set(pmcMap, SetOptions(merge: true));
      }

      int j = 0;
      for (j = 0; j <= 1; j++) {
        HashMap<String, Object> donationMap = HashMap();
        donationMap["DATE"] = DateTime.now();
        donationMap["AMOUNT"] = "700";
        donationMap["INSTALLMENT"] = j + 1;
        donationMap["FROM_ID"] = memberId;
        donationMap["TYPE"] = "CMF";
        donationMap["STATUS"] = "PENDING";
        donationMap["GRADE"] = "GREEN";
        donationMap["TREE"] = "MASTER_CLUB";
        db
            .collection("DISTRIBUTIONS")
            .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
            .set(donationMap, SetOptions(merge: true));
      }


    Map<dynamic, dynamic> memberMap2 = starMemberValue.data() as Map;
    List<dynamic> upgradeOutStarParentList = memberMap2["PARENTS"];
    var parentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutStarParentList[1])
        .get();

    HashMap<String, Object> starUpgradeMap = HashMap();

    starUpgradeMap["DATE"] = DateTime.now();
    starUpgradeMap["AMOUNT"] = "200";
    starUpgradeMap["TO_ID"] = parentValue.docs.first.id;
    starUpgradeMap["FROM_ID"] = memberId;
    starUpgradeMap["SCREENSHOT"] = "";
    starUpgradeMap["TYPE"] = "HELP";
    starUpgradeMap["STATUS"] = "PENDING";
    starUpgradeMap["GRADE"] = "STAR";
    starUpgradeMap["TREE"] = "STAR_CLUB";
    starUpgradeMap["IN_TREE"] = "STAR_CLUB";

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
        generateRandomString(4))
        .set(starUpgradeMap, SetOptions(merge: true));

  }

  placeInCrownClub(
      String memberId, String tree, String userGreenDocId, String crownDistributionId,
      String userDistName, String userDistNumber, String userDistImage,BuildContext ctx) async {
    waitingBool = true;
    notifyListeners();
    DateTime now = DateTime.now();
    String newId =
        now.millisecondsSinceEpoch.toString() + generateRandomString(2);

    var memberValue = await db.collection(tree).doc(userGreenDocId).get();

    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;

    var crownValue = await db.collection("CROWN_CLUB").doc(userGreenDocId).get();

    // .then((autoValue) async {
    if(!crownValue.exists){
      var autoValue = await db
          .collection("CROWN_CLUB")
          .where("CHILD_COUNT", isEqualTo: 1)
          .orderBy("STEP_ID")
          .limit(1)
          .get();
      if (autoValue.docs.isNotEmpty) {
        String toParentId = autoValue.docs.first.get("MEMBER_ID");
        String toParentDocId = autoValue.docs.first.id;
        List<dynamic> parentList = [];
        List<dynamic> parentList2 = autoValue.docs.first.get("PARENTS");
        List<dynamic> childList = autoValue.docs.first.get("CHILDREN");
        childList.add(userGreenDocId);

        db
            .collection("DISTRIBUTIONS")
            .doc(crownDistributionId)
            .set({"TO_ID":toParentId}, SetOptions(merge: true));

        db.collection("CROWN_CLUB").doc(toParentDocId).set({
          "CHILD_COUNT": FieldValue.increment(1),
          "CHILDREN": childList,
        }, SetOptions(merge: true));

        db.collection("USERS").doc(memberId).set({
          "AUTO_TWO_GRADE": "",
          "CROWN_ENTRY": "SUCCESS",
          "TREES": ["MASTER_CLUB", "STAR_CLUB", "CROWN_CLUB"],
          "TOTAL_AUTO_TWO_HELP": 0,
        }, SetOptions(merge: true));

        db.collection("MASTER_CLUB").doc(userGreenDocId).set({
          "TREES": ["MASTER_CLUB", "STAR_CLUB", "CROWN_CLUB"],
        }, SetOptions(merge: true));

        db.collection("STAR_CLUB").doc(userGreenDocId).set({
          "TREES": ["MASTER_CLUB", "STAR_CLUB", "CROWN_CLUB"],
        }, SetOptions(merge: true));

        HashMap<String, Object> treeMap = HashMap();
        treeMap["DOCUMENT_ID"] = userGreenDocId;
        treeMap["MEMBER_ID"] = memberId;
        treeMap["STEP_ID"] = autoValue.docs.first.get("STEP_ID") + 1;
        treeMap["DIRECT_PARENT_ID"] = toParentId;
        treeMap["DIRECT_PARENT_DOC_ID"] = toParentDocId;
        treeMap["GRADE"] = "";
        treeMap["CHILD_COUNT"] = 0;
        treeMap['REG_DATE'] = now;
        treeMap['NAME'] = memberMap1["NAME"] ?? "";
        treeMap['PHONE'] = memberMap1["PHONE"] ?? "";
        treeMap['ItemImage'] = memberMap1["ItemImage"] ?? "";
        treeMap["STATUS"] = "ACTIVE";
        treeMap["TYPE"] = "MEMBER";

        parentList.add(toParentDocId);
        parentList = parentList + parentList2;
        if (parentList.length < 128) {
          treeMap["PARENTS"] = parentList;
        } else {
          parentList.removeAt(parentList.length - 1);
          treeMap["PARENTS"] = parentList;
        }

        db.collection("CROWN_CLUB").doc(userGreenDocId).set(treeMap);

        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] =
        "${memberMap1["NAME"]} has attained CROWN CLUB status.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["TO_ID"] = [toParentId];
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap["VIEWERS"] = [];
        notificationMap['REG_DATE'] = DateTime.now();
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();

        db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);

        waitingBool = false;
        finish(ctx);
        notifyListeners();

      }
      else {
        var autoValue2 = await db
            .collection("CROWN_CLUB")
            .where("CHILD_COUNT", isEqualTo: 0)
            .orderBy("STEP_ID")
            .limit(1)
            .get();

        String toParentId = autoValue2.docs.first.get("MEMBER_ID");
        String toParentDocId = autoValue2.docs.first.id;
        List<dynamic> parentList = [];
        List<dynamic> parentList2 = autoValue2.docs.first.get("PARENTS");
        List<dynamic> childList = [userGreenDocId];

        db
            .collection("DISTRIBUTIONS")
            .doc(crownDistributionId)
            .set({"TO_ID":toParentId}, SetOptions(merge: true));

        db.collection("CROWN_CLUB").doc(toParentDocId).set({
          "CHILD_COUNT": FieldValue.increment(1),
          "CHILDREN": childList,
        }, SetOptions(merge: true));

        HashMap<String, Object> treeMap = HashMap();
        treeMap["DOCUMENT_ID"] = userGreenDocId;
        treeMap["MEMBER_ID"] = memberId;
        treeMap["STEP_ID"] = autoValue2.docs.first.get("STEP_ID") + 1;
        treeMap["DIRECT_PARENT_ID"] = toParentId;
        treeMap["DIRECT_PARENT_DOC_ID"] = toParentDocId;
        treeMap["GRADE"] = "";
        treeMap["CHILD_COUNT"] = 0;
        treeMap['REG_DATE'] = now;
        treeMap['NAME'] = memberMap1["NAME"] ?? "";
        treeMap['PHONE'] = memberMap1["PHONE"] ?? "";
        treeMap['ItemImage'] = memberMap1["ItemImage"] ?? "";
        treeMap["STATUS"] = "ACTIVE";
        treeMap["TYPE"] = "MEMBER";

        parentList.add(toParentDocId);
        parentList = parentList + parentList2;
        if (parentList.length < 128) {
          treeMap["PARENTS"] = parentList;
        } else {
          parentList.removeAt(parentList.length - 1);
          treeMap["PARENTS"] = parentList;
        }

        db.collection("CROWN_CLUB").doc(userGreenDocId).set(treeMap);

        db.collection("USERS").doc(memberId).set({
          "AUTO_TWO_GRADE": "",
          "CROWN_ENTRY": "SUCCESS",
          "TREES": ["MASTER_CLUB", "STAR_CLUB", "CROWN_CLUB"],
          "TOTAL_AUTO_TWO_HELP": 0,
        }, SetOptions(merge: true));

        db.collection("MASTER_CLUB").doc(userGreenDocId).set({
          "TREES": ["MASTER_CLUB", "STAR_CLUB", "CROWN_CLUB"],
        }, SetOptions(merge: true));

        db.collection("STAR_CLUB").doc(userGreenDocId).set({
          "TREES": ["MASTER_CLUB", "STAR_CLUB", "CROWN_CLUB"],
        }, SetOptions(merge: true));

        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] = "has attained CROWN CLUB status.";
        notificationMap["FROM_ID"] = memberId;
        notificationMap["TO_ID"] = [toParentId];
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap["VIEWERS"] = [];
        notificationMap['REG_DATE'] = DateTime.now();
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();

        db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
        waitingBool = false;
        finish(ctx);
        notifyListeners();

      }
    }else{
      db.collection("USERS").doc(memberId).set({
        "CROWN_ENTRY": "SUCCESS",
      }, SetOptions(merge: true));
      waitingBool = false;
      finish(ctx);
      notifyListeners();
    }

  }

  generate4StarDistributions(
      String memberId, String tree, String user4StarDocId) async {
    var memberValue = await db.collection(tree).doc(user4StarDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];
    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[4])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "5000";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "4 STAR";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    int i = 0;
    for (i = 0; i < 2; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "750";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "4 STAR";
      pmcMap["TREE"] = "STAR_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 2; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "750";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "4 STAR";
      donationMap["TREE"] = "STAR_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });

    // });
  }

  generatePlatinumDistributions(
      String memberId, String tree, String userPlatinumDocId) async {
    List<String> amountList = ["750", "750", "1000"];
    var memberValue = await db.collection(tree).doc(userPlatinumDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];
    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[3])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "5000";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "PLATINUM";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    int i = 0;
    for (i = 0; i < 3; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = amountList[i];
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "PLATINUM";
      pmcMap["TREE"] = "CROWN_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 3; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = amountList[j];
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "PLATINUM";
      donationMap["TREE"] = "CROWN_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });

    // });
  }

  generateYellowDistributions(
      String memberId, String tree, String userYellowDocId) async {
    var crownMemberValue = await db.collection(tree).doc(userYellowDocId).get();
    // .then((crownMemberValue) {
    Map<dynamic, dynamic> crownParentMap = crownMemberValue.data() as Map;
    List<dynamic> upgradeCrownParentList = crownParentMap["PARENTS"];

    // var crownParentValue = await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: upgradeCrownParentList[1]).get();
    //
    // var crownParentFirstValue = crownParentValue.docs.first;

    var crownParentQuery = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeCrownParentList[1])
        .get();

    var crownParentValue = crownParentQuery.docs.first;

    var memberValue = await db.collection(tree).doc(userYellowDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];

    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[5])
        .get();

    HashMap<String, Object> crownUpgradeMap = HashMap();

    crownUpgradeMap["DATE"] = DateTime.now();
    crownUpgradeMap["AMOUNT"] = "2000";
    crownUpgradeMap["TO_ID"] = crownParentValue.id;
    crownUpgradeMap["FROM_ID"] = memberId;
    crownUpgradeMap["SCREENSHOT"] = "";
    crownUpgradeMap["TYPE"] = "HELP";
    crownUpgradeMap["STATUS"] = "PENDING";
    crownUpgradeMap["GRADE"] = "SILVER";
    crownUpgradeMap["TREE"] = "CROWN_CLUB";
    crownUpgradeMap["IN_TREE"] = "CROWN_CLUB";

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(crownUpgradeMap, SetOptions(merge: true));

    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["AMOUNT"] = "5000";
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "YELLOW";
    upgradeMap["TREE"] = "MASTER_CLUB";
    upgradeMap["IN_TREE"] = "MASTER_CLUB";
    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    HashMap<String, Object> sponsorMap = HashMap();
    sponsorMap["DATE"] = DateTime.now();
    sponsorMap["AMOUNT"] = "5000";
    sponsorMap["TO_ID"] = memberMap1["REFERENCE"].toString();
    sponsorMap["FROM_ID"] = memberId;
    sponsorMap["SCREENSHOT"] = "";
    sponsorMap["TYPE"] = "REFERRAL";
    sponsorMap["STATUS"] = "PENDING";
    sponsorMap["GRADE"] = "YELLOW";
    sponsorMap["TREE"] = "MASTER_CLUB";
    sponsorMap["IN_TREE"] = "MASTER_CLUB";
    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(sponsorMap, SetOptions(merge: true));

    int i = 0;
    for (i = 0; i < 5; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "YELLOW";
      pmcMap["TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 5; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "YELLOW";
      donationMap["TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }
  }

  generate5StarDistributions(
      String memberId, String tree, String user5StarDocId) async {
    var memberValue = await db.collection(tree).doc(user5StarDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];

    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[5])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "10000";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "5 STAR";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    int i = 0;
    for (i = 0; i < 10; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "5 STAR";
      pmcMap["TREE"] = "STAR_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 10; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "5 STAR";
      donationMap["TREE"] = "STAR_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });

    // });
  }

  generateDiamondDistributions(
      String memberId, String tree, String userDiamondDocId) async {
    var memberValue = await db.collection(tree).doc(userDiamondDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];

    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[4])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "10000";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "DIAMOND";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    int i = 0;
    for (i = 0; i < 10; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "DIAMOND";
      pmcMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 10; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "DIAMOND";
      donationMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }
    // });

    // });
  }

  generateOrangeDistributions(
      String memberId, String tree, String userOrangeDocId) async {
    var memberValue = await db.collection(tree).doc(userOrangeDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];

    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[6])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["AMOUNT"] = "10000";
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "ORANGE";
    upgradeMap["TREE"] = "MASTER_CLUB";
    upgradeMap["IN_TREE"] = "MASTER_CLUB";
    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    HashMap<String, Object> sponsorMap = HashMap();
    sponsorMap["DATE"] = DateTime.now();
    sponsorMap["AMOUNT"] = "20000";
    sponsorMap["TO_ID"] = memberMap1["REFERENCE"].toString();
    sponsorMap["FROM_ID"] = memberId;
    sponsorMap["SCREENSHOT"] = "";
    sponsorMap["TYPE"] = "REFERRAL";
    sponsorMap["STATUS"] = "PENDING";
    sponsorMap["GRADE"] = "ORANGE";
    sponsorMap["TREE"] = "MASTER_CLUB";
    sponsorMap["IN_TREE"] = "MASTER_CLUB";
    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(sponsorMap, SetOptions(merge: true));
    int i = 0;
    for (i = 0; i < 20; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "ORANGE";
      pmcMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j <= 19; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "ORANGE";
      donationMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });

    // });
  }

  generate6StarDistributions(
      String memberId, String tree, String user6StarDocId) async {
    var memberValue = await db.collection(tree).doc(user6StarDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];

    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[6])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "20000";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "6 STAR";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    int i = 0;
    for (i = 0; i < 20; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "6 STAR";
      pmcMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 20; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "6 STAR";
      donationMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });

    // });
  }

  generateRoyalDistributions(
      String memberId, String tree, String userRoyalDocId) async {
    var memberValue = await db.collection(tree).doc(userRoyalDocId).get();
    // .then((memberValue) {
    Map<dynamic, dynamic> memberMap1 = memberValue.data() as Map;
    List<dynamic> upgradeOutParentList = memberMap1["PARENTS"];
    var upgradeParentValue = await db
        .collection("USERS")
        .where("DOCUMENT_ID", isEqualTo: upgradeOutParentList[5])
        .get();
    // .then((upgradeParentValue) {
    HashMap<String, Object> upgradeMap = HashMap();
    upgradeMap["DATE"] = DateTime.now();
    upgradeMap["TO_ID"] = upgradeParentValue.docs.first.id;
    upgradeMap["AMOUNT"] = "20000";
    upgradeMap["FROM_ID"] = memberId;
    upgradeMap["SCREENSHOT"] = "";
    upgradeMap["TYPE"] = "HELP";
    upgradeMap["STATUS"] = "PENDING";
    upgradeMap["GRADE"] = "ROYAL";
    upgradeMap["TREE"] = tree;
    upgradeMap["IN_TREE"] = tree;

    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(upgradeMap, SetOptions(merge: true));

    int i = 0;
    for (i = 0; i < 15; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "ROYAL";
      pmcMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 15; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "ROYAL";
      donationMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });

    // });
  }

  generateRedDistributions(String memberId, String tree) async {
    var memberValue = await db.collection("USERS").doc(memberId).get();
    // .then((memberValue) {

    HashMap<String, Object> sponsorMap = HashMap();
    sponsorMap["DATE"] = DateTime.now();
    sponsorMap["AMOUNT"] = "30000";
    sponsorMap["TO_ID"] = memberValue.get("REFERENCE");
    sponsorMap["FROM_ID"] = memberId;
    sponsorMap["SCREENSHOT"] = "";
    sponsorMap["TYPE"] = "REFERRAL";
    sponsorMap["STATUS"] = "PENDING";
    sponsorMap["GRADE"] = "RED";
    sponsorMap["TREE"] = tree;
    sponsorMap["IN_TREE"] = tree;
    db
        .collection("DISTRIBUTIONS")
        .doc(DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(4))
        .set(sponsorMap, SetOptions(merge: true));

    int i = 0;
    for (i = 0; i < 25; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "RED";
      pmcMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 25; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "RED";
      donationMap["TREE"] = "MASTER_CLUB";
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });
  }

  generate7StarDistributions(String memberId, String tree) async {
    var memberValue = await db.collection("USERS").doc(memberId).get();
    // .then((memberValue) {

    int i = 0;
    for (i = 0; i < 30; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "7 STAR";
      pmcMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 30; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "7 STAR";
      donationMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });
  }

  generateCrownDistributions(String memberId, String tree) async {
    var memberValue = await db.collection("USERS").doc(memberId).get();
    // .then((memberValue) {

    int i = 0;
    for (i = 0; i < 25; i++) {
      HashMap<String, Object> pmcMap = HashMap();
      pmcMap["DATE"] = DateTime.now();
      pmcMap["AMOUNT"] = "1000";
      pmcMap["INSTALLMENT"] = i + 1;
      pmcMap["FROM_ID"] = memberId;
      pmcMap["TYPE"] = "PMC";
      pmcMap["STATUS"] = "PENDING";
      pmcMap["GRADE"] = "CROWN";
      pmcMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(pmcMap, SetOptions(merge: true));
    }

    int j = 0;
    for (j = 0; j < 25; j++) {
      HashMap<String, Object> donationMap = HashMap();
      donationMap["DATE"] = DateTime.now();
      donationMap["AMOUNT"] = "1000";
      donationMap["INSTALLMENT"] = j + 1;
      donationMap["FROM_ID"] = memberId;
      donationMap["TYPE"] = "CMF";
      donationMap["STATUS"] = "PENDING";
      donationMap["GRADE"] = "CROWN";
      donationMap["TREE"] = tree;
      db
          .collection("DISTRIBUTIONS")
          .doc(DateTime.now().millisecondsSinceEpoch.toString() +
              generateRandomString(4))
          .set(donationMap, SetOptions(merge: true));
    }

    // });
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: clEBEBEB,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            content: SizedBox(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Do you want to exit?",
                    style: TextStyle(
                      color: cl252525,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.56,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.center,
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color(0xFFEBEBEB),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x1C000000),
                          blurRadius: 11,
                          offset: Offset(0, 9),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Image.asset("assets/logout.png",
                        scale: 1.5, color: cl2F7DC1),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 39,
                        width: 110,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffFFFCF8)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60)))),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: cl252525,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 39,
                        width: 110,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                textStyle: MaterialStateProperty.all(
                                    const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900)),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xff1746A2)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(60)))),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                            child: const Text(
                              'Exit',
                              style: TextStyle(
                                color: clFFFCF8,
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }



  StreamSubscription? _streamBasicGrade;
  StreamSubscription? _streamAutoOneGrade;
  StreamSubscription? _streamAutoTwoGrade;

  fetchUserAllGrades(String memberId) {
    currentBasicGrade = "";
    currentAutoOneGrade = "";
    currentAutoTwoGrade = "";
    if (_streamBasicGrade != null) {
      _streamBasicGrade!.cancel();
    }
    _streamBasicGrade = db
        .collection("MASTER_CLUB")
        .where("MEMBER_ID", isEqualTo: memberId)
        .snapshots()
        .listen((basicEvent) {
      if (_streamAutoOneGrade != null) {
        _streamAutoOneGrade!.cancel();
      }
      _streamAutoOneGrade = db
          .collection("STAR_CLUB")
          .where("MEMBER_ID", isEqualTo: memberId)
          .snapshots()
          .listen((oneEvent) {
        if (_streamAutoTwoGrade != null) {
          _streamAutoTwoGrade!.cancel();
        }
        _streamAutoTwoGrade = db
            .collection("CROWN_CLUB")
            .where("MEMBER_ID", isEqualTo: memberId)
            .snapshots()
            .listen((twoEvent) {
          if (basicEvent.docs.isNotEmpty) {
            Map<dynamic, dynamic> basicMap = basicEvent.docs.first.data();
            currentBasicGrade = basicMap['GRADE'] ?? "";
          }
          if (oneEvent.docs.isNotEmpty) {
            Map<dynamic, dynamic> oneMap = oneEvent.docs.first.data();
            currentAutoOneGrade = oneMap['GRADE'] ?? "";
          }
          if (twoEvent.docs.isNotEmpty) {
            Map<dynamic, dynamic> twoMap = twoEvent.docs.first.data();
            currentAutoTwoGrade = twoMap['GRADE'] ?? "";
          }
        });
      });
    });
  }

  String currentBasicGrade = "";
  String currentAutoOneGrade = "";
  String currentAutoTwoGrade = "";
  String currentTreeGrade = "";
  List<String> parentList = [];
  List<usersListModel> usersList = [];
  List<basic_treeModel> treeModelList = [];
  List<UpgradeModel> filterUpgradeParentsList = [];
  List<UpgradeModel> basicTreeUpgradeUsersList = [];
  List<UpgradeModel> autoPollOneUpgradeUsersList = [];
  List<UpgradeModel> autoPollTwoUpgradeUsersList = [];

  StreamSubscription? _streamBasicParents;
  StreamSubscription? _streamAutoOneParents;
  StreamSubscription? _streamAutoTwoParents;

  Future<void> fetchParentList(
    String id,
  ) async {
    if (_streamBasicParents != null) {
      _streamBasicParents!.cancel();
    }
    basicTreeUpgradeUsersList.clear();
    filterUpgradeParentsList.clear();
    currentBasicGrade = "";
    currentAutoOneGrade = "";
    currentAutoTwoGrade = "";
    currentTreeGrade = "";
    _streamBasicParents = db
        .collection("MASTER_CLUB")
        .where('MEMBER_ID', isEqualTo: id)
        .snapshots()
        .listen((value) async {
      basicTreeUpgradeUsersList.clear();
      if (value.docs.isNotEmpty) {
        List<String> upgradeParents = [];
        List<String> parentsAmountList = [];
        Map<dynamic, dynamic> map = value.docs.first.data();
        currentBasicGrade = map['GRADE'] ?? "";
        if (map['PARENTS'] != null) {
          for (var ee in map['PARENTS']) {
            upgradeParents.add(ee);
          }
          await db
              .collection("TOTAL_AMOUNTS")
              .doc("UPGRADES")
              .get()
              .then((event) async {
            if (event.exists) {
              Map<dynamic, dynamic> map2 = event.data() as Map;
              for (var cc in map2["MASTER_CLUB"]) {
                parentsAmountList.add(cc);
              }
              for (int i = 0; i < parentsAmountList.length; i++) {
                await db
                    .collection("USERS")
                    .where("DOCUMENT_ID", isEqualTo: upgradeParents[i])
                    .get()
                    .then((userValue) {
                  if (userValue.docs.isNotEmpty) {
                    Map<dynamic, dynamic> map3 = userValue.docs.first.data();
                    basicTreeUpgradeUsersList.add(UpgradeModel(
                        map3["NAME"].toString(),
                        upgradeParents[i],
                        map3["PHONE"].toString(),
                        parentsAmountList[i]));
                    filterUpgradeParentsList = basicTreeUpgradeUsersList;
                  }
                  notifyListeners();
                });
              }
            }
          });
        }
      }

      notifyListeners();
    });
    if (_streamAutoOneParents != null) {
      _streamAutoOneParents!.cancel();
    }

    _streamAutoOneParents = db
        .collection("STAR_CLUB")
        .where('MEMBER_ID', isEqualTo: id)
        .snapshots()
        .listen((value2) async {
      autoPollOneUpgradeUsersList.clear();
      if (value2.docs.isNotEmpty) {
        List<String> upgradeParents = [];
        List<String> parentsAmountList = [];
        Map<dynamic, dynamic> map = value2.docs.first.data();
        currentAutoOneGrade = map['GRADE'] ?? "";
        if (map['PARENTS'] != null) {
          for (var ee in map['PARENTS']) {
            upgradeParents.add(ee);
          }
          await db
              .collection("TOTAL_AMOUNTS")
              .doc("UPGRADES")
              .get()
              .then((event) async {
            if (event.exists) {
              Map<dynamic, dynamic> map2 = event.data() as Map;
              for (var cc in map2["STAR_CLUB"]) {
                parentsAmountList.add(cc);
              }
              for (int i = 0; i < parentsAmountList.length; i++) {
                await db
                    .collection("USERS")
                    .where("DOCUMENT_ID", isEqualTo: upgradeParents[i])
                    .get()
                    .then((userValue) {
                  if (userValue.docs.isNotEmpty) {
                    Map<dynamic, dynamic> map3 = userValue.docs.first.data();
                    autoPollOneUpgradeUsersList.add(UpgradeModel(
                        map3["NAME"].toString(),
                        upgradeParents[i],
                        map3["PHONE"].toString(),
                        parentsAmountList[i]));
                  }
                  notifyListeners();
                });
              }
            }
          });
        }
      }

      notifyListeners();
    });
    if (_streamAutoTwoParents != null) {
      _streamAutoTwoParents!.cancel();
    }
    _streamAutoTwoParents = db
        .collection("CROWN_CLUB")
        .where('MEMBER_ID', isEqualTo: id)
        .snapshots()
        .listen((value3) async {
      autoPollTwoUpgradeUsersList.clear();
      if (value3.docs.isNotEmpty) {
        List<String> upgradeParents = [];
        List<String> parentsAmountList = [];

        Map<dynamic, dynamic> map = value3.docs.first.data();
        currentAutoTwoGrade = map['GRADE'] ?? "";
        if (map['PARENTS'] != null) {
          for (var ee in map['PARENTS']) {
            upgradeParents.add(ee);
          }
          await db
              .collection("TOTAL_AMOUNTS")
              .doc("UPGRADES")
              .get()
              .then((event) async {
            if (event.exists) {
              Map<dynamic, dynamic> map2 = event.data() as Map;
              for (var cc in map2["CROWN_CLUB"]) {
                parentsAmountList.add(cc);
              }
              for (int i = 0; i < parentsAmountList.length; i++) {
                await db
                    .collection("USERS")
                    .where("DOCUMENT_ID", isEqualTo: upgradeParents[i])
                    .get()
                    .then((userValue) {
                  if (userValue.docs.isNotEmpty) {
                    Map<dynamic, dynamic> map3 = userValue.docs.first.data();
                    autoPollTwoUpgradeUsersList.add(UpgradeModel(
                        map3["NAME"].toString(),
                        upgradeParents[i],
                        map3["PHONE"].toString(),
                        parentsAmountList[i]));
                  }
                  notifyListeners();
                });
              }
            }
          });
        }
      }
      notifyListeners();
    });
  }

  String getTexts(int index2, String tree) {
    int index = index2;
    String text = '';
    if (tree == "MASTER_CLUB") {
      if (index == 0) {
        text = '';
      } else if (index == 1) {
        text = 'VIOLET';
      } else if (index == 2) {
        text = 'INDIGO';
      } else if (index == 3) {
        text = 'BLUE';
      } else if (index == 4) {
        text = 'GREEN';
      } else if (index == 5) {
        text = 'YELLOW';
      } else if (index == 6) {
        text = 'ORANGE';
      } else if (index == 7) {
        text = 'RED';
      }
      return text;
    } else if (tree == "STAR_CLUB") {
      if (index == 0) {
        text = '';
      } else if (index == 1) {
        text = 'STAR';
      } else if (index == 2) {
        text = '2 STAR';
      } else if (index == 3) {
        text = '3 STAR';
      } else if (index == 4) {
        text = '4 STAR';
      } else if (index == 5) {
        text = '5 STAR';
      } else if (index == 6) {
        text = '6 STAR';
      } else if (index == 7) {
        text = '7 STAR';
      }

      return text;
    } else {
      if (index == 0) {
        text = '';
      } else if (index == 1) {
        text = 'SILVER';
      } else if (index == 2) {
        text = 'GOLD';
      } else if (index == 3) {
        text = 'PLATINUM';
      } else if (index == 4) {
        text = 'DIAMOND';
      } else if (index == 5) {
        text = 'ROYAL';
      } else if (index == 6) {
        text = 'CROWN';
      }
      return text;
    }
  }

  filterGiveHelp(String item) {
    filterUserGiveHelpList = userGiveHelpList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.number.toLowerCase().contains(item.toLowerCase()) ||
            element.status.toLowerCase().contains(item.toLowerCase()) ||
            element.grade.toLowerCase().contains(item.toLowerCase()) ||
            element.tree.toLowerCase().contains(item.toLowerCase()) ||
            element.amount.toLowerCase().contains(item.toLowerCase()))
        .toList();
    totalGiveHelpAmount = filterUserGiveHelpList.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element.amount));
    notifyListeners();
  }

  filterGiveHelpReceived(String item) {
    filterUserHelpReceiveList = userHelpReceiveList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.number.toLowerCase().contains(item.toLowerCase()) ||
            element.status.toLowerCase().contains(item.toLowerCase()) ||
            element.grade.toLowerCase().contains(item.toLowerCase()) ||
            element.tree.toLowerCase().contains(item.toLowerCase()) ||
            element.amount.toLowerCase().contains(item.toLowerCase()))
        .toList();
    totalHelpReceivedAmount = filterUserHelpReceiveList.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element.amount));
    notifyListeners();
  }

  List<UserHelpModel> userGiveHelpList = [];
  List<UserHelpModel> filterUserGiveHelpList = [];
  List<UserHelpModel> userHelpReceiveList = [];
  List<UserHelpModel> filterUserHelpReceiveList = [];
  List<UserHelpModel> userHelpLedgerList = [];
  List<UserHelpModel> filterUserHelpLedgerList = [];
  double totalHelpReceivedAmount = 0;
  double totalGiveHelpAmount = 0;

  helpGiveList(String userId) {
    String date = "";
    userGiveHelpList.clear();
    filterUserGiveHelpList.clear();
    db
        .collection("TRANSACTIONS")
        .where("FROM_USER_ID", isEqualTo: userId)
        .where("PAYMENT_TYPE", whereIn: ["HELP", "STAR_CLUB", "CROWN_CLUB"])
        .get()
        .then((giveValue) {
          if (giveValue.docs.isNotEmpty) {
            userGiveHelpList.clear();
            filterUserGiveHelpList.clear();
            for (var element in giveValue.docs) {
              db
                  .collection("USERS")
                  .doc(element["TO_USER_ID"])
                  .get()
                  .then((userValue) {
                if (userValue.exists) {
                  Map<dynamic, dynamic> userMap = userValue.data() as Map;
                  DateTime regDate = DateTime.parse(
                      element["PAYMENT_TIME"].toDate().toString());
                  date = DateFormat('dd/MM/yyyy h:mm a').format(regDate);
                  userGiveHelpList.add(UserHelpModel(
                    userMap["NAME"],
                    element["TO_USER_ID"],
                    userMap["PHONE"],
                    element["AMOUNT"].toString(),
                    "-",
                    "-",
                    element["PAYMENT_STATUS"],
                    date,
                    element["GRADE"],
                    element["TREE"],
                    element["PAYMENT_TIME"].toDate(),
                    element["PAYMENT_TYPE"],
                  ));
                  filterUserGiveHelpList = userGiveHelpList;
                  totalGiveHelpAmount = userGiveHelpList.fold(
                      0,
                      (previousValue, element) =>
                          previousValue + double.parse(element.amount));
                  notifyListeners();
                }
              });
            }
          }
        });
  }

  helpReceiveList(String userId) {
    filterUserHelpReceiveList.clear();
    userHelpReceiveList.clear();
    String date = "";
    db
        .collection("TRANSACTIONS")
        .where("TO_USER_ID", isEqualTo: userId)
        .where("PAYMENT_TYPE", whereIn: ["HELP", "STAR_CLUB", "CROWN_CLUB"])
        .get()
        .then((receivedValue) {
          filterUserHelpReceiveList.clear();
          userHelpReceiveList.clear();
          if (receivedValue.docs.isNotEmpty) {
            for (var element1 in receivedValue.docs) {
              DateTime regDate =
                  DateTime.parse(element1["PAYMENT_TIME"].toDate().toString());
              date = DateFormat('dd/MM/yyyy h:mm a').format(regDate);
              userHelpReceiveList.add(UserHelpModel(
                element1["USER_NAME"],
                element1["FROM_USER_ID"],
                element1["PHONE_NUMBER"],
                element1["AMOUNT"].toString(),
                "-",
                "-",
                element1["PAYMENT_STATUS"],
                date,
                element1["GRADE"],
                element1["TREE"],
                element1["PAYMENT_TIME"].toDate(),
                element1["PAYMENT_TYPE"],
              ));
              filterUserHelpReceiveList = userHelpReceiveList;
              totalHelpReceivedAmount = userHelpReceiveList.fold(
                  0,
                  (previousValue, element) =>
                      previousValue + double.parse(element.amount));
              notifyListeners();
            }
          }
        });
  }

  helpGiveAndReceived(String userId) {
    filterUserHelpReceiveList.clear();
    userHelpReceiveList.clear();
    userGiveHelpList.clear();
    filterUserGiveHelpList.clear();
    filterUserHelpLedgerList.clear();
    userHelpLedgerList.clear();
    totalGiveHelpAmount = 0;
    totalHelpReceivedAmount = 0;
    String date = "";
    db
        .collection("TRANSACTIONS")
        // .where("MEMBERS", arrayContains: userId)
        .where("PAYMENT_TYPE", whereIn: ["HELP", "STAR_CLUB", "CROWN_CLUB"])
        .get()
        .then((helpLedgerValue) {
          if (helpLedgerValue.docs.isNotEmpty) {
            filterUserHelpReceiveList.clear();
            userHelpReceiveList.clear();
            userGiveHelpList.clear();
            filterUserGiveHelpList.clear();
            filterUserHelpLedgerList.clear();
            userHelpLedgerList.clear();
            totalGiveHelpAmount = 0;
            totalHelpReceivedAmount = 0;
            for (var elements in helpLedgerValue.docs) {
              if (elements["FROM_USER_ID"] == userId) {
                db
                    .collection("USERS")
                    .doc(elements["TO_USER_ID"])
                    .get()
                    .then((userValue) {
                  if (userValue.exists) {
                    Map<dynamic, dynamic> userMap = userValue.data() as Map;
                    DateTime regDate = DateTime.parse(
                        elements["PAYMENT_TIME"].toDate().toString());
                    date = DateFormat('dd/MM/yyyy h:mm a').format(regDate);
                    userHelpLedgerList.add(UserHelpModel(
                      userMap["NAME"],
                      elements["TO_USER_ID"],
                      userMap["PHONE"],
                      elements["AMOUNT"].toString(),
                      elements["AMOUNT"].toString(),
                      "-",
                      elements["PAYMENT_STATUS"],
                      date,
                      elements["GRADE"],
                      elements["TREE"],
                      elements["PAYMENT_TIME"].toDate(),
                      elements["PAYMENT_TYPE"],
                    ));
                    notifyListeners();
                    filterUserGiveHelpList =
                        userGiveHelpList = userHelpLedgerList;
                    totalGiveHelpAmount = totalGiveHelpAmount +
                        double.parse(elements["AMOUNT"].toString());
                    notifyListeners();
                    filterUserHelpLedgerList
                        .sort((a, b) => b.date.compareTo(a.date));
                    notifyListeners();
                  }
                });
              } else if (elements["TO_USER_ID"] == userId) {
                DateTime regDate = DateTime.parse(
                    elements["PAYMENT_TIME"].toDate().toString());
                date = DateFormat('dd/MM/yyyy h:mm a').format(regDate);
                userHelpLedgerList.add(UserHelpModel(
                  elements["USER_NAME"],
                  elements["FROM_USER_ID"],
                  elements["PHONE_NUMBER"],
                  elements["AMOUNT"].toString(),
                  "-",
                  elements["AMOUNT"].toString(),
                  elements["PAYMENT_STATUS"],
                  date,
                  elements["GRADE"],
                  elements["TREE"],
                  elements["PAYMENT_TIME"].toDate(),
                  elements["PAYMENT_TYPE"],
                ));
                notifyListeners();

                filterUserHelpReceiveList =
                    userHelpReceiveList = userHelpLedgerList;

                totalHelpReceivedAmount = totalHelpReceivedAmount +
                    double.parse(elements["AMOUNT"].toString());
                notifyListeners();
                filterUserHelpLedgerList
                    .sort((a, b) => b.date.compareTo(a.date));
                notifyListeners();
              }
              filterUserHelpLedgerList = userHelpLedgerList;
              notifyListeners();
            }
          }
        });
  }

  void giveHelpGradeWiseList(String grade) {
    if (grade == "All Stages") {
      filterUserGiveHelpList = userGiveHelpList;
      totalGiveHelpAmount = filterUserGiveHelpList.fold(
          0,
          (previousValue, element) =>
              previousValue + double.parse(element.amount));
    } else {
      filterUserGiveHelpList = userGiveHelpList
          .where((element) => element.grade == grade)
          .toSet()
          .toList();
      totalGiveHelpAmount = filterUserGiveHelpList.fold(
          0,
          (previousValue, element) =>
              previousValue + double.parse(element.amount));
    }
    notifyListeners();
  }

  void helpReceivedGradeWiseList(String grade) {
    if (grade == "All Stages") {
      filterUserHelpReceiveList = userHelpReceiveList;
      totalHelpReceivedAmount = filterUserHelpReceiveList.fold(
          0,
          (previousValue, element) =>
              previousValue + double.parse(element.amount));
    } else {
      filterUserHelpReceiveList = userHelpReceiveList
          .where((element) => element.grade == grade)
          .toSet()
          .toList();
      totalHelpReceivedAmount = filterUserHelpReceiveList.fold(
          0,
          (previousValue, element) =>
              previousValue + double.parse(element.amount));
    }
    notifyListeners();
  }

  // List<UserInModel> fiterIncomStatus = [];
  List<String> incomeStatusList = ["ALL STATUS", "PAID", "PENDING", "REJECTED"];
  List<String> incomeLevelList = [
    "ALL LEVEL",
    'STARTER',
    'VIOLET',
    'INDIGO',
    'BLUE',
    'GREEN',
    'YELLOW',
    "ORANGE",
    'RED',
  ];
  String selectedIncome = "ALL STATUS";
  String selectedLevel = "ALL LEVEL";
  bool lessBool = false;
  bool lessIncomeBool = false;
  bool hideFilterBool = false;
  bool hideHelpFilterBool = false;
  bool hideIncomeFilterBool = false;

  showFilter(String from) {
    if (from == "Help") {
      selectedUserTree = 'MASTER_CLUB';
      hideHelpFilterBool = true;
      for (var element in helpTreeList) {
        element.color = true;
      }
      helpTreeList[0].color = false;
      notifyListeners();
      currentTreeGrade = currentBasicGrade;
      filterUpgradeParentsList = basicTreeUpgradeUsersList;
      notifyListeners();
    } else if (from == "Distribution") {
      filterCompanyLevelList = companyBasicTreeList;
      hideFilterBool = true;
      for (var element in treeList) {
        element.color = true;
      }
      treeList[0].color = false;
      notifyListeners();
      sortDistributionList = distributionList
          .where((element) => element.tree == "MASTER_CLUB")
          .toSet()
          .toList();
    } else {
      filterCompanyLevelList = companyBasicTreeList;
      hideIncomeFilterBool = true;
      for (var element in incomeTreeList) {
        element.color = true;
      }
      incomeTreeList[0].color = false;
      notifyListeners();
      filterIncomeList = userInList
          .where((element) => element.tree == "MASTER_CLUB")
          .toSet()
          .toList();
    }
    notifyListeners();
  }

  void assignCurrentGrade(String treeGrade) {
    currentTreeGrade = treeGrade;
    notifyListeners();
  }

  hideFilter(String from) {
    if (from == "Help") {
      selectedUserTree = 'MASTER_CLUB';
      hideHelpFilterBool = false;
      filterUpgradeParentsList = basicTreeUpgradeUsersList;
      currentTreeGrade = currentBasicGrade;
      notifyListeners();
    } else if (from == "Distribution") {
      filterCompanyLevelList = companyBasicTreeList;
      hideFilterBool = false;
      lessBool = false;
      sortDistributionList = distributionList
          .where((element) => element.status != "PAID")
          .toSet()
          .toList();
    } else {
      filterCompanyLevelList = companyBasicTreeList;
      lessIncomeBool = false;
      hideIncomeFilterBool = false;
      filterIncomeList = userInList
          .where((element) => element.status != "PAID")
          .toSet()
          .toList();
    }
    notifyListeners();
  }

  void toggleLess(String from, String tree) {
    if (from == "Distribution") {
      statusList[0].color = false;
      for (var element in statusList) {
        if (element.levelName != "ALL") {
          element.color = true;
        }
      }
      filterCompanyLevelList[0].color = false;
      for (var element in filterCompanyLevelList) {
        if (element.levelName != "ALL") {
          element.color = true;
        }
      }
      sortDistributionList = distributionList
          .where((element) => element.tree == tree)
          .toSet()
          .toList();

      selectDistributionLevel = "ALL";
      lessBool = true;
    } else {
      incomeStatusListNew[0].color = false;

      for (var element in incomeStatusListNew) {
        if (element.levelName != "ALL") {
          element.color = true;
        }
      }
      filterCompanyLevelList[0].color = false;

      for (var element in filterCompanyLevelList) {
        if (element.levelName != "ALL") {
          element.color = true;
        }
      }

      filterIncomeList =
          userInList.where((element) => element.tree == tree).toSet().toList();

      selectIncomeLevel = "ALL";
      lessIncomeBool = true;
    }

    notifyListeners();
  }

  void toggleMore(String from, String tree) {
    if (from == "Distribution") {
      sortDistributionList = distributionList
          .where((element) => element.tree == tree)
          .toSet()
          .toList();
      selectDistributionLevel = "ALL";
      lessBool = false;
    } else {
      filterIncomeList =
          userInList.where((element) => element.tree == tree).toSet().toList();
      selectIncomeLevel = "ALL";
      lessIncomeBool = false;
    }

    notifyListeners();
  }

  treeColorChange(
    List list,
    int index,
    String select,
  ) {
    list[index].color = false;
    for (var element in list) {
      if (element.levelName != select) {
        element.color = true;
      }
    }
    notifyListeners();
  }

  filterParentsList(String tree) {
    if (tree == "MASTER_CLUB") {
      filterUpgradeParentsList = basicTreeUpgradeUsersList;
      currentTreeGrade = currentBasicGrade;
      notifyListeners();
    } else if (tree == "STAR_CLUB") {
      filterUpgradeParentsList = autoPollOneUpgradeUsersList;
      currentTreeGrade = currentAutoOneGrade;
      notifyListeners();
    } else {
      filterUpgradeParentsList = autoPollTwoUpgradeUsersList;
      currentTreeGrade = currentAutoTwoGrade;
      notifyListeners();
    }
    notifyListeners();
  }

  bool isSecondDropdownEnabled = false;

  String selectedValue = "Second";

  List<TreeListModel> partialItemList = [
    TreeListModel("STARTER", true),
    TreeListModel("VIOLET", true),
    TreeListModel("INDIGO", true),
    TreeListModel("BLUE", true),
    TreeListModel("GREEN", true),
    TreeListModel("YELLOW", true),
    TreeListModel("ORANGE", true),
    TreeListModel("RED", true),
  ];

  // List<String> treeList = [
  //   "MASTER_CLUB",
  //   "STAR_CLUB",
  //   "CROWN_CLUB",
  // ];
  String selectDistributionTree = "MASTER_CLUB";
  String selectDistributionLevel = "ALL";
  String selectIncomeTree = "MASTER_CLUB";
  String selectIncomeLevel = "ALL";

  List<TreeListModel> treeList = [
    TreeListModel("MASTER_CLUB", true),
    TreeListModel("STAR_CLUB", true),
    TreeListModel("CROWN_CLUB", true),
  ];
  List<TreeListModel> incomeTreeList = [
    TreeListModel("MASTER_CLUB", true),
    TreeListModel("STAR_CLUB", true),
    TreeListModel("CROWN_CLUB", true),
  ];
  List<TreeListModel> helpTreeList = [
    TreeListModel("MASTER_CLUB", true),
    TreeListModel("STAR_CLUB", true),
    TreeListModel("CROWN_CLUB", true),
  ];

  List<TreeListModel> statusList = [
    TreeListModel("ALL", true),
    TreeListModel("PAID", true),
    TreeListModel("PENDING", true),
    TreeListModel("PROCESSING", true),
    TreeListModel("REJECTED", true),
  ];
  List<TreeListModel> incomeStatusListNew = [
    TreeListModel("ALL", true),
    TreeListModel("PAID", true),
    TreeListModel("PENDING", true),
    TreeListModel("PROCESSING", true),
    TreeListModel("REJECTED", true),
  ];

  List<String> treeListWithoutBasicTree = [
    "STAR_CLUB",
    "CROWN_CLUB",
  ];
  List<int> childCountListNew = [0, 1, 2];

  List<TreeListModel> fullItemList = [
    TreeListModel("STARTER", true),
    TreeListModel("VIOLET", true),
    TreeListModel("INDIGO", true),
    TreeListModel("BLUE", true),
    TreeListModel("GREEN", true),
    TreeListModel("YELLOW", true),
    TreeListModel("ORANGE", true),
    TreeListModel("RED", true),
  ];

  List<CompanyTreeModel> companyBasicTreeList = [
    CompanyTreeModel("ALL", true),
    CompanyTreeModel("", true),
    CompanyTreeModel("VIOLET", true),
    CompanyTreeModel("INDIGO", true),
    CompanyTreeModel("BLUE", true),
    CompanyTreeModel("GREEN", true),
    CompanyTreeModel("YELLOW", true),
    CompanyTreeModel("ORANGE", true),
    CompanyTreeModel("RED", true),
  ];
  List<CompanyTreeModel> companyAutoPollOneTreeList = [
    CompanyTreeModel("ALL", true),
    CompanyTreeModel("", true),
    CompanyTreeModel("STAR", true),
    CompanyTreeModel("1 STAR", true),
    CompanyTreeModel("2 STAR", true),
    CompanyTreeModel("3 STAR", true),
    CompanyTreeModel("4 STAR", true),
    CompanyTreeModel("5 STAR", true),
    CompanyTreeModel("6 STAR", true),
  ];
  List<CompanyTreeModel> companyAutoPollTwoTreeList = [
    CompanyTreeModel("ALL", true),
    CompanyTreeModel("", true),
    CompanyTreeModel("SILVER", true),
    CompanyTreeModel("GOLD", true),
    CompanyTreeModel("PLATINUM", true),
    CompanyTreeModel("DIAMOND", true),
    CompanyTreeModel("ROYAL", true),
    CompanyTreeModel("CROWN", true),
  ];

  String? selectedUserTree = 'MASTER_CLUB';

  String? selectedUserGrade = 'STARTER';
  List<int> childCountList = [0, 1, 2];
  int selectedChildCountList = 0;

  incomeFilterTreeBase(String tree) {
    filterIncomeList =
        userInList.where((element) => element.tree == tree).toSet().toList();
    notifyListeners();
  }

  void filterListForDropDown(String newValue) {
    selectedValue = newValue;
    if (newValue == 'MASTER_CLUB') {
      filterCompanyLevelList = companyBasicTreeList;
    } else if (newValue == 'STAR_CLUB') {
      filterCompanyLevelList = companyAutoPollOneTreeList;
    } else {
      filterCompanyLevelList = companyAutoPollTwoTreeList;
    }
    if (filterCompanyLevelList.isNotEmpty) {
      selectedUserGrade = filterCompanyLevelList[0].toString();
    }
    notifyListeners();
  }

  setDistributionControllers() {
    lessBool = false;
    for (var element in partialItemList) {
      element.color = true;
    }
    for (var element in statusList) {
      element.color = true;
    }
    notifyListeners();
  }

  setIncomeControllers() {
    lessIncomeBool = false;
    for (var element in partialItemList) {
      element.color = true;
    }
    for (var element in statusList) {
      element.color = true;
    }
    notifyListeners();
  }

  void valueUpdate(String value) {
    selectedUserGrade = value.toString();
    notifyListeners();
  }

  void valueUpdateChildCount(int value) {
    selectedChildCountList = value;
    notifyListeners();
  }

  String donAmount = "";
  String donTime = "";

  fetchDonation(String id) {
    db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: id)
        .get()
        .then((value4) {
      if (value4.docs.isNotEmpty) {
        for (var elements in value4.docs) {
          Map<dynamic, dynamic> don = elements.data();
          if (don["TO_ID"] != null) {
            donAmount = don["AMOUNT"];
            donTime = outTimeFormat.format(don["DATE"].toDate());
            db.collection("USERS").doc(don["TO_ID"]).get().then((donateUser) {
              if (donateUser.exists) {
                Map<dynamic, dynamic> donator = donateUser.data() as Map;

                myDonationList.add(DonationModel(donator["MEMBER_ID"],
                    donator["NAME"], donator["PHONE"], donator["ItemImage"]));
              }
            });
          }
        }

        notifyListeners();
      }
    });
  }

  payPmcFromMyPmc(String memberId, String paymentType, BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: myWhite),
          );
        });

    db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: memberId)
        .where("TYPE", isEqualTo: paymentType)
        .where("STATUS", isEqualTo: "PENDING")
        .get()
        .then((pmcDonation) {
      if (pmcDonation.docs.isNotEmpty) {
        String txnID = DateTime.now().millisecondsSinceEpoch.toString() +
            generateRandomString(2);
        Map<dynamic, dynamic> don = pmcDonation.docs.first.data();
        gstCalc(double.parse(don["AMOUNT"]));
        finish(ctx);
        gatewayShowFun();
        callNext(
            PMCPaymentScreen(
                name: paymentType,
                amount: don["AMOUNT"],
                grade: don["GRADE"],
                tree: don["TREE"],
                fromId: memberId,
                distributionId: pmcDonation.docs.first.id,
                userName: userName,
                phoneNumber: userPhone,
                installment: don["INSTALLMENT"] ?? 1,
                txnID: txnID),
            ctx);

        attemptPmCmf(
            ctx,
            txnID,
            don["AMOUNT"],
            paymentType,
            don["GRADE"],
            memberId,
            don["TREE"],
            pmcDonation.docs.first.id,
            don["INSTALLMENT"] ?? 1);

        notifyListeners();
      } else {
        finish(ctx);

        const snackBar = SnackBar(
          elevation: 6.0,
          backgroundColor: myWhite,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          content: Text(
            "No Pending Payments",
            style: TextStyle(color: Colors.red),
          ),
        );
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    });
  }

  void clearFilter() {
    isSecondDropdownEnabled = false;
    selectedUserTree = "MASTER_CLUB";
    selectedUserGrade = "STARTER";
    partialItemList = fullItemList;
    notifyListeners();
  }

  List<TransactionDateModel> reportDateList = [];
  List<TransactionDateModel> historyDateList = [];
  List<PaymentReportModel> paymentReportList = [];
  List<PaymentReportModel> filterPaymentReportList = [];

  void fetchPaymentReport(String id) {
    paymentReportList.clear();
    DateTime date = DateTime.now();
    String dateFormat = "";
    String timeFormat = "";
    String todayFormat = outputDayNode.format(date).toString();
    String yesterdayFormat =
        outputDayNode.format(date.add(const Duration(days: -1))).toString();
    db
        .collection("ATTEMPTS")
        .where('FROM_USER_ID', isEqualTo: id)
        .orderBy("PAYMENT_TIME", descending: true)
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          dateFormat =
              outputDayNode.format(map["PAYMENT_TIME"].toDate()).toString();
          timeFormat =
              outputDayNode2.format(map["PAYMENT_TIME"].toDate()).toString();
          // if (dateFormat == todayFormat) {
          //   dateFormat = "Today";
          // } else if (dateFormat == yesterdayFormat) {
          //   dateFormat = "Yesterday";
          // }

          paymentReportList.add(PaymentReportModel(
            element.id,
            double.parse(map["AMOUNT"].toString()),
            map["PAYMENT_TIME"].toDate(),
            map["PAYMENT_TYPE"],
            map["PHONE_NUMBER"],
            map["PAYMENT_STATUS"],
            dateFormat,
            map["USER_NAME"],
            timeFormat,
            map["GRADE"],
            map["TREE"],
            map["INSTALLMENT"] ?? "1",
          ));
          notifyListeners();
          if (!reportDateList
              .map((item) => item.dateFormat)
              .contains(dateFormat)) {
            reportDateList.add(
                TransactionDateModel(dateFormat, map["PAYMENT_TIME"].toDate()));
          }
          reportDateList.sort((a, b) => b.date.compareTo(a.date));
          notifyListeners();
        }
        filterPaymentReportList = paymentReportList;
        notifyListeners();
      }
    });
  }

  void showCalendarDialogUser(BuildContext context, String userId) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: _userDateRangePickerController,
          initialSelectedRange: PickerDateRange(startDateUser, endDateUser),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            selectedRangeUser = args.value;
            selectedFirstDateUser =
                selectedRangeUser.startDate ?? DateTime.now();
            selectedLastDateUser = selectedRangeUser.endDate ?? DateTime.now();
          },
          onSubmit: (Object? val) {
            if (_userDateRangePickerController.selectedRange!.endDate == null) {
              selectedFirstDateUser =
                  _userDateRangePickerController.selectedRange!.startDate!;
              selectedFirstDateUser = selectedFirstDateUser.subtract(Duration(
                hours: selectedFirstDateUser.hour,
                minutes: selectedFirstDateUser.minute,
                seconds: selectedFirstDateUser.second,
                microseconds: selectedFirstDateUser.microsecond,
                milliseconds: selectedFirstDateUser.millisecond,
              ));
              selectedLastDateUser =
                  selectedFirstDateUser.add(const Duration(days: 1));
              notifyListeners();
              getFilteredList(userId);
              finish(context);
            } else {
              selectedFirstDateUser =
                  _userDateRangePickerController.selectedRange!.startDate!;
              selectedLastDateUser =
                  _userDateRangePickerController.selectedRange!.endDate!;
              selectedLastDateUser = selectedLastDateUser.add(const Duration(
                days: 1,
              ));
              selectedLastDateUser = selectedLastDateUser.subtract(Duration(
                hours: selectedFirstDateUser.hour,
                minutes: selectedFirstDateUser.minute,
                seconds: selectedFirstDateUser.second,
                microseconds: selectedFirstDateUser.microsecond,
                milliseconds: selectedFirstDateUser.millisecond,
              ));
              selectedFirstDateUser = selectedFirstDateUser.subtract(Duration(
                hours: selectedFirstDateUser.hour,
                minutes: selectedFirstDateUser.minute,
                seconds: selectedFirstDateUser.second,
                microseconds: selectedFirstDateUser.microsecond,
                milliseconds: selectedFirstDateUser.millisecond,
              ));
              notifyListeners();
              getFilteredList(userId);
              finish(context);
            }
          },
          onCancel: () {
            // _userDateRangePickerController.selectedRange = null;
            // _userDateRangePickerController.selectedDate = null;
            showSelectedDateUser = '';
            notifyListeners();
            finish(context);
          },
        ),
      );
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            // title: Container(
            //     child: Text('Printers', style: TextStyle(color: my_white))),
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  void getFilteredList(String userId) {
    if (selectedFirstDateUser == null || selectedLastDateUser == null) {
    } else {
      filterUserHelpLedgerList = userHelpLedgerList
          .where((element) =>
              element.newDate.isAfter(selectedFirstDateUser) &&
              element.newDate.isBefore(selectedLastDateUser))
          .toSet()
          .toList();
      filterUserHelpReceiveList = filterUserHelpLedgerList
          .where((element) => element.toAmount != "-")
          .toSet()
          .toList();
      totalHelpReceivedAmount = filterUserHelpReceiveList.fold(
          0,
          (previousValue, element) =>
              previousValue + double.parse(element.amount));
      filterUserGiveHelpList = filterUserHelpLedgerList
          .where((element) => element.fromAmount != "-")
          .toSet()
          .toList();
      totalGiveHelpAmount = filterUserGiveHelpList.fold(
          0,
          (previousValue, element) =>
              previousValue + double.parse(element.amount));
      notifyListeners();
    }
  }

  // List filterUserHelpLedgerSearchList = [];

  void filteruserHelpLedgerSeach(String item) {
    filterUserHelpLedgerList = userHelpLedgerList
        .where((a) =>
            a.name.toLowerCase().contains(item.toLowerCase()) ||
            a.amount.toLowerCase().contains(item.toLowerCase()) ||
            a.grade.toLowerCase().contains(item.toLowerCase()) ||
            a.number.toLowerCase().contains(item.toLowerCase()) ||
            a.status.toLowerCase().contains(item.toLowerCase()) ||
            a.fromUserId.toLowerCase().contains(item.toLowerCase()) ||
            a.toAmount.toLowerCase().contains(item.toLowerCase()))
        .toList();
    filterUserHelpReceiveList = filterUserHelpLedgerList
        .where((element) => element.toAmount != "-")
        .toSet()
        .toList();
    totalHelpReceivedAmount = filterUserHelpReceiveList.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element.amount));
    filterUserGiveHelpList = filterUserHelpLedgerList
        .where((element) => element.fromAmount != "-")
        .toSet()
        .toList();
    totalGiveHelpAmount = filterUserGiveHelpList.fold(
        0,
        (previousValue, element) =>
            previousValue + double.parse(element.amount));
    notifyListeners();
  }

  void filteruserPaymentReportSeach(String item) {
    filterPaymentReportList = paymentReportList
        .where((a) =>
            a.tree.toLowerCase().contains(item.toLowerCase()) ||
            a.grade.toLowerCase().contains(item.toLowerCase()) ||
            a.paymentType.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  List<UserNotificationModel> notificationList = [];
  List<UserLatestNotificationDateModel> notificationDateonlyList = [];
  List<TransactionDateModel> tranactionDateList = [];

  int notificationLength = 0;
  bool haveNotification = false;
  StreamSubscription? _streamNotifications;

  Future<void> fetchFirstNotification(String memberId) async {
    if (_streamNotifications != null) {
      _streamNotifications!.cancel();
    }
    notificationList.clear();
    tranactionDateList.clear();
    String transactionDateFormat = '';
    notificationLength = 0;
    List<dynamic> newNotList = [];
    haveNotification = false;
    QuerySnapshot querySnapshot = await db
        .collection("NOTIFICATIONS")
        .where("TO_ID", arrayContains: memberId)
        .get();
    notificationLength = querySnapshot.size;
    notifyListeners();

    _streamNotifications = db
        .collection("NOTIFICATIONS")
        .where("TO_ID", arrayContains: memberId)
        .orderBy("REG_DATE", descending: true)
        .limit(limit)
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        notificationList.clear();
        tranactionDateList.clear();
        haveNotification = false;
        for (var element in value.docs) {
          Map<dynamic, dynamic> notMap = element.data();
          newNotList.clear();
          newNotList = notMap["VIEWERS"] ?? [];
          if (!newNotList.contains(memberId)) {
            haveNotification = true;
            notifyListeners();
          }
          transactionDateFormat =
              outputDayNode.format(notMap["REG_DATE"].toDate()).toString();
          notificationList.add(UserNotificationModel(
              element.id,
              notMap["CONTENT"] ?? '',
              notMap["DATE"] ?? "",
              notMap["FROM_ID"] ?? '',
              notMap["NOTIFICATION_ID"] ?? '',
              notMap["REG_DATE"].toDate(),
              notMap["TIME"] ?? '',
              notMap["NAME"] ?? '',
              notMap["NUMBER"] ?? '',
              '',
              transactionDateFormat));
          if (!tranactionDateList
              .map((item) => item.dateFormat)
              .contains(transactionDateFormat)) {
            tranactionDateList.add(TransactionDateModel(
                transactionDateFormat, element["REG_DATE"].toDate()));
          }
          tranactionDateList.sort((a, b) => b.date.compareTo(a.date));
          notifyListeners();
        }
      }
    });
  }

  Future<void> fetchNotification(String memberId,
      [dynamic lastDoc = false]) async {
    String transactionDateFormat = '';
    // notificationLength=0;
    var collectionRef;
    List<dynamic> newNotList = [];
    haveNotification = false;
    // QuerySnapshot querySnapshot = await db.collection("NOTIFICATIONS").where("TO_ID", arrayContains: memberId).get();
    // notificationLength=querySnapshot.size;
    // notifyListeners();
    collectionRef = db
        .collection("NOTIFICATIONS")
        .where("TO_ID", arrayContains: memberId)
        .orderBy("REG_DATE", descending: true)
        .startAfter([lastDoc]).limit(limit);
    collectionRef.get().then((value) {
      if (value.docs.isNotEmpty) {
        haveNotification = false;
        for (var element in value.docs) {
          Map<dynamic, dynamic> notMap = element.data();
          newNotList.clear();
          newNotList = notMap["VIEWERS"] ?? [];
          if (!newNotList.contains(memberId)) {
            haveNotification = true;
            notifyListeners();
          }
          transactionDateFormat =
              outputDayNode.format(notMap["REG_DATE"].toDate()).toString();
          notificationList.add(UserNotificationModel(
              element.id,
              notMap["CONTENT"] ?? '',
              notMap["DATE"] ?? "",
              notMap["FROM_ID"] ?? '',
              notMap["NOTIFICATION_ID"] ?? '',
              notMap["REG_DATE"].toDate(),
              notMap["TIME"] ?? '',
              notMap["NAME"] ?? '',
              notMap["NUMBER"] ?? '',
              '',
              transactionDateFormat));
          if (!tranactionDateList
              .map((item) => item.dateFormat)
              .contains(transactionDateFormat)) {
            tranactionDateList.add(TransactionDateModel(
                transactionDateFormat, element["REG_DATE"].toDate()));
          }
          tranactionDateList.sort((a, b) => b.date.compareTo(a.date));
          notifyListeners();
        }
      }
    });
  }

  addNotToViewers(String memberId) {
    db
        .collection("NOTIFICATIONS")
        .where("TO_ID", arrayContains: memberId)
        .where("VIEWERS", whereNotIn: [
          [memberId]
        ])
        .get()
        .then((newValue) {
          if (newValue.docs.isNotEmpty) {
            for (var elements in newValue.docs) {
              Map<dynamic, dynamic> viewersMap = elements.data();
              List<dynamic> viewersList = viewersMap["VIEWERS"] ?? [];
              viewersList.add(memberId);
              db
                  .collection("NOTIFICATIONS")
                  .doc(elements.id)
                  .set({"VIEWERS": viewersList}, SetOptions(merge: true));
            }
          }
        });
  }

  double amount = 0;
  double fullgst = 0;
  double gst = 0;

  void gstCalc(double totalAmount) {
    amount = totalAmount / 1.18;
    fullgst = totalAmount - amount;
    gst = fullgst / 2;

    notifyListeners();
  }

  void getUsersTree(String userId) {
    db.collection("USERS").doc(userId).get().then((userValue) {
      Map<dynamic, dynamic> userMap = userValue.data() as Map;
      if (userMap["CHILD_COUNT"] != 0 || userMap["CHILD_COUNT"] != null) {
        db
            .collection("USERS")
            .where("DIRECT_PARENT_ID", isEqualTo: userId)
            .get()
            .then((child1Value) {});
      }
    });
  }

  TextEditingController userMessageHeadingTEC = TextEditingController();
  TextEditingController userMessageContentTEC = TextEditingController();
  TextEditingController userMessageLinkTEC = TextEditingController();

  void userToChildrenSendMessage() {
    HashMap<String, Object> sentMessage = HashMap();
    sentMessage["HEADING"] = userMessageHeadingTEC.text;
    sentMessage["CONTENT"] = userMessageContentTEC.text;
    sentMessage["LINK"] = userMessageLinkTEC.text;
    db.collection("").doc().set(sentMessage, SetOptions(merge: true));
  }

  Reference ref9 = FirebaseStorage.instance.ref("PROOF_IMAGE");

  Future<void> userExchangeRequest(
      BuildContext context,
      String reId,
      File? fileImage,
      TextEditingController fromText,
      TextEditingController toText,
      TextEditingController otherReason,
      String reason) async {
    HashMap<String, Object> exchangeReq = HashMap();
    String categoryId = DateTime.now().millisecondsSinceEpoch.toString();
    exchangeReq["REQUEST_TIME"] = DateTime.now();
    exchangeReq["REQUEST_ID"] = reId;
    exchangeReq["REQUEST_NAME"] = userName;
    exchangeReq["REQUEST_PHONE"] = userPhone;
    exchangeReq["FROM_ID"] = fromText.text;
    exchangeReq["TO_ID"] = toText.text;
    exchangeReq["STATUS"] = "REQUESTED";
    exchangeReq["EXCHANGE_TYPE"] = "LEADER";
    exchangeReq["EXCHANGE_TIME"] = DateTime.now();
    exchangeReq["EXCHANGE_ADMIN_ID"] = "";
    exchangeReq["EXCHANGE_ADMIN_NAME"] = "";
    exchangeReq["EXCHANGE_ADMIN_PHONE"] = "";

    if (otherReason.text == "") {
      exchangeReq["REASON"] = reason;
    } else {
      exchangeReq["REASON"] = otherReason.text;
    }
    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref9 = FirebaseStorage.instance.ref().child(time);
      await ref9.putFile(fileImage!).whenComplete(() async {
        await ref9.getDownloadURL().then((value3) {
          exchangeReq['PROOF_IMAGE'] = value3;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      exchangeReq['PROOF_IMAGE'] = "";
    }
    db
        .collection("EXCHANGE_USERS")
        .doc(categoryId)
        .set(exchangeReq, SetOptions(merge: true));

    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    adminProvider.clearAllExchangeControllers();

    notifyListeners();
  }

  void addMessageViewers(String memberId) {
    db
        .collection("MESSAGES")
        .where("TO_ID_LIST", arrayContains: memberId)
        .where("VIEWERS", whereNotIn: [
          [memberId]
        ])
        .get()
        .then((newValue) {
          if (newValue.docs.isNotEmpty) {
            for (var elements in newValue.docs) {
              Map<dynamic, dynamic> viewersMap = elements.data();
              List<dynamic> viewersList = viewersMap["VIEWERS"] ?? [];
              viewersList.add(memberId);
              db
                  .collection("MESSAGES")
                  .doc(elements.id)
                  .set({"VIEWERS": viewersList}, SetOptions(merge: true));
            }
          }
        });
    notifyListeners();
  }

  bool youHaveMessage = false;
  String sendMessTree = "";
  int sendMesschildCount = 0;

  assignToIdList() {
    if (isSelectedTree) {
      if (isSelectedLevel) {
        if (isSelectedChild) {
          if (isSelectedAutoPoll) {
            filterSendMesssFilterList = sendMesssFilterList
                .where((element) =>
                    element.grade == selLevel &&
                    element.childCount == sendMesschildCount &&
                    element.treeList.contains(selTree))
                .toSet()
                .toList();
            notifyListeners();
          } else {
            filterSendMesssFilterList = sendMesssFilterList
                .where((element) =>
                    element.grade == selLevel &&
                    element.childCount == sendMesschildCount)
                .toSet()
                .toList();
            notifyListeners();
          }
        } else {
          if (isSelectedAutoPoll) {
            filterSendMesssFilterList = sendMesssFilterList
                .where((element) =>
                    element.grade == selLevel &&
                    element.treeList.contains(selTree))
                .toSet()
                .toList();
            notifyListeners();
          } else {
            filterSendMesssFilterList = sendMesssFilterList
                .where((element) => element.grade == selLevel)
                .toSet()
                .toList();
            notifyListeners();
          }
        }
      } else {
        if (isSelectedChild) {
          if (isSelectedAutoPoll) {
            filterSendMesssFilterList = sendMesssFilterList
                .where((element) =>
                    element.childCount == sendMesschildCount &&
                    element.treeList.contains(selTree))
                .toSet()
                .toList();
            notifyListeners();
          } else {
            filterSendMesssFilterList = sendMesssFilterList
                .where((element) => element.childCount == sendMesschildCount)
                .toSet()
                .toList();
            notifyListeners();
          }
        } else {
          if (isSelectedAutoPoll) {
            filterSendMesssFilterList = sendMesssFilterList
                .where((element) => element.treeList.contains(selTree))
                .toSet()
                .toList();
            notifyListeners();
          } else {
            filterSendMesssFilterList = sendMesssFilterList;
            notifyListeners();
          }
        }
      }
    } else {
      filterSendMesssFilterList = allBasicChildrenListForMessage;
      notifyListeners();
    }
  }

  Future<void> userMessageSend(String memberId, String memberDocID,
      String userName, BuildContext context, List<String> newList) async {
    List<String> toIdList = [];

    toIdList = filterSendMesssFilterList.map((e) => e.userId).toSet().toList();
    notifyListeners();

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });

    String categoryId = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, Object> dataMapp = HashMap();
    dataMapp["MESSAGES"] = messageController.text;
    if (MessageFileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref3 = FirebaseStorage.instance.ref().child(time);
      await ref3.putFile(MessageFileImage!).whenComplete(() async {
        await ref3.getDownloadURL().then((value3) {
          dataMapp["MESSAGE_IMAGE"] = value3;
          notifyListeners();
        });
      });
    }
    dataMapp["LINK"] = messagePasteLinkController.text;
    dataMapp["FROM_ID"] = memberId;
    dataMapp["FROM_NAME"] = userName;
    dataMapp["FROM_MEMBER_DOC_ID"] = memberDocID;
    dataMapp["ADDED_TIME"] = DateTime.now();
    dataMapp["DOC_ID"] = categoryId;
    dataMapp["TO_ID_LIST"] = toIdList;
    dataMapp["VIEWERS"] = [];

    db
        .collection("MESSAGES")
        .doc(categoryId)
        .set(dataMapp, SetOptions(merge: true));
    // getMessages(registerDocID);
    getSendedMessage(memberId);
    clearMessageFileds(context);

    Navigator.pop(
      context,
      MaterialPageRoute(
          builder: (context) => MessageSendRecieve(
              memberID: memberId,
              registerDocID: registerDocID,
              userName: userName)),
    );
    finish(context);
    notifyListeners();
  }

  List<GetMessageModel> getMessageList = [];
  List<GetMessageModel> getSendMessage = [];
  List<MessageDateModel> messageDateList = [];
  List<MessageDateModel> getMessageDateList = [];
  List<ChildrenListModel> allBasicChildrenListForMessage = [];
  List<ChildrenListModel> allAutoOneChildrenListForMessage = [];
  List<ChildrenListModel> allAutoTwoChildrenListForMessage = [];
  List<ChildrenListModel> filterAllBasicChildrenListForMessage = [];
  List<ChildrenListModel> filterAllAutoOneChildrenListForMessage = [];
  List<ChildrenListModel> filterAllAutoTwoChildrenListForMessage = [];
  List<String> newFilterAllChildrenListForMessage = [];

  Future<void> getChildForMessage(String memberId, String memberDocID,
      String userName, BuildContext context) async {
    allBasicChildrenListForMessage.clear();
    filterAllBasicChildrenListForMessage.clear();
    allAutoOneChildrenListForMessage.clear();
    filterAllAutoOneChildrenListForMessage.clear();
    allAutoTwoChildrenListForMessage.clear();
    filterAllAutoTwoChildrenListForMessage.clear();
    await db
        .collection('MASTER_CLUB')
        .where("PARENTS", arrayContains: memberDocID)
        .get()
        .then((childrenValue) async {
      if (childrenValue.docs.isNotEmpty) {
        allBasicChildrenListForMessage.clear();
        filterAllBasicChildrenListForMessage.clear();
        for (var element in childrenValue.docs) {
          Map<dynamic, dynamic> childrenMap = element.data();
          allBasicChildrenListForMessage.add(ChildrenListModel(
            childrenMap["MEMBER_ID"] ?? "",
            childrenMap["DOCUMENT_ID"] ?? "",
            childrenMap["NAME"],
            childrenMap["PHONE"],
            "MASTER_CLUB",
            childrenMap["CHILD_COUNT"] ?? 0,
            childrenMap["TREES"] ?? [],
            childrenMap["GRADE"],
          ));
          filterAllBasicChildrenListForMessage = allBasicChildrenListForMessage;
          notifyListeners();
        }
        notifyListeners();
        await db
            .collection('STAR_CLUB')
            .where("PARENTS", arrayContains: memberDocID)
            .get()
            .then((childrenValue) {
          if (childrenValue.docs.isNotEmpty) {
            allAutoOneChildrenListForMessage.clear();
            filterAllAutoOneChildrenListForMessage.clear();
            for (var element in childrenValue.docs) {
              Map<dynamic, dynamic> childrenMap = element.data();
              allAutoOneChildrenListForMessage.add(ChildrenListModel(
                childrenMap["MEMBER_ID"] ?? "",
                childrenMap["DOCUMENT_ID"] ?? "",
                childrenMap["NAME"],
                childrenMap["PHONE"],
                "STAR_CLUB",
                childrenMap["CHILD_COUNT"] ?? 0,
                childrenMap["TREES"] ?? [],
                childrenMap["GRADE"],
              ));
              filterAllAutoOneChildrenListForMessage =
                  allAutoOneChildrenListForMessage;
              notifyListeners();
            }
          }
        });
        notifyListeners();
        await db
            .collection('CROWN_CLUB')
            .where("PARENTS", arrayContains: memberDocID)
            .get()
            .then((childrenValue) {
          if (childrenValue.docs.isNotEmpty) {
            allAutoTwoChildrenListForMessage.clear();
            filterAllAutoTwoChildrenListForMessage.clear();
            for (var element in childrenValue.docs) {
              Map<dynamic, dynamic> childrenMap = element.data();
              allAutoTwoChildrenListForMessage.add(ChildrenListModel(
                childrenMap["MEMBER_ID"] ?? "",
                childrenMap["DOCUMENT_ID"] ?? "",
                childrenMap["NAME"],
                childrenMap["PHONE"],
                "CROWN_CLUB",
                childrenMap["CHILD_COUNT"] ?? 0,
                childrenMap["TREES"] ?? [],
                childrenMap["GRADE"],
              ));
              filterAllAutoTwoChildrenListForMessage =
                  allAutoTwoChildrenListForMessage;
              notifyListeners();
            }
          }
        });
        notifyListeners();

        filterSelect = false;
        ToDocIdsList.clear();
        sendMessTree = "MASTER_CLUB";
        messageController.clear();
        messagePasteLinkController.clear();
        MessageFileImage = null;

        callNext(
            MessageScreen(
              memberId: memberId,
              memberDocID: memberDocID,
              userName: userName,
            ),
            context);
      } else {
        final snackBar = SnackBar(
          backgroundColor: myWhite,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(79),
          ),
          behavior: SnackBarBehavior.floating,
          content: const Text(
            "You Have No Children",
            style: TextStyle(color: Colors.red),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });

    notifyListeners();
    // userMessageSend(memberId, memberDocID, userName, context,allChildrenListForMessage);
  }

  StreamSubscription? _streamMessages;

  void getMessages(String docID) {
    List<dynamic> newNotList = [];

    String dateFormat = "";
    String time = "";
    if (_streamMessages != null) {
      _streamMessages!.cancel();
    }
    getMessageList.clear();
    messageDateList.clear();

    _streamMessages = db
        .collection("MESSAGES")
        .where("TO_ID_LIST", arrayContains: docID)
        .snapshots()
        .listen((value) {
      if (value.docs.isNotEmpty) {
        youHaveMessage = false;
        getMessageList.clear();
        messageDateList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          newNotList.clear();
          newNotList = map["VIEWERS"] ?? [];
          if (!newNotList.contains(docID)) {
            youHaveMessage = true;
            notifyListeners();
          }
          dateFormat =
              outputDayNode.format(map["ADDED_TIME"].toDate()).toString();
          time = outTimeFormat.format(map["ADDED_TIME"].toDate());
          getMessageList.add(GetMessageModel(
            map["MESSAGES"],
            map["MESSAGE_IMAGE"] ?? '',
            map["LINK"] ?? '',
            map["FROM_ID"],
            map["FROM_NAME"],
            map["FROM_MEMBERDOC_ID"] ?? '',
            time,
            dateFormat,
            false,
            map["DOC_ID"],
          ));
          notifyListeners();
          if (!messageDateList
              .map((item) => item.dateFormat)
              .contains(dateFormat)) {
            messageDateList.add(
              MessageDateModel(dateFormat, map["ADDED_TIME"].toDate()),
            );
            messageDateList.sort((a, b) => b.date.compareTo(a.date));
            notifyListeners();

            ///edit
          }
        }
      }
      notifyListeners();
    });
  }

  void getSendedMessage(String memberID) {
    String dateFormat = "";
    String time = "";
    getSendMessage.clear();
    db
        .collection("MESSAGES")
        .where("FROM_ID", isEqualTo: memberID)
        .get()
        .then((userValue) {
      if (userValue.docs.isNotEmpty) {
        getSendMessage.clear();
        getMessageDateList.clear();
        for (var element in userValue.docs) {
          Map<dynamic, dynamic> map = element.data();
          dateFormat =
              outputDayNode.format(map["ADDED_TIME"].toDate()).toString();
          time = outTimeFormat.format(map["ADDED_TIME"].toDate());
          getSendMessage.add(GetMessageModel(
            map["MESSAGES"],
            map["MESSAGE_IMAGE"] ?? '',
            map["LINK"] ?? '',
            map["FROM_ID"],
            map["FROM_NAME"],
            map["FROM_MEMBER_DOC_ID"],
            time,
            dateFormat,
            false,
            map["DOC_ID"],
          ));
          notifyListeners();
          if (!getMessageDateList
              .map((item) => item.dateFormat)
              .contains(dateFormat)) {
            getMessageDateList.add(
              MessageDateModel(dateFormat, map["ADDED_TIME"].toDate()),
            );
            print(getMessageDateList.map((e) => e.dateFormat));
            getMessageDateList.sort((a, b) => b.date.compareTo(a.date));
            notifyListeners();

            ///edit
          }
        }
      }
      notifyListeners();
    });
  }

  void clearMessageFileds(BuildContext context) {
    messageController.clear();
    MessageFileImage = null;
    messagePasteLinkController.clear();
  }

  void moreClicked(String id) {
    int index = getMessageList.indexWhere((element) => element.docID == id);
    if (getMessageList[index].isMoreClicked) {
      getMessageList[index].isMoreClicked = false;
    } else {
      getMessageList[index].isMoreClicked = true;
    }

    notifyListeners();
  }

  void moreClickedFromSend(String id) {
    int index = getSendMessage.indexWhere((element) => element.docID == id);
    if (getSendMessage[index].isMoreClicked) {
      getSendMessage[index].isMoreClicked = false;
    } else {
      getSendMessage[index].isMoreClicked = true;
    }

    notifyListeners();
  }

  deleteMessageAlert(BuildContext context, String id) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: Colors.transparent,
        scrollable: true,
        content: Container(
          // height: height*0.26,
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFEBEBEB),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(26),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x1C000000),
                blurRadius: 11,
                offset: Offset(0, 9),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'You Want to Delete ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF252525),
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        width: 62,
                        height: 62,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(16),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFEBEBEB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(102),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x1C000000),
                              blurRadius: 11,
                              offset: Offset(0, 9),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Image.asset("assets/dlt.png")),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            finish(context);
                          },
                          child: Container(
                            width: 120,
                            height: 39,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFFFFCF8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(62),
                              ),
                            ),
                            child: const Text(
                              'Cancel',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF252525),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            messageDelete(id, context);
                          },
                          child: Container(
                            width: 120,
                            height: 39,
                            alignment: Alignment.center,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2F7DC1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(62),
                              ),
                            ),
                            child: const Text(
                              "Delete",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFFFFCF8),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void messageDelete(String id, BuildContext context) {
    db.collection('MESSAGES').doc(id).delete();
    getSendedMessage(registerID);
    getMessageDateList.clear();
    finish(context);
    notifyListeners();
  }

  bool isOpenedFilter = false;

  void filterOpened() {
    if (isOpenedFilter) {
      isOpenedFilter = false;
    } else {
      isOpenedFilter = true;
    }
    isSecondDropdownEnabled = false;
    notifyListeners();
  }

  void secondDropDownOpened() {
    if (isSecondDropdownEnabled) {
      isSecondDropdownEnabled = false;
    } else {
      isSecondDropdownEnabled = true;
    }
    notifyListeners();
  }

  // void filterForTreeMessage(String tree) {
  //   print("treedsfsdfsdf");
  //   filterAllChildrenListForMessage = allChildrenListForMessage
  //       .where((element) =>
  //       element.treeList.any((item) => item.toLowerCase().contains(tree.toLowerCase()))).toList();
  //   print(filterAllChildrenListForMessage.map((e) => e.userName).toString()+'filterAllChildrenListForMessage');
  //   notifyListeners();
  // }
  //
  //
  // void filterForLevelMessage(String grade) {
  //   print(grade);
  //   filterAllChildrenListForMessage = allChildrenListForMessage
  //       .where((element) =>
  //       element.grade.toLowerCase().contains(grade.toLowerCase()))
  //       .toList();
  //   print(filterAllChildrenListForMessage.map((e) => e.userName).toString()+'filterAllChildrenListForMessage');
  //
  //   notifyListeners();
  // }
  // void filterForchildCount(int count) {
  //   filterAllChildrenListForMessage = allChildrenListForMessage
  //       .where((element) =>
  //       element.childCount.toString().toLowerCase().contains(count.toString().toLowerCase()))
  //       .toList();
  //   print(filterAllChildrenListForMessage.map((e) => e.userName).toString()+'filterAllChildrenListForMessage');
  //
  //   notifyListeners();
  // }

  List<String> ToDocIdsList = [];
  List<ChildrenListModel> levelFilterList = [];

  void filterForSendMessage(String level) {
    ToDocIdsList.clear();

    levelFilterList = sendMesssFilterList
        .where((element) =>
            element.grade.toLowerCase().contains(level.toLowerCase()))
        .toList();

    // Extract the userName values to ToDocIdsList
    // ToDocIdsList = filterAllBasicChildrenListForMessage.map((e) => e.userName).toList();
    notifyListeners();
  }

  bool isSelectedTree = false;
  bool isSelectedLevel = false;
  bool isSelectedChild = false;
  bool isSelectedAutoPoll = false;
  bool filterSelect = false;

  void isSelectedTreeF(bool value) {
    if (isSelectedTree) {
      isSelectedTree = false;
    } else {
      isSelectedTree = true;
    }
    sendMesssFilterList = allBasicChildrenListForMessage;
    notifyListeners();
  }

  void isSelectedLevelF(bool value) {
    if (isSelectedLevel) {
      isSelectedLevel = false;
    } else {
      isSelectedLevel = true;
    }
    selLevel = "STARTER";

    notifyListeners();
  }

  void isSelectedChildF(bool value) {
    if (isSelectedChild) {
      isSelectedChild = false;
    } else {
      isSelectedChild = true;
    }
    selectedIndex1 = 0;

    notifyListeners();
  }

  void isSelectedAutoPollF(bool value) {
    if (isSelectedAutoPoll) {
      isSelectedAutoPoll = false;
    } else {
      isSelectedAutoPoll = true;
    }
    selectedIndex2 = 0;

    notifyListeners();
  }

  void isSelectedFilter() {
    if (filterSelect) {
      filterSelect = false;
    } else {
      filterSelect = true;
    }
    notifyListeners();
  }

  void clearBoolFun() {
    isSelectedTree = false;
    isSelectedLevel = false;
    isSelectedChild = false;
    isSelectedAutoPoll = false;
    selectedIndex2 = -1;

    notifyListeners();
  }

  int selectedIndex2 = -1;
  String selTree = 'MASTER_CLUB';

  void isColorChanged(int index, String selected) {
    selectedIndex2 = index;
    selTree = selected;
    notifyListeners();
  }

  List<ChildrenListModel> sendMesssFilterList = [];
  List<ChildrenListModel> filterSendMesssFilterList = [];
  int selectedIndex = 0;

  void containerColorChange(int index) {
    selectedIndex = index;
    if (index == 0) {
      sendMesssFilterList = allBasicChildrenListForMessage;
    } else if (index == 1) {
      sendMesssFilterList = allAutoOneChildrenListForMessage;
    } else {
      sendMesssFilterList = allAutoTwoChildrenListForMessage;
    }
    notifyListeners();
  }

  int selectedIndex1 = -1;

  void containerColorChange1(int index) {
    selectedIndex1 = index;
    sendMesschildCount = index;
    notifyListeners();
  }

  String selLevel = "STARTER";

  void levelSelectionSendMess(String lev) {
    selLevel = lev;
    notifyListeners();
  }

  finishFaz(BuildContext context) {
    Navigator.pop(context);
  }

  logOutAlert(BuildContext context, bool adminLeader) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(0),
        backgroundColor: cl00369F,
        scrollable: true,
        content: Container(
          // height: height*0.26,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment(0.92, -0.40),
              end: Alignment(-0.92, 0.4),
              colors: [
                Color(0xFF2FC1BC),
                Color(0xFF2F7DC1),
              ],
            ),
          ),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Are you sure",
                      style: TextStyle(
                          color: myWhite,
                          fontFamily: 'PoppinsMedium',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const Text(
                      "want to log out?",
                      style: TextStyle(
                          color: myWhite,
                          fontFamily: 'PoppinsMedium',
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 62,
                      height: 62,
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment(0.92, -0.40),
                          end: Alignment(-0.92, 0.4),
                          colors: [
                            Color(0xFF2FC1BC),
                            Color(0xFF2F7DC1),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(102),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x1C000000),
                            blurRadius: 11,
                            offset: Offset(0, 9),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Center(
                          child: Icon(
                        Icons.logout,
                        color: myWhite,
                      )),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              finish(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 120,
                              height: 39,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFF2FC1BC),
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 1.0,
                                    ),
                                  ],
                                  color: const Color(0xFF2F7DC1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text('Cancel',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontFamily: "PoppinsMedium")),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (adminLeader) {
                                print("dtrertytregfvhbjnk");
                                LoginProvider loginProvider =
                                    Provider.of<LoginProvider>(context,
                                        listen: false);
                                loginProvider.userLoginPhoneCT.clear();
                                loginProvider.userLoginPasswordCT.clear();
                                await clearOnRegistration();
                                await clearStreamSubscriptions();

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.clear();

                                finish(context);

                                callNextReplacement(Admin_Login(), context);
                              } else {
                                if (!payckagebool) {
                                  // await cancelStreams();

                                  bottomSelectedIndex.value = 0;
                                  await clearOnRegistration();
                                  await clearStreamSubscriptions();
                                  // FirebaseAuth auth = FirebaseAuth.instance;
                                  // auth.signOut();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();

                                  finish(context);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen(
                                                referralId: '',
                                              )),
                                      (Route<dynamic> route) => false);
                                  // callNextReplacement(
                                  //     LoginScreen(
                                  //       referralId: '',
                                  //     ),
                                  //     context);
                                } else {
                                  // await cancelStreams();

                                  bottomSelectedIndex.value = 0;
                                  await clearOnRegistration();
                                  await clearStreamSubscriptions();
                                  // FirebaseAuth auth = FirebaseAuth.instance;
                                  // auth.signOut();
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  prefs.clear();

                                  finish(context);
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AdminFixedLogin()),
                                      (Route<dynamic> route) => false);
                                  // callNextReplacement(
                                  //     LoginScreen(
                                  //       referralId: '',
                                  //     ),
                                  //     context);
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 120,
                              height: 39,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Text(
                                'Log out',
                                style: TextStyle(
                                    color: Color(0xFF2F7DC1),
                                    fontSize: 16,
                                    fontFamily: "PoppinsMedium"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

// List<NewDistributionScreen>upgradeList=[];

  fetchDistributionsNEW(
    String memberId,
    String grade,
    String tree,
  ) {
    if (_streamDirectDistributions != null) {
      _streamDirectDistributions!.cancel();
    }

    clearDistributions();
    sortDistributionList.clear();
    distributionList.clear();
    homeDistributionList.clear();
    pmcDistributionList.clear();

    _streamDirectDistributions = db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: memberId)
        .snapshots()
        .listen((transactionEvent) async {
      isFirstTime = false;
      if (transactionEvent.docs.isNotEmpty) {
        distributionList.clear();
        sortDistributionList.clear();
        homeDistributionList.clear();

        for (var elements in transactionEvent.docs) {
          Map<dynamic, dynamic> distribute = elements.data();
          if (distribute["TYPE"] == "CMF" || distribute["TYPE"] == "PMC") {
            distributionList.add(DistributionModel(
                distribute["AMOUNT"].toString(),
                "",
                elements.id,
                "",
                distribute["TYPE"].toString(),
                distribute["STATUS"].toString(),
                "",
                distribute["GRADE"].toString(),
                "",
                distribute["TREE"].toString(),
                "",
                "",
                "",
                "",
                distribute["FROM_ID"].toString(),
                "",
                0));
            distributionList = removeDistributionDuplicate(distributionList);

            homeDistributionList = distributionList
                .where((item) =>
                    item.type == 'PMC' ||
                    item.type == 'CMF' && item.status != 'PAID')
                .toSet()
                .toList();
            // sortDistributionList= distributionList.where((element) => element.status!="PAID").toSet().toList();
            totalPmcList
                .add(PrivilegeModel(distribute["GRADE"].toString(), false));
            totalPmcList = removePmcDuplicate(totalPmcList);
            notifyListeners();
          } else {
            db
                .collection("USERS")
                .doc(distribute["TO_ID"])
                .get()
                .then((userValue) {
              Map<dynamic, dynamic> userMap = userValue.data() as Map;
              distributionList.add(DistributionModel(
                  distribute["AMOUNT"].toString(),
                  distribute["TO_ID"].toString(),
                  elements.id,
                  distribute["SCREENSHOT"].toString(),
                  distribute["TYPE"].toString(),
                  distribute["STATUS"].toString(),
                  userMap["STATUS"].toString(),
                  distribute["GRADE"].toString(),
                  userMap["DOCUMENT_ID"].toString(),
                  distribute["TREE"].toString(),
                  userMap["ItemImage"] ?? "",
                  userMap["NAME"].toString(),
                  userMap["PHONE"].toString(),
                  userMap["UPI_Id"].toString(),
                  distribute["FROM_ID"].toString(),
                  "",
                  0));
              distributionList = removeDistributionDuplicate(distributionList);
              homeDistributionList = distributionList
                  .where((item) => item.status != "PAID")
                  .take(2)
                  .toSet()
                  .toList();
              sortDistributionList = distributionList
                  .where((element) => element.status != "PAID")
                  .toSet()
                  .toList();

              notifyListeners();
            });
          }
          // if (distribute["TYPE"] == "HELP") {
          //   if(_streamHelpDistributions!=null) {
          //     _streamHelpDistributions!.cancel();
          //   }
          //   _streamHelpDistributions = db.collection("USERS")
          //       .doc(distribute["TO_ID"])
          //       .snapshots()
          //       .listen((userValue) {
          //     if (userValue.exists) {
          //       userUpgradeBool=true;
          //       Map<dynamic, dynamic> userMap = userValue.data() as Map;
          //
          //       // upgradeList.add(re
          //       //     NewDistributionModel(
          //       //     amount, toId, distributionId,
          //       //     screenShot, type, status, grade, tree,
          //       //     proImage, name, phoneNumber, upiId, fromId,
          //       //     childCount));
          //
          //       userUpgradeDistributionId=elements.id;
          //       userUpgradeId = userMap["MEMBER_ID"].toString();
          //       userUpgradeName = userMap["NAME"].toString();
          //       userUpgradeNumber = userMap["PHONE"].toString();
          //       userUpgradeProfileImage = userMap["ItemImage"]??"";
          //       userUpgradeStatus = distribute["STATUS"].toString();
          //       userUpgradeAmount = distribute["AMOUNT"].toString();
          //       userUpgradeScreenShot = distribute["SCREENSHOT"]??"";
          //       userUpgradeUpiID = userMap["UPI_Id"]??"";
          //       userUpgradeGrade = userMap["GRADE"].toString();
          //       upgradeUserStatus = userMap["STATUS"].toString();
          //       userUpgradeTree = distribute["TREE"].toString();
          //       upgradeUserChildCount = userMap["CHILD_COUNT"].toString();
          //       // Duration difference =
          //       // currentDate.difference(userMap["REG_DATE"].toDate());
          //       // upgradeUserLeftDays = totalDays - (joinDate = difference.inDays);
          //       notifyListeners();
          //
          //     }
          //   });
          //
          // }
          // else if (distribute["TYPE"] == "PMC") {
          //   userPmcBool=true;
          //   userPmcDistributionId=elements.id;
          //   userPmcAmount = distribute["AMOUNT"];
          //   userPmcGrade = distribute["GRADE"];
          //   userPmcStatus = distribute["STATUS"];
          //   userPmcTree = distribute["TREE"];
          //   // Duration difference = currentDate.difference(distribute["DATE"].toDate());
          //   // leftPmcDays = threeDays - (joinDate = difference.inDays);
          //   notifyListeners();
          // }
          // else if (distribute["TYPE"] == "CMF") {
          //
          //   userDonationBool=true;
          //   userDonationDistributionId=elements.id;
          //   userDonationAmount = distribute["AMOUNT"];
          //   userDonationGrade = distribute["GRADE"];
          //   userDonationStatus = distribute["STATUS"];
          //   userDonationTree = distribute["TREE"];
          //   notifyListeners();
          // }
          // else if (distribute["TYPE"] == "REFERRAL") {
          //   if(_streamReferralDistributions!=null) {
          //     _streamReferralDistributions!.cancel();
          //   }
          //   _streamReferralDistributions = db
          //       .collection("USERS")
          //       .doc(distribute["TO_ID"])
          //       .snapshots()
          //       .listen((userValue) {
          //     if (userValue.exists) {
          //       userReferralBool=true;
          //       Map<dynamic, dynamic> userRefMap = userValue.data() as Map;
          //       userReferralDistributionId=elements.id;
          //       userReferralId = userRefMap["MEMBER_ID"].toString();
          //       userReferralName = userRefMap["NAME"].toString();
          //       userReferralNumber = userRefMap["PHONE"].toString();
          //       userReferralProfileImage = userRefMap["ItemImage"]??"";
          //       userReferralStatus = distribute["STATUS"].toString();
          //       referralUserStatus = userRefMap["STATUS"].toString();
          //       userReferralAmount = distribute["AMOUNT"].toString();
          //       userReferralScreenShot = distribute["SCREENSHOT"]??"";
          //       userReferralUpiID = userRefMap["UPI_Id"].toString();
          //       userReferralGrade = userRefMap["GRADE"].toString();
          //       userReferralTree = distribute["TREE"].toString();
          //       referralUserChildCount = userRefMap["CHILD_COUNT"].toString();
          //       // Duration difference =
          //       // currentDate.difference(userRefMap["REG_DATE"].toDate());
          //       // referralUserLeftDays = totalDays - (joinDate = difference.inDays);
          //       notifyListeners();
          //     }
          //   });
          // }
          // else if (distribute["TYPE"] == "STAR_CLUB") {
          //
          //   if(tree == "MASTER_CLUB") {
          //     if(_streamAutoOneDistributions!=null) {
          //       _streamAutoOneDistributions!.cancel();
          //     }
          //     _streamAutoOneDistributions = db
          //         .collection("USERS")
          //         .doc(distribute["TO_ID"])
          //         .snapshots()
          //         .listen((userValue) {
          //       if (userValue.exists) {
          //         userAuto1Bool=true;
          //         Map<dynamic, dynamic> userAutoPollOneMap = userValue.data() as Map;
          //         userAutoPollOneDistributionId=elements.id;
          //         userAutoPollOneId = userAutoPollOneMap["MEMBER_ID"].toString();
          //         userAutoPollOneName = userAutoPollOneMap["NAME"].toString();
          //         userAutoPollOneNumber = userAutoPollOneMap["PHONE"].toString();
          //         userAutoPollOneProfileImage = userAutoPollOneMap["ItemImage"]??"";
          //         userAutoPollOneStatus = distribute["STATUS"].toString();
          //         autoPollOneUserStatus = userAutoPollOneMap["STATUS"].toString();
          //         userAutoPollOneAmount = distribute["AMOUNT"].toString();
          //         userAutoPollOneScreenShot = distribute["SCREENSHOT"]??"";
          //         userAutoPollOneUpiID = userAutoPollOneMap["UPI_Id"].toString();
          //         userAutoPollOneGrade = userAutoPollOneMap["GRADE"].toString();
          //         userAutoPollOneTree = distribute["TREE"].toString();
          //         autoPollOneUserChildCount = userAutoPollOneMap["CHILD_COUNT"].toString();
          //         // Duration difference =
          //         // currentDate.difference(userAutoPollOneMap["REG_DATE"].toDate());
          //         // autoPollOneUserLeftDays = totalDays - (joinDate = difference.inDays);
          //         notifyListeners();
          //       }
          //     });
          //   }else{
          //     if(_streamAutoOneDistributions!=null) {
          //       _streamAutoOneDistributions!.cancel();
          //     }
          //     _streamAutoOneDistributions = db
          //         .collection("USERS")
          //         .doc(distribute["TO_ID"])
          //         .snapshots()
          //         .listen((userValue) {
          //       if(_streamAutoOneDocDistributions!=null) {
          //         _streamAutoOneDocDistributions!.cancel();
          //       }
          //       _streamAutoOneDocDistributions = db
          //           .collection(tree)
          //           .where("MEMBER_ID",isEqualTo: distribute["TO_ID"])
          //           .snapshots()
          //           .listen((userDocValue) {
          //
          //         if (userValue.exists) {
          //           if (userDocValue.docs.isNotEmpty) {
          //             userAuto1Bool=true;
          //             Map<dynamic, dynamic> userAutoPollOneMap = userValue.data() as Map;
          //             Map<dynamic, dynamic> userAutoPollOneDocMap = userDocValue.docs.first.data();
          //             userAutoPollOneDistributionId=elements.id;
          //             userAutoPollOneId = userAutoPollOneMap["MEMBER_ID"].toString();
          //             userAutoPollOneName = userAutoPollOneMap["NAME"].toString();
          //             userAutoPollOneNumber = userAutoPollOneMap["PHONE"].toString();
          //             userAutoPollOneProfileImage = userAutoPollOneMap["ItemImage"]??"";
          //             userAutoPollOneStatus = distribute["STATUS"].toString();
          //             autoPollOneUserStatus = userAutoPollOneMap["STATUS"].toString();
          //             userAutoPollOneAmount = distribute["AMOUNT"].toString();
          //             userAutoPollOneScreenShot = distribute["SCREENSHOT"]??"";
          //             userAutoPollOneUpiID = userAutoPollOneMap["UPI_Id"].toString();
          //             userAutoPollOneGrade = userAutoPollOneDocMap["GRADE"].toString();
          //             userAutoPollOneTree = distribute["TREE"].toString();
          //             autoPollOneUserChildCount = userAutoPollOneMap["CHILD_COUNT"].toString();
          //             // Duration difference =
          //             // currentDate.difference(userAutoPollOneMap["REG_DATE"].toDate());
          //             // autoPollOneUserLeftDays = totalDays - (joinDate = difference.inDays);
          //             notifyListeners();
          //           }
          //         }
          //
          //       });
          //     });
          //   }
          // }
          // else if (distribute["TYPE"] == "CROWN_CLUB") {
          //   if(tree == "MASTER_CLUB") {
          //     if(_streamAutoTwoDistributions!=null) {
          //       _streamAutoTwoDistributions!.cancel();
          //     }
          //     _streamAutoTwoDistributions = db.collection("USERS")
          //         .doc(distribute["TO_ID"])
          //         .snapshots()
          //         .listen((userValue) {
          //       if (userValue.exists) {
          //         userAuto2Bool=true;
          //         Map<dynamic, dynamic> userAutoPollTwoMap = userValue.data() as Map;
          //         userAutoPollTwoDistributionId=elements.id;
          //         userAutoPollTwoId = userAutoPollTwoMap["MEMBER_ID"].toString();
          //         userAutoPollTwoName = userAutoPollTwoMap["NAME"].toString();
          //         userAutoPollTwoNumber = userAutoPollTwoMap["PHONE"].toString();
          //         userAutoPollTwoProfileImage = userAutoPollTwoMap["ItemImage"]??"";
          //         userAutoPollTwoStatus = distribute["STATUS"].toString();
          //         autoPollTwoUserStatus = userAutoPollTwoMap["STATUS"].toString();
          //         userAutoPollTwoAmount = distribute["AMOUNT"].toString();
          //         userAutoPollTwoScreenShot = distribute["SCREENSHOT"]??"";
          //         userAutoPollTwoUpiID = userAutoPollTwoMap["UPI_Id"].toString();
          //         userAutoPollTwoGrade = userAutoPollTwoMap["GRADE"].toString();
          //         userAutoPollTwoTree = distribute["TREE"].toString();
          //         autoPollTwoUserChildCount = userAutoPollTwoMap["CHILD_COUNT"].toString();
          //         // Duration difference =
          //         // currentDate.difference(userAutoPollTwoMap["REG_DATE"].toDate());
          //         // autoPollTwoUserLeftDays = totalDays - (joinDate = difference.inDays);
          //         notifyListeners();
          //       }
          //     });
          //   }
          //   else {
          //     if(_streamAutoTwoDistributions!=null) {
          //       _streamAutoTwoDistributions!.cancel();
          //     }
          //     _streamAutoTwoDistributions = db.collection("USERS")
          //         .doc(distribute["TO_ID"])
          //         .snapshots()
          //         .listen((userValue) {
          //       if(_streamAutoTwoDocDistributions!=null) {
          //         _streamAutoTwoDocDistributions!.cancel();
          //       }
          //       _streamAutoTwoDocDistributions = db
          //           .collection(tree)
          //           .where("MEMBER_ID",isEqualTo: distribute["TO_ID"])
          //           .snapshots()
          //           .listen((userDocValue) {
          //         if (userValue.exists) {
          //           if (userDocValue.docs.isNotEmpty) {
          //             userAuto2Bool=true;
          //             Map<dynamic, dynamic> userAutoPollTwoMap = userValue.data() as Map;
          //             Map<dynamic, dynamic> userAutoPollTwoDocMap = userDocValue.docs.first.data();
          //             userAutoPollTwoDistributionId=elements.id;
          //             userAutoPollTwoId = userAutoPollTwoMap["MEMBER_ID"].toString();
          //             userAutoPollTwoName = userAutoPollTwoMap["NAME"].toString();
          //             userAutoPollTwoNumber = userAutoPollTwoMap["PHONE"].toString();
          //             userAutoPollTwoProfileImage = userAutoPollTwoMap["ItemImage"]??"";
          //             userAutoPollTwoStatus = distribute["STATUS"].toString();
          //             autoPollTwoUserStatus = userAutoPollTwoMap["STATUS"].toString();
          //             userAutoPollTwoAmount = distribute["AMOUNT"].toString();
          //             userAutoPollTwoScreenShot = distribute["SCREENSHOT"]??"";
          //             userAutoPollTwoUpiID = userAutoPollTwoMap["UPI_Id"].toString();
          //             userAutoPollTwoGrade = userAutoPollTwoDocMap["GRADE"].toString();
          //             userAutoPollTwoTree = distribute["TREE"].toString();
          //             autoPollTwoUserChildCount = userAutoPollTwoMap["CHILD_COUNT"].toString();
          //             // Duration difference =
          //             // currentDate.difference(userAutoPollTwoMap["REG_DATE"].toDate());
          //             // autoPollTwoUserLeftDays = totalDays - (joinDate = difference.inDays);
          //             notifyListeners();
          //           }
          //         }
          //       });
          //     });
          //   }
          // }
          // notifyListeners();
        }
      } else {
        crownDistributionList.clear();
        starDistributionList.clear();
        starDistributionList.clear();
        distributionList.clear();
        sortDistributionList.clear();
        homeDistributionList.clear();
        notifyListeners();
        // clearDistributions();
      }
    });
  }

  fetchDirectDistributions(
    String memberId,
    String grade,
    String tree,
  ) {
    if (_streamDirectDistributions != null) {
      _streamDirectDistributions!.cancel();
    }

    _streamDirectDistributions = db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: memberId)
        .where("TYPE", whereNotIn: ["CMF", "PMC", "PRC"])
        .snapshots()
        .listen((transactionEvent) async {
          clearDistributions();

          isFirstTime = false;
          if (transactionEvent.docs.isNotEmpty) {
            for (var elements in transactionEvent.docs) {
              // print(masterDistributionList.length.toString() +
              //     "  9995655534   starting   ${elements.id}");
              Map<dynamic, dynamic> distribute = elements.data();
              db
                  .collection("USERS")
                  .doc(distribute["TO_ID"])
                  .get()
                  .then((userValue) {
                Map<dynamic, dynamic> userMap = userValue.data() as Map;
                distributionList.add(DistributionModel(
                    distribute["AMOUNT"].toString(),
                    distribute["TO_ID"].toString(),
                    elements.id,
                    distribute["SCREENSHOT"].toString(),
                    distribute["TYPE"].toString(),
                    distribute["STATUS"].toString(),
                    userMap["STATUS"].toString(),
                    distribute["GRADE"].toString(),
                    userMap["DOCUMENT_ID"].toString(),
                    distribute["TREE"].toString(),
                    userMap["ItemImage"] ?? "",
                    userMap["NAME"].toString(),
                    userMap["PHONE"].toString(),
                    userMap["UPI_Id"].toString(),
                    distribute["FROM_ID"].toString(),
                    "",
                    0));
                print(masterDistributionList.length.toString() +
                    "     starting 2  ${elements.id}");
                distributionList =
                    removeDistributionDuplicate(distributionList);

                // distributionList.sort((a, b) =>
                //     ['PENDING', 'REJECTED','PROCESSING', 'PAID'].indexOf(a.status)
                //         .compareTo(['PENDING', 'REJECTED','PROCESSING', 'PAID'].indexOf(b.status)));

                distributionList.sort((a, b) {
                  var statusOrder = {
                    'PENDING': 0,
                    'REJECTED': 1,
                    'PROCESSING': 2,
                    'PAID': 3
                  };
                  return statusOrder[a.status]! - statusOrder[b.status]!;
                });

                homeDistributionList = distributionList
                    .where((item) =>
                        item.status == "PENDING" || item.status == "REJECTED")
                    .take(2)
                    .toSet()
                    .toList();
                if (homeDistributionList.isEmpty) {
                  homeDistributionList =
                      distributionList.take(2).toSet().toList();
                }
                // sortDistributionList= distributionList.where((element) => element.status!="PAID").toSet().toList();
                print(
                      "${masterDistributionList.length}     starting 3  ${elements.id}");
                masterDistributionList = distributionList
                    .where((element) => element.tree == "MASTER_CLUB")
                    .toSet()
                    .toList();
                print(masterDistributionList.length.toString() +
                    "     652626   ${elements.id}");
                masterAllDistributionList = masterDistributionList;
                starDistributionList = distributionList
                    .where((element) => element.tree == "STAR_CLUB")
                    .toSet()
                    .toList();
                starAllDistributionList = starDistributionList;
                crownDistributionList = distributionList
                    .where((element) => element.tree == "CROWN_CLUB")
                    .toSet()
                    .toList();
                crownAllDistributionList = crownDistributionList;
                notifyListeners();
              });
            }
          }
        });
  }

  masterClubDistributionFiltering(String from, String level, String status) {
    print("uyguygug $status");
    print("uyguygug $level");
    if (from == "LEVEL") {
      if (level == "ALL LEVEL") {
        masterDistributionList = masterAllDistributionList;
        notifyListeners();
      } else if (level == "ENTRY HELP") {
        masterDistributionList = masterAllDistributionList
            .where((element) => element.fromGrade == "")
            .toSet()
            .toList();
        notifyListeners();
      } else {
        masterDistributionList = masterAllDistributionList
            .where((element) => element.fromGrade == level)
            .toSet()
            .toList();
        notifyListeners();
      }
    } else if (from == "STATUS") {
      if (level == "ALL LEVEL") {
        if (status == "ALL STATUS") {
          print("uyguygug $status");
          masterDistributionList = masterAllDistributionList;
          notifyListeners();
        } else {
          masterDistributionList = masterAllDistributionList
              .where((element) => element.status == status)
              .toSet()
              .toList();
          notifyListeners();
        }
      } else if (level == "ENTRY HELP") {
        if (status == "ALL STATUS") {
          masterDistributionList = masterAllDistributionList
              .where((element) => element.fromGrade == "")
              .toSet()
              .toList();
          notifyListeners();
        } else {
          masterDistributionList = masterAllDistributionList
              .where((element) =>
                  element.status == status && element.fromGrade == "")
              .toSet()
              .toList();
          notifyListeners();
        }
      } else {
        if (status == "ALL STATUS") {
          masterDistributionList = masterAllDistributionList
              .where((element) => element.fromGrade == level)
              .toSet()
              .toList();
          notifyListeners();
        } else {
          masterDistributionList = masterAllDistributionList
              .where((element) =>
                  element.status == status && element.fromGrade == level)
              .toSet()
              .toList();
          notifyListeners();
        }
      }
    } else {
      masterDistributionList = masterAllDistributionList;
      selectedMasterStatus = 'ALL STATUS';
      selectedMasterLevel = 'ALL LEVEL';
      notifyListeners();
    }
  }

  starClubDistributionFiltering(String from, String level, String status) {
    print("uyguygug $status");
    print("uyguygug $level");
    if (from == "LEVEL") {
      if (level == "ALL LEVEL") {
        starDistributionList = starAllDistributionList;
        notifyListeners();
      } else if (level == "ENTRY HELP") {
        starDistributionList = starAllDistributionList
            .where((element) => element.fromGrade == "")
            .toSet()
            .toList();
        notifyListeners();
      } else {
        starDistributionList = starAllDistributionList
            .where((element) => element.fromGrade == level)
            .toSet()
            .toList();
        notifyListeners();
      }
    } else if (from == "STATUS") {
      if (level == "ALL LEVEL") {
        if (status == "ALL STATUS") {
          print("uyguygug $status");
          starDistributionList = starAllDistributionList;
          notifyListeners();
        } else {
          starDistributionList = starAllDistributionList
              .where((element) => element.status == status)
              .toSet()
              .toList();
          notifyListeners();
        }
      } else if (level == "ENTRY HELP") {
        if (status == "ALL STATUS") {
          starDistributionList = starAllDistributionList
              .where((element) => element.fromGrade == "")
              .toSet()
              .toList();
          notifyListeners();
        } else {
          starDistributionList = starAllDistributionList
              .where((element) =>
                  element.status == status && element.fromGrade == "")
              .toSet()
              .toList();
          notifyListeners();
        }
      } else {
        if (status == "ALL STATUS") {
          starDistributionList = starAllDistributionList
              .where((element) => element.fromGrade == level)
              .toSet()
              .toList();
          notifyListeners();
        } else {
          starDistributionList = starAllDistributionList
              .where((element) =>
                  element.status == status && element.fromGrade == level)
              .toSet()
              .toList();
          notifyListeners();
        }
      }
    } else {
      starDistributionList = starAllDistributionList;
      selectedStarStatus = 'ALL STATUS';
      selectedStarLevel = 'ALL LEVEL';
      notifyListeners();
    }
  }

  crownClubDistributionFiltering(String from, String level, String status) {
    print("uyguygug $status");
    print("uyguygug $level");
    if (from == "LEVEL") {
      if (level == "ALL LEVEL") {
        crownDistributionList = crownAllDistributionList;
        notifyListeners();
      } else if (level == "ENTRY HELP") {
        crownDistributionList = crownAllDistributionList
            .where((element) => element.fromGrade == "")
            .toSet()
            .toList();
        notifyListeners();
      } else {
        crownDistributionList = crownAllDistributionList
            .where((element) => element.fromGrade == level)
            .toSet()
            .toList();
        notifyListeners();
      }
    } else if (from == "STATUS") {
      if (level == "ALL LEVEL") {
        if (status == "ALL STATUS") {
          print("uyguygug $status");
          crownDistributionList = crownAllDistributionList;
          notifyListeners();
        } else {
          crownDistributionList = crownAllDistributionList
              .where((element) => element.status == status)
              .toSet()
              .toList();
          notifyListeners();
        }
      } else if (level == "ENTRY HELP") {
        if (status == "ALL STATUS") {
          crownDistributionList = crownAllDistributionList
              .where((element) => element.fromGrade == "")
              .toSet()
              .toList();
          notifyListeners();
        } else {
          crownDistributionList = crownAllDistributionList
              .where((element) =>
                  element.status == status && element.fromGrade == "")
              .toSet()
              .toList();
          notifyListeners();
        }
      } else {
        if (status == "ALL STATUS") {
          crownDistributionList = crownAllDistributionList
              .where((element) => element.fromGrade == level)
              .toSet()
              .toList();
          notifyListeners();
        } else {
          crownDistributionList = crownAllDistributionList
              .where((element) =>
                  element.status == status && element.fromGrade == level)
              .toSet()
              .toList();
          notifyListeners();
        }
      }
    } else {
      crownDistributionList = crownAllDistributionList;
      selectedCrownStatus = 'ALL STATUS';
      selectedCrownLevel = 'ALL LEVEL';
      notifyListeners();
    }
  }

  List<DistributionModel> companyDistributionsList = [];
  List<DistributionModel> filterPmcDistributionsList = [];
  List<DistributionModel> masterPmcDistributionsList = [];
  List<DistributionModel> starPmcDistributionsList = [];
  List<DistributionModel> crownPmcDistributionsList = [];
  List<DistributionModel> filterPtcfDistributionsList = [];
  List<DistributionModel> masterPtcfDistributionsList = [];
  List<DistributionModel> starPtcfDistributionsList = [];
  List<DistributionModel> crownPtcfDistributionsList = [];
  List<CompanyLevelModel> companyLevelList = [];
  List<CompanyLevelModel> companyAllLevelList = [];
  List<CompanyLevelModel> basicCompanyLevelList = [];
  List<CompanyTreeModel> filterCompanyLevelList = [];
  List<CompanyLevelModel> oneCompanyLevelList = [];
  List<CompanyLevelModel> twoCompanyLevelList = [];
  double totalPmcPaid = 0;
  double masterPmcPaid = 0;
  double starPmcPaid = 0;
  double crownPmcPaid = 0;
  int totalPmcPaidCount = 0;
  int masterTotalPmcPaidCount = 0;
  int starTotalPmcPaidCount = 0;
  int crownTotalPmcPaidCount = 0;
  double totalPmcAmount = 0;
  double masterTotalPmcAmount = 0;
  double starTotalPmcAmount = 0;
  double crownTotalPmcAmount = 0;
  int totalPmcCount = 0;
  int masterTotalPmcCount = 0;
  int starTotalPmcCount = 0;
  int crownTotalPmcCount = 0;
  double totalPtcfPaid = 0;
  double masterTotalPtcfPaid = 0;
  double starTotalPtcfPaid = 0;
  double crownTotalPtcfPaid = 0;
  int totalPtcfPaidCount = 0;
  int masterTotalPtcfPaidCount = 0;
  int starTotalPtcfPaidCount = 0;
  int crownTotalPtcfPaidCount = 0;
  double totalPtcfAmount = 0;
  double masterPtcfAmount = 0;
  double starPtcfAmount = 0;
  double crownPtcfAmount = 0;
  int totalPtcfCount = 0;
  int masterTotalPtcfCount = 0;
  int starTotalPtcfCount = 0;
  int crownTotalPtcfCount = 0;

  void clearCompanyDistributions() {
    totalPmcPaid = 0;
    masterPmcPaid = 0;
    starPmcPaid = 0;
    crownPmcPaid = 0;
    totalPmcPaidCount = 0;
    masterTotalPmcPaidCount = 0;
    starTotalPmcPaidCount = 0;
    crownTotalPmcPaidCount = 0;
    totalPmcAmount = 0;
    masterTotalPmcAmount = 0;
    starTotalPmcAmount = 0;
    crownTotalPmcAmount = 0;
    totalPmcCount = 0;
    crownTotalPmcCount = 0;
    starTotalPmcCount = 0;
    masterTotalPmcCount = 0;
    totalPtcfPaid = 0;
    masterTotalPtcfPaid = 0;
    starTotalPtcfPaid = 0;
    crownTotalPtcfPaid = 0;
    totalPtcfPaidCount = 0;
    masterTotalPtcfPaidCount = 0;
    starTotalPtcfPaidCount = 0;
    crownTotalPtcfPaidCount = 0;
    totalPtcfAmount = 0;
    masterPtcfAmount = 0;
    starPtcfAmount = 0;
    crownPtcfAmount = 0;
    totalPtcfCount = 0;
    masterTotalPtcfCount = 0;
    starTotalPtcfCount = 0;
    crownTotalPtcfCount = 0;
    filterPmcDistributionsList.clear();
    masterPmcDistributionsList.clear();
    starPmcDistributionsList.clear();
    crownPmcDistributionsList.clear();
    filterPtcfDistributionsList.clear();
    companyDistributionsList.clear();
    companyLevelList.clear();
    companyAllLevelList.clear();
    basicCompanyLevelList.clear();
    oneCompanyLevelList.clear();
    twoCompanyLevelList.clear();
    notifyListeners();
  }

  fetchCompanyDistributions(
    String memberId,
    String grade,
    String tree,
  ) {
    if (_streamCompanyDistributions != null) {
      _streamCompanyDistributions!.cancel();
    }

    clearCompanyDistributions();
    _streamCompanyDistributions = db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: memberId)
        .where("TYPE", whereIn: ["CMF", "PMC"])
        .snapshots()
        .listen((transactionEvent) async {
          isFirstTime = false;
          if (transactionEvent.docs.isNotEmpty) {
            clearCompanyDistributions();
            for (var elements in transactionEvent.docs) {
              Map<dynamic, dynamic> distribute = elements.data();
              companyDistributionsList.add(DistributionModel(
                  distribute["AMOUNT"].toString(),
                  "",
                  elements.id,
                  "",
                  distribute["TYPE"].toString(),
                  distribute["STATUS"].toString(),
                  "",
                  distribute["GRADE"].toString(),
                  "",
                  distribute["TREE"].toString(),
                  "",
                  "",
                  "",
                  "",
                  distribute["FROM_ID"].toString(),
                  "",
                  distribute["INSTALLMENT"] ?? 1));
              print("pmc list : ${companyDistributionsList.length}");
              filterPmcDistributionsList = companyDistributionsList
                  .where((element) => element.type == "PMC")
                  .toSet()
                  .toList();
              masterPmcDistributionsList = companyDistributionsList
                  .where((element) =>
                      element.type == "PMC" && element.tree == "MASTER_CLUB")
                  .toSet()
                  .toList();
              starPmcDistributionsList = companyDistributionsList
                  .where((element) =>
                      element.type == "PMC" && element.tree == "STAR_CLUB")
                  .toSet()
                  .toList();
              crownPmcDistributionsList = companyDistributionsList
                  .where((element) =>
                      element.type == "PMC" && element.tree == "CROWN_CLUB")
                  .toSet()
                  .toList();
              filterPtcfDistributionsList = companyDistributionsList
                  .where((element) => element.type == "CMF")
                  .toSet()
                  .toList();
              masterPtcfDistributionsList = companyDistributionsList
                  .where((element) =>
                      element.type == "CMF" && element.tree == "MASTER_CLUB")
                  .toSet()
                  .toList();
              starPtcfDistributionsList = companyDistributionsList
                  .where((element) =>
                      element.type == "CMF" && element.tree == "STAR_CLUB")
                  .toSet()
                  .toList();
              crownPtcfDistributionsList = companyDistributionsList
                  .where((element) =>
                      element.type == "CMF" && element.tree == "CROWN_CLUB")
                  .toSet()
                  .toList();

              if (!companyLevelList
                  .map((item) => item.levelName)
                  .contains(distribute["GRADE"].toString())) {
                companyLevelList.add(CompanyLevelModel(
                    distribute["GRADE"].toString(),
                    distribute["TREE"].toString(),
                    true));
              }

              basicCompanyLevelList = companyLevelList
                  .where((element) => element.levelTree == "MASTER_CLUB")
                  .toSet()
                  .toList();

              // filterCompanyLevelList=basicCompanyLevelList;

              oneCompanyLevelList = companyLevelList
                  .where((element) => element.levelTree == "STAR_CLUB")
                  .toSet()
                  .toList();
              twoCompanyLevelList = companyLevelList
                  .where((element) => element.levelTree == "CROWN_CLUB")
                  .toSet()
                  .toList();
              companyAllLevelList = basicCompanyLevelList +
                  oneCompanyLevelList +
                  twoCompanyLevelList;
              notifyListeners();
              // totalHelpReceivedAmount = filterUserHelpReceiveList.fold(0, (previousValue, element) =>
              // previousValue + double.parse(element.amount));
              totalPmcPaid =
                  filterPmcDistributionsList.fold(0, (previousValue, element) {
                if (element.status == 'PAID' && element.type == "PMC") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              masterPmcPaid =
                  masterPmcDistributionsList.fold(0, (previousValue, element) {
                if (element.status == 'PAID' && element.type == "PMC") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              starPmcPaid =
                  starPmcDistributionsList.fold(0, (previousValue, element) {
                if (element.status == 'PAID' && element.type == "PMC") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              crownPmcPaid =
                  crownPmcDistributionsList.fold(0, (previousValue, element) {
                if (element.status == 'PAID' && element.type == "PMC") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              totalPmcAmount =
                  filterPmcDistributionsList.fold(0, (previousValue, element) {
                if (element.type == "PMC") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              masterTotalPmcAmount =
                  masterPmcDistributionsList.fold(0, (previousValue, element) {
                if (element.type == "PMC") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              starTotalPmcAmount =
                  starPmcDistributionsList.fold(0, (previousValue, element) {
                if (element.type == "PMC") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              crownTotalPmcAmount =
                  crownPmcDistributionsList.fold(0, (previousValue, element) {
                if (element.type == "PMC") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              totalPtcfPaid =
                  filterPtcfDistributionsList.fold(0, (previousValue, element) {
                if (element.status == 'PAID' && element.type == "CMF") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              masterTotalPtcfPaid =
                  masterPtcfDistributionsList.fold(0, (previousValue, element) {
                if (element.status == 'PAID' && element.type == "CMF") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              starTotalPtcfPaid =
                  starPtcfDistributionsList.fold(0, (previousValue, element) {
                if (element.status == 'PAID' && element.type == "CMF") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              crownTotalPtcfPaid =
                  crownPtcfDistributionsList.fold(0, (previousValue, element) {
                if (element.status == 'PAID' && element.type == "CMF") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });

              totalPtcfAmount =
                  filterPtcfDistributionsList.fold(0, (previousValue, element) {
                if (element.type == "CMF") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              crownPtcfAmount =
                  masterPtcfDistributionsList.fold(0, (previousValue, element) {
                if (element.type == "CMF") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              starPtcfAmount =
                  starPtcfDistributionsList.fold(0, (previousValue, element) {
                if (element.type == "CMF") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              masterPtcfAmount =
                  crownPtcfDistributionsList.fold(0, (previousValue, element) {
                if (element.type == "CMF") {
                  return previousValue + double.parse(element.amount);
                } else {
                  return previousValue;
                }
              });
              totalPmcPaidCount = filterPmcDistributionsList
                  .where((element) =>
                      element.status == 'PAID' && element.type == "PMC")
                  .toSet()
                  .toList()
                  .length;
              masterTotalPmcPaidCount = masterPmcDistributionsList
                  .where((element) =>
                      element.status == 'PAID' && element.type == "PMC")
                  .toSet()
                  .toList()
                  .length;
              starTotalPmcPaidCount = starPmcDistributionsList
                  .where((element) =>
                      element.status == 'PAID' && element.type == "PMC")
                  .toSet()
                  .toList()
                  .length;
              crownTotalPmcPaidCount = crownPmcDistributionsList
                  .where((element) =>
                      element.status == 'PAID' && element.type == "PMC")
                  .toSet()
                  .toList()
                  .length;

              totalPmcCount = filterPmcDistributionsList
                  .where((element) => element.type == "PMC")
                  .toSet()
                  .toList()
                  .length;
              masterTotalPmcCount = masterPmcDistributionsList
                  .where((element) => element.type == "PMC")
                  .toSet()
                  .toList()
                  .length;
              starTotalPmcCount = starPmcDistributionsList
                  .where((element) => element.type == "PMC")
                  .toSet()
                  .toList()
                  .length;
              crownTotalPmcCount = crownPmcDistributionsList
                  .where((element) => element.type == "PMC")
                  .toSet()
                  .toList()
                  .length;
              totalPtcfPaidCount = filterPtcfDistributionsList
                  .where((element) =>
                      element.status == 'PAID' && element.type == "CMF")
                  .toSet()
                  .toList()
                  .length;
              masterTotalPtcfPaidCount = masterPtcfDistributionsList
                  .where((element) =>
                      element.status == 'PAID' && element.type == "CMF")
                  .toSet()
                  .toList()
                  .length;
              starTotalPtcfPaidCount = starPtcfDistributionsList
                  .where((element) =>
                      element.status == 'PAID' && element.type == "CMF")
                  .toSet()
                  .toList()
                  .length;
              crownTotalPtcfPaidCount = crownPtcfDistributionsList
                  .where((element) =>
                      element.status == 'PAID' && element.type == "CMF")
                  .toSet()
                  .toList()
                  .length;
              totalPtcfCount = filterPtcfDistributionsList
                  .where((element) => element.type == "CMF")
                  .toSet()
                  .toList()
                  .length;
              masterTotalPtcfCount = masterPtcfDistributionsList
                  .where((element) => element.type == "CMF")
                  .toSet()
                  .toList()
                  .length;
              starTotalPtcfCount = starPtcfDistributionsList
                  .where((element) => element.type == "CMF")
                  .toSet()
                  .toList()
                  .length;
              crownTotalPtcfCount = crownPtcfDistributionsList
                  .where((element) => element.type == "CMF")
                  .toSet()
                  .toList()
                  .length;
              notifyListeners();
            }
          } else {
            clearCompanyDistributions();
          }
        });
  }

  StreamSubscription? _streamPrcDistributions;
  List<DistributionModel> prcDistributionsList = [];

  fetchPrcPayment(
    String memberId,
  ) {
    if (_streamPrcDistributions != null) {
      _streamPrcDistributions!.cancel();
    }
    _streamPrcDistributions = db
        .collection("DISTRIBUTIONS")
        .where("FROM_ID", isEqualTo: memberId)
        .where("TYPE", isEqualTo: "PRC")
        .snapshots()
        .listen((transactionEvent) async {
      if (transactionEvent.docs.isNotEmpty) {
        prcDistributionsList.clear();
        for (var elements in transactionEvent.docs) {
          Map<dynamic, dynamic> distribute = elements.data();
          prcDistributionsList.add(DistributionModel(
              distribute["AMOUNT"].toString(),
              "",
              elements.id,
              "",
              distribute["TYPE"].toString(),
              distribute["STATUS"].toString(),
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              "",
              distribute["FROM_ID"].toString(),
              "",
              0));
          notifyListeners();
        }
      }
    });
  }

  String selectedMasterStatus = 'ALL STATUS';
  String selectedMasterLevel = 'ALL LEVEL';
  String selectedStarStatus = 'ALL STATUS';
  String selectedStarLevel = 'ALL LEVEL';
  String selectedCrownStatus = 'ALL STATUS';
  String selectedCrownLevel = 'ALL LEVEL';

  void updateMasterLevel(String newValue) {
    selectedMasterLevel = newValue;
    masterClubDistributionFiltering('LEVEL', newValue, "");
    print(newValue);
    notifyListeners();
  }

  void updateMasterStatus(String newValue) {
    print("ewdr : $newValue");
    selectedMasterStatus = newValue;
    masterClubDistributionFiltering('STATUS', selectedMasterLevel, newValue);
    notifyListeners();
  }

  void updateStarLevel(String newValue) {
    selectedStarLevel = newValue;
    starClubDistributionFiltering('LEVEL', newValue, "");
    print(newValue);
    notifyListeners();
  }

  void updateStarStatus(String newValue) {
    print("ewdr : $newValue");
    selectedStarStatus = newValue;
    starClubDistributionFiltering('STATUS', selectedStarLevel, newValue);
    notifyListeners();
  }

  void updateCrownLevel(String newValue) {
    selectedCrownLevel = newValue;
    crownClubDistributionFiltering('LEVEL', newValue, "");
    print(newValue);
    notifyListeners();
  }

  void updateCrownStatus(String newValue) {
    print("ewdr : $newValue");
    selectedCrownStatus = newValue;
    crownClubDistributionFiltering('STATUS', selectedCrownLevel, newValue);
    notifyListeners();
  }

  int inviteCount = 0;

  Future<void> fetchMyInvitationCount(String id,String loginUserType) async {
    if(loginUserType=="ADMIN LEADER"){
      inviteCount=2;
      notifyListeners();

    }else{
      QuerySnapshot querySnapshot =
      await db.collection("USERS").where("REFERENCE", isEqualTo: id).get();
      inviteCount = querySnapshot.size;
      notifyListeners();

    }
    print(inviteCount);
    print("dxtgfhjklyfghbjnkl");
  }

//   filterMasterClub(String fromGrade,String status) {
//     print(fromGrade);
//     print(status);
//
//     masterAllDistributionList = masterDistributionList
//         .where((element) =>
//         element.fromGrade.toLowerCase().contains(fromGrade.toLowerCase()) ||
//         element.status.toLowerCase().contains(status.toLowerCase()) )
//         .toList();
// if(){
//
// }
//     notifyListeners();
//   }

  String contactUs = '';

  void fetchDetails() {
    mRoot.child('0').onValue.listen((event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;

        contactUs = map['PhoneNumber2'] ?? '';
      }
    });
  }

  String appName = "";

  getAppNameForAlert() {
    mRoot.child('0').child('appName').onValue.listen((event) {
      if (event.snapshot.exists) {
        appName = event.snapshot.value.toString();
        notifyListeners();
      }
    });
  }

  String contactHelpNumber = '';
  String whatsappHelpNumber = '';

  void fetchSupportDetails() {
    mRoot.child('0').onValue.listen((event) {
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        contactHelpNumber = map['SupportPhoneNumber'] ?? '';
        whatsappHelpNumber = map['SupportWhatsappNumber'] ?? '';
      }
    });
  }
}
