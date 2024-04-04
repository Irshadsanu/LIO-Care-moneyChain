import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/models/blocked_members_Model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../Constants/functions.dart';
import '../LockScreen/Admin_Update_Screen.dart';
import '../LockScreen/Strings.dart';
import '../admin/screens/admin_exchange_List.dart';
import '../admin/screens/admin_homeScreen.dart';
import '../constants/my_colors.dart';
import '../help_tree/tree_provider.dart';
import '../models/admin_trasnaction_historyModelClass.dart';
import '../models/adminsListModel.dart';
import '../models/exchangeModel.dart';
import '../models/assigned_task_model.dart';
import '../models/members_Model.dart';
import '../admin/screens/kyc_upload_list.dart';
import '../models/pmfDetail_model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import '../models/user_giveHelpModel.dart';
import '../splash_screen.dart';
import 'donation_provider.dart';
import 'login_provider.dart';

class AdminProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final DatabaseReference mRoot = FirebaseDatabase.instance.ref();
  TextEditingController userNameCT = TextEditingController();
  TextEditingController addAdminNameCT = TextEditingController();
  TextEditingController addAdminNumberCT = TextEditingController();
  TextEditingController addAdminPasswordCT = TextEditingController();
  TextEditingController taskController = TextEditingController();
  TextEditingController taskLinkController = TextEditingController();
  TextEditingController taskHeadingController = TextEditingController();
  TextEditingController taskDurationController = TextEditingController();
  TextEditingController searchTransactionCT = TextEditingController();
  TextEditingController searchReferralCT = TextEditingController();

  TextEditingController kycStatusCT = TextEditingController();

  String adminName = '';
  String adminPhone = '';
  String adminImage = '';
  String adminId = '';
  String adminPassword = '';
  List<dynamic> adminPrivilegeList = [];
  double gstAdmin = 0;
  double fullgstAdmin = 0;
  double gst = 0;
  List<String> partialItemList = [
    'STARTER',
    'VIOLET',
    'INDIGO',
    'BLUE',
    'GREEN',
    'YELLOW',
    "ORANGE",
    'RED'
  ];
  List<String> fullItemList = [
    'STARTER',
    'VIOLET',
    'INDIGO',
    'BLUE',
    'GREEN',
    'YELLOW',
    "ORANGE",
    'RED'
  ];

  clearFilter() {
    selectedUserTree = 'MASTER_CLUB';
    selectedUserGrade = 'RED';
    fetchReferralLedger(true);
    notifyListeners();
  }

  bool showTick = false;
  final ImagePicker picker = ImagePicker();
  File? fileImage;
  String adminProfile = "";

  ///admin home details
  double pmcTotal = 0;
  double donationTotal = 0;
  double giveHelpTotal = 0;
  double referralTotal = 0;
  String pmcTotalCount = '';
  String donationTotalCount = '';
  String giveHelpCount = '';
  String referralTotalCount = '';
  String membersCount = '';
  String prcTotalCount = '';
  double prcTotal = 0;

  ///Pmc
  List<AdminPMCDetails> adminPMCDetailsList = [];
  List<AdminPMCDetails> filterAdminPMCDetailsList = [];
  List<AdminGiveHelpModel> adminGiveHelpList = [];
  List<AdminGiveHelpModel> filterAdminHelpReport = [];
  List<AdminGiveHelpModel> filterAdminGiveHelpList = [];
  int helpReportLimit = 50;
  List<MembersModel> registrationPendingList = [];
  List<MembersModel> filterRegistrationPendingList = [];
  List<MembersModel> fetchParticipantsList = [];
  List<MembersModel> filterFetchParticipantsList = [];
  List<AdminReferralLedgerModel> adminReferralList = [];
  List<AdminReferralLedgerModel> filterAdminReferralList = [];

  int pmcLimit = 50;
  int pmcLoadMoreLimit = 50;

  ///CMF
  List<AdminDonationDetails> adminDonationList = [];
  List<AdminDonationDetails> filterAdminDonationList = [];
  int donationLimit = 50;
  int donationLoadLimit = 50;

  List<AssignedTaskModel> assignedTaskList = [];
  List<AssignedTaskModel> filterAssignedTaskList = [];
  List<TransactionDateModel> assignedTaskDateList = [];

  ///member details for approve
  String aadhaarId = '';
  String panId = '';
  String aadhaarImg = '';
  String aadhaarSecondSideImg = '';
  String panImg = '';
  String? kycValue = 'All';

  List<String> fcmList = [];
  List<String> kycStatusList = [
    'All',
    'Submitted',
    'Rejected',
    'Pending',
    'Verified'
  ];
  List<String> kycStatusList1 = [
    'Kyc Status',
    'All',
    'Submitted',
    'Rejected',
    'Pending',
    'Verified'
  ];
  String treeLock = '';

  userTreeLock() {
    db.collection("TOTAL_AMOUNTS")
        .doc("TOTAL_AMOUNTS")
        .snapshots()
        .listen((value) {
      if (value.exists) {
        Map<dynamic, dynamic> lockMap = value.data() as Map;
        treeLock = lockMap["TREE_USER"];
        notifyListeners();
      }
    });
  }

  bool isSecondDropdownEnabled = false;

  void enableSecondDropdown() {
    isSecondDropdownEnabled = true;
    notifyListeners();
  }

  String selectedValue = "Second";
  String? selectedUserTree = 'MASTER_CLUB';
  String? selectedUserGrade = 'RED';

  void filterListForDropDown(String newValue) {
    selectedValue = newValue;
    if (newValue == 'MASTER_CLUB') {
      partialItemList = fullItemList;
    } else if (newValue == 'STAR_CLUB') {
      partialItemList = fullItemList.sublist(fullItemList.length - 7);
    } else {
      partialItemList = fullItemList.sublist(fullItemList.length - 6);
    }
    selectedUserGrade = partialItemList[0].toString();
    notifyListeners();
  }

  Future<bool> checkAdminVersionExist() async {
    var dataSnapshot = await mRoot.child("0").child('AdminAppVersion').once();
    List<String> versions = dataSnapshot.snapshot.value.toString().split(',');

    print("versions,  $versions");

    if (versions.contains(adminAppVersion)) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> confirmAdminLocking(BuildContext context) async {
    var dataSnapshot = await mRoot.child("0").child('AdminAppVersion').once();
    List<String> versions = dataSnapshot.snapshot.value.toString().split(',');

    print("versions,  $versions");

    if (versions.contains(adminAppVersion)) {
      print("if versions $versions");
      print("if app version $adminAppVersion");
      callNextReplacement(SplashScreen(), context);
    }else{
      print("else app version $adminAppVersion");
      print("else versions $versions");
    }


  }


  void adminLockApp() {
    mRoot.child("0").onValue.listen((event) async {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map;
        List<String> versions = map['AdminAppVersion'].toString().split(',');
        if (!versions.contains(adminAppVersion)) {
          bool versionStatus = await checkAdminVersionExist();
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
                      home: AdminUpdateScreen(
                        address: address,
                        button: button,
                        text: text,
                      )
                  ),
                ));
          }
        }
      }
    });
  }


  // void adminLockApp() {
  //   mRoot.child("0").onValue.listen((event) {
  //     if (event.snapshot.value != null) {
  //       Map<dynamic, dynamic> map = event.snapshot.value as Map;
  //       List<String> versions = map['AdminAppVersion'].toString().split(',');
  //       if (!versions.contains(adminAppVersion)) {
  //         String address = map['ADDRESS'].toString();
  //         String button = map['BUTTON'].toString();
  //         String text = map['TEXT'].toString();
  //         runApp(MaterialApp(
  //           debugShowCheckedModeBanner: false,
  //           home: UpdateScreen(
  //             address: address,
  //             button: button,
  //             text: text,
  //           ),
  //         ));
  //       }
  //     }
  //   });
  // }

  void loopParentsToParents() {
    db.collection("MEMBERS").get().then((chainValue) {
      for (var elements in chainValue.docs) {
        Map<dynamic, dynamic> map3 = elements.data();
        if (map3['PARENTS'] != null) {
          Map<dynamic, dynamic> map4 = map3['PARENTS'];
          HashMap<String, dynamic> map44 = HashMap();
          map44['PARENTS'] = map4;
          db.collection("MEMBERS").doc(elements.id).update(map44);
          db.collection("MEMBERS").doc(elements.id).set(
            {'PARENTS': FieldValue.delete()},
            SetOptions(
              merge: true,
            ),
          );
        }
      }
    });
  }
bool reportLoadMore=false;
  fetchAdminHelpReport(bool firstFetch, [dynamic lastDoc = false]) async {
    String date = '';
    String time = '';
    DateTime dateNow = DateTime.now();
    String todayFormat = DateFormat('dd/MM/yyyy').format(dateNow);
    String yesterdayFormat =
        DateFormat('dd/MM/yyyy').format(dateNow.add(const Duration(days: -1)));
    reportLoadMore = true;
    var collectionRef;
    if (!firstFetch) {
      collectionRef = db
          .collection('TRANSACTIONS')
          .where("PAYMENT_TYPE",
              whereIn: ["HELP", "STAR_CLUB", "CROWN_CLUB"])
          .orderBy("PAYMENT_TIME", descending: true)
          .startAfter([lastDoc])
          .limit(limit);
    } else {
      collectionRef = db
          .collection('TRANSACTIONS')
          .where("PAYMENT_TYPE",
              whereIn: ["HELP", "STAR_CLUB", "CROWN_CLUB"])
          .orderBy("PAYMENT_TIME", descending: true)
          .limit(limit);
      adminGiveHelpList.clear();
      filterAdminHelpReport.clear();
      reportDateList.clear();
    }
    collectionRef.get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          Map<dynamic, dynamic> transMap = element.data() as Map;

          db
              .collection("USERS")
              .doc(element["TO_USER_ID"])
              .get()
              .then((userValue) {
            if (userValue.exists) {
              Map<dynamic, dynamic> userMap = userValue.data() as Map;
              DateTime paymentDate = transMap["PAYMENT_TIME"].toDate();
              date = DateFormat('dd/MM/yyyy').format(paymentDate);
              time = DateFormat('h:mm a').format(paymentDate);
              if (date == todayFormat) {
                date = "Today";
              } else if (date == yesterdayFormat) {
                date = "Yesterday";
              }
              adminGiveHelpList.add(AdminGiveHelpModel(
                transMap["USER_NAME"],
                transMap["PHONE_NUMBER"],
                userMap["NAME"],
                userMap["PHONE"],
                element.id,
                date,
                time,
                paymentDate,
                transMap["AMOUNT"],
                transMap["PAYMENT_TYPE"],
                transMap["TREE"],
              ));
              filterAdminHelpReport = adminGiveHelpList;

              notifyListeners();
              if (!reportDateList
                  .map((item) => item.dateFormat)
                  .contains(date)) {
                reportDateList.add(TransactionDateModel(date, paymentDate));
              }
              filterAdminHelpReport
                  .sort((a, b) => b.paymentDateTime.compareTo(a.paymentDateTime));
              notifyListeners();
            }
          });
        }

        notifyListeners();
      }
    });
    notifyListeners();
  }

  fetchAdminTotalGiveHelp(bool firstFetch, [dynamic lastDoc = false]) async {
    var collectionRef;
    reportLoadMore = true;
    if (!firstFetch) {
      collectionRef = db
          .collection('TRANSACTIONS')
          .where("PAYMENT_TYPE",
              whereIn: ["HELP", "STAR_CLUB", "CROWN_CLUB"])
          .orderBy("PAYMENT_TIME", descending: true)
          .startAfter([lastDoc])
          .limit(limit);
      helpsLoadLimit = helpsLoadLimit + limit;
    } else {
      collectionRef = db
          .collection('TRANSACTIONS')
          .where("PAYMENT_TYPE",
              whereIn: ["HELP", "STAR_CLUB", "CROWN_CLUB"])
          .orderBy("PAYMENT_TIME", descending: true)
          .limit(limit);
      adminGiveHelpList.clear();
      filterAdminGiveHelpList.clear();
      reportDateList.clear();
      helpsLoadLimit = 50;
    }

    String date = '';
    String time = '';
    DateTime dateNow = DateTime.now();
    String todayFormat = DateFormat('dd/MM/yyyy').format(dateNow);
    String yesterdayFormat =
        DateFormat('dd/MM/yyyy').format(dateNow.add(const Duration(days: -1)));

    collectionRef.get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var element in snapshot.docs) {
          Map<dynamic, dynamic> transMap = element.data() as Map;
          db
              .collection("USERS")
              .doc(transMap["TO_USER_ID"])
              .get()
              .then((userValue) {
            if (userValue.exists) {
              Map<dynamic, dynamic> userMap = userValue.data() as Map;
              DateTime paymentDate = transMap["PAYMENT_TIME"].toDate();
              date = DateFormat('dd/MM/yyyy').format(paymentDate);
              time = DateFormat('h:mm a').format(paymentDate);
              if (date == todayFormat) {
                date = "Today";
              } else if (date == yesterdayFormat) {
                date = "Yesterday";
              }

              adminGiveHelpList.add(AdminGiveHelpModel(
                transMap["USER_NAME"],
                transMap["PHONE_NUMBER"],
                userMap["NAME"],
                userMap["PHONE"],
                element.id,
                date,
                time,
                paymentDate,
                transMap["AMOUNT"],
                transMap["PAYMENT_TYPE"],
                transMap["TREE"],
              ));
              filterAdminGiveHelpList = adminGiveHelpList;

              notifyListeners();
              if (!reportDateList
                  .map((item) => item.dateFormat)
                  .contains(date)) {
                reportDateList.add(TransactionDateModel(date, paymentDate));
              }
              reportDateList.sort((a, b) => b.date.compareTo(a.date));
              notifyListeners();
            }
          });
        }
        notifyListeners();
      }
    });
    notifyListeners();
  }

  filterGiveHelpReport(String item) {
    filterAdminGiveHelpList = adminGiveHelpList
        .where((element) =>
            element.fromName.toLowerCase().contains(item.toLowerCase()) ||
            element.fromNumber.toLowerCase().contains(item.toLowerCase()) ||
            // element.toName.toLowerCase().contains(item.toLowerCase()) ||
            // element.toNumber.toLowerCase().contains(item.toLowerCase()) ||
            element.amount.toLowerCase().contains(item.toLowerCase()) ||
            element.transactionID.toLowerCase().contains(item.toLowerCase()))
        .toList();
    giveHelpTotal = filterAdminGiveHelpList.fold(0, (previousValue, element) => previousValue + double.parse(element.amount));

    notifyListeners();
  }

  filterHelpReport(String item) {
    reportLoadMore = false;
    filterAdminHelpReport = adminGiveHelpList
        .where((element) =>
            element.fromName.toLowerCase().contains(item.toLowerCase()) ||
            element.fromNumber.toLowerCase().contains(item.toLowerCase()) ||
            element.toName.toLowerCase().contains(item.toLowerCase()) ||
            element.toNumber.toLowerCase().contains(item.toLowerCase()) ||
            element.amount.toLowerCase().contains(item.toLowerCase()) ||
            element.transactionID.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  filtertotalReferrals(String item) {
    filterAdminReferralList = adminReferralList
        .where((element) =>
            element.fromName.toLowerCase().contains(item.toLowerCase()) ||
            element.fromNumber.toLowerCase().contains(item.toLowerCase()) ||
            element.toName.toLowerCase().contains(item.toLowerCase()) ||
            element.amount.toLowerCase().contains(item.toLowerCase()) ||
            element.tree.toLowerCase().contains(item.toLowerCase()) ||
            element.grade.toLowerCase().contains(item.toLowerCase()) ||
            element.transactionID.toLowerCase().contains(item.toLowerCase()))
        .toList();
    referralTotal = filterAdminReferralList.fold(0, (previousValue, element) => previousValue + double.parse(element.amount));
    notifyListeners();
  }

  filterForTree(String tree) {
    filterAdminReferralList = adminReferralList.where((element) =>
            element.tree.toLowerCase().contains(tree.toLowerCase()))
        .toList();
    notifyListeners();
  }

  filterForGrade(String grade, String tree) {
    filterAdminReferralList = adminReferralList
        .where((element) =>
            element.tree.toLowerCase().contains(tree.toLowerCase()) &
            element.grade.toLowerCase().contains(grade.toLowerCase()))
        .toList();
    notifyListeners();
  }

  dateWiseFilterGiveHelpReport(var firstDate, var secondDate) {
    String date = '';
    String time = '';
    DateTime dateNow = DateTime.now();
    String todayFormat = DateFormat('dd/MM/yyyy').format(dateNow);
    String yesterdayFormat =
        DateFormat('dd/MM/yyyy').format(dateNow.add(const Duration(days: -1)));
    adminGiveHelpList.clear();
    filterAdminHelpReport.clear();
    reportDateList.clear();
    db
        .collection("TRANSACTIONS")
        .where("PAYMENT_TYPE", isEqualTo: "HELP")
        .where("PAYMENT_TIME", isGreaterThanOrEqualTo: firstDate)
        .where("PAYMENT_TIME", isLessThanOrEqualTo: secondDate)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        adminGiveHelpList.clear();
        filterAdminHelpReport.clear();
        reportDateList.clear();
        helpsLoadLimit = value.docs.length+1;
        for (var element in value.docs) {
          Map<dynamic, dynamic> transMap = element.data();

          db
              .collection("USERS")
              .doc(transMap["TO_USER_ID"])
              .get()
              .then((userValue) {
            if (userValue.exists) {
              Map<dynamic, dynamic> userMap = userValue.data() as Map;
              DateTime paymentDate = element["PAYMENT_TIME"].toDate();
              date = DateFormat('dd/MM/yyyy').format(paymentDate);
              time = DateFormat('h:mm a').format(paymentDate);
              if (date == todayFormat) {
                date = "Today";
              } else if (date == yesterdayFormat) {
                date = "Yesterday";
              }
              adminGiveHelpList.add(AdminGiveHelpModel(
                transMap["USER_NAME"],
                transMap["PHONE_NUMBER"],
                userMap["NAME"],
                userMap["PHONE"],
                element.id,
                date,
                time,
                paymentDate,
                transMap["AMOUNT"],
                transMap["PAYMENT_TYPE"],
                transMap["TREE"],
              ));
              filterAdminHelpReport = adminGiveHelpList;
              filterAdminGiveHelpList = adminGiveHelpList;
              notifyListeners();
              if (!reportDateList
                  .map((item) => item.dateFormat)
                  .contains(date)) {
                reportDateList.add(TransactionDateModel(date, paymentDate));
              }
              reportDateList.sort((a, b) => b.date.compareTo(a.date));
              notifyListeners();
            }
          });
        }
        // filterAdminGiveHelpList=adminGiveHelpList;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  bool transactionLoadMore = false;

  dateWiseFilterTransaction(var firstDate, var secondDate) async {
    // transactionLoadMore = true ;
    listLength = 0;
    String transactionDateFormat = "";
    transcation_HistoryList.clear();
    filter_Transcation_HistoryList.clear();
    reportDateList.clear();

    QuerySnapshot querySnapshot = await db
        .collection("TRANSACTIONS")
        .where("PAYMENT_TIME", isGreaterThanOrEqualTo: firstDate)
        .where("PAYMENT_TIME", isLessThanOrEqualTo: secondDate)
        .get();
    listLength = querySnapshot.size;
    notifyListeners();

    db
        .collection("TRANSACTIONS")
        .where("PAYMENT_TIME", isGreaterThanOrEqualTo: firstDate)
        .where("PAYMENT_TIME", isLessThanOrEqualTo: secondDate)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        transcation_HistoryList.clear();
        filter_Transcation_HistoryList.clear();
        reportDateList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;
          transactionDateFormat =
              outputDayNode.format(map["PAYMENT_TIME"].toDate()).toString();
          transcation_HistoryList.add(AdminsTransactionListModel(
              double.parse(map["AMOUNT"].toString()),
              map["APP_VERSION"],
              map["FROM_USER_ID"],
              map["GRADE"],
              map["PAYMENT_MODE"],
              map["PAYMENT_STATUS"].toString(),
              map["PAYMENT_TIME"].toDate(),
              map["PAYMENT_TYPE"],
              map["TO_USER_ID"] ?? "",
              map["TREE"],
              map["USER_NAME"],
              map["PHONE_NUMBER"],
              element.id.toString(),
              transactionDateFormat));
          // if(!reportDateList.contains(map["PAYMENT_TIME"].toDate())) {
          if (!reportDateList
              .map((item) => item.dateFormat)
              .contains(transactionDateFormat)) {
            reportDateList.add(TransactionDateModel(
                transactionDateFormat, map["PAYMENT_TIME"].toDate()));
          }
          filter_Transcation_HistoryList = transcation_HistoryList;
        }

        notifyListeners();
      }
      notifyListeners();
    });
  }

  fetchReferralLedger(bool firstFetch, [dynamic lastDoc = false]) async {
    var collectionRef;

    notifyListeners();
    if (!firstFetch) {
      collectionRef = db
          .collection("TRANSACTIONS")
          .where("PAYMENT_TYPE", isEqualTo: "REFERRAL")
          .orderBy("PAYMENT_TIME", descending: true)
          .startAfter([lastDoc]).limit(referralLimit);
      referralLoadLimit = referralLoadLimit+referralLimit;
    } else {
      adminReferralList.clear();
      filterAdminReferralList.clear();
      collectionRef = db
          .collection("TRANSACTIONS")
          .where("PAYMENT_TYPE", isEqualTo: "REFERRAL")
          .orderBy("PAYMENT_TIME", descending: true)
          .limit(referralLimit);
      referralLoadLimit = 50;
    }
    String date = '';
    String dateTimeString = '';

    collectionRef.get().then((value) {
      if (value.docs.isNotEmpty) {

          for (var element in value.docs) {
            try{
              date =
                  outputDayNode.format(element["PAYMENT_TIME"].toDate()).toString();
              dateTimeString =
                  outputDayNode3.format(element["PAYMENT_TIME"].toDate()).toString();
              adminReferralList.add(AdminReferralLedgerModel(
                element["GRADE"].toString(),
                element["TREE"].toString(),
                element["USER_NAME"]??"",
                element["PHONE_NUMBER"]??"",
                element["TO_USER_ID"],
                element["FROM_USER_ID"],
                element.id,
                date,
                element["AMOUNT"],
                '',
                element["PAYMENT_TIME"].toDate(),dateTimeString
              ));

              if (!refferalDateList.map((item) => item.dateFormat).contains(date)) {
                refferalDateList.add(
                    TransactionDateModel(date, element["PAYMENT_TIME"].toDate()));
              }
              notifyListeners();
            }
            catch(e){
              print("error id :${element.id}");
            }

          }
          getToName();
          filterAdminReferralList = adminReferralList;
          notifyListeners();


      }
      notifyListeners();
    });
  }

  filterFetchReferralLedger(String item) {
    filterAdminReferralList = adminReferralList
        .where((element) =>
            element.fromName.toLowerCase().contains(item.toLowerCase()) ||
            element.fromNumber.toLowerCase().contains(item.toLowerCase()) ||
            element.toId.toLowerCase().contains(item.toLowerCase()) ||
            element.fromId.toLowerCase().contains(item.toLowerCase()) ||
            element.amount.toLowerCase().contains(item.toLowerCase()) ||
            element.transactionID.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  dateWiseFetchReferralLedger(var firstDate, var secondDate) {
    String date = '';
    String dateTimeString = '';
    adminReferralList.clear();
    filterAdminReferralList.clear();
    db
        .collection("TRANSACTIONS")
        .where("PAYMENT_TYPE", isEqualTo: "REFERRAL")
        .where("PAYMENT_TIME", isGreaterThanOrEqualTo: firstDate)
        .where("PAYMENT_TIME", isLessThanOrEqualTo: secondDate)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        adminReferralList.clear();
        filterAdminReferralList.clear();
        for (var element in value.docs) {
          date =
              outputDayNode.format(element["PAYMENT_TIME"].toDate()).toString();
          dateTimeString =
              outputDayNode3.format(element["PAYMENT_TIME"].toDate()).toString();
          adminReferralList.add(AdminReferralLedgerModel(
            element["GRADE"].toString(),
            element["TREE"].toString(),
            element["USER_NAME"].toString(),
            element["PHONE_NUMBER"].toString(),
            element["TO_USER_ID"],
            element["FROM_USER_ID"],
            element.id,
            date,
            element["AMOUNT"],
            '',
            element["PAYMENT_TIME"].toDate(),dateTimeString
          ));

          if (!refferalDateList.map((item) => item.dateFormat).contains(date)) {
            refferalDateList.add(
                TransactionDateModel(date, element["PAYMENT_TIME"].toDate()));
          }
          notifyListeners();

          filterAdminReferralList = adminReferralList;
          notifyListeners();
        }
        getToName();
      }
      notifyListeners();
    });
  }

  void getToName() {
    for (var elements in adminReferralList) {
      db.collection('USERS').doc(elements.toId).get().then((value) {
        if (value.exists) {
          Map<dynamic, dynamic> map = value.data() as Map;
          elements.toName = map['NAME'].toString();
          notifyListeners();
        }
      });
    }
  }

  void createExcelReferralLedgerReport(
      List<AdminReferralLedgerModel> referralExcelList) async {
    // loader=true;
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    final List<Object> list = [
      'SL',
      'Transaction ID'
          'Name',
      'Phone Number',
      'From ID',
      'To ID',
      'PaymentTime',
      'Amount',
    ];

    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    int index = 1;

    for (var element in referralExcelList) {
      i++;
      final List<Object> list = [
        index++,
        element.transactionID,
        element.fromName,
        element.fromNumber,
        element.fromId,
        element.toId,
        element.paymentTime,
        // DateFormat("hh:mm a").format(element.paymentTime),
        element.amount,
        // DateFormat("MM/dd/yyyy").format(element.dateTime),
      ];

      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    // if
    final String path = (await getApplicationSupportDirectory()).path;
    final fileName = '$path/Report.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

    File testFile = File("$path/Report.xlsx");

    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
    // Share.shareFiles([file.path], text: 'House report');

    // loader=false;
    notifyListeners();
  }

  void fetchFcmID() {
    fcmList.clear();
    db.collection('USERS').get().then((value) {
      if (value.docs.isNotEmpty) {
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data() as Map;
          fcmList.add(map['FCM_ID'].toString());
        }
        callOnFcmApiSendPushNotifications(
            title: 'NEWS TITLE',
            body: 'CONTENEGYEYGEY',
            fcmList: fcmList,
            imageLink:
                'https://firebasestorage.googleapis.com/v0/b/lio-care.appspot.com/o/1688553244534?alt=media&token=7064643d-646f-4470-b411-f6ec85cdbb1b');
      }
    });
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
          'key=AAAA2PUBAyQ:APA91bFENEwDsIjz37Z2rQ-MUH76WsMrOlWaJKOCO1F8wT1hgxI-mmAEyZ6e7KLAKF17-7GrjIETUGpA-uiuh1x4f-mcDiFZ6h9d7FoK_VPpQDES_GsFygP_tpsv96brDPiY0VmcItbo',
      // '
      // key=YOUR_SERVER_KEY'
      'project_id': '931823420196'
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
          'key=AAAA2PUBAyQ:APA91bFENEwDsIjz37Z2rQ-MUH76WsMrOlWaJKOCO1F8wT1hgxI-mmAEyZ6e7KLAKF17-7GrjIETUGpA-uiuh1x4f-mcDiFZ6h9d7FoK_VPpQDES_GsFygP_tpsv96brDPiY0VmcItbo'
      // 'key=YOUR_SERVER_KEY'
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
  double pendingRegistrationLimit = 50;

  fetchPendingRegistrations(bool firstFetch, [dynamic lastDoc = false]) async {
    DateTime regDate = DateTime.now();


    String date = '';

    var collectionRef;

    notifyListeners();
    if (!firstFetch) {
      pendingRegistrationLimit=pendingRegistrationLimit+limit;

      collectionRef = db
          .collection('USERS')
          .where("TYPE", isEqualTo: "MEMBER")
          .orderBy("REG_DATE", descending: true)
          .where("STATUS", isEqualTo: "IN_ACTIVE")
          .startAfter([lastDoc]).limit(limit);
    } else {
      registrationPendingList.clear();
      filterRegistrationPendingList.clear();
      collectionRef = db
          .collection('USERS')
          .where("TYPE", isEqualTo: "MEMBER")
          .orderBy("REG_DATE", descending: true)
          .where("STATUS", isEqualTo: "IN_ACTIVE")
          .limit(limit);
    }
    collectionRef.get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var element in snapshot.docs) {
          Map<dynamic, dynamic> regMap = element.data() as Map;

          Timestamp regDATE = regMap['REG_DATE'];
          regDate = DateTime.parse(regDATE.toDate().toString());
          DateTime date1 = DateTime.parse(regMap["REG_DATE"].toDate().toString());
          date = DateFormat('dd/MM/yyyy h:mm a').format(date1);

          registrationPendingList.add(MembersModel(
            regMap["DOCUMENT_ID"],
            regMap["NAME"],
            regMap["REFERENCE_NAME"]??"",
            regMap["PHONE"],
            element.id,
            date,
            regDate,
            regMap["TOTAL_PMC"].toString(),
            regMap["TOTAL_CMF"].toString(),
            regMap["TOTAL_HELP"].toString(),
            regMap["TOTAL_EARNINGS"].toString(),
            "",
            regMap["TOTAL_REFERRAL_COUNT"].toString(),
            "",
            regMap["TYPE"].toString(),
            "",
            "",
            "",""

          ));
        }
        filterRegistrationPendingList = registrationPendingList;
        notifyListeners();
      }
    });
  }

  filterPendingRegistrations(String item) {
    filterRegistrationPendingList = registrationPendingList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.phone.toLowerCase().contains(item.toLowerCase()) ||
            element.regid.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  dateWiseFilterPendingRegistration(var firstDate, var secondDate) {
    String date = '';
    kycSubmittedDate= '';
    kycVerifiedDate= '';
    kycRejectedDate = '';
    registrationPendingList.clear();
    filterRegistrationPendingList.clear();

    db
        .collection("USERS")
        .where("STATUS", isEqualTo: "IN_ACTIVE")
        .where("REG_DATE", isGreaterThanOrEqualTo: firstDate)
        .where("REG_DATE", isLessThanOrEqualTo: secondDate)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        registrationPendingList.clear();
        filterRegistrationPendingList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> regMap = element.data();

          DateTime paymentDate =
              DateTime.parse(regMap["REG_DATE"].toDate().toString());
          date = DateFormat('dd/MM/yyyy h:mm a').format(paymentDate);
          if(regMap["KYC_SUBMITTED_DATE"]!=""&&regMap["KYC_SUBMITTED_DATE"]!=null){
            kycSubmittedDate= outputFormat.format(regMap["KYC_SUBMITTED_DATE"].toDate());
          }
          if(regMap["KYC_VERIFIED_DATE"]!=""&&regMap["KYC_VERIFIED_DATE"]!=null){
            kycVerifiedDate=outputFormat.format(regMap["KYC_VERIFIED_DATE"].toDate());
          }
          if(regMap["KYC_REJECTED_DATE"]!=""&&regMap["KYC_REJECTED_DATE"]!=null){
            kycRejectedDate=outputFormat.format(regMap["KYC_REJECTED_DATE"].toDate());
          }


          registrationPendingList.add(MembersModel(
            regMap["DOCUMENT_ID"],
            regMap["NAME"],
            regMap["REFERENCE_NAME"]??"",
            regMap["PHONE"],
            element.id,
            date,
            regMap["REG_DATE"].toDate(),
            regMap["TOTAL_PMC"].toString(),
            regMap["TOTAL_CMF"].toString(),
            regMap["TOTAL_HELP"].toString(),
            regMap["TOTAL_EARNINGS"].toString(),
            "",
            regMap["TOTAL_REFERRAL_COUNT"].toString(),
            regMap['KYC_STATUS'] ?? "",
            regMap["TYPE"],
              kycSubmittedDate,
              kycVerifiedDate,
              kycRejectedDate,""
          ));
          filterRegistrationPendingList = registrationPendingList;
          notifyListeners();
        }
      }
    });
  }

  Future<void> fetchParticipants(bool firstFetch,
      [dynamic lastDoc = false]) async {
    participantsLength = 0;
    kycSubmittedDate= '';
    kycVerifiedDate= '';
    kycRejectedDate = '';
    // String name = '';
    // String phNumber = '';
    String date = '';
    // String id = '';
    // String image = '';

    DateTime scheduledTimeFrom = DateTime.now();
    var collectionRef;
    QuerySnapshot querySnapshot = await db.collection('USERS').get();
    participantsLength = querySnapshot.size;
    notifyListeners();

    if (!firstFetch) {
      collectionRef = db
          .collection('USERS')
          .where("TYPE", isEqualTo: "MEMBER")
          .orderBy("REG_DATE", descending: true)
          .startAfter([lastDoc]).limit(limit);
    } else {
      collectionRef = db
          .collection('USERS')
          .where("TYPE", isEqualTo: "MEMBER")
          .orderBy("REG_DATE", descending: true)
          .limit(limit);
      fetchParticipantsList.clear();
      filterFetchParticipantsList.clear();
    }
    collectionRef.get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var element in snapshot.docs) {
          Map<dynamic, dynamic> map1 = element.data() as Map;

          // DateTime paymentDate = DateTime.parse(element["REG_DATE"].toDate().toString());
          // date = DateFormat('dd/MM/yyyy h:mm a').format(paymentDate);
          Timestamp stttTo = map1['REG_DATE'];
          scheduledTimeFrom = DateTime.parse(stttTo.toDate().toString());

          if(map1["KYC_SUBMITTED_DATE"]!=""&&map1["KYC_SUBMITTED_DATE"]!=null){
            kycSubmittedDate= outputFormat.format(map1["KYC_SUBMITTED_DATE"].toDate());
          }
          if(map1["KYC_VERIFIED_DATE"]!=""&&map1["KYC_VERIFIED_DATE"]!=null){
            kycVerifiedDate=outputFormat.format(map1["KYC_VERIFIED_DATE"].toDate());
          }
          if(map1["KYC_REJECTED_DATE"]!=""&&map1["KYC_REJECTED_DATE"]!=null){
            kycRejectedDate=outputFormat.format(map1["KYC_REJECTED_DATE"].toDate());
          }

          if(map1["KYC_REJECT_REASON"]!=""&&map1["KYC_REJECT_REASON"]!=null){
            kycRejectedReason=map1["KYC_REJECT_REASON"].toString();
          }
          totalInvetorsCount = map1["TOTAL_INVITEES_COUNT"].toString()??"0";

          fetchParticipantsList.add(MembersModel(
            map1["DOCUMENT_ID"],
            map1["NAME"],
            map1["REFERENCE_NAME"]??"",
            map1["PHONE"],
            element.id,
            date,
            scheduledTimeFrom,
            map1["TOTAL_PMC"].toString(),
            map1["TOTAL_CMF"].toString(),
            map1["TOTAL_HELP"].toString(),
            map1["TOTAL_EARNINGS"].toString(),
            "",
              totalInvetorsCount,
            "",
            map1["TYPE"].toString(),
              kycSubmittedDate,
              kycVerifiedDate,
              kycRejectedDate,
              kycRejectedReason

          ));
        }
        filterFetchParticipantsList = fetchParticipantsList;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  filterParticipants(String item) {
    filterFetchParticipantsList = fetchParticipantsList
        .where((element) =>
            element.name.toLowerCase().contains(item.toLowerCase()) ||
            element.phone.toLowerCase().contains(item.toLowerCase()) ||
            element.regid.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  dateWiseFilterParticipants(var firstDate, var secondDate) async {
    participantsLength = 0;
    String date = '';
    kycSubmittedDate='';
    kycVerifiedDate='';
    kycRejectedDate='';
    fetchParticipantsList.clear();
    filterFetchParticipantsList.clear();
    QuerySnapshot querySnapshot = await db
        .collection("USERS")
        .where("REG_DATE", isGreaterThanOrEqualTo: firstDate)
        .where("REG_DATE", isLessThanOrEqualTo: secondDate)
        .get();
    participantsLength = querySnapshot.size;
    notifyListeners();

    db
        .collection("USERS")
        .where("REG_DATE", isGreaterThanOrEqualTo: firstDate)
        .where("REG_DATE", isLessThanOrEqualTo: secondDate)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        fetchParticipantsList.clear();
        filterFetchParticipantsList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();

          DateTime paymentDate =
              DateTime.parse(map["REG_DATE"].toDate().toString());
          date = DateFormat('dd/MM/yyyy h:mm a').format(paymentDate);

          if(map["KYC_SUBMITTED_DATE"]!=""&&map["KYC_SUBMITTED_DATE"]!=null){
            kycSubmittedDate= outputFormat.format(map["KYC_SUBMITTED_DATE"].toDate());
          }
          if(map["KYC_VERIFIED_DATE"]!=""&&map["KYC_VERIFIED_DATE"]!=null){
            kycVerifiedDate=outputFormat.format(map["KYC_VERIFIED_DATE"].toDate());
          }
          if(map["KYC_REJECTED_DATE"]!=""&&map["KYC_REJECTED_DATE"]!=null){
            kycRejectedDate=outputFormat.format(map["KYC_REJECTED_DATE"].toDate());
          }
          if(map["KYC_REJECT_REASON"]!=""&&map["KYC_REJECT_REASON"]!=null){
            kycRejectedReason=map["KYC_REJECT_REASON"].toString();
          }
          totalInvetorsCount = map["TOTAL_INVITEES_COUNT"].toString()??"0";

          fetchParticipantsList.add(MembersModel(
              map["DOCUMENT_ID"],
              map["NAME"],
              map["REFERENCE_NAME"]??"",
              map["PHONE"],
              element.id,
              date,
              map["REG_DATE"].toDate(),
              map["TOTAL_PMC"].toString(),
              map["TOTAL_CMF"].toString(),
              element["TOTAL_HELP"].toString(),
              map["TOTAL_EARNINGS"].toString(),
              "",
              totalInvetorsCount,
              map['KYC_STATUS'] ?? "",
              map["TYPE"].toString(),
              kycSubmittedDate,
              kycVerifiedDate,
              kycRejectedDate,
              kycRejectedReason
          ));
          filterFetchParticipantsList = fetchParticipantsList;
          notifyListeners();
        }
      }
      notifyListeners();
    });
  }

  void placeMembersInChain(String referrerId, String childId) {
    int i = 1;
    db.collection("MEMBERS").doc(referrerId).get().then((chainValue) {
      Map<dynamic, dynamic> chainMap = chainValue.data() as Map;
      Map<dynamic, dynamic> map3 = chainValue.get('PARENTS') as Map;
      HashMap<String, dynamic> map4 = HashMap();
      HashMap<String, dynamic> map44 = HashMap();
      if (chainMap["LCHILD"] == "") {
        db
            .collection("MEMBERS")
            .doc(referrerId)
            .set({"LCHILD": childId}, SetOptions(merge: true));
        if (map3.length < 7) {
          map4['L1'] = referrerId;
          for (var elements in map3.values) {
            i++;
            map4['L$i'] = elements;
          }
          map44['PARENTS'] = map4;
          db
              .collection("MEMBERS")
              .doc(childId)
              .set(map44, SetOptions(merge: true));
        } else {
          map3.remove("L7");
          map4['L1'] = referrerId;
          for (var elements in map3.values) {
            i++;
            map4['L$i'] = elements;
          }
          map44['PARENTS'] = map4;
          db
              .collection("MEMBERS")
              .doc(childId)
              .set(map44, SetOptions(merge: true));
        }
      } else if (chainMap["RCHILD"] == "") {
        db
            .collection("MEMBERS")
            .doc(referrerId)
            .set({"RCHILD": childId}, SetOptions(merge: true));
        if (map3.length < 7) {
          map4['L1'] = referrerId;
          for (var elements in map3.values) {
            i++;
            map4['L$i'] = elements;
          }
          map44['PARENTS'] = map4;
          db
              .collection("MEMBERS")
              .doc(childId)
              .set(map44, SetOptions(merge: true));
        } else {
          map3.remove("L7");
          map4['L1'] = referrerId;
          for (var elements in map3.values) {
            i++;
            map4['L$i'] = elements;
          }
          map44['PARENTS'] = map4;
          db
              .collection("MEMBERS")
              .doc(childId)
              .set(map44, SetOptions(merge: true));
        }
      }
    });
  }




  void addTotalPayments() {
    List<String> basicAmounts = [
      "200",
      "200",
      "400",
      "1000",
      "2000",
      "5000",
      "10000"
    ];
    List<String> autoOneAmounts = [
      "200",
      "400",
      "1000",
      "5000",
      "10000",
      "15000"
    ];
    List<String> autoTwoAmounts = ["2000", "4000", "5000", "10000", "20000"];
    HashMap<String, Object> basic = HashMap();
    basic["MASTER_CLUB"] = basicAmounts;
    db
        .collection("TOTAL_AMOUNTS")
        .doc("UPGRADES")
        .set(basic, SetOptions(merge: true));
    HashMap<String, Object> autoOne = HashMap();
    autoOne["STAR_CLUB"] = autoOneAmounts;
    db
        .collection("TOTAL_AMOUNTS")
        .doc("UPGRADES")
        .set(autoOne, SetOptions(merge: true));
    HashMap<String, Object> autoTwo = HashMap();
    autoTwo["CROWN_CLUB"] = autoTwoAmounts;
    db
        .collection("TOTAL_AMOUNTS")
        .doc("UPGRADES")
        .set(autoTwo, SetOptions(merge: true));
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

  // Future<void> addFonts() async {
  //   List<String> googleFontsList = GoogleFonts.asMap().keys.toList();
  //
  //   mRoot.child("0").child("FONTS").set(googleFontsList);
  //   notifyListeners();
  // }

  void showBottomSheet(
    BuildContext context,
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
                  onTap: () => {imageFromCamera(), Navigator.pop(context)}),
              ListTile(
                  leading: const Icon(
                    Icons.photo,
                    //color: cl172f55
                  ),
                  title: const Text(
                    'Gallery',
                  ),
                  onTap: () => {imageFromGallery(), Navigator.pop(context)}),
            ],
          );
        });
    // ImageSource
  }

  imageFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 15);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  imageFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 15);
    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    } else {}
    if (pickedFile!.path.isEmpty) retrieveLostData();

    notifyListeners();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      fileImage = File(response.file!.path);

      notifyListeners();
    }
  }

  Future<void> _cropImage(
    String path,
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
      fileImage = File(croppedFile.path);

      // imgCheck = true;
      notifyListeners();
    }
  }

  Reference ref9 = FirebaseStorage.instance.ref("PROFILE_IMAGE");
  bool addAdminBool = false;

  Future<void> addAdmin(String userID, String from, String adminName,
      String addAdminId, BuildContext context) async {
    addAdminBool = true;
    notifyListeners();
    DateTime now = DateTime.now();
    String adminId = now.millisecondsSinceEpoch.toString();
    HashMap<String, Object> addAdmin = HashMap();
    HashMap<String, Object> editAdmin = HashMap();
    List<String> list = [];
    for (var element in privilegeList) {
      if (element.select) {
        list.add(element.item.toString());
      }
    }

    editAdmin["NAME"] = addAdminNameCT.text;
    editAdmin["PHONE_NUMBER"] = addAdminNumberCT.text;
    editAdmin["PASSWORD"] = addAdminPasswordCT.text;
    editAdmin["PRIVILEGE"] = list;
    editAdmin["EDITED_BY_NAME"] = adminName;
    editAdmin["EDITED_BY_ID"] = addAdminId;
    editAdmin["EDITED_DATE"] = now;

    addAdmin["NAME"] = addAdminNameCT.text;
    addAdmin["PHONE_NUMBER"] = addAdminNumberCT.text;
    addAdmin["PASSWORD"] = addAdminPasswordCT.text;
    addAdmin["ADDED_BY_NAME"] = adminName;
    addAdmin["ADDED_BY_ID"] = addAdminId;
    addAdmin["STATUS"] = "ACTIVE";
    addAdmin["REG_DATE"] = now;
    addAdmin["PRIVILEGE"] = list;

    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref9 = FirebaseStorage.instance.ref().child(time);
      await ref9.putFile(fileImage!).whenComplete(() async {
        await ref9.getDownloadURL().then((value3) {
          addAdmin['PROFILE_IMAGE'] = value3;
          editAdmin['PROFILE_IMAGE'] = value3;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      addAdmin['PROFILE_IMAGE'] = adminProfile;
      editAdmin['PROFILE_IMAGE'] = adminProfile;
    }

    if (from == "ADD") {
      db
          .collection("ADMINS")
          .doc(adminId)
          .set(addAdmin, SetOptions(merge: true));
    } else {
      db
          .collection("ADMINS")
          .doc(userID)
          .set(editAdmin, SetOptions(merge: true));
    }
    addAdminBool = false;
    notifyListeners();
    finish(context);
    clearAddAdminCT();
  }

  void clearAddAdminCT() {
    addAdminNameCT.clear();
    addAdminNumberCT.clear();
    addAdminPasswordCT.clear();
    fileImage = null;
    checkAll = false;
    for (var element in privilegeList) {
      element.select = false;
    }
    notifyListeners();
  }

  fetchAdminForEdit(String docID) {
    db.collection("ADMINS").doc(docID).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> map = value.data() as Map;
        addAdminNameCT.text = map["NAME"].toString();
        addAdminNumberCT.text = map["PHONE_NUMBER"].toString();
        addAdminPasswordCT.text = map["PASSWORD"].toString();
        adminProfile = map["PROFILE_IMAGE"] ?? "";
        if (map["PRIVILEGE"] != null) {
          map["PRIVILEGE"].forEach((value2) {
            for (var element in privilegeList) {
              if (element.item == value2) {
                element.select = true;
              }
            }
          });
        }
        notifyListeners();
      }
    });
  }


  var outputFormat = DateFormat('dd/MM/yyyy');
  List<AdminsListModel> adminList = [];
  List<AdminsListModel> filterAdminList = [];

  StreamSubscription? _streamAdminDetails;
  void fetchAdminsDetails(String userAdminId) {
    if(_streamAdminDetails!=null) {
      _streamAdminDetails!.cancel();
    }
    _streamAdminDetails = db.collection("ADMINS").snapshots().listen(
      (value) {
        adminList.clear();
        if (value.docs.isNotEmpty) {
          for (var element in value.docs) {
            Map<dynamic, dynamic> map = element.data();
            if(element.id!=userAdminId){
            adminList.add(AdminsListModel(
                element.id,
                map["PROFILE_IMAGE"],
                map["NAME"].toString(),
                map["PHONE_NUMBER"].toString(),
                outputFormat.format(
                  map["REG_DATE"].toDate(),
                )));}
          }
          filterAdminList = adminList;
          notifyListeners();
          filterAdminList.sort((a, b) => b.id.compareTo(a.id));
          notifyListeners();
        }
      },
    );
  }

  void deleteAdmin(String id, BuildContext context) {
    if (id == adminId) {
      const snackBar = SnackBar(
        content: Text("You can't Remove Yourself"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      db.collection('ADMINS').doc(id).delete();
    }
  }

  void filterAdminLists(String item) {
    filterAdminList = adminList
        .where((a) =>
            a.name.toLowerCase().contains(item.toLowerCase()) ||
            a.phNumber.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void adminAddTask(String memberId, String memberName, String from,
      String taskId, BuildContext context) async {
    String categoryId = DateTime.now().millisecondsSinceEpoch.toString();

    Map<String, Object> dataMapp = HashMap();

    if (from == "ADD") {
      dataMapp["TASK"] = taskController.text;
      dataMapp["TASK_LINK"] = taskLinkController.text;
      dataMapp["ADDED_BY"] = memberId;
      dataMapp["ADDED_TIME"] = DateTime.now();
      dataMapp["ADDED_NAME"] = memberName;
      dataMapp["START_DATE"] = durationStart;
      dataMapp["END_DATE"] = durationEnd;
      dataMapp["TASK_HEADING"] = taskHeadingController.text;
      db
          .collection("TASKS")
          .doc(categoryId)
          .set(dataMapp, SetOptions(merge: true));
    } else {
      dataMapp["TASK"] = taskController.text;
      dataMapp["TASK_LINK"] = taskLinkController.text;
      dataMapp["LAST_EDITED_BY"] = memberId;
      dataMapp["LAST_EDITED_TIME"] = DateTime.now();
      dataMapp["LAST_EDITED_NAME"] = memberName;
      dataMapp["START_DATE"] = durationStart;
      dataMapp["END_DATE"] = durationEnd;
      dataMapp["TASK_HEADING"] = taskHeadingController.text;
      db.collection("TASKS").doc(taskId).set(dataMapp, SetOptions(merge: true));
    }

  showNotificationSnackBar(context, "Task assigned successfully");
    addTaskClearController();
    finish(context);
    // callNext(AdminMenuScreen(), context);
    notifyListeners();
  }

  String taskAddedBy = '';
  String taskEditedBy = '';
  String taskStatus = '';
  String taskAddedDateTime = '';

  void fetchTaskEdit(
      String taskId, String addedName, String dateTime, String taskHeading) {
    String startDuration = '';
    String endDuration = '';

    db.collection("TASKS").doc(taskId).get().then((taskValue) {
      Map<dynamic, dynamic> taskMap = taskValue.data() as Map;
      taskController.text = taskMap["TASK"];
      taskLinkController.text = taskMap["TASK_LINK"];
      durationEnd = taskMap["END_DATE"].toDate();
      durationStart = taskMap["START_DATE"].toDate();
      startDuration = outputDayNode.format(durationStart).toString();
      endDuration = outputDayNode.format(durationEnd).toString();
      taskDurationController.text = "$startDuration - $endDuration";
      taskHeadingController.text = taskHeading;

      taskAddedBy = addedName;
      taskAddedDateTime = dateTime;
      notifyListeners();
    });
  }

  addTaskClearController() {
    taskController.clear();
    taskLinkController.clear();
    taskHeadingController.clear();
    taskDurationController.clear();
    notifyListeners();
  }

  String memberName = '';
  String memberReferredName = '';
  String memberDocID = '';
  String memberPhone = '';
  String memberRegId = '';
  String memberRegDate = '';
  String memberPMC = '';
  String memberDonation = '';
  String memberReceiveHelp = '';
  String memberInvitations = '';
  String memberGiveHelp = '';
  String kycStatus = '';
  String userType = '';
  String kycSubmittedDate = '';
  String kycVerifiedDate = '';
  String kycRejectedDate = '';
  String kycRejectedReason = '';
  String totalInvetorsCount = '';

  String memberProfileImage = '';
  List<MembersModel> membersKycSubmittedList = [];
  List<MembersModel> membersList = [];
  List<MembersModel> adminLeadersList = [];
  List<MembersModel> filterMembersList = [];
  int pendingRegistrationLength = 0;
  int referralLimit = 50;
  int referralLoadLimit = 50;
  int participantsLength = 0;

  Future<void> fetchMembersByDate(var firstDate, var secondDate) async {
    membersList.clear();
    filterMembersList.clear();
    kycSubmittedDate='';
    kycVerifiedDate='';
    kycRejectedDate='';
    db.collection("USERS").where("STATUS", isEqualTo: "ACTIVE")
        // .where("TYPE",whereIn: ["MEMBER","LEADER"])
        .where("REG_DATE", isGreaterThanOrEqualTo: firstDate)
        .where("REG_DATE", isLessThanOrEqualTo: secondDate)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        membersList.clear();
        filterMembersList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> activeMember = elements.data();
          memberName = activeMember["NAME"];
          memberReferredName = activeMember["REFERENCE_NAME"]??"";
          memberPhone = activeMember["PHONE"];
          memberDocID = activeMember["DOCUMENT_ID"];
          memberRegId = elements.id;
          memberRegDate = outputFormat.format(activeMember["REG_DATE"].toDate());
          memberPMC = activeMember["TOTAL_PMC"].toString();
          memberDonation = activeMember["TOTAL_CMF"].toString();
          memberGiveHelp = activeMember["TOTAL_HELP"].toString();
          if(activeMember["KYC_SUBMITTED_DATE"]!=""&&activeMember["KYC_SUBMITTED_DATE"]!=null){
            kycSubmittedDate= outputFormat.format(activeMember["KYC_SUBMITTED_DATE"].toDate());
          }
          if(activeMember["KYC_VERIFIED_DATE"]!=""&&activeMember["KYC_VERIFIED_DATE"]!=null){
            kycVerifiedDate=outputFormat.format(activeMember["KYC_VERIFIED_DATE"].toDate());
          }
          if(activeMember["KYC_REJECTED_DATE"]!=""&&activeMember["KYC_REJECTED_DATE"]!=null){
            kycRejectedDate=outputFormat.format(activeMember["KYC_REJECTED_DATE"].toDate());
          }
          if(activeMember["KYC_REJECT_REASON"]!=""&&activeMember["KYC_REJECT_REASON"]!=null){
            kycRejectedReason=activeMember["KYC_REJECT_REASON"].toString();
          }
          memberReceiveHelp = activeMember["TOTAL_EARNINGS"].toString();
          memberProfileImage = activeMember["ItemImage"] ?? "";
          totalInvetorsCount = activeMember["TOTAL_INVITEES_COUNT"].toString()??"0";
          // memberInvitations=activeMember[""];
          // memberGiveHelp=activeMember[""];
          membersList.add(MembersModel(
              memberDocID,
              memberName,
              memberReferredName,
              memberPhone,
              memberRegId,
              memberRegDate,
              activeMember["REG_DATE"].toDate(),
              memberPMC,
              memberDonation,
              memberGiveHelp,
              memberReceiveHelp,
              memberProfileImage,
              totalInvetorsCount,
              // activeMember["TOTAL_REFERRAL_COUNT"].toString(),
              activeMember['KYC_STATUS'] ?? "",
              activeMember["TYPE"].toString(),
              kycSubmittedDate,
              kycVerifiedDate,
              kycRejectedDate,
              kycRejectedReason



          ));
        }
        filterMembersList = membersList;
        notifyListeners();
      }
      // else{
      //   filterMembersList=[];
      //   notifyListeners();
      // }
    });
  }
double membersListLimit = 50;
  Future<void> fetchAdminLeaders() async {
    print("admin leader fetching");
    adminLeadersList.clear();
    var collectionRef;
    kycSubmittedDate='';
    kycVerifiedDate='';
    kycRejectedDate='';
      collectionRef = db
          .collection('USERS')
          // .orderBy("REG_DATE", descending: true)
          // .where("STATUS", isEqualTo: "ACTIVE")
          .where("TYPE", isEqualTo: "ADMIN LEADER");


    collectionRef.get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var elements in snapshot.docs) {
          Map<dynamic, dynamic> activeMemeber = elements.data() as Map;
          memberDocID = activeMemeber["DOCUMENT_ID"];
          memberName = activeMemeber["NAME"];
          memberReferredName = activeMemeber["REFERENCE_NAME"]??"";
          memberPhone = activeMemeber["PHONE"];
          memberRegId = elements.id;
          memberRegDate =
              outputFormat.format(activeMemeber["REG_DATE"].toDate());
          memberPMC = activeMemeber["TOTAL_PMC"].toString();
          memberDonation = activeMemeber["TOTAL_CMF"].toString();
          memberGiveHelp = activeMemeber["TOTAL_HELP"].toString();

          memberReceiveHelp = activeMemeber["TOTAL_EARNINGS"].toString();
          userType = activeMemeber["TYPE"].toString();
          memberProfileImage = activeMemeber["ItemImage"] ?? "";
          kycStatus = activeMemeber['KYC_STATUS'] ?? "";
          totalInvetorsCount = activeMemeber["TOTAL_INVITEES_COUNT"].toString()??"0";

          if (activeMemeber["KYC_SUBMITTED_DATE"] != "" &&
              activeMemeber["KYC_SUBMITTED_DATE"] != null) {
            kycSubmittedDate = outputFormat.format(
                activeMemeber["KYC_SUBMITTED_DATE"].toDate());
          }
          if (activeMemeber["KYC_VERIFIED_DATE"] != "" &&
              activeMemeber["KYC_VERIFIED_DATE"] != null) {
            kycVerifiedDate = outputFormat.format(
                activeMemeber["KYC_VERIFIED_DATE"].toDate());
          }
          if (activeMemeber["KYC_REJECTED_DATE"] != "" &&
              activeMemeber["KYC_REJECTED_DATE"] != null) {
            kycRejectedDate = outputFormat.format(
                activeMemeber["KYC_REJECTED_DATE"].toDate());
          }
          adminLeadersList.add(MembersModel(
              memberDocID,
              memberName,
              memberReferredName,
              memberPhone,
              memberRegId,
              memberRegDate,
              activeMemeber["REG_DATE"].toDate(),
              memberPMC,
              memberDonation,
              memberGiveHelp,
              memberReceiveHelp,
              memberProfileImage,
              totalInvetorsCount,
              kycStatus,
              userType,
              kycSubmittedDate,
              kycVerifiedDate,
              kycRejectedDate,""

          ));
          adminLeadersList.sort((b, a) => a.regDate.compareTo(b.regDate));
        }
        notifyListeners();
      }
      notifyListeners();
    });
  }

  Future<void> firstFetchMembers(bool firstFetch,
      [dynamic lastDoc = false]) async {
    var collectionRef;

    kycSubmittedDate='';
    kycVerifiedDate='';
    kycRejectedDate='';
    if (!firstFetch) {
      membersListLimit=membersListLimit+limit;
      collectionRef = db
          .collection('USERS')
          .where("TYPE", isEqualTo: "MEMBER")
          .orderBy("REG_DATE", descending: true)
          .where("STATUS", isEqualTo: "ACTIVE")
          .startAfter([lastDoc]).limit(limit);
    } else {
      collectionRef = db
          .collection('USERS')
          .where("TYPE", isEqualTo: "MEMBER")
          .orderBy("REG_DATE", descending: true)
          .where("STATUS", isEqualTo: "ACTIVE")
          .limit(limit);
      membersList.clear();
      filterMembersList.clear();
    }
    collectionRef.get().then((QuerySnapshot snapshot) {
      // if (firstFetch) {
      //
      // }
      if (snapshot.docs.isNotEmpty) {
        for (var elements in snapshot.docs) {
          Map<dynamic, dynamic> activeMemeber = elements.data() as Map;
          memberDocID = activeMemeber["DOCUMENT_ID"];
          memberName = activeMemeber["NAME"];
          memberReferredName = activeMemeber["REFERENCE_NAME"]??"";
          memberPhone = activeMemeber["PHONE"];
          memberRegId = elements.id;
          memberRegDate =
              outputFormat.format(activeMemeber["REG_DATE"].toDate());
          memberPMC = activeMemeber["TOTAL_PMC"].toString();
          memberDonation = activeMemeber["TOTAL_CMF"].toString();
          memberGiveHelp = activeMemeber["TOTAL_HELP"].toString();

          memberReceiveHelp = activeMemeber["TOTAL_EARNINGS"].toString();
          userType = activeMemeber["TYPE"].toString();
          memberProfileImage = activeMemeber["ItemImage"] ?? "";
          kycStatus = activeMemeber['KYC_STATUS'] ?? "";
          totalInvetorsCount = activeMemeber["TOTAL_INVITEES_COUNT"].toString()??"0";

          if(activeMemeber["KYC_SUBMITTED_DATE"]!=""&&activeMemeber["KYC_SUBMITTED_DATE"]!=null){
            kycSubmittedDate= outputFormat.format(activeMemeber["KYC_SUBMITTED_DATE"].toDate());
          }
          if(activeMemeber["KYC_VERIFIED_DATE"]!=""&&activeMemeber["KYC_VERIFIED_DATE"]!=null){
            kycVerifiedDate=outputFormat.format(activeMemeber["KYC_VERIFIED_DATE"].toDate());
          }
          if(activeMemeber["KYC_REJECTED_DATE"]!=""&&activeMemeber["KYC_REJECTED_DATE"]!=null){
            kycRejectedDate=outputFormat.format(activeMemeber["KYC_REJECTED_DATE"].toDate());
          }
          if(activeMemeber["KYC_REJECT_REASON"]!=""&&activeMemeber["KYC_REJECT_REASON"]!=null){
            kycRejectedReason=activeMemeber["KYC_REJECT_REASON"].toString();
          }




          // memberInvitations=activeMemeber[""];
          // memberGiveHelp=activeMemeber[""];
          membersList.add(MembersModel(
              memberDocID,
              memberName,
              memberReferredName,
              memberPhone,
              memberRegId,
              memberRegDate,
              activeMemeber["REG_DATE"].toDate(),
              memberPMC,
              memberDonation,
              memberGiveHelp,
              memberReceiveHelp,
              memberProfileImage,
              totalInvetorsCount,
              // activeMemeber["TOTAL_REFERRAL_COUNT"].toString(),
              kycStatus,
              userType,
              kycSubmittedDate,
              kycVerifiedDate,
              kycRejectedDate,
              kycRejectedReason

          ));
        }
        filterMembersList = membersList;
        notifyListeners();
        // print(transcation_HistoryList.map((e) => e.paymentTime.toString()+'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'));
      }
      notifyListeners();
    });

    // db.collection("USERS").where("STATUS",isEqualTo: "ACTIVE").limit(50).orderBy("REG_DATE",descending: true)
    //     .get().then((value) {
    //   if(value.docs.isNotEmpty){
    //     membersList.clear();
    //     filterMembersList.clear();
    //     for(var elements in value.docs){
    //       Map<dynamic, dynamic> activeMemeber = elements.data();
    //        memberName=activeMemeber["NAME"];
    //        memberPhone=activeMemeber["PHONE"];
    //        memberRegId=elements.id;
    //        memberRegDate=outputFormat.format(activeMemeber["REG_DATE"].toDate());
    //        memberPMF=activeMemeber["TOTAL_AMF"].toString();
    //        memberDonation=activeMemeber["TOTAL_DONATION"].toString();
    //        memberReceiveHelp=activeMemeber["TOTAL_EARNINGS"].toString();
    //       memberProfileImage=activeMemeber["ItemImage"]??"";
    //
    //       // memberInvitations=activeMemeber[""];
    //        // memberGiveHelp=activeMemeber[""];
    //       membersList.add(MembersModel(memberName, memberPhone, memberRegId, memberRegDate, memberPMF, memberDonation, memberReceiveHelp,memberProfileImage));
    //     }
    //     filterMembersList = membersList;
    //     notifyListeners();
    //   }
    //
    //
    // });
  }

  String memberInviteesCount = '';
  fetchMemberInviteesCount(String memberId) async {
    var inviteesSnapshot = await db
        .collection('USERS')
        .where("STATUS", isEqualTo: "ACTIVE")
        .where("REFERENCE", isEqualTo: memberId).count().get();

    memberInviteesCount = inviteesSnapshot.count.toString();
    notifyListeners();

  }

  Future<void> fetchMembersKycSubmitted() async {

    kycSubmittedDate='';
    kycVerifiedDate='';
    kycRejectedDate='';
        db
          .collection('USERS')
            .where("TYPE", isEqualTo: "MEMBER")
          .orderBy("REG_DATE", descending: true)
          .where("STATUS", isEqualTo: "ACTIVE")
          .where("KYC_STATUS", isEqualTo: "SUBMITTED").
    snapshots().listen((QuerySnapshot snapshot) {
        membersKycSubmittedList.clear();
      if (snapshot.docs.isNotEmpty) {
        for (var elements in snapshot.docs) {
          Map<dynamic, dynamic> activeMemeber = elements.data() as Map;
          memberDocID = activeMemeber["DOCUMENT_ID"];
          memberName = activeMemeber["NAME"];
          memberReferredName = activeMemeber["REFERENCE_NAME"]??"";
          memberPhone = activeMemeber["PHONE"];
          memberRegId = elements.id;
          memberRegDate =
              outputFormat.format(activeMemeber["REG_DATE"].toDate());
          memberPMC = activeMemeber["TOTAL_PMC"].toString();
          memberDonation = activeMemeber["TOTAL_CMF"].toString();
          memberGiveHelp = activeMemeber["TOTAL_HELP"].toString();
          memberReceiveHelp = activeMemeber["TOTAL_EARNINGS"].toString();
          userType = activeMemeber["TYPE"].toString();
          memberProfileImage = activeMemeber["ItemImage"] ?? "";
          kycStatus = activeMemeber['KYC_STATUS'] ?? "";
          if(activeMemeber["KYC_SUBMITTED_DATE"]!=""&&activeMemeber["KYC_SUBMITTED_DATE"]!=null){
            kycSubmittedDate= outputFormat.format(activeMemeber["KYC_SUBMITTED_DATE"].toDate());
          }
          if(activeMemeber["KYC_VERIFIED_DATE"]!=""&&activeMemeber["KYC_VERIFIED_DATE"]!=null){
            kycVerifiedDate=outputFormat.format(activeMemeber["KYC_VERIFIED_DATE"].toDate());
          }
          if(activeMemeber["KYC_REJECTED_DATE"]!=""&&activeMemeber["KYC_REJECTED_DATE"]!=null){
            kycRejectedDate=outputFormat.format(activeMemeber["KYC_REJECTED_DATE"].toDate());
          }
          totalInvetorsCount = activeMemeber["TOTAL_INVITEES_COUNT"].toString()??"0";
          membersKycSubmittedList.add(MembersModel(
              memberDocID,
              memberName,
              memberReferredName,
              memberPhone,
              memberRegId,
              memberRegDate,
              activeMemeber["REG_DATE"].toDate(),
              memberPMC,
              memberDonation,
              memberGiveHelp,
              memberReceiveHelp,
              memberProfileImage,
              totalInvetorsCount,
              kycStatus,
              userType,
              kycSubmittedDate,
              kycVerifiedDate,
              kycRejectedDate,
              ""

          ));
        }
        notifyListeners();
      }
      notifyListeners();
    });

  }

  void filterMembersLists(String item) {
    filterMembersList = membersList
        .where((a) =>
            a.name.toLowerCase().contains(item.toLowerCase()) ||
            a.phone.toLowerCase().contains(item.toLowerCase()) ||
            a.regid.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  //getUserHistoryDateWise(userId, firstDate2, endDate2UserHis);
  DateRangePickerController dateRangePickerController =
      DateRangePickerController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  DateTime firstDate = DateTime.now();
  DateTime secondDate = DateTime.now();
  DateTime endDate2 = DateTime.now();
  DateTime durationStart = DateTime.now();
  DateTime durationEnd = DateTime.now();
  String startDateFormat = '';
  String endDateFormat = '';
  String showSelectedDate = '';
  bool isDateSelected = false;

  //firstDateUserHis  endDate2UserHis
  void showCalendarDialog(BuildContext context, String fromWhere) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(
          selectionMode: DateRangePickerSelectionMode.range,
          controller: dateRangePickerController,
          initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 25.0,
          showTodayButton: true,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,
          onSubmit: (Object? val) {
            isDateSelected = true;

            // isDateSelected = true;
            dateRangePickerController.selectedRange = val as PickerDateRange?;

            if (dateRangePickerController.selectedRange!.endDate == null) {
              ///single date picker
              firstDate = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.startDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));

              final formatter = DateFormat('dd/MM/yyyy');
              showSelectedDate = formatter.format(firstDate);
              if (fromWhere == "MEMBERS") {
                kycValue = 'All';

                fetchMembersByDate(firstDate2, endDate2);

              } else if (fromWhere == "BLOCKLIST") {
                fetchBlockedUsersDateFilter(firstDate2, endDate2);
              } else if (fromWhere == "PMC_REPORT") {
                adminPMCDateWiseFilter(firstDate2, endDate2,"PMC");
              } else if (fromWhere == "PRC_REPORT") {
                adminPMCDateWiseFilter(firstDate2, endDate2,"PRC");
              } else if (fromWhere == "HELP_REPORT") {
                reportLoadMore = false;
                dateWiseFilterGiveHelpReport(firstDate2, endDate2);
              } else if (fromWhere == 'CMF_REPORT') {
                dateWiseFilterDonation(firstDate2, endDate2);
              } else if (fromWhere == "TOTAL_REGISTRATION") {
                dateWiseFilterPendingRegistration(firstDate2, endDate2);
              } else if (fromWhere == "PARTICIPANTS") {
                dateWiseFilterParticipants(firstDate2, endDate2);
              } else if (fromWhere == "REFERRAL_LEDGER") {
                dateWiseFetchReferralLedger(firstDate2, endDate2);
              } else if (fromWhere == 'Transaction') {
                dateWiseFilterTransaction(firstDate2, endDate2);
              } else if (fromWhere == 'Referral') {
                dateWiseFetchReferralLedger(firstDate2, endDate2);
              } else {}
              notifyListeners();
            } else {
              ///two dates select picker
              firstDate = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.endDate!;
              endDate2 = secondDate.add(const Duration(hours: 24));
              DateTime firstDate2 = firstDate.subtract(Duration(
                  hours: firstDate.hour,
                  minutes: firstDate.minute,
                  seconds: firstDate.second));
              if (fromWhere == "MEMBERS") {
                kycValue = 'All';

                fetchMembersByDate(firstDate2, endDate2);
              } else if (fromWhere == "HELP_REPORT") {
                reportLoadMore = false;
                dateWiseFilterGiveHelpReport(firstDate2, endDate2);
              } else if (fromWhere == "PMC_REPORT") {
                adminPMCDateWiseFilter(firstDate2, endDate2,"PMC");
              } else if (fromWhere == 'Transaction') {
                dateWiseFilterTransaction(firstDate2, endDate2);
              } else if (fromWhere == 'CMF_REPORT') {
                dateWiseFilterDonation(firstDate2, endDate2);
              } else if (fromWhere == "TOTAL_REGISTRATION") {
                dateWiseFilterPendingRegistration(firstDate2, endDate2);
              } else if (fromWhere == "PARTICIPANTS") {
                dateWiseFilterParticipants(firstDate2, endDate2);
              } else if (fromWhere == "REFERRAL_LEDGER") {
                dateWiseFetchReferralLedger(firstDate2, endDate2);
              } else if (fromWhere == 'Referral') {
                dateWiseFetchReferralLedger(firstDate2, endDate2);
              } else {
                fetchBlockedUsersDateFilter(firstDate2, endDate2);
              }

              isDateSelected = true;

              final formatter = DateFormat('dd/MM/yyyy');
              startDateFormat = formatter.format(firstDate);
              endDateFormat = formatter.format(secondDate);
              if (startDateFormat != endDateFormat) {
                showSelectedDate = "$startDateFormat - $endDateFormat";
              } else {
                showSelectedDate = startDateFormat;
              }

              notifyListeners();
            }
            finish(context);
          },
          onCancel: () {
            isDateSelected = false;
            dateRangePickerController.selectedRange = null;
            dateRangePickerController.selectedDate = null;
            showSelectedDate = '';
            if (fromWhere == "MEMBERS") {
              kycValue = 'All';

              firstFetchMembers(
                true,
              );
            } else if (fromWhere == "PMC_REPORT") {
              fetchAdminPMCData("PMC",true);
            } else if (fromWhere == "CMF_REPORT") {
            fetchAdminDonationData(true);
            } else if (fromWhere == "TOTAL_REGISTRATION") {
              fetchPendingRegistrations(true);
            } else if (fromWhere == "HELP_REPORT") {
              fetchAdminHelpReport(true);
            } else if (fromWhere == "PARTICIPANTS") {
              fetchParticipants(true);
            } else if (fromWhere == "REFERRAL_LEDGER") {
              fetchReferralLedger(true);
            } else if (fromWhere == 'Transaction') {
              fetchTransactionHistory('', true);
            } else {
              fetchBlockedUsers();
            }
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

  void adminTaskAssignDateSelect(BuildContext context) {
    Widget calendarWidget() {
      return SizedBox(
        width: 300,
        height: 300,
        child: SfDateRangePicker(

          selectionMode: DateRangePickerSelectionMode.range,
          controller: dateRangePickerController,
          initialSelectedRange: PickerDateRange(_startDate, _endDate),
          allowViewNavigation: true,
          headerHeight: 20.0,
          showTodayButton: false,
          headerStyle: const DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
          ),
          initialSelectedDate: DateTime.now(),
          navigationMode: DateRangePickerNavigationMode.snap,
          monthCellStyle: const DateRangePickerMonthCellStyle(
              todayTextStyle: TextStyle(fontWeight: FontWeight.bold)),
          showActionButtons: true,



          onSubmit: (Object? val) {

            print("today button is working");

            dateRangePickerController.selectedRange = val as PickerDateRange?;

            if (dateRangePickerController.selectedRange!.endDate == null) {
              ///single date picker

              durationStart = dateRangePickerController.selectedRange!.startDate!;
              final formatter = DateFormat('dd/MM/yyyy');
              showSelectedDate = formatter.format(durationStart);
              taskDurationController.text = showSelectedDate;
              durationEnd = dateRangePickerController.selectedRange!.endDate!;

              notifyListeners();
            } else {
              ///two dates select picker

              firstDate = dateRangePickerController.selectedRange!.startDate!;
              durationStart = dateRangePickerController.selectedRange!.startDate!;
              secondDate = dateRangePickerController.selectedRange!.endDate!;
              durationEnd = dateRangePickerController.selectedRange!.endDate!;

              final formatter = DateFormat('dd/MM/yyyy');
              taskDurationController.text = '${formatter.format(firstDate)}-${formatter.format(secondDate)}';
              notifyListeners();
            }
            finish(context);
          },
          onCancel: () {
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
            content: calendarWidget(),
          );
        });
    notifyListeners();
  }

  List<AdminsTransactionListModel> transcation_HistoryList = [];
  List<AdminsTransactionListModel> filter_Transcation_HistoryList = [];
  List<AdminsTransactionListModel> home_Transcation_HistoryList = [];
  int limit = 50;
  int helpsLoadLimit = 50;
  int listLength = 0;
  List<TransactionDateModel> reportDateList = [];
  List<TransactionDateModel> refferalDateList = [];
  var outputDayNode = DateFormat('dd/MM/yyy');
  var outputDayNode2 = DateFormat('h:mm a');
  var outputDayNode3 = DateFormat('dd/MM/yyy\nh:mm a');

  Future<void> fetchTransactionHistory(String from, bool firstFetch,
      [dynamic lastDoc = false]) async {
    listLength = 0;
    if (from == 'splash') {
      home_Transcation_HistoryList.clear();
    }
    String transactionDateFormat = "";
    var collectionRef;

    QuerySnapshot querySnapshot = await db.collection('TRANSACTIONS').get();
    listLength = querySnapshot.size;
    notifyListeners();
    if (!firstFetch) {
      collectionRef = db
          .collection('TRANSACTIONS')
          .orderBy("PAYMENT_TIME", descending: true)
          .startAfter([lastDoc]).limit(limit);
    } else {
      collectionRef = db
          .collection('TRANSACTIONS')
          .orderBy("PAYMENT_TIME", descending: true)
          .limit(limit);
      transcation_HistoryList.clear();
      filter_Transcation_HistoryList.clear();

    }
    collectionRef.get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {
        for (var element in snapshot.docs) {
          Map<dynamic, dynamic> map = element.data() as Map;
          transactionDateFormat = outputDayNode.format(map["PAYMENT_TIME"].toDate()).toString();
          transcation_HistoryList.add(AdminsTransactionListModel(
              double.parse(map["AMOUNT"].toString()),
              map["APP_VERSION"],
              map["FROM_USER_ID"],
              map["GRADE"],
              map["PAYMENT_MODE"],
              map["PAYMENT_STATUS"].toString(),
              map["PAYMENT_TIME"].toDate(),
              map["PAYMENT_TYPE"],
              map["TO_USER_ID"] ?? "",
              map["TREE"],
              map["USER_NAME"]??"",
              map["PHONE_NUMBER"]??"",
              element.id.toString(),
              transactionDateFormat));
          if (!reportDateList
              .map((item) => item.dateFormat)
              .contains(transactionDateFormat)) {
            reportDateList.add(TransactionDateModel(
                transactionDateFormat, map["PAYMENT_TIME"].toDate()));
          }
          filter_Transcation_HistoryList = transcation_HistoryList;
          if (from == 'splash') {
            transcation_HistoryList
                .sort((a, b) => b.dateFormat.compareTo(a.dateFormat));
            home_Transcation_HistoryList = transcation_HistoryList;
          }

          reportDateList.sort((a, b) => b.date.compareTo(a.date));
          notifyListeners();
        }
        notifyListeners();
      }
    });
  }

  bool reportOtherCheck = true;
  bool exchangeOtherCheck = true;

  reportOtherCheckFun() {
    if (reportOtherCheck) {
      reportOtherCheck = false;
    } else {
      reportOtherCheck = true;
    }
    notifyListeners();
  }

  exchangeOtherCheckFun() {
    if (reportOtherCheck) {
      reportOtherCheck = false;
    } else {
      reportOtherCheck = true;
    }
    notifyListeners();
  }

  searcTransaction(String item) {
    if (item != '') {
      filter_Transcation_HistoryList = transcation_HistoryList
          .where((element) =>
              element.username.toLowerCase().contains(item.toLowerCase()) ||
              element.phone.toLowerCase().contains(item.toLowerCase()) ||
              element.id.toLowerCase().contains(item.toLowerCase()) ||
              element.amount.toString().contains(item.toLowerCase()))
          .toList();
    } else {
      filter_Transcation_HistoryList = transcation_HistoryList;
    }

    notifyListeners();
  }

  searchReferral(String item, BuildContext context) {
    if (item != '') {
      filter_ReferralList = referralList
          .where((element) =>
              element.username.toLowerCase().contains(item.toLowerCase()) ||
              element.phone.toLowerCase().contains(item.toLowerCase()) ||
              element.id.toLowerCase().contains(item.toLowerCase()) ||
              element.amount.toString().contains(item.toLowerCase()))
          .toList();
    } else {
      fetchReferralList(context);
    }

    notifyListeners();
  }

  // void listenToListLength() {
  //   CollectionReference collectionRef =
  //   db.collection('TRANSACTIONS');
  //
  //   collectionRef.snapshots().listen((event) {
  //     QuerySnapshot snapshot = event;
  //      listLength = snapshot.docs.length;
  //
  //     // Do something with the list length
  //     print('List length: $listLength');
  //   });
  // }

  String hintColor = '';

  List<String> blockingReasons = [
    "Non-Payment of PMC",
    "Inactivity or Dormancy",
    "Fraudulent Activity",
    "Violation of Rules",
    "Other"
  ];



  List<String> kycRejectedReasons = [
    "Incomplete Documents",
    "Incorrect Documents",
    "Fraudulent Activity",
    "Age or Eligibility",
    "Other"
  ];


  List<PrivilegeModel> privilegeList = [
    PrivilegeModel("Exchange user", false),
    PrivilegeModel("Total amounts", false),
    PrivilegeModel("Admins changes", false),
    PrivilegeModel("Members changes", false),
  ];
  bool allPrivilege = false;

  String privilege = 'Exchange user';
  bool checkAll = false;
  List<String> exchangeReasons = [
    "Disruptive Behavior",
    "Privacy Concerns",
    "PMC Not completed",
    "No Invites on last month ",
    "Other"
  ];
  String selectedReason = '';
  String selectedExchange = '';
  TextEditingController blockingReasonController = TextEditingController();
  TextEditingController kycRejectReasonController = TextEditingController();

  selectAllPrivilege(bool val) {
    for (var element in privilegeList) {
      if (val == true) {
        element.select = true;
      } else {
        element.select = false;
      }
    }
    notifyListeners();
  }

  TextEditingController exChangeController = TextEditingController();

  closeButton() {
    fileImage = null;
    notifyListeners();
  }

  radioFun(val) {
    selectedReason = val;
    if (selectedReason == "Other") {
      reportOtherCheck = true;
    } else {
      reportOtherCheck = false;
    }

    notifyListeners();
  }

  adminPrivilege(int index, bool val) {
    privilegeList[index].select = val;
    notifyListeners();
  }

  radioForExchange(val) {
    selectedExchange = val;
    if (selectedExchange == "Other") {
      exchangeOtherCheck = true;
    } else {
      exchangeOtherCheck = false;
    }

    notifyListeners();
  }


  addBlockingReason(BuildContext context, String reason, String blockAdminName,
      String blockAdminId, String userId, String userName) async {
    Map<String, Object> blockMap = HashMap();

    db.collection("MASTER_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((basicValue) async {
      db.collection("STAR_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((oneValue) async {
      db.collection("CROWN_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((twoValue) async {
        // if (value.get("CHILD_COUNT") == 0) {
        if (reason != "Other") {
          blockMap["BLOCK_REASON"] = reason;
        }
        else {
          blockMap["BLOCK_REASON"] = blockingReasonController.text;
        }
        blockMap["BLOCKED_ADMIN_NAME"] = blockAdminName;
        blockMap["BLOCKED_ADMIN_ID"] = blockAdminId;
        blockMap["BLOCKED_DATE"] = DateTime.now();
        blockMap["STATUS"] = "BLOCKED";

        db
            .collection("USERS")
            .doc(userId)
            .set(blockMap, SetOptions(merge: true));
        db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set(
            {"MEMBERS": FieldValue.increment(-1)}, SetOptions(merge: true));
        if(basicValue.docs.isNotEmpty){
          db
              .collection("MASTER_CLUB")
              .doc(basicValue.docs.first.id)
              .set({"STATUS":"BLOCKED"}, SetOptions(merge: true));
        }
        if(oneValue.docs.isNotEmpty){
          db
              .collection("STAR_CLUB")
              .doc(oneValue.docs.first.id)
              .set({"STATUS":"BLOCKED"}, SetOptions(merge: true));
        }
        if(twoValue.docs.isNotEmpty){
          db
              .collection("CROWN_CLUB")
              .doc(twoValue.docs.first.id)
              .set({"STATUS":"BLOCKED"}, SetOptions(merge: true));
        }

        List<String> fcmList = [];
        List<String> toList = [];
        DateTime now = DateTime.now();
        String newId =
            now.millisecondsSinceEpoch.toString() + generateRandomString(2);
        toList.add(userId);
        await db.collection("USERS").doc(userId).get().then((userValue) async {
          Map<dynamic, dynamic> userMap = userValue.data() as Map;
          fcmList.add(userMap['FCM_ID'].toString());
        });

        HashMap<String, Object> notificationMap = HashMap();
        notificationMap["CONTENT"] = "We're sorry to inform you that you're now blocked.";
        notificationMap["FROM_ID"] = blockAdminId;
        notificationMap["TO_ID"] = toList;
        notificationMap["NOTIFICATION_ID"] = newId;
        notificationMap['REG_DATE'] = now;
        notificationMap["VIEWERS"] = [];
        notificationMap["DATE"] = outputDayNode.format(now).toString();
        notificationMap["TIME"] = outputDayNode2.format(now).toString();
        db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
        callOnFcmApiSendPushNotifications(
            title: 'Blocked!',
            body: "We're sorry to inform you that you're now blocked.",
            fcmList: fcmList,
            imageLink: '');
        firstFetchMembers(true);
        final snackDemo = SnackBar(
          content: SizedBox(
            width: 284,
            height: 20,
            child: Text(
              'You have blocked  $userName',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF16B200),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(79),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 200,
            left: 10,
            right: 10,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackDemo);
        // }
        // else {
        //   final snackDemo1 = SnackBar(
        //     content: const SizedBox(
        //       width: 284,
        //       height: 20,
        //       child: Text(
        //         'You Cant Block This Member',
        //         textAlign: TextAlign.center,
        //         style: TextStyle(
        //           color: clBE0000,
        //           fontSize: 16,
        //           fontFamily: 'Poppins',
        //           fontWeight: FontWeight.w400,
        //         ),
        //       ),
        //     ),
        //     backgroundColor: Colors.white,
        //     elevation: 10,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(79),
        //     ),
        //     behavior: SnackBarBehavior.floating,
        //     margin: const EdgeInsets.only(
        //       bottom: 30,
        //       left: 10,
        //       right: 10,
        //     ),
        //   );
        //   ScaffoldMessenger.of(context).showSnackBar(snackDemo1);
        // }

        blockingReasonController.clear();
        finish(context);
        finish(context);
      });
      });
    });

    // finish(context);
    // finish(context);
    // finish(context);
    notifyListeners();
  }

  participantsBlock(BuildContext context, String reason, String blockAdminName,
      String blockAdminId, String userId, String userName) async {
    Map<String, Object> blockMap = HashMap();

    db.collection("MASTER_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((basicValue) async {
      db.collection("STAR_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((oneValue) async {
        db.collection("CROWN_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((twoValue) async {

        blockMap["BLOCK_REASON"] = blockingReasonController.text;

        // }
        blockMap["BLOCKED_ADMIN_NAME"] = blockAdminName;
        blockMap["BLOCKED_ADMIN_ID"] = blockAdminId;
        blockMap["BLOCKED_DATE"] = DateTime.now();
        blockMap["STATUS"] = "BLOCKED";

        db
            .collection("USERS")
            .doc(userId)
            .set(blockMap, SetOptions(merge: true));

        if(basicValue.docs.isNotEmpty){
          db
              .collection("MASTER_CLUB")
              .doc(basicValue.docs.first.id)
              .set({"STATUS":"BLOCKED"}, SetOptions(merge: true));
        }
        if(oneValue.docs.isNotEmpty){
          db
              .collection("STAR_CLUB")
              .doc(oneValue.docs.first.id)
              .set({"STATUS":"BLOCKED"}, SetOptions(merge: true));
        }
        if(twoValue.docs.isNotEmpty){
          db
              .collection("CROWN_CLUB")
              .doc(twoValue.docs.first.id)
              .set({"STATUS":"BLOCKED"}, SetOptions(merge: true));
        }


        toString() + generateRandomString(2);

        fetchParticipants(true);
        final snackDemo = SnackBar(
          content: SizedBox(
            width: 284,
            height: 20,
            child: Text(
              'You have blocked  $userName',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF16B200),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(79),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height - 200,
            left: 10,
            right: 10,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackDemo);


      blockingReasonController.clear();
      finish(context);
      finish(context);
    });
  });
});

    // finish(context);
    // finish(context);
    // finish(context);
    notifyListeners();
  }

  List<BlockedMembersModel> blockedMembersList = [];
  List<BlockedMembersModel> filterBlockedMembersList = [];

  fetchBlockedUsers() {
    db
        .collection("USERS")
        .where("STATUS", isEqualTo: "BLOCKED")
        .get()
        .then((blockedValue) {
      blockedMembersList.clear();
      filterBlockedMembersList.clear();
      notifyListeners();
      if (blockedValue.docs.isNotEmpty) {
        for (var elements in blockedValue.docs) {
          Map<dynamic, dynamic> blockedMember = elements.data();
          blockedMembersList.add(BlockedMembersModel(
              blockedMember["MEMBER_ID"],
              blockedMember["NAME"],
              outputFormat.format(blockedMember["BLOCKED_DATE"].toDate()),
              blockedMember["PHONE"],
              blockedMember["TOTAL_REFERRAL_COUNT"].toString(),
              blockedMember["BLOCK_REASON"]));
        }
        filterBlockedMembersList = blockedMembersList;

        notifyListeners();
      }
    });
  }

  fetchBlockedUsersDateFilter(var firstDate, var secondDate) {
    db
        .collection("USERS")
        .where("STATUS", isEqualTo: "BLOCKED")
        .where("BLOCKED_DATE", isGreaterThanOrEqualTo: firstDate)
        .where("BLOCKED_DATE", isLessThanOrEqualTo: secondDate)
        .get()
        .then((blockedValue) {
      blockedMembersList.clear();
      filterBlockedMembersList.clear();
      notifyListeners();
      if (blockedValue.docs.isNotEmpty) {
        for (var elements in blockedValue.docs) {
          Map<dynamic, dynamic> blockedMember = elements.data();
          blockedMembersList.add(BlockedMembersModel(
              blockedMember["MEMBER_ID"],
              blockedMember["NAME"],
              outputFormat.format(blockedMember["BLOCKED_DATE"].toDate()),
              blockedMember["PHONE"],
              blockedMember["TOTAL_REFERRAL_COUNT"].toString(),
              blockedMember["BLOCK_REASON"]));
        }
        filterBlockedMembersList = blockedMembersList;
        notifyListeners();
      }
    });
  }

  unblockUser(BuildContext context, String userId) async {
    Map<String, Object> unblockMap = HashMap();
    unblockMap["STATUS"] = "ACTIVE";
    unblockMap["UN_BLOCKED_ADMIN_NAME"] = adminName;
    unblockMap["UN_BLOCKED_ADMIN_ID"] = adminId;
    unblockMap["UN_BLOCKED_DATE"] = DateTime.now();
    db.collection("USERS").doc(userId).set(unblockMap, SetOptions(merge: true));
    db
        .collection("TOTAL_AMOUNTS")
        .doc("TOTAL_AMOUNTS")
        .set({"MEMBERS": FieldValue.increment(1)}, SetOptions(merge: true));

    List<String> fcmList = [];
    List<String> toList = [];
    DateTime now = DateTime.now();
    String newId =
        now.millisecondsSinceEpoch.toString() + generateRandomString(2);
    toList.add(userId);
    await db.collection("USERS").doc(userId).get().then((userValue) async {
      db.collection("MASTER_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((basicValue) async {
        db.collection("STAR_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((oneValue) async {
          db.collection("CROWN_CLUB").where("MEMBER_ID",isEqualTo: userId).get().then((twoValue) async {
      Map<dynamic, dynamic> userMap = userValue.data() as Map;
      fcmList.add(userMap['FCM_ID'].toString());

      if(basicValue.docs.isNotEmpty){
        db
            .collection("MASTER_CLUB")
            .doc(basicValue.docs.first.id)
            .set({"STATUS":"ACTIVE"}, SetOptions(merge: true));
      }
      if(oneValue.docs.isNotEmpty){
        db
            .collection("STAR_CLUB")
            .doc(oneValue.docs.first.id)
            .set({"STATUS":"ACTIVE"}, SetOptions(merge: true));
      }
      if(twoValue.docs.isNotEmpty){
        db
            .collection("CROWN_CLUB")
            .doc(twoValue.docs.first.id)
            .set({"STATUS":"ACTIVE"}, SetOptions(merge: true));
      }


    });});
});
});
    HashMap<String, Object> notificationMap = HashMap();
    notificationMap["CONTENT"] = "Congratulations, your access has been restored.";
    notificationMap["FROM_ID"] = adminId;
    notificationMap["TO_ID"] = toList;
    notificationMap["NOTIFICATION_ID"] = newId;
    notificationMap["VIEWERS"] = [];
    notificationMap['REG_DATE'] = now;
    notificationMap["DATE"] = outputDayNode.format(now).toString();
    notificationMap["TIME"] = outputDayNode2.format(now).toString();
    db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);
    callOnFcmApiSendPushNotifications(
        title: 'Unblocked!',
        body: "Congratulations, your access has been restored.",
        fcmList: fcmList,
        imageLink: '');
    fetchBlockedUsers();
    // finish(context);
    // finish(context);
    notifyListeners();
  }

  void filterBlockedMembersLists(String item) {
    filterBlockedMembersList = blockedMembersList
        .where((a) =>
            a.name.toLowerCase().contains(item.toLowerCase()) ||
            a.phone.toLowerCase().contains(item.toLowerCase()) ||
            a.id.toLowerCase().contains(item.toLowerCase()))
        .toList();
    notifyListeners();
  }

  blockAlert(
    BuildContext context,
    String from,
    String regId,
    String nam,
  ) {
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
                    Text(
                      from == "BLOCK"
                          ? 'You Want to Block ?'
                          : "You Want to UnBlock ?",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
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
                      child: from == "BLOCK"
                          ? Image.asset("assets/lock_person.png")
                          : Image.asset("assets/unlock.png"),
                    )
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
                            if (from == "BLOCK") {


                              addBlockingReason(context, selectedReason,
                                  adminName, adminId, regId, nam);
                            }
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
                            child: Text(
                              from == "UNBLOCK" ? "UnBlock" : "Block",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
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

  participantsBlockAlert(BuildContext context, String userID, String nam) {
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
                      'Do You Want to Block ?',
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
                      child: Image.asset("assets/lock_person.png"),
                    )
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
                            participantsBlock(context, selectedReason,
                                adminName, adminId, userID, nam);
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
                              "Block",
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

  StreamSubscription? _streamHomeDetails;
  void adminHomeDetails() {
    if(_streamHomeDetails!=null) {
      _streamHomeDetails!.cancel();
    }
    pmcTotal = 0;
    prcTotal = 0;
    donationTotal = 0;
    giveHelpTotal = 0;
    referralTotal = 0;
    prcTotalCount = '';
    pmcTotalCount = '';
    donationTotalCount = '';
    giveHelpCount = '';
    referralTotalCount = '';
    _streamHomeDetails = db
        .collection("TOTAL_AMOUNTS")
        .doc("TOTAL_AMOUNTS")
        .snapshots()
        .listen((userValue) {
      if (userValue.exists) {
        Map<dynamic, dynamic> userMap = userValue.data() as Map;
        pmcTotal = double.parse(userMap["PMC"].toString());
        prcTotal = double.parse(userMap["PRC"].toString());
        donationTotal = double.parse(userMap['CMF'].toString());
        giveHelpTotal =double.parse(userMap["GIVE_HELP"].toString());
        referralTotal =double.parse( userMap["REFERRAL"].toString());
        pmcTotalCount = userMap['PMC_COUNT'].toString();
        prcTotalCount = userMap['PRC_COUNT'].toString();
        donationTotalCount = userMap['CMF_COUNT'].toString();
        giveHelpCount = userMap['GIVE_HELP_COUNT'].toString();
        referralTotalCount = userMap['REFERRAL_COUNT'].toString();
        membersCount = userMap['MEMBERS'].toString();
      }
      notifyListeners();
    });
  }

  List<DateTime> dateList = [];

  fetchAdminPMCData(String type,bool firstFetch, [dynamic lastDoc = false]) async {
    var collectionRef;

    if (!firstFetch) {
      collectionRef = db
          .collection('TRANSACTIONS')
          .where("PAYMENT_TYPE", isEqualTo: type)
          .where("PAYMENT_STATUS", isEqualTo: "SUCCESS")
          .orderBy('PAYMENT_TIME', descending: true)
          .startAfter([lastDoc]).limit(pmcLimit);
      pmcLoadMoreLimit = pmcLoadMoreLimit+pmcLimit;
    } else {
      collectionRef = db
          .collection('TRANSACTIONS')
          .where("PAYMENT_TYPE", isEqualTo: type)
          .where("PAYMENT_STATUS", isEqualTo: "SUCCESS")
          .orderBy('PAYMENT_TIME', descending: true)
          .limit(pmcLimit);
      adminPMCDetailsList.clear();
      filterAdminPMCDetailsList.clear();
    }

    collectionRef.get().then((QuerySnapshot snapshot) {
      if (snapshot.docs.isNotEmpty) {

        for (var elements in snapshot.docs) {
          Map<dynamic, dynamic> pmcMap = elements.data() as Map;
          // DateTime pmcDate = pmcMap["PAYMENT_TIME"].toDate();
          String scheduledTimeFrom =
              outputDayNode.format(pmcMap["PAYMENT_TIME"].toDate()).toString();
          String time =
              DateFormat('h:mm a').format(pmcMap["PAYMENT_TIME"].toDate());
          adminPMCDetailsList.add(AdminPMCDetails(
              elements.id,
              pmcMap["USER_NAME"] ?? "",
              pmcMap['DISTRIBUTION_ID'] ?? "",
              elements.id,
              pmcMap["GRADE"] ?? "",
              '',
              pmcMap["AMOUNT"].toString(),
              scheduledTimeFrom,
              time,
              pmcMap["PHONE_NUMBER"].toString(),
              pmcMap["PAYMENT_TIME"].toDate()));

          if (!reportDateList
              .map((item) => item.dateFormat)
              .contains(scheduledTimeFrom)) {
            reportDateList.add(TransactionDateModel(
                scheduledTimeFrom, pmcMap["PAYMENT_TIME"].toDate()));
          }
        }
        filterAdminPMCDetailsList = adminPMCDetailsList;
        notifyListeners();
      }
    });
    notifyListeners();

  }

  void filterAdminPMC(text) {
    filterAdminPMCDetailsList = adminPMCDetailsList
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()) ||
            element.transactionId.toLowerCase().contains(text.toLowerCase()) ||
            element.regId.toLowerCase().contains(text.toLowerCase()) ||
            element.level.toLowerCase().contains(text.toLowerCase()))
        .toList();

    pmcTotal = filterAdminPMCDetailsList.fold(0, (previousValue, element) => previousValue + double.parse(element.amount));
    notifyListeners();
  }

  adminPMCDateWiseFilter(var firstDate, var secondDate,String type) async {
    db
        .collection("TRANSACTIONS")
        .where("PAYMENT_TYPE", isEqualTo: type)
        .where("PAYMENT_STATUS", isEqualTo: "SUCCESS")
        .where("PAYMENT_TIME", isGreaterThanOrEqualTo: firstDate)
        .where("PAYMENT_TIME", isLessThanOrEqualTo: secondDate)
        .orderBy('PAYMENT_TIME', descending: true)
        .get()
        .then((value) {
      adminPMCDetailsList.clear();
      filterAdminPMCDetailsList.clear();
      notifyListeners();
      if (value.docs.isNotEmpty) {
        pmcLoadMoreLimit = value.docs.length+1;
        adminPMCDetailsList.clear();
        dateList.clear();
        filterAdminPMCDetailsList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> pmcMap = elements.data();
          Timestamp stttTo = pmcMap['PAYMENT_TIME'];
          String time = DateFormat('h:mm a').format(stttTo.toDate());
          String scheduledTimeFrom =
              outputDayNode.format(pmcMap["PAYMENT_TIME"].toDate()).toString();
          adminPMCDetailsList.add(AdminPMCDetails(
              elements.id,
              pmcMap["USER_NAME"] ?? "",
              pmcMap['DISTRIBUTION_ID'] ?? "",
              elements.id,
              pmcMap["GRADE"] ?? "",
              '',
              pmcMap["AMOUNT"].toString(),
              scheduledTimeFrom,
              time,
              pmcMap["PHONE_NUMBER"].toString(),
              pmcMap["PAYMENT_TIME"].toDate()));
          if (!reportDateList
              .map((item) => item.dateFormat)
              .contains(scheduledTimeFrom)) {
            reportDateList.add(TransactionDateModel(
                scheduledTimeFrom, pmcMap["PAYMENT_TIME"].toDate()));
          }
        }
        filterAdminPMCDetailsList = adminPMCDetailsList;
      }
    });
    notifyListeners();
  }

  void createExcelPMCReport(List<AdminPMCDetails> pmcExcelList) async {
    // loader=true;
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    final List<Object> list = [
      'SL',
      'Name',
      'Transaction ID',
      'Distribution ID',
      'Level',
      'Amount',
      'Date'
    ];

    const int firstRow = 1;
    const int firstColumn = 1;
    const bool isVertical = false;
    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    int index = 1;
    for (var element in pmcExcelList) {
      i++;
      final List<Object> list = [
        index++,
        element.name,
        element.transactionId,
        element.regId,
        element.level,
        element.amount,
        element.date
      ];

      final int firstRow = i;
      const int firstColumn = 1;
      const bool isVertical = false;
      sheet.importList(list, firstRow, firstColumn, isVertical);
    }
    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    // if
    final String path = (await getApplicationSupportDirectory()).path;
    final fileName = '$path/Report.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

    File testFile = File("$path/Report.xlsx");

    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
    // Share.shareFiles([file.path], text: 'House report');

    // loader=false;
    notifyListeners();
  }

  fetchAdminDonationData(bool firstFetch, [dynamic lastDoc = false]) async {
    var collectionRef;

    if (!firstFetch) {
      collectionRef = db
          .collection("TRANSACTIONS")
          .where("PAYMENT_TYPE", isEqualTo: "CMF")
          .orderBy('PAYMENT_TIME', descending: true)
          .startAfter([lastDoc]).limit(donationLimit);
      donationLoadLimit = donationLoadLimit+donationLimit;
    } else {
      collectionRef = db
          .collection("TRANSACTIONS")
          .where("PAYMENT_TYPE", isEqualTo: "CMF")
          .orderBy('PAYMENT_TIME', descending: true)
          .limit(donationLimit);

      adminDonationList.clear();
      filterAdminDonationList.clear();
      dateList.clear();
      reportDateList.clear();
      donationLoadLimit = 50;
    }

    collectionRef.get().then((value) {
      if (value.docs.isNotEmpty) {
        // adminDonationList.clear();
        // filterAdminDonationList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();

          String scheduledTimeFrom =
              outputDayNode.format(map["PAYMENT_TIME"].toDate()).toString();
          String time =
              DateFormat('h:mm a').format(map["PAYMENT_TIME"].toDate());
          adminDonationList.add(AdminDonationDetails(
              elements.id,
              map["USER_NAME"] ?? "",
              map['DISTRIBUTION_ID'] ?? "",
              map['PHONE_NUMBER'],
              map["AMOUNT"].toString(),
              scheduledTimeFrom,
              time,
              map["PAYMENT_TIME"].toDate()));

          if (!reportDateList
              .map((item) => item.dateFormat)
              .contains(scheduledTimeFrom)) {
            reportDateList.add(TransactionDateModel(
                scheduledTimeFrom, map["PAYMENT_TIME"].toDate()));
          }
        }
        filterAdminDonationList = adminDonationList;
        notifyListeners();
      }
    });
  }

  dateWiseFilterDonation(var firstDate, var secondDate) async {
    db
        .collection("TRANSACTIONS")
        .where("PAYMENT_TYPE", isEqualTo: "CMF")
        .where("PAYMENT_TIME", isGreaterThanOrEqualTo: firstDate)
        .where("PAYMENT_TIME", isLessThanOrEqualTo: secondDate)
        .orderBy('PAYMENT_TIME', descending: true)
        .get()
        .then((value) {
      adminDonationList.clear();
      filterAdminDonationList.clear();
      notifyListeners();
      if (value.docs.isNotEmpty) {
        donationLoadLimit = value.docs.length+1;
        adminDonationList.clear();
        dateList.clear();
        filterAdminDonationList.clear();
        for (var elements in value.docs) {
          Map<dynamic, dynamic> map = elements.data();

          String scheduledTimeFrom =
              outputDayNode.format(map["PAYMENT_TIME"].toDate()).toString();
          String time =
              DateFormat('h:mm a').format(map["PAYMENT_TIME"].toDate());
          adminDonationList.add(AdminDonationDetails(
              elements.id,
              map["USER_NAME"] ?? "",
              map['DISTRIBUTION_ID'] ?? "",
              map['PHONE_NUMBER'],
              map["AMOUNT"].toString(),
              scheduledTimeFrom,
              time,
              map["PAYMENT_TIME"].toDate()));
          if (!reportDateList
              .map((item) => item.dateFormat)
              .contains(scheduledTimeFrom)) {
            reportDateList.add(TransactionDateModel(
                scheduledTimeFrom, map["PAYMENT_TIME"].toDate()));
          }
        }
        filterAdminDonationList = adminDonationList;
      }
    });
    notifyListeners();
  }

  void filterAdminDonation(text) {
    filterAdminDonationList = adminDonationList
        .where((element) =>
            element.name.toLowerCase().contains(text.toLowerCase()) ||
            element.distribution.toLowerCase().contains(text.toLowerCase()) ||
            element.phoneNo.toLowerCase().contains(text.toLowerCase()) ||
            element.id.toLowerCase().contains(text.toLowerCase()))
        .toList();
    donationTotal= filterAdminDonationList.fold(0, (previousValue, element) => previousValue + double.parse(element.amount));

    notifyListeners();
  }

  void createExcelDonationReport(
      List<AdminDonationDetails> donationExcelList) async {
    // loader=true;
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    final List<Object> list = [
      'SL',
      'Name',
      'Transaction ID',
      'Distribution ID',
      'phone',
      'time',
      'Amount',
      'Date'
    ];

    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 0;
    for (var element in donationExcelList) {
      i++;
      final List<Object> list = [
        i,
        element.name,
        element.id,
        element.distribution,
        element.phoneNo,
        DateFormat("hh:mm a").format(element.dateTime),
        element.amount,
        DateFormat("MM/dd/yyyy").format(element.dateTime),
      ];

      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    // if
    final String path = (await getApplicationSupportDirectory()).path;
    final fileName = '$path/Report.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);

    File testFile = File("$path/Report.xlsx");

    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
    // Share.shareFiles([file.path], text: 'House report');

    // loader=false;
    notifyListeners();
  }

  List<AdminsTransactionListModel> referralList = [];
  List<AdminsTransactionListModel> filter_ReferralList = [];
  List<TransactionDateModel> referralDateList = [];

  void fetchReferralList(BuildContext context) {
    double amount = 0;
    String transactionDateFormat = "";
    referralList.clear();
    db
        .collection('TRANSACTIONS')
        .where('PAYMENT_TYPE', isEqualTo: 'PMC')
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        referralList.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          transactionDateFormat =
              outputDayNode.format(map["PAYMENT_TIME"].toDate()).toString();
          referralList.add(AdminsTransactionListModel(
              double.parse(map["AMOUNT"].toString()),
              map["APP_VERSION"],
              map["FROM_USER_ID"],
              map["GRADE"],
              map["PAYMENT_MODE"],
              map["PAYMENT_STATUS"].toString(),
              map["PAYMENT_TIME"].toDate(),
              map["PAYMENT_TYPE"],
              map["TO_USER_ID"] ?? "",
              map["TREE"],
              map["USER_NAME"],
              map["PHONE_NUMBER"],
              element.id.toString(),
              transactionDateFormat));
          amount = amount + double.parse(map["AMOUNT"].toString());
          if (!referralDateList
              .map((item) => item.dateFormat)
              .contains(transactionDateFormat)) {
            referralDateList.add(TransactionDateModel(
                transactionDateFormat, map["PAYMENT_TIME"].toDate()));
          }
          filter_ReferralList = referralList;
          notifyListeners();
        }
      }
// print("dfbjvjvn"+amount.toString());
//       callNext( AdminGiveHelp( amount: amount,), context);
    });

    notifyListeners();
  }

  String membrName = '';
  String memberPhn = '';
  String gender = '';
  String address = '';
  String accNo = '';
  String ifscCode = '';
  String upiID = '';
  String nomineeName = '';
  String nomineePhone = '';
  String nomineeAge = '';
  String nomineeRelation = '';

  StreamSubscription? _streamMemberDetails;
  void memberDetailsForApprove(String memberID) {
    if(_streamMemberDetails!=null) {
      _streamMemberDetails!.cancel();
    }
    aadhaarId = '';
    panId = '';
    aadhaarImg = '';
    panImg = '';
    membrName = '';
    memberPhn = '';
    address = '';
    accNo = '';
    ifscCode = '';
    upiID = '';
     nomineeName = '';
     nomineePhone = '';
     nomineeAge = '';
     nomineeRelation = '';

    _streamMemberDetails = db.collection("USERS").doc(memberID).snapshots().listen((userValue) {
      if (userValue.exists) {
        Map<dynamic, dynamic> userMap = userValue.data() as Map;
        aadhaarId = userMap['AADHAAR_NUMBER'] ?? "";
        panId = userMap['PAN_NUMBER'] ?? "";
        aadhaarImg = userMap['ID_IMAGE'] ?? "";
          aadhaarSecondSideImg = userMap['ID_SECOND_IMAGE'] ?? "";
        panImg = userMap['PAN_IMAGE'] ?? "";
        membrName = userMap['NAME'] ?? "";
        memberPhn = userMap['PHONE'] ?? "";
        address = userMap['ADDRESS'] ?? "";
        accNo = userMap['ACCOUNT_NUMBER'] ?? "";
        ifscCode = userMap['IFSC_CODE'] ?? "";
        upiID = userMap['UPI_Id'] ?? "";
        nomineeName = userMap['NOMINEE_NAME'] ?? "";
        nomineePhone = userMap['NOMINEE_PHONE_NUMBER'] ?? "";
        if (userMap["NOMINEE_YEAR_OF_BIRTH"] != null) {
          nomineeAge = userMap["NOMINEE_YEAR_OF_BIRTH"].toString();
        } else {
          int age = int.parse(userMap["NOMINEE_AGE"].toString());

          nomineeAge = "${2024 - age}";
          db.collection("USERS").doc(memberID).set(
              {"NOMINEE_YEAR_OF_BIRTH": "${2024 - age}"},
              SetOptions(merge: true));
        }
        // nomineeAge = userMap['NOMINEE_AGE'] ?? "";
        nomineeRelation = userMap['NOMINEE_RELATION'] ?? "";
      }
      notifyListeners();
    });
  }



  Future<void> memberKYCStatusChange(
      String memberID, String status, BuildContext context) async {
    var kycUser = await db.collection("USERS").doc(memberID).get();
    Map <dynamic,dynamic> kycMap = kycUser.data() as Map;

    List<String> fcmList = [];
    fcmList.add(kycMap['FCM_ID'].toString());



    DateTime now = DateTime.now();
    String newId = now.millisecondsSinceEpoch.toString()+generateRandomString(2);

    HashMap<String, Object> dataMap = HashMap();
    dataMap["KYC_STATUS"] = status;
    if(status=="REJECTED") {
      if(selectedReason!="Other") {
        dataMap["KYC_REJECT_REASON"] = selectedReason;
      }else{
        dataMap["KYC_REJECT_REASON"] = kycRejectReasonController.text;
      }
    }
    dataMap["KYC_${status}_DATE"] = DateTime.now();
    db.collection("USERS").doc(memberID).set(dataMap, SetOptions(merge: true));

    String notificationContent = "";
    String notificationTitle = "";
    if(status=="VERIFIED"){
      notificationTitle = "KYC Verification Successful";
      notificationContent = "We're pleased to inform you that your KYC has been successfully processed.";
      notifyListeners();
    }else{
      notificationTitle = "KYC Verification Failed";
      notificationContent = "We regret to inform you that your KYC verification has not been successful.";
      notifyListeners();
    }


    HashMap<String, Object> notificationMap = HashMap();
    notificationMap["CONTENT"] = notificationContent;
    notificationMap["FROM_ID"] = memberID;
    notificationMap["TO_ID"] = [memberID];
    notificationMap["NOTIFICATION_ID"] = newId;
    notificationMap['REG_DATE'] = now;
    notificationMap["VIEWERS"] = [];
    notificationMap["DATE"] = outputDayNode.format(now).toString();
    notificationMap["TIME"] = outputDayNode2.format(now).toString();
    db.collection('NOTIFICATIONS').doc(newId).set(notificationMap);


    callOnFcmApiSendPushNotifications(
        title: notificationTitle,
        body: notificationContent,
        fcmList: fcmList,
        imageLink: '');




    final snackBar = SnackBar(
      elevation: 6.0,
      backgroundColor: myWhite,
      behavior: SnackBarBehavior.floating,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Text(
        status == "VERIFIED" ? "KYC Verified" : "KYC Rejected",
        style: TextStyle(color: status == "VERIFIED" ? cl16B200 : clBE0000),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    firstFetchMembers(true);
    notifyListeners();

    fetchMembersKycSubmitted();
    callNextReplacement(const KycUploadedScreen(), context);
  }

  // List<String>kycStatusList=['Kyc Status','All','Submitted','Rejected','Pending','Verified'];

  void filterMembersKycBased(String status) {
    String checkStatus = '';
    if (status == 'Verified') {
      checkStatus = 'VERIFIED';
    } else if (status == 'Pending') {
      checkStatus = 'PENDING';
    } else if (status == 'Rejected') {
      checkStatus = 'REJECTED';
    } else if (status == 'Submitted') {
      checkStatus = 'SUBMITTED';
    }
    if (status != 'All') {
      filterMembersList = membersList
          .where((element) => element.kycStatus == checkStatus)
          .toSet()
          .toList();
    } else {
      filterMembersList = membersList;
    }
    notifyListeners();
  }

  Future<bool> checkExchangeIdExist(
      String fromId, String toId, BuildContext context2) async {
    showDialog(
        context: context2,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    var D = await db
        .collection("USERS")
        .where("MEMBER_ID", isEqualTo: fromId)
        .where("STATUS",isEqualTo:"ACTIVE")
        .get();
    var E =
        await db.collection("USERS").where("MEMBER_ID", isEqualTo: toId).get();
    if (D.docs.isEmpty||E.docs.isEmpty) {
      finish(context2);
      return true;
    } else {
      finish(context2);
      return false;
    }
  }

  bool exchangeUserBool = false;
  bool exchangeUserKycBool = false;

  // Future<void> exchangeUsers2(
  //     String fromId, String toId, BuildContext context2) async {
  //   bool fromToIdStatus = await checkExchangeIdExist(fromId, toId, context2);
  //   bool kycStatus = await kycCheckForExchangeUser(fromId, toId);
  //   bool userStatus = await statusCheckForExchangeUser(fromId);
  //   exchangeUserBool = true;
  //   notifyListeners();
  //   String fromDocID = '';
  //   String fromName = '';
  //   String fromPhone = '';
  //   String fromDParentID = '';
  //   String fromGrade = '';
  //   String fromDStatus = '';
  //   String fromFcmId = '';
  //   String fromReference = '';
  //   int fromDStepId = 0;
  //   String fromDType = '';
  //   String fromImage = '';
  //   String fromUpi = '';
  //   int fromChild = 0;
  //
  //   String toDocID = '';
  //   String toName = '';
  //   String toPhone = '';
  //   String toDParentID = '';
  //   String toGrade = '';
  //
  //   String toDStatus = '';
  //   String toFcmId = '';
  //   String toReference = '';
  //   int toStepId = 0;
  //   String toType = '';
  //   String toImage = '';
  //   String toUpi = '';
  //   int toChild = 0;
  //   List<dynamic>fromTreeChildList = [];
  //   List<dynamic>toTreeChildList = [];
  //
  //   if (!fromToIdStatus) {
  //     if(kycStatus&&userStatus){
  //       exchangeUserKycBool=true;
  //       db.collection("TOTAL_AMOUNTS").doc("REFERRAL").get().then((referValue) {
  //       db.collection("USERS").doc(fromId).get().then((userValue) {
  //         db.collection("USERS").doc(toId).get().then((userValue2) {
  //           db
  //               .collection("MASTER_CLUB")
  //               .where("MEMBER_ID", isEqualTo: fromId)
  //               .get()
  //               .then((fromBasicTree) {
  //             db
  //                 .collection("MASTER_CLUB")
  //                 .where("MEMBER_ID", isEqualTo: toId)
  //                 .get()
  //                 .then((toBasicTree) {
  //
  //           db
  //               .collection("STAR_CLUB")
  //               .where("MEMBER_ID", isEqualTo: fromId)
  //               .get()
  //               .then((fromAutoOneMember) {
  //             db
  //                 .collection("STAR_CLUB")
  //                 .where("MEMBER_ID", isEqualTo: toId)
  //                 .get()
  //                 .then((toAutoOneMember) {
  //               db
  //                   .collection("CROWN_CLUB")
  //                   .where("MEMBER_ID", isEqualTo: fromId)
  //                   .get()
  //                   .then((fromAutoTwoMember) {
  //                 db
  //                     .collection("CROWN_CLUB")
  //                     .where("MEMBER_ID", isEqualTo: toId)
  //                     .get()
  //                     .then((toAutoTwoMember) {
  //                   db
  //                       .collection("USERS")
  //                       .where("DIRECT_PARENT_ID", isEqualTo: fromId)
  //                       .get()
  //                       .then((fromParentValue) {
  //                     db
  //                         .collection("USERS")
  //                         .where("DIRECT_PARENT_ID", isEqualTo: toId)
  //                         .get()
  //                         .then((toParentValue) {
  //                       db
  //                           .collection("MASTER_CLUB")
  //                           .where("DIRECT_PARENT_ID", isEqualTo: fromId)
  //                           .get()
  //                           .then((fromBasicValue) {
  //                         db
  //                             .collection("MASTER_CLUB")
  //                             .where("DIRECT_PARENT_ID", isEqualTo: toId)
  //                             .get()
  //                             .then((toBasicValue) {
  //                           db
  //                               .collection("STAR_CLUB")
  //                               .where("DIRECT_PARENT_ID", isEqualTo: fromId)
  //                               .get()
  //                               .then((fromAutoOne) {
  //                             db
  //                                 .collection("STAR_CLUB")
  //                                 .where("DIRECT_PARENT_ID", isEqualTo: toId)
  //                                 .get()
  //                                 .then((toAutoOne) {
  //                               db
  //                                   .collection("CROWN_CLUB")
  //                                   .where("DIRECT_PARENT_ID",
  //                                       isEqualTo: fromId)
  //                                   .get()
  //                                   .then((fromAutoTwo) {
  //                                 db
  //                                     .collection("CROWN_CLUB")
  //                                     .where("DIRECT_PARENT_ID",
  //                                         isEqualTo: toId)
  //                                     .get()
  //                                     .then((toAutoTwo) {
  //                                   String referId="";
  //                                   Map<String, dynamic> data = referValue.data() as Map<String, dynamic>;
  //                                   if (data.containsKey("REFERRAL_ID")) {
  //                                   referId = data["REFERRAL_ID"];
  //                                   }
  //
  //                                   // String referId =
  //                                   //     referValue.get("REFERRAL_ID");
  //                                   Map<dynamic, dynamic> userMap1 =
  //                                       userValue.data() as Map;
  //                                   fromDocID = userMap1["DOCUMENT_ID"] ?? "";
  //                                   fromDParentID =
  //                                       userMap1["DIRECT_PARENT_ID"] ?? "";
  //                                   fromGrade = userMap1["GRADE"] ?? "";
  //                                   fromDStatus = userMap1["STATUS"] ?? "";
  //                                   if(fromDStatus=="ACTIVE") {
  //                                     fromDStepId = userMap1["STEP_ID"]??0;
  //                                     fromTreeChildList = userMap1["TREES"]??[];
  //                                     notifyListeners();
  //                                   }
  //                                   fromDType = userMap1["TYPE"] ?? "";
  //                                   fromName = userMap1["NAME"] ?? "";
  //                                   fromPhone = userMap1["PHONE"] ?? "";
  //                                   fromReference = userMap1["REFERENCE"] ?? "";
  //                                   fromFcmId = userMap1["FCM_ID"] ?? "";
  //                                   fromImage = userMap1["ItemImage"] ?? "";
  //                                   fromChild = userMap1["CHILD_COUNT"] ?? 0;
  //
  //                                   Map<dynamic, dynamic> userMap2 =
  //                                       userValue2.data() as Map;
  //                                   toDocID = userMap2["DOCUMENT_ID"] ?? "";
  //                                   toDParentID =
  //                                       userMap2["DIRECT_PARENT_ID"] ?? "";
  //                                   toGrade = userMap2["GRADE"] ?? "";
  //                                   toDStatus = userMap2["STATUS"] ?? "";
  //                                   if(toDStatus=="ACTIVE") {
  //                                     toStepId = userMap2["STEP_ID"];
  //                                     toTreeChildList = userMap2["TREES"]??[];
  //                                     notifyListeners();
  //                                   }
  //                                   toType = userMap2["TYPE"] ?? "";
  //                                   toName = userMap2["NAME"] ?? "";
  //                                   toPhone = userMap2["PHONE"] ?? "";
  //                                   toReference = userMap2["REFERENCE"] ?? "";
  //                                   toFcmId = userMap2["FCM_ID"] ?? "";
  //                                   toImage = userMap2["ItemImage"] ?? "";
  //                                   toChild = userMap2["CHILD_COUNT"] ?? 0;
  //                                   notifyListeners();
  //
  //                                   db.collection("USERS").doc(fromId).set({
  //                                     "DIRECT_PARENT_ID": toDParentID,
  //                                     "DOCUMENT_ID": toDocID,
  //                                     "GRADE": toGrade,
  //                                     "STATUS": toDStatus,
  //                                     "STEP_ID": toStepId,
  //                                     "TYPE": toType,
  //                                     "TREES": toTreeChildList,
  //                                     "CHILD_COUNT": toChild,
  //                                   }, SetOptions(merge: true));
  //                                   db.collection("USERS").doc(toId).set({
  //                                     "DIRECT_PARENT_ID": fromDParentID,
  //                                     "DOCUMENT_ID": fromDocID,
  //                                     "GRADE": fromGrade,
  //                                     "STATUS": fromDStatus,
  //                                     "STEP_ID": fromDStepId,
  //                                     "TYPE": fromDType,
  //                                     "TREES": fromTreeChildList,
  //                                     "CHILD_COUNT": fromChild
  //                                   }, SetOptions(merge: true));
  //
  //                                   if (fromParentValue.docs.isNotEmpty) {
  //                                     for (var elements
  //                                         in fromParentValue.docs) {
  //                                       db
  //                                           .collection("USERS")
  //                                           .doc(elements.id)
  //                                           .set({"DIRECT_PARENT_ID": toId},
  //                                               SetOptions(merge: true));
  //                                     }
  //                                   }
  //
  //                                   if (toParentValue.docs.isNotEmpty) {
  //                                     for (var elements in toParentValue.docs) {
  //                                       db
  //                                           .collection("USERS")
  //                                           .doc(elements.id)
  //                                           .set({"DIRECT_PARENT_ID": fromId},
  //                                               SetOptions(merge: true));
  //                                     }
  //                                   }
  //
  //                                   if (fromBasicTree.docs.isNotEmpty) {
  //                                     db
  //                                         .collection("MASTER_CLUB")
  //                                         .doc(fromDocID)
  //                                         .set({
  //                                       "MEMBER_ID": toId,
  //                                       "NAME": toName,
  //                                       "PHONE": toPhone,
  //                                       "FCM_ID": toFcmId,
  //                                       "REFERENCE": toReference,
  //                                       "ItemImage": toImage,
  //                                       "STATUS": toDStatus,
  //                                       "UPI_Id": toUpi,
  //                                       "TREES": toTreeChildList,
  //                                     }, SetOptions(merge: true));
  //                                   if (fromBasicValue.docs.isNotEmpty) {
  //
  //                                     for (var elements
  //                                         in fromBasicValue.docs) {
  //                                       db.collection("MASTER_CLUB")
  //                                           .doc(elements.id)
  //                                           .set({"DIRECT_PARENT_ID": toId},
  //                                               SetOptions(merge: true));
  //                                     }
  //                                   }
  //                                   }
  //
  //                                   if (toBasicTree.docs.isNotEmpty) {
  //
  //                                     db
  //                                         .collection("MASTER_CLUB")
  //                                         .doc(toDocID)
  //                                         .set({
  //                                       "MEMBER_ID": fromId,
  //                                       "NAME": fromName,
  //                                       "PHONE": fromPhone,
  //                                       "FCM_ID": fromFcmId,
  //                                       "REFERENCE": fromReference,
  //                                       "ItemImage": fromImage,
  //                                       "STATUS": fromDStatus,
  //                                       "UPI_Id": fromUpi,
  //                                       "TREES": fromTreeChildList,
  //                                     }, SetOptions(merge: true));
  //                                   if (toBasicValue.docs.isNotEmpty) {
  //
  //                                     for (var elements in toBasicValue.docs) {
  //                                       db
  //                                           .collection("MASTER_CLUB")
  //                                           .doc(elements.id)
  //                                           .set({"DIRECT_PARENT_ID": fromId},
  //                                               SetOptions(merge: true));
  //                                     }
  //                                   }
  //                                   }
  //
  //                                   if (fromAutoOneMember.docs.isNotEmpty) {
  //
  //                                     db
  //                                         .collection("STAR_CLUB")
  //                                         .doc(fromDocID)
  //                                         .set({
  //                                       "MEMBER_ID": toId,
  //                                       "NAME": toName,
  //                                       "PHONE": toPhone,
  //                                       "ItemImage": toImage,
  //                                       "STATUS": toDStatus,
  //                                       "TREES": toTreeChildList,
  //                                     }, SetOptions(merge: true));
  //
  //                                   if (fromAutoOne.docs.isNotEmpty) {
  //                                     for (var elements in fromAutoOne.docs) {
  //                                       db
  //                                           .collection("STAR_CLUB")
  //                                           .doc(elements.id)
  //                                           .set({"DIRECT_PARENT_ID": toId},
  //                                               SetOptions(merge: true));
  //                                     }
  //                                   }
  //                                   }
  //
  //                                   if (toAutoOneMember.docs.isNotEmpty) {
  //                                     db
  //                                         .collection("STAR_CLUB")
  //                                         .doc(toDocID)
  //                                         .set({
  //                                       "MEMBER_ID": fromId,
  //                                       "NAME": fromName,
  //                                       "PHONE": fromPhone,
  //                                       "ItemImage": fromImage,
  //                                       "STATUS": fromDStatus,
  //                                       "TREES": fromTreeChildList,
  //                                     }, SetOptions(merge: true));
  //                                   if (toAutoOne.docs.isNotEmpty) {
  //                                     for (var elements in toAutoOne.docs) {
  //                                       db
  //                                           .collection("STAR_CLUB")
  //                                           .doc(elements.id)
  //                                           .set({"DIRECT_PARENT_ID": fromId},
  //                                               SetOptions(merge: true));
  //                                     }
  //                                   }
  //                                   }
  //
  //                                   if (fromAutoTwoMember.docs.isNotEmpty) {
  //                                     db
  //                                         .collection("CROWN_CLUB")
  //                                         .doc(fromDocID)
  //                                         .set({
  //                                       "MEMBER_ID": toId,
  //                                       "NAME": toName,
  //                                       "PHONE": toPhone,
  //                                       "ItemImage": toImage,
  //                                       "STATUS": toDStatus,
  //                                       "TREES": toTreeChildList,
  //                                     }, SetOptions(merge: true));
  //                                   if (fromAutoTwo.docs.isNotEmpty) {
  //                                     for (var elements in fromAutoTwo.docs) {
  //                                       db
  //                                           .collection("CROWN_CLUB")
  //                                           .doc(elements.id)
  //                                           .set({"DIRECT_PARENT_ID": toId},
  //                                               SetOptions(merge: true));
  //                                     }
  //                                   }
  //                                   }
  //
  //                                   if (toAutoTwoMember.docs.isNotEmpty) {
  //                                     db
  //                                         .collection("CROWN_CLUB")
  //                                         .doc(toDocID)
  //                                         .set({
  //                                       "MEMBER_ID": fromId,
  //                                       "NAME": fromName,
  //                                       "PHONE": fromPhone,
  //                                       "ItemImage": fromImage,
  //                                       "STATUS": fromDStatus,
  //                                       "TREES": fromTreeChildList,
  //                                     }, SetOptions(merge: true));
  //                                   if (toAutoTwo.docs.isNotEmpty) {
  //
  //                                     for (var elements in toAutoTwo.docs) {
  //                                       db
  //                                           .collection("CROWN_CLUB")
  //                                           .doc(elements.id)
  //                                           .set({"DIRECT_PARENT_ID": fromId},
  //                                               SetOptions(merge: true));
  //                                     }
  //                                   }
  //                                   }
  //
  //                                   db
  //                                       .collection("USERS")
  //                                       .where("REFERENCE", isEqualTo: fromId)
  //                                       .get()
  //                                       .then((toValue1) {
  //                                     if (toValue1.docs.isNotEmpty) {
  //                                       for (var elements in toValue1.docs) {
  //                                         db
  //                                             .collection("USERS")
  //                                             .doc(elements.id)
  //                                             .set({"REFERENCE": referId},
  //                                                 SetOptions(merge: true));
  //                                       }
  //                                     }
  //                                   });
  //
  //                                   /// distributions
  //
  //                                   db.collection("DISTRIBUTIONS")
  //                                       .where("FROM_ID", isEqualTo: fromId)
  //                                       .where("STATUS", isEqualTo: "PENDING")
  //                                       .get().then((fromDistributionFrom) {
  //                                     db
  //                                         .collection("DISTRIBUTIONS")
  //                                         .where("FROM_ID", isEqualTo: toId)
  //                                         .where("STATUS", isEqualTo: "PENDING")
  //                                         .get().then((fromDistributionTo) {
  //
  //                                       db
  //                                           .collection("DISTRIBUTIONS")
  //                                           .where("TO_ID", isEqualTo: fromId)
  //                                           .where("STATUS", isEqualTo: "PENDING")
  //                                           .get().then((toDistributionFrom) {
  //                                         db
  //                                             .collection("DISTRIBUTIONS")
  //                                             .where("TO_ID", isEqualTo: toId)
  //                                             .where("STATUS", isEqualTo: "PENDING")
  //                                             .get().then((toDistributionTo) {
  //
  //                                           if (fromDistributionFrom.docs.isNotEmpty) {
  //                                             for (var element
  //                                             in fromDistributionFrom.docs) {
  //                                               db
  //                                                   .collection("DISTRIBUTIONS")
  //                                                   .doc(element.id)
  //                                                   .set({
  //                                                 "FROM_ID": toId
  //                                               }, SetOptions(merge: true));
  //                                             }
  //                                           }
  //
  //                                           if (fromDistributionTo.docs.isNotEmpty) {
  //                                             for (var element
  //                                             in fromDistributionTo.docs) {
  //                                               db
  //                                                   .collection("DISTRIBUTIONS")
  //                                                   .doc(element.id)
  //                                                   .set({
  //                                                 "FROM_ID": fromId
  //                                               }, SetOptions(merge: true));
  //                                             }
  //                                           }
  //
  //                                           if (toDistributionFrom.docs.isNotEmpty) {
  //                                             for (var element
  //                                             in toDistributionFrom.docs) {
  //                                               db
  //                                                   .collection("DISTRIBUTIONS")
  //                                                   .doc(element.id)
  //                                                   .set({
  //                                                 "TO_ID": toId
  //                                               }, SetOptions(merge: true));
  //                                             }
  //                                           }
  //
  //                                           if (toDistributionTo.docs.isNotEmpty) {
  //                                             for (var element in toDistributionTo.docs ) {
  //                                               db
  //                                                   .collection("DISTRIBUTIONS")
  //                                                   .doc(element.id)
  //                                                   .set({
  //                                                 "TO_ID": fromId
  //                                               }, SetOptions(merge: true));
  //                                             }
  //                                           }
  //
  //                                           newExchangeUsers(
  //                                               fromController.text,
  //                                               toController.text, context2);
  //                                            showNotificationSnackBar(context2, "$exchangeFromName to $exchangeToName exchanged");
  //
  //
  //                                         });});
  //
  //                                     });});
  //                                 });
  //                               });
  //                               });
  //                               });
  //                             });
  //                           });
  //                         });
  //                       });
  //                     });
  //                   });
  //                 });
  //               });
  //             });
  //           });
  //         });
  //       });
  //     });
  //     }
  //     else{
  //       exchangeUserKycBool=  false;
  //       final snackDemo = SnackBar(
  //         content:  const SizedBox(
  //           child: Text(
  //            "kyc not update/user not active",
  //             style: TextStyle(
  //               color: Colors.red,
  //               fontSize: 15,
  //               fontFamily: 'PoppinsRegular',
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ),
  //         backgroundColor: myWhite,
  //         elevation: 10,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(79),
  //         ),
  //         behavior: SnackBarBehavior.floating,
  //         margin: const EdgeInsets.all(10),
  //       );
  //       ScaffoldMessenger.of(context2)
  //           .showSnackBar(snackDemo);
  //     }
  //   } else {
  //     warningAlert(context2, "Id not found.");
  //   }
  //   exchangeUserBool = false;
  //   notifyListeners();
  //   finish(context2);
  // }


  Future<void> exchangeUsers(String fromId, String toId,String fromDocId, String toDocId, BuildContext context2) async {

    String fromUserName = "";
    String fromUserPhone = "";
    String fromUserStatus = "";
    String fromUserFcm = "";
    String fromUserReference = "";
    String fromUserReferenceName = "";
    String fromUserReferenceNumber = "";
    String fromUserImage = "";
    String fromUserUpi = "";
    String fromUserDirectParentId = "";
    String fromUserDocumentId = "";
    String fromUserAutoOneGrade = "";
    String fromUserMasterGrade = "";
    String fromUserAutoTwoGrade = "";
    String fromUserStarEntry = "";
    String fromUserCrownEntry = "";
    int fromUserStepId = 0;
    int fromUserChildCount = 0;
    List<dynamic>fromUserTreeList = [];

    String toUserName = "";
    String toUserPhone = "";
    String toUserStatus = "";
    String toUserFcm = "";
    String toUserReference = "";
    String toUserReferenceName = "";
    String toUserReferenceNumber = "";
    String toUserImage = "";
    String toUserUpi = "";
    String toUserDirectParentId = "";
    String toUserDocumentId = "";
    String toUserMasterGrade = "";
    String toUserAutoOneGrade = "";
    String toUserAutoTwoGrade = "";
    String toUserStarEntry = "";
    String toUserCrownEntry = "";
    int toUserStepId = 0;
    int toUserChildCount = 0;
    List<dynamic>toUserTreeList = [];

    var fromUserValue = await db.collection("USERS").doc(fromId).get();
    var toUserValue = await db.collection("USERS").doc(toId).get();
    var fromUserMasterValue = await db.collection("MASTER_CLUB").doc(fromDocId).get();
    var toUserMasterValue = await db.collection("MASTER_CLUB").doc(toDocId).get();

    if(fromUserValue.exists&&toUserValue.exists
        &&fromUserMasterValue.exists&&toUserMasterValue.exists){

      Map<dynamic, dynamic> fromUserMap = fromUserValue.data() as Map;

      fromUserName = fromUserMap["NAME"].toString();
      fromUserPhone = fromUserMap["PHONE"].toString();
      fromUserStatus = fromUserMap["STATUS"].toString();
      fromUserFcm = fromUserMap["FCM_ID"].toString();
      fromUserReference = fromUserMap["REFERENCE"].toString();
      fromUserReferenceName = fromUserMap["REFERENCE_NAME"].toString();
      fromUserReferenceNumber = fromUserMap["REFERENCE_NUMBER"].toString();
      fromUserImage = fromUserMap["ItemImage"].toString();
      fromUserUpi = fromUserMap["UPI_Id"].toString();
      fromUserDirectParentId = fromUserMap["DIRECT_PARENT_ID"] ?? "";
      fromUserDocumentId = fromUserMap["DOCUMENT_ID"] ?? "";
      fromUserMasterGrade = fromUserMap["GRADE"] ?? "";
      fromUserAutoOneGrade = fromUserMap["AUTO_ONE_GRADE"] ?? "";
      fromUserAutoTwoGrade = fromUserMap["AUTO_TWO_GRADE"] ?? "";
      fromUserStarEntry = fromUserMap["STAR_ENTRY"] ?? "";
      fromUserCrownEntry = fromUserMap["CROWN_ENTRY"] ?? "";
      fromUserStepId = fromUserMap["STEP_ID"]??0;
      fromUserChildCount = fromUserMap["CHILD_COUNT"] ?? 0;
      fromUserTreeList = fromUserMap["TREES"] ?? [];

      notifyListeners();

      Map<String, Object> fromUserHashMap = HashMap();
      fromUserHashMap["STEP_ID"] = fromUserStepId;
      fromUserHashMap["CHILD_COUNT"] = fromUserChildCount;
      fromUserHashMap["DIRECT_PARENT_ID"] = fromUserDirectParentId;
      fromUserHashMap["MEMBER_ID"] = fromId;
      fromUserHashMap["GRADE"] = fromUserMasterGrade;
      fromUserHashMap["REFERENCE"] = fromUserReference;
      fromUserHashMap["REFERENCE_NAME"] = fromUserReferenceName;
      fromUserHashMap["REFERENCE_NUMBER"] = fromUserReferenceNumber;
      fromUserHashMap["EXCHANGE_USER"] = toId;
      fromUserHashMap["EXCHANGE_USER_TYPE"] = "TO_USER";
      if(fromUserStarEntry.isNotEmpty) {
        fromUserHashMap["STAR_ENTRY"] = fromUserStarEntry;
      }
      if(fromUserCrownEntry.isNotEmpty) {
        fromUserHashMap["CROWN_ENTRY"] = fromUserCrownEntry;
      }
      if(fromUserAutoOneGrade.isNotEmpty) {
        fromUserHashMap["AUTO_ONE_GRADE"] = fromUserAutoOneGrade;
      }
      if(fromUserAutoTwoGrade.isNotEmpty) {
        fromUserHashMap["AUTO_TWO_GRADE"] = fromUserAutoTwoGrade;
      }
      fromUserHashMap["DOCUMENT_ID"] = fromUserDocumentId;
      fromUserHashMap["TREES"] = fromUserTreeList;


      Map<dynamic, dynamic> toUserMap = toUserValue.data() as Map;

      toUserName = toUserMap["NAME"].toString();
      toUserPhone = toUserMap["PHONE"].toString();
      toUserStatus = toUserMap["STATUS"].toString();
      toUserFcm = toUserMap["FCM_ID"].toString();
      toUserReference = toUserMap["REFERENCE"].toString();
      toUserReferenceName = toUserMap["REFERENCE_NAME"].toString();
      toUserReferenceNumber = toUserMap["REFERENCE_NUMBER"].toString();
      toUserImage = toUserMap["ItemImage"].toString();
      toUserUpi = toUserMap["UPI_Id"].toString();
      toUserDirectParentId = toUserMap["DIRECT_PARENT_ID"] ?? "";
      toUserDocumentId = toUserMap["DOCUMENT_ID"] ?? "";
      toUserMasterGrade = toUserMap["GRADE"] ?? "";
      toUserAutoOneGrade = toUserMap["AUTO_ONE_GRADE"] ?? "";
      toUserAutoTwoGrade = toUserMap["AUTO_TWO_GRADE"] ?? "";
      toUserStarEntry = toUserMap["STAR_ENTRY"] ?? "";
      toUserCrownEntry = toUserMap["CROWN_ENTRY"] ?? "";
      toUserStepId = toUserMap["STEP_ID"]??0;
      toUserChildCount = toUserMap["CHILD_COUNT"] ?? 0;
      toUserTreeList = toUserMap["TREES"] ?? [];

      notifyListeners();

      Map<String, Object> toUserHashMap = HashMap();
      toUserHashMap["STEP_ID"] = toUserStepId;
      toUserHashMap["CHILD_COUNT"] = toUserChildCount;
      toUserHashMap["DIRECT_PARENT_ID"] = toUserDirectParentId;
      toUserHashMap["MEMBER_ID"] = toId;
      toUserHashMap["EXCHANGE_USER"] = fromId;
      toUserHashMap["GRADE"] = toUserMasterGrade;
      toUserHashMap["REFERENCE"] = toUserReference;
      toUserHashMap["REFERENCE_NAME"] = toUserReferenceName;
      toUserHashMap["REFERENCE_NUMBER"] = toUserReferenceNumber;
      toUserHashMap["EXCHANGE_USER_TYPE"] = "FROM_USER";
      if(toUserStarEntry.isNotEmpty) {
        toUserHashMap["STAR_ENTRY"] = toUserStarEntry;
      }
      if(toUserCrownEntry.isNotEmpty) {
        toUserHashMap["CROWN_ENTRY"] = toUserCrownEntry;
      }
      if(toUserAutoOneGrade.isNotEmpty) {
        toUserHashMap["AUTO_ONE_GRADE"] = toUserAutoOneGrade;
      }
      if(toUserAutoTwoGrade.isNotEmpty) {
        toUserHashMap["AUTO_TWO_GRADE"] = toUserAutoTwoGrade;
      }
      toUserHashMap["DOCUMENT_ID"] = toUserDocumentId;
      toUserHashMap["TREES"] = toUserTreeList;

      notifyListeners();

      await db.collection("USERS").doc(fromId).set(toUserMap.cast());
      await db.collection("USERS").doc(fromId).set(fromUserHashMap,SetOptions(merge: true));
      await db.collection("USERS").doc(toId).set(fromUserMap.cast());
      await db.collection("USERS").doc(toId).set(toUserHashMap,SetOptions(merge: true));

      await db.collection("MASTER_CLUB").doc(fromDocId).set(
          {
            "NAME":toUserName,
            "PHONE":toUserPhone,
            "STATUS":toUserStatus,
            "FCM_ID":toUserFcm,
            "ItemImage":toUserImage,
            "UPI_Id":toUserUpi,
          },SetOptions(merge: true));


      await db.collection("MASTER_CLUB").doc(toDocId).set(
          {
            "NAME":fromUserName,
            "PHONE":fromUserPhone,
            "STATUS":fromUserStatus,
            "FCM_ID":fromUserFcm,
            "ItemImage":fromUserImage,
            "UPI_Id":fromUserUpi,
          },SetOptions(merge: true));

      var fromUserStarValue = await db.collection("STAR_CLUB").doc(fromDocId).get();
      var toUserStarValue = await db.collection("STAR_CLUB").doc(toDocId).get();
      var fromUserCrownValue = await db.collection("CROWN_CLUB").doc(fromDocId).get();
      var toUserCrownValue = await db.collection("CROWN_CLUB").doc(toDocId).get();
      var fromUserRefValue = await db.collection("USERS").where("REFERENCE",isEqualTo: fromId).get();
      var toUserRefValue = await db.collection("USERS").where("REFERENCE",isEqualTo: toId).get();

      if(fromUserRefValue.docs.isNotEmpty){
        for(var fromElements in fromUserRefValue.docs){
          await db.collection("USERS").doc(fromElements.id)
              .set({
            "REFERENCE_NAME":toUserName,
            "REFERENCE_NUMBER":toUserPhone,
              },SetOptions(merge: true));
        }
      }
      if(toUserRefValue.docs.isNotEmpty){
        for(var toElements in toUserRefValue.docs){
          await db.collection("USERS").doc(toElements.id)
              .set({
            "REFERENCE_NAME":fromUserName,
            "REFERENCE_NUMBER":fromUserPhone,
          },SetOptions(merge: true));
        }
      }

      if(fromUserStarValue.exists){
        print("from star exist");
        await db.collection("STAR_CLUB").doc(fromDocId).set(
            {
              "NAME":toUserName,
              "PHONE":toUserPhone,
              "STATUS":toUserStatus,
              "FCM_ID":toUserFcm,
              "ItemImage":toUserImage,
              "UPI_Id":toUserUpi,
            },SetOptions(merge: true));
      }else{
        print("from star not exist");
      }
      if(toUserStarValue.exists){
        print("to star exist");
        await db.collection("STAR_CLUB").doc(toDocId).set(
            {
              "NAME":fromUserName,
              "PHONE":fromUserPhone,
              "STATUS":fromUserStatus,
              "FCM_ID":fromUserFcm,
              "ItemImage":fromUserImage,
              "UPI_Id":fromUserUpi,
            },SetOptions(merge: true));
      }else{
        print("to star not exist");
      }
      if(fromUserCrownValue.exists){
        print("from crown exist");
        await db.collection("CROWN_CLUB").doc(fromDocId).set(
            {
              "NAME":toUserName,
              "PHONE":toUserPhone,
              "STATUS":toUserStatus,
              "FCM_ID":toUserFcm,
              "ItemImage":toUserImage,
              "UPI_Id":toUserUpi,
            },SetOptions(merge: true));
      }else{
        print("from crown not exist");
      }
      if(toUserCrownValue.exists){
        print("to crown exist");
        await db.collection("CROWN_CLUB").doc(toDocId).set(
            {
              "NAME":fromUserName,
              "PHONE":fromUserPhone,
              "STATUS":fromUserStatus,
              "FCM_ID":fromUserFcm,
              "ItemImage":fromUserImage,
              "UPI_Id":fromUserUpi,
            },SetOptions(merge: true));
      }else{
        print("to crown not exist");
      }
      notifyListeners();
      newExchangeUsers(
          fromController.text,fromUserName,fromUserPhone,
          toController.text,toUserName,toUserPhone, context2);
      showNotificationSnackBar(context2, "$exchangeFromName to $exchangeToName exchanged");

    }

  }


  Future<bool> statusCheckForExchangeUser(String fromId) async {
  var s=await db.collection("USERS").where("MEMBER_ID",isEqualTo: fromId).where("STATUS",isEqualTo:"ACTIVE").get();
  if(s.docs.isEmpty){
    return false;
  }else{
    return true;
  }
  }
  Future<bool> kycCheckForExchangeUser(String fromId,String toId) async {

  var k=await db.collection("USERS").where("MEMBER_ID",isEqualTo: fromId).where("KYC_STATUS",isEqualTo:"VERIFIED").get();
  // var y= await db.collection("USERS").where("MEMBER_ID",isEqualTo: toId).where("KYC_STATUS",isEqualTo:"VERIFIED" ).get();

  if(k.docs.isEmpty
      // ||y.docs.isEmpty
  ){
    return false;
  }else{
    return true;
  }

  }


  String exchangeToName = '';
  String exchangeToRegID = '';
  String exchangeToRegDocID = '';
  String exchangeToPhone = '';

  String exchangeFromName = '';
  String exchangeFromRegID = '';
  String exchangeFromRegDocID = '';
  String exchangeFromPhone = '';

  TextEditingController toController = TextEditingController();
  TextEditingController fromController = TextEditingController();
  TextEditingController deleteUserController = TextEditingController();

  clearExchangeControllers(String from) {
    if (from == "TO") {
      exchangeToName = '';
      exchangeToRegID = '';
      exchangeToPhone = '';
    } else {
      exchangeFromName = '';
      exchangeFromRegID = '';
      exchangeFromPhone = '';
    }
    notifyListeners();
  }

  clearAllExchangeControllers() {
    exchangeToName = '';
    exchangeToRegID = '';
    exchangeToPhone = '';
    exchangeFromName = '';
    exchangeFromRegID = '';
    exchangeFromPhone = '';
    fromController.clear();
    toController.clear();
    fileImage = null;
    selectedExchange = '';
    exchangeOtherCheck = false;
    isEligibleToExchange = false;
    notifyListeners();
  }
  bool isEligibleToExchange = false;
  bool isEligibleChecking = false;

  Future<void> checkUserExchangeEligibility(String fromUserId,String toUserId,BuildContext context) async {

    isEligibleChecking=true;
    notifyListeners();
    var fromUserValue = await db.collection("USERS")
        .where("MEMBER_ID",isEqualTo: fromUserId)
        .where("KYC_STATUS",isEqualTo: "VERIFIED")
        .where("STATUS",isEqualTo: "ACTIVE").get();
    if(fromUserValue.docs.isNotEmpty){
      var toUserValue = await db.collection("USERS")
          .where("MEMBER_ID",isEqualTo: toUserId).get();
      if(toUserValue.docs.isNotEmpty){
        var toUserStarValue = await db.collection("STAR_CLUB")
            .where("MEMBER_ID",isEqualTo: toUserId).get();
        if(toUserStarValue.docs.isNotEmpty){
          var fromUserRefValue = await db.collection("USERS")
              .where("REFERENCE",isEqualTo: fromUserId)
              .where("STATUS",isEqualTo: "ACTIVE").get();
          if(fromUserRefValue.docs.length>1){
            Map<dynamic, dynamic> exchangeFromMap = fromUserValue.docs.first.data() as Map;
            exchangeFromName = exchangeFromMap["NAME"] ?? "";
            exchangeFromRegID = exchangeFromMap["MEMBER_ID"] ?? "";
            exchangeFromRegDocID = exchangeFromMap["DOCUMENT_ID"] ?? "";
            exchangeFromPhone = exchangeFromMap["PHONE"] ?? "";
            Map<dynamic, dynamic> exchangeToMap = toUserValue.docs.first.data() as Map;
            exchangeToName = exchangeToMap["NAME"] ?? "";
            exchangeToRegID = exchangeToMap["MEMBER_ID"] ?? "";
            exchangeToRegDocID = exchangeToMap["DOCUMENT_ID"] ?? "";
            exchangeToPhone = exchangeToMap["PHONE"] ?? "";
            isEligibleToExchange = true;
            isEligibleChecking = false;
            notifyListeners();
          }
          else{
            isEligibleChecking = false;
            notifyListeners();
            warningAlert(context,"Exchange user must need two active references to exchange with auto poll members.");
          }
        }else{
          Map<dynamic, dynamic> exchangeFromMap = fromUserValue.docs.first.data() as Map;
          exchangeFromName = exchangeFromMap["NAME"] ?? "";
          exchangeFromRegID = exchangeFromMap["MEMBER_ID"] ?? "";
          exchangeFromRegDocID = exchangeFromMap["DOCUMENT_ID"] ?? "";
          exchangeFromPhone = exchangeFromMap["PHONE"] ?? "";
          Map<dynamic, dynamic> exchangeToMap = toUserValue.docs.first.data() as Map;
          exchangeToName = exchangeToMap["NAME"] ?? "";
          exchangeToRegID = exchangeToMap["MEMBER_ID"] ?? "";
          exchangeToRegDocID = exchangeToMap["DOCUMENT_ID"] ?? "";
          exchangeToPhone = exchangeToMap["PHONE"] ?? "";
          isEligibleToExchange = true;
          isEligibleChecking = false;
          notifyListeners();
        }

      }
      else{
        isEligibleChecking = false;
        notifyListeners();
        warningAlert(context,"To User Id Not Found.");
      }
    }else{
      isEligibleChecking = false;
      notifyListeners();
      warningAlert(context,"Exchange user must be an active KYC verified member.");
    }
  }

  String deleteUserName="";
  String deleteUserNumber="";
  String deleteUserId="";
  String deleteUserDocId="";
  String deleteUserImage="";
  bool isEligibleForDelete=false;
  bool isDeletionEligibility=false;

  checkUserDeletionEligibility(String deletionMemberId,BuildContext context223) async {
    isDeletionEligibility=true;
    notifyListeners();
    var userRefValue = await db.collection("USERS")
        .where("DIRECT_PARENT_ID",isEqualTo: deletionMemberId).get();
    var userDistValue = await db.collection("DISTRIBUTIONS")
        .where("FROM_ID",isEqualTo: deletionMemberId)
        .where("TYPE",isEqualTo: "HELP")
        .where("STATUS",isEqualTo: "PAID")
        .get();
    if(userRefValue.docs.isEmpty&&userDistValue.docs.isEmpty){

      var deleteValue = await db.collection("USERS").doc(deletionMemberId).get();
      if(deleteValue.exists){
        isEligibleForDelete=true;
        Map<dynamic, dynamic> deletionMap = deleteValue.data() as Map;
        deleteUserName = deletionMap["NAME"] ?? "";
        deleteUserId = deletionMap["MEMBER_ID"] ?? "";
        deleteUserDocId = deletionMap["DOCUMENT_ID"] ?? "";
        deleteUserNumber = deletionMap["PHONE"] ?? "";
        deleteUserImage = deletionMap["ItemImage"] ?? "";
        isDeletionEligibility=false;
        notifyListeners();
      }
    }else{
      warningAlert(context223,"Not eligible to delete this Member");
    }

  }
  clearUserDeletionEligibility(){
    deleteUserName="";
    deleteUserNumber="";
    deleteUserId="";
    deleteUserDocId="";
    deleteUserImage="";
    isEligibleForDelete=false;
    isDeletionEligibility=false;
    deleteUserController.clear();
    notifyListeners();
  }

  bool loaderDelete = false;

  deleteUser(String memberId,BuildContext ctx) async {
    loaderDelete = true;
    notifyListeners();
    String deleteUserParentID ="";
    String deleteUserReferenceId ="";
    String deleteUserDocumentId ="";
    String deleteUserParentDocumentId ="";

    var deleteUserValue = await  db.collection("USERS").doc(memberId).get();

    if(deleteUserValue.exists) {
      print("deleteUserValue");
      Map<dynamic, dynamic> deleteUserMap = deleteUserValue.data() as Map;

      if (deleteUserMap["DIRECT_PARENT_ID"] != null) {
        deleteUserParentID = deleteUserMap["DIRECT_PARENT_ID"];
        deleteUserReferenceId = deleteUserMap["REFERENCE"];
        deleteUserDocumentId = deleteUserMap["DOCUMENT_ID"];
        notifyListeners();
        var deleteUserParentValue = await db.collection("USERS").doc(
            deleteUserParentID).get();
        var deleteUserReferenceValue = await db.collection("USERS").doc(
            deleteUserReferenceId).get();
        if (deleteUserParentValue.exists) {
          print("deleteUserParentValue");
          Map<dynamic, dynamic> deleteUserParentMap = deleteUserParentValue
              .data() as Map;

          deleteUserParentDocumentId = deleteUserParentMap["DOCUMENT_ID"];
          notifyListeners();
          await db.collection("USERS").doc(deleteUserParentID)
              .set(
              {"CHILD_COUNT": FieldValue.increment(-1)}, SetOptions(merge: true));

          await db.collection("MASTER_CLUB").doc(deleteUserParentDocumentId)
              .set({
            "CHILD_COUNT": FieldValue.increment(-1),
            "CHILDREN": FieldValue.arrayRemove([deleteUserDocumentId])
          }, SetOptions(merge: true));
        }

        if (deleteUserReferenceValue.exists) {
          print("deleteUserReferenceValue");
          await db.collection("USERS").doc(deleteUserReferenceId)
              .set({"TOTAL_INVITEES_COUNT": FieldValue.increment(-1)},
              SetOptions(merge: true));
        }

        var distValue = await db.collection("DISTRIBUTIONS")
            .where("FROM_ID", isEqualTo: memberId).get();
        if (distValue.docs.isNotEmpty) {
          print("distValue");
          for (var element in distValue.docs) {
            await db.collection("DISTRIBUTIONS").doc(element.id).delete();
            notifyListeners();
          }
        }

        var commonRefValue = await db.collection("TOTAL_AMOUNTS")
            .doc("REFERRAL")
            .get();
        if (commonRefValue.exists) {
          print("commonRefValue");
          Map<dynamic, dynamic> commonRefMap = commonRefValue.data() as Map;

          var memberRefValue = await db.collection("USERS")
              .where("REFERENCE", isEqualTo: memberId).get();
          if (memberRefValue.docs.isNotEmpty) {
            print("memberRefValue");

            String referenceUserName = commonRefMap["REFERENCE_NAME"];
            String referenceUserNumber = commonRefMap["REFERRAL_ID"];
            String referenceUserId = commonRefMap["REFERENCE"];

            for (var element in memberRefValue.docs) {
              await db.collection("USERS").doc(element.id).set({
                "REFERENCE": referenceUserId,
                "REFERENCE_NAME": referenceUserName,
                "REFERENCE_NUMBER": referenceUserNumber,
              }, SetOptions(merge: true));
              notifyListeners();
              var refMaster = await db.collection("MASTER_CLUB").where(
                  "MEMBER_ID", isEqualTo: element.id).get();
              var refStar = await db.collection("STAR_CLUB").where(
                  "MEMBER_ID", isEqualTo: element.id).get();
              var refCrown = await db.collection("CROWN_CLUB").where(
                  "MEMBER_ID", isEqualTo: element.id).get();


              if (refMaster.docs.isNotEmpty) {
                await db.collection("MASTER_CLUB")
                    .doc(refMaster.docs.first.id)
                    .set({
                  "REFERENCE": referenceUserId,
                }, SetOptions(merge: true));

                if (refStar.docs.isNotEmpty) {
                  await db.collection("STAR_CLUB").doc(refStar.docs.first.id).set(
                      {
                        "REFERENCE": referenceUserId,
                      }, SetOptions(merge: true));

                  if (refCrown.docs.isNotEmpty) {
                    await db.collection("CROWN_CLUB")
                        .doc(refCrown.docs.first.id)
                        .set({
                      "REFERENCE": referenceUserId,
                    }, SetOptions(merge: true));
                  }
                }
              }

              notifyListeners();
            }
          }
        }


        await db.collection("USERS").doc(memberId).delete();
        await db.collection("MASTER_CLUB").doc(deleteUserDocumentId).delete();

        loaderDelete = false;
        notifyListeners();
        callNextReplacement(const AdminHomeScreen(), ctx);
      }else{
        await db.collection("USERS").doc(memberId).delete();
        loaderDelete = false;
        notifyListeners();
        callNextReplacement(AdminHomeScreen(), ctx);
      }

    }
  }

  registrationIdExchange(String regID, String from) {
    db.collection("USERS").doc(regID).get().then((value) {
      if (value.exists) {
        Map<dynamic, dynamic> exchangeMap = value.data() as Map;
        if (from == "TO") {
          exchangeToName = exchangeMap["NAME"] ?? "";
          exchangeToRegID = exchangeMap["MEMBER_ID"] ?? "";
          exchangeToPhone = exchangeMap["PHONE"] ?? "";
        } else {
          // db.collection("USERS").where("REFERENCE",isEqualTo: regID).get().then((value) => null)
          
          exchangeFromName = exchangeMap["NAME"] ?? "";
          exchangeFromRegID = exchangeMap["MEMBER_ID"] ?? "";
          exchangeFromPhone = exchangeMap["PHONE"] ?? "";
        }
      }
      notifyListeners();
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

  adminGstCalc(double amount) {
    double gstAmount = amount / 1.18;
    double amountByGst = amount - gstAmount;
    double finalGst = amountByGst / 2;
    return finalGst.toStringAsFixed(2);
  }

  void createExcelPMCReciept(String name, String stage, String phone,
      String regId, String transID, String date, String amount) async {
    // loader=true;
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    // sheet.getRangeByName('A1').setText('SL NO');
    sheet.getRangeByName('A1').setText('Name');
    sheet.getRangeByName('A2').setText('Stage');
    sheet.getRangeByName('A3').setText('Phone Number');
    sheet.getRangeByName('A4').setText('Register ID');
    sheet.getRangeByName('A5').setText('Transaction ID');
    sheet.getRangeByName('A6').setText('Date Time');
    sheet.getRangeByName('A7').setText('SGST');
    sheet.getRangeByName('A8').setText('CGST');
    sheet.getRangeByName('A9').setText('Total');
    // sheet.getRangeByName('B1').setNumber(1);
    sheet.getRangeByName('B1').setText(name);
    sheet.getRangeByName('B2').setText(stage);
    sheet.getRangeByName('B3').setText(phone);
    sheet.getRangeByName('B4').setText(regId);
    sheet.getRangeByName('B5').setText(transID);
    sheet.getRangeByName('B6').setText(date);
    sheet.getRangeByName('B7').setText(adminGstCalc(double.parse(amount)));
    sheet.getRangeByName('B8').setText(adminGstCalc(double.parse(amount)));
    sheet
        .getRangeByName('B9')
        .setText(((double.parse(amount)) / 1.18).toStringAsFixed(2));

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    // if
    final String path = (await getApplicationSupportDirectory()).path;
    final fileName = '$path/Report.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
    File testFile = File("$path/Report.xlsx");

    if (!await testFile.exists()) {
      await testFile.create(recursive: true);
      testFile.writeAsStringSync("test for share documents file");
    }
    ShareExtend.share(testFile.path, "file");
    // Share.shareFiles([file.path], text: 'House report');

    // loader=false;
    notifyListeners();
  }

  void showNotificationSnackBar(BuildContext context, String message) {
    print(MediaQuery.of(context).size.height);
    final snackDemo = SnackBar(
      content: SizedBox(
        width: 284,
        height: 20,
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF16B200),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(79),
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 10,
        left: 10,
        right: 10,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackDemo);


  }

// Call the function
  Reference ref3 = FirebaseStorage.instance.ref("PROOF_IMAGE");

  Future<void> newExchangeUsers(
      String fromId,String fromName,String fromNumber, String toId,String toName,String toNumber, BuildContext context2) async {
    String categoryId = DateTime.now().millisecondsSinceEpoch.toString();
    Map<String, Object> dataMapp = HashMap();

    dataMapp["EXCHANGE_TIME"] = DateTime.now();
    dataMapp["EXCHANGE_ADMIN_ID"] = adminId;
    dataMapp["EXCHANGE_ADMIN_NAME"] = adminName;
    dataMapp["EXCHANGE_ADMIN_PHONE"] = adminPhone;
    dataMapp["FROM_ID"] = fromId;
    dataMapp["FROM_USER_NAME"] = fromName;
    dataMapp["FROM_USER_NUMBER"] = fromNumber;
    dataMapp["TO_ID"] = toId;
    dataMapp["TO_USER_NAME"] = toName;
    dataMapp["TO_USER_NUMBER"] = toNumber;
    dataMapp["STATUS"] = "APPROVED";
    dataMapp["EXCHANGE_TYPE"] = "ADMIN";
    dataMapp["REQUEST_TIME"] = DateTime.now();
    dataMapp["REQUEST_ID"] = "";
    dataMapp["REQUEST_NAME"] = "";
    dataMapp["REQUEST_PHONE"] = "";
    if (exChangeController.text != "") {
      dataMapp["REASON"] = exChangeController.text;
    } else {
      dataMapp["REASON"] = selectedExchange;
    }
    if (fileImage != null) {
      String time = DateTime.now().millisecondsSinceEpoch.toString();
      ref3 = FirebaseStorage.instance.ref().child(time);
      await ref3.putFile(fileImage!).whenComplete(() async {
        await ref3.getDownloadURL().then((value3) {
          dataMapp['PROOF_IMAGE'] = value3;

          // userProfileImage = value3;
          notifyListeners();
        });
        notifyListeners();
      });
      notifyListeners();
    } else {
      dataMapp['PROOF_IMAGE'] = "";
    }
    await db
        .collection("EXCHANGE_USERS")
        .doc(categoryId)
        .set(dataMapp, SetOptions(merge: true));
    // showNotificationSnackBar(context2, "$exchangeFromName to $exchangeToName exchanged");
    exChangeController.text = '';
    selectedExchange = '';
    toId = '';
    fromId = '';
    fileImage == null;
    clearAllExchangeControllers();
    notifyListeners();
    Navigator.pushAndRemoveUntil(context2,  MaterialPageRoute(builder: (context) => ExchangeUserList()), (route) => false);
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

  StreamSubscription? _streamTaskDetails;
  void getAssignedTasksAdmin() {
    if(_streamTaskDetails!=null) {
      _streamTaskDetails!.cancel();
    }
    assignedTaskList.clear();
    assignedTaskDateList.clear();
    String taskStatus = "";
    bool isDateLessThanOrEqual = false;
    String taskDate = "";
    String taskTime = "";
    String startDuration = "";
    String endDuration = "";
    DateTime now = DateTime.now();
    String nowString = outputDayNode.format(now).toString();
    DateTime taskDateTime = DateTime.now();
    DateTime durationEndTime = DateTime.now();
    _streamTaskDetails = db.collection("TASKS").snapshots().listen((taskSnap) {
      if (taskSnap.docs.isNotEmpty) {
        assignedTaskList.clear();
        for (var elements in taskSnap.docs) {
          Map<dynamic, dynamic> taskMap = elements.data();
          taskDateTime = taskMap["ADDED_TIME"].toDate();
          taskDate = outputDayNode.format(taskDateTime).toString();
          taskTime = outputDayNode2.format(taskDateTime).toString();
          startDuration = outputDayNode.format(taskMap["START_DATE"].toDate()).toString();
          endDuration = outputDayNode.format(taskMap["END_DATE"].toDate()).toString();
          durationEndTime = taskMap["END_DATE"].toDate();
          isDateLessThanOrEqual = durationEndTime.isAfter(now) || nowString == endDuration;
          //isDateLessThanOrEqual = durationEndTime.isAfter(now) ||
          durationEndTime.isAtSameMomentAs(now);
          taskStatus = isDateLessThanOrEqual ? "ACTIVE" : "EXPIRED";

          assignedTaskList.add(AssignedTaskModel(
              elements.id,
              "$startDuration - $endDuration",
              taskMap["ADDED_NAME"],
              taskMap["TASK_HEADING"],
              taskStatus,
              taskDate,
              taskTime,
              taskDateTime));
          filterAssignedTaskList = assignedTaskList;

          if (!assignedTaskDateList
              .map((item) => item.dateFormat).contains(taskDate)) {
            assignedTaskDateList.add(TransactionDateModel(taskDate, taskDateTime));
            notifyListeners();
          }
          notifyListeners();
        }
        notifyListeners();
      }
    });
  }

  void filterForAssignedTasksActive() {
    filterAssignedTaskList = assignedTaskList
        .where((element) =>
        element.taskStatus.toLowerCase().contains('ACTIVE'.toLowerCase()))
        .toList();
    notifyListeners();
  }
  void filterForAssignedTasksEXPAIRED() {
    filterAssignedTaskList = assignedTaskList
        .where((element) =>
        element.taskStatus.toLowerCase().contains('EXPIRED'.toLowerCase()))
        .toList();
    notifyListeners();
  }
  List<ExchangeModel> approvedExchangeUsers = [];
  List<ExchangeModel> filterApprovedExchangeUsers = [];

  void getExchangeDetails() {
    db.collection("EXCHANGE_USERS").get().then((value) {
      if (value.docs.isNotEmpty) {
        approvedExchangeUsers.clear();
        filterApprovedExchangeUsers.clear();
        for (var element in value.docs) {
          Map<dynamic, dynamic> map = element.data();
          approvedExchangeUsers.add(ExchangeModel(
            element.id,
            map["EXCHANGE_ADMIN_ID"] ?? "",
            map["EXCHANGE_ADMIN_NAME"] ?? "",
            map["EXCHANGE_ADMIN_PHONE"] ?? "",
            outputDayNode
                .format(map["EXCHANGE_TIME"].toDate() ?? "")
                .toString(),
            map["REQUEST_ID"] ?? "",
            map["REQUEST_NAME"] ?? "",
            map["REQUEST_PHONE"] ?? "",
            outputDayNode.format(map["REQUEST_TIME"].toDate() ?? "").toString(),
            map["PROOF_IMAGE"] ?? "",
            map["FROM_ID"] ?? "",
            map["FROM_USER_NAME"] ?? "",
            map["FROM_USER_NUMBER"] ?? "",
            map["TO_ID"] ?? "",
            map["TO_USER_NAME"] ?? "",
            map["TO_USER_NUMBER"] ?? "",
            map["REASON"] ?? "",
            map["STATUS"] ?? "",
          ));
        }
        filterForExchangeAppList();
        notifyListeners();
      }
    });
  }

  void filterForExchangeReqList() {
    filterApprovedExchangeUsers = approvedExchangeUsers
        .where((element) =>
            element.status.toLowerCase().contains('REQUESTED'.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void filterForExchangeAppList() {
    filterApprovedExchangeUsers = approvedExchangeUsers
        .where((element) =>
            element.status.toLowerCase().contains('APPROVED'.toLowerCase()))
        .toList();
    notifyListeners();
  }

  String fromName = '';
  String toName = '';
  void exchangeUserName(String fromId, String toID) {
    db.collection("USERS").doc(fromId).get().then((value) {
      if (value.exists) {
        fromName = value["NAME"];
      } else {
        fromName = "";
      }
      notifyListeners();
    });
    db.collection("USERS").doc(toID).get().then((value) {
      if (value.exists) {
        toName = value["NAME"];
      } else {
        toName = "";
      }
      notifyListeners();
    });
  }

  void exchangeApproveANDRejectFun(
    String from,
    String docId,
  ) {
    Map<String, Object> dataMapp = HashMap();
    if (from == "APPROVE") {
      dataMapp["EXCHANGE_TIME"] = DateTime.now();
      dataMapp["EXCHANGE_ADMIN_ID"] = adminId;
      dataMapp["EXCHANGE_ADMIN_NAME"] = adminName;
      dataMapp["EXCHANGE_ADMIN_PHONE"] = adminPhone;
      dataMapp["STATUS"] = "APPROVED";
    } else {
      dataMapp["REJECTED_TIME"] = DateTime.now();
      dataMapp["REJECTED_ADMIN_ID"] = adminId;
      dataMapp["REJECTED_ADMIN_NAME"] = adminName;
      dataMapp["REJECTED_ADMIN_PHONE"] = adminPhone;
      dataMapp["STATUS"] = "REJECT";
    }
    db
        .collection("EXCHANGE_USERS")
        .doc(docId)
        .set(dataMapp, SetOptions(merge: true));
    notifyListeners();
  }


  void downloadExcelForMembers(List<MembersModel> membersList,String from) async {
    // loader=true;
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    final List<Object> list = [
      'SL',
      'Name',
      'Document ID',
      'Phone',
      'RegID',
      'RegDate',
      'PMC',
      'Donations',
      'ReceiveHelp',
      'Invitor',
      'GiveHelp',
      'KycStatus',
      'kycSubmittedDate',
      'kycVerifiedDate',
      'kycRejectedDate',
      'memberReferredBy',
      'kycRejectedReason',
    ];

    const int firstRow = 1;

    const int firstColumn = 1;

    const bool isVertical = false;

    sheet.importList(list, firstRow, firstColumn, isVertical);
    int i = 1;
    for (var element in membersList) {
      i++;
      final List<Object> list1 = [
        i-1,
        element.name,
        element.docID,
        element.phone,
        element.regid,
        DateFormat("hh:mm a").format(element.regDateTime),
        element.pmc,
        element.donations,
        element.receiveHelp,
        element.invitor,
        element.giveHelp,
        element.kycStatus,
        element.kycSubmittedDate,
        element.kycVerifiedDate,
        element.kycRejectedDate,
        element.memberReferredBy,
        element.kycRejectedReason,

      ];

      final int firstRow = i;

      const int firstColumn = 1;

      const bool isVertical = false;

      sheet.importList(list1, firstRow, firstColumn, isVertical);
    }

    sheet.getRangeByIndex(1, 1, 1, 4).autoFitColumns();
    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    // if
    final String path = (await getApplicationSupportDirectory()).path;
    final fileName = '$path/MembersReport.xlsx';
    final file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);

    if(from=="DOWNLOAD"){
      OpenFile.open(fileName);
    }else{
      File testFile = File("$path/MembersReport.xlsx");

      if (!await testFile.exists()) {
        await testFile.create(recursive: true);
        testFile.writeAsStringSync("test for share documents file");
      }
      ShareExtend.share(testFile.path, "file");

    }



    // loader=false;
    notifyListeners();
  }


}
