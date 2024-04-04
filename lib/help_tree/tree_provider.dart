

import 'dart:collection';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:lio_care/help_tree/tree_page_navigator.dart';
import 'package:provider/provider.dart';

import '../Constants/functions.dart';
import '../User/screens/bottomNavigation.dart';
import '../constants/my_colors.dart';
import '../graph/tree_graphview.dart';
import '../registration_test_page.dart';
import 'help_tree_model.dart';
import 'help_tree_page.dart';

class TreeProvider with ChangeNotifier {
  final FirebaseFirestore db = FirebaseFirestore.instance;


  List<HelpTreeModel> level0 = [];
  List<HelpTreeModel> level1 = [];
  List<HelpTreeModel> level21 = [];
  List<HelpTreeModel> level22 = [];
  List<HelpTreeModel> level31 = [];
  List<HelpTreeModel> level32 = [];
  List<HelpTreeModel> level33 = [];
  List<HelpTreeModel> level34 = [];
  List<HelpTreeModel> level41 = [];
  List<HelpTreeModel> level42 = [];
  List<HelpTreeModel> level43 = [];
  List<HelpTreeModel> level44 = [];
  List<HelpTreeModel> level45 = [];
  List<HelpTreeModel> level46 = [];
  List<HelpTreeModel> level47 = [];
  List<HelpTreeModel> level48 = [];
  List<HelpTreeModel> level51 = [];
  List<HelpTreeModel> level52 = [];
  List<HelpTreeModel> level53 = [];
  List<HelpTreeModel> level54 = [];
  List<HelpTreeModel> level55 = [];
  List<HelpTreeModel> level56 = [];
  List<HelpTreeModel> level57 = [];
  List<HelpTreeModel> level58 = [];
  List<HelpTreeModel> level59 = [];
  List<HelpTreeModel> level510 = [];
  List<HelpTreeModel> level511 = [];
  List<HelpTreeModel> level512 = [];
  List<HelpTreeModel> level513 = [];
  List<HelpTreeModel> level514 = [];
  List<HelpTreeModel> level515 = [];
  List<HelpTreeModel> level516 = [];
  List<HelpTreeModel> level61 = [];
  List<HelpTreeModel> level62 = [];
  List<HelpTreeModel> level63 = [];
  List<HelpTreeModel> level64 = [];
  List<HelpTreeModel> level65 = [];
  List<HelpTreeModel> level66 = [];
  List<HelpTreeModel> level67 = [];
  List<HelpTreeModel> level68 = [];
  List<HelpTreeModel> level69 = [];
  List<HelpTreeModel> level610 = [];
  List<HelpTreeModel> level611 = [];
  List<HelpTreeModel> level612 = [];
  List<HelpTreeModel> level613 = [];
  List<HelpTreeModel> level614 = [];
  List<HelpTreeModel> level615 = [];
  List<HelpTreeModel> level616 = [];
  List<HelpTreeModel> level617 = [];
  List<HelpTreeModel> level618 = [];
  List<HelpTreeModel> level619 = [];
  List<HelpTreeModel> level620 = [];
  List<HelpTreeModel> level621 = [];
  List<HelpTreeModel> level622 = [];
  List<HelpTreeModel> level623 = [];
  List<HelpTreeModel> level624 = [];
  List<HelpTreeModel> level625 = [];
  List<HelpTreeModel> level626 = [];
  List<HelpTreeModel> level627 = [];
  List<HelpTreeModel> level628 = [];
  List<HelpTreeModel> level629 = [];
  List<HelpTreeModel> level630 = [];
  List<HelpTreeModel> level631 = [];
  List<HelpTreeModel> level632 = [];
  List<HelpTreeModel> level71 = [];
  List<HelpTreeModel> level72 = [];
  List<HelpTreeModel> level73 = [];
  List<HelpTreeModel> level74 = [];
  List<HelpTreeModel> level75 = [];
  List<HelpTreeModel> level76 = [];
  List<HelpTreeModel> level77 = [];
  List<HelpTreeModel> level78 = [];
  List<HelpTreeModel> level79 = [];
  List<HelpTreeModel> level710 = [];
  List<HelpTreeModel> level711 = [];
  List<HelpTreeModel> level712 = [];
  List<HelpTreeModel> level713 = [];
  List<HelpTreeModel> level714 = [];
  List<HelpTreeModel> level715 = [];
  List<HelpTreeModel> level716 = [];
  List<HelpTreeModel> level717 = [];
  List<HelpTreeModel> level718 = [];
  List<HelpTreeModel> level719 = [];
  List<HelpTreeModel> level720 = [];
  List<HelpTreeModel> level721 = [];
  List<HelpTreeModel> level722 = [];
  List<HelpTreeModel> level723 = [];
  List<HelpTreeModel> level724 = [];
  List<HelpTreeModel> level725 = [];
  List<HelpTreeModel> level726 = [];
  List<HelpTreeModel> level727 = [];
  List<HelpTreeModel> level728 = [];
  List<HelpTreeModel> level729 = [];
  List<HelpTreeModel> level730 = [];
  List<HelpTreeModel> level731 = [];
  List<HelpTreeModel> level732 = [];
  List<HelpTreeModel> level733 = [];
  List<HelpTreeModel> level734 = [];
  List<HelpTreeModel> level735 = [];
  List<HelpTreeModel> level736 = [];
  List<HelpTreeModel> level737 = [];
  List<HelpTreeModel> level738 = [];
  List<HelpTreeModel> level739 = [];
  List<HelpTreeModel> level740 = [];
  List<HelpTreeModel> level741 = [];
  List<HelpTreeModel> level742 = [];
  List<HelpTreeModel> level743 = [];
  List<HelpTreeModel> level744 = [];
  List<HelpTreeModel> level745 = [];
  List<HelpTreeModel> level746 = [];
  List<HelpTreeModel> level747 = [];
  List<HelpTreeModel> level748 = [];
  List<HelpTreeModel> level749 = [];
  List<HelpTreeModel> level750 = [];
  List<HelpTreeModel> level751 = [];
  List<HelpTreeModel> level752 = [];
  List<HelpTreeModel> level753 = [];
  List<HelpTreeModel> level754 = [];
  List<HelpTreeModel> level755 = [];
  List<HelpTreeModel> level756 = [];
  List<HelpTreeModel> level757 = [];
  List<HelpTreeModel> level758 = [];
  List<HelpTreeModel> level759 = [];
  List<HelpTreeModel> level760 = [];
  List<HelpTreeModel> level761 = [];
  List<HelpTreeModel> level762 = [];
  List<HelpTreeModel> level763 = [];
  List<HelpTreeModel> level764 = [];
  List<HelpTreeModel> allChildrenList = [];



  void clearTreeLists(){

    allChildrenList.clear();
    level0.clear();
    level1.clear();
    level21.clear();
    level22.clear();
    level31.clear();
    level32.clear();
    level33.clear();
    level34.clear();
    level41.clear();
    level42.clear();
    level43.clear();
    level44.clear();
    level45.clear();
    level46.clear();
    level47.clear();
    level48.clear();
    level51.clear();
    level52.clear();
    level53.clear();
    level54.clear();
    level55.clear();
    level56.clear();
    level57.clear();
    level58.clear();
    level59.clear();
    level510.clear();
    level511.clear();
    level512.clear();
    level513.clear();
    level514.clear();
    level515.clear();
    level516.clear();
    level61.clear();
    level62.clear();
    level63.clear();
    level64.clear();
    level65.clear();
    level66.clear();
    level67.clear();
    level68.clear();
    level69.clear();
    level610.clear();
    level611.clear();
    level612.clear();
    level613.clear();
    level614.clear();
    level615.clear();
    level616.clear();
    level617.clear();
    level618.clear();
    level619.clear();
    level620.clear();
    level621.clear();
    level622.clear();
    level623.clear();
    level624.clear();
    level625.clear();
    level626.clear();
    level627.clear();
    level628.clear();
    level629.clear();
    level630.clear();
    level631.clear();
    level632.clear();
    level71.clear();
    level72.clear();
    level73.clear();
    level74.clear();
    level75.clear();
    level76.clear();
    level77.clear();
    level78.clear();
    level79.clear();
    level710.clear();
    level711.clear();
    level712.clear();
    level713.clear();
    level714.clear();
    level715.clear();
    level716.clear();
    level717.clear();
    level718.clear();
    level719.clear();
    level720.clear();
    level721.clear();
    level722.clear();
    level723.clear();
    level724.clear();
    level725.clear();
    level726.clear();
    level727.clear();
    level728.clear();
    level729.clear();
    level730.clear();
    level731.clear();
    level732.clear();
    level733.clear();
    level734.clear();
    level735.clear();
    level736.clear();
    level737.clear();
    level738.clear();
    level739.clear();
    level740.clear();
    level741.clear();
    level742.clear();
    level743.clear();
    level744.clear();
    level745.clear();
    level746.clear();
    level747.clear();
    level748.clear();
    level749.clear();
    level750.clear();
    level751.clear();
    level752.clear();
    level753.clear();
    level754.clear();
    level755.clear();
    level756.clear();
    level757.clear();
    level758.clear();
    level759.clear();
    level760.clear();
    level761.clear();
    level762.clear();
    level763.clear();
    level764.clear();
  }

  fetchHelpTree(String userId,String userDocId, String treeSection,
      String userImage, BuildContext context3,String from,String userNameInAdmin) async {
    clearTreeLists();
    showDialog(
        context: context3,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });
    await db.collection(treeSection).doc(userDocId).get().then((parentValue) async {
      await db.collection(treeSection).where("PARENTS",arrayContains: userDocId).get().then((childrenValue) {
        if(parentValue.exists){

          if(childrenValue.docs.isNotEmpty){
            clearTreeLists();
          allChildrenList.clear();
          Map<dynamic,dynamic>  parentMap = parentValue.data() as Map;
          List<dynamic> parentChildList = parentMap["CHILDREN"]??[];
          for(var elements in childrenValue.docs){
            Map<dynamic,dynamic>  childrenMap = elements.data();
            allChildrenList.add(HelpTreeModel(childrenMap["MEMBER_ID"]??"", childrenMap["DOCUMENT_ID"]??"", childrenMap["NAME"],
                childrenMap["ItemImage"]??"",childrenMap["PHONE"],childrenMap["CHILDREN"]??[]));
          }
          level0.add(HelpTreeModel(userId, userDocId, parentMap["NAME"],
              userImage, parentMap["PHONE"],parentChildList));

          if(parentChildList.isNotEmpty){
            level1.clear();
            for(var elements in parentChildList) {
              level1 = level1 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
            }
            if(level1.isNotEmpty){
              level21.clear();
              for(var elements in level1[0].childList) {
                level21 = level21 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
              }
              if(level21.isNotEmpty){
                for(var elements in level21[0].childList) {
                  level31 = level31 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                }
                if(level31.isNotEmpty){
                  for(var elements in level31[0].childList) {
                    level41 = level41 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                  }

                  if(level41.isNotEmpty){
                    for(var elements in level41[0].childList) {
                      level51 = level51 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                    }
                    if(level51.isNotEmpty){
                      for(var elements in level51[0].childList) {
                        level61 = level61 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                      }
                      if(level61.isNotEmpty){
                        for(var elements in level61[0].childList) {
                          level71 = level71 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level61.length>1){
                          for(var elements in level61[1].childList) {
                            level72 = level72 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                        }
                      }
                      if(level51.length>1){
                        for(var elements in level51[1].childList) {
                          level62 = level62 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level62.isNotEmpty){
                          for(var elements in level62[0].childList) {
                            level73 = level73 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level62.length>1){
                            for(var elements in level62[1].childList) {
                              level74 = level74 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                          }
                        }
                      }
                    }
                    if(level41.length>1){
                      for(var elements in level41[1].childList) {
                        level52 = level52 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                      }
                      if(level52.isNotEmpty){
                        for(var elements in level52[0].childList) {
                          level63 = level63 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level63.isNotEmpty){
                          for(var elements in level63[0].childList) {
                            level75 = level75 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level63.length>1){
                            for(var elements in level63[1].childList) {
                              level76 = level76 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                          }
                        }
                        if(level52.length>1){
                          for(var elements in level52[1].childList) {
                            level64 = level64 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level64.isNotEmpty){
                            for(var elements in level64[0].childList) {
                              level77 = level77 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level64.length>1){
                              for(var elements in level64[1].childList) {
                                level78 = level78 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                        }
                      }
                    }
                  }

                  if(level31.length>1){
                    for(var elements in level31[1].childList) {
                      level42 = level42 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                    }
                    if(level42.isNotEmpty){
                      for(var elements in level42[0].childList) {
                        level53 = level53 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                      }
                      if(level53.isNotEmpty){
                        for(var elements in level53[0].childList) {
                          level65 = level65 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level65.isNotEmpty){
                          for(var elements in level65[0].childList) {
                            level79 = level79 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level65.length>1){
                            for(var elements in level65[1].childList) {
                              level710 = level710 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                          }
                        }
                        if(level53.length>1){
                          for(var elements in level53[1].childList) {
                            level66 = level66 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level66.isNotEmpty){
                            for(var elements in level66[0].childList) {
                              level711 = level711 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level66.length>1){
                              for(var elements in level66[1].childList) {
                                level712 = level712 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                        }
                      }
                      if(level42.length>1){
                        for(var elements in level42[1].childList) {
                          level54 = level54 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level54.isNotEmpty){
                          for(var elements in level54[0].childList) {
                            level67 = level67 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level67.isNotEmpty){
                            for(var elements in level67[0].childList) {
                              level713 = level713 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level67.length>1){
                              for(var elements in level67[1].childList) {
                                level714 = level714 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                          if(level54.length>1){
                            for(var elements in level54[1].childList) {
                              level68 = level68 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level68.isNotEmpty){
                              for(var elements in level68[0].childList) {
                                level715 = level715 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level68.length>1){
                                for(var elements in level68[1].childList) {
                                  level716 = level716 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                }

                if(level21.length>1){
                  for(var elements in level21[1].childList) {
                    level32 = level32 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                  }
                  if(level32.isNotEmpty){
                    for(var elements in level32[0].childList) {
                      level43 = level43 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                    }
                    if(level43.isNotEmpty){
                      for(var elements in level43[0].childList) {
                        level55 = level55 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                      }
                      if(level55.isNotEmpty){
                        for(var elements in level55[0].childList) {
                          level69 = level69 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level69.isNotEmpty){
                          for(var elements in level69[0].childList) {
                            level717 = level717 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level69.length>1){
                            for(var elements in level69[1].childList) {
                              level718 = level718 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                          }
                        }
                        if(level55.length>1){
                          for(var elements in level55[1].childList) {
                            level610 = level610 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level610.isNotEmpty){
                            for(var elements in level610[0].childList) {
                              level719 = level719 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level610.length>1){
                              for(var elements in level610[1].childList) {
                                level720 = level720 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                        }
                      }
                      if(level43.length>1){
                        for(var elements in level43[1].childList) {
                          level56 = level56 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level56.isNotEmpty){
                          for(var elements in level56[0].childList) {
                            level611 = level611 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level611.isNotEmpty){
                            for(var elements in level611[0].childList) {
                              level721 = level721 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level611.length>1){
                              for(var elements in level611[1].childList) {
                                level722 = level722 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                          if(level56.length>1){
                            for(var elements in level56[1].childList) {
                              level612 = level612 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level612.isNotEmpty){
                              for(var elements in level612[0].childList) {
                                level723 = level723 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level612.length>1){
                                for(var elements in level612[1].childList) {
                                  level724 = level724 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                          }
                        }
                      }
                    }

                    if(level32.length>1){
                      for(var elements in level32[1].childList) {
                        level44 = level44 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                      }
                      if(level44.isNotEmpty){
                        for(var elements in level44[0].childList) {
                          level57 = level57 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level57.isNotEmpty){
                          for(var elements in level57[0].childList) {
                            level613 = level613 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level613.isNotEmpty){
                            for(var elements in level613[0].childList) {
                              level725 = level725 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level613.length>1){
                              for(var elements in level613[1].childList) {
                                level726 = level726 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                          if(level57.length>1){
                            for(var elements in level57[1].childList) {
                              level614 = level614 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level614.isNotEmpty){
                              for(var elements in level614[0].childList) {
                                level727 = level727 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level614.length>1){
                                for(var elements in level614[1].childList) {
                                  level728 = level728 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                          }
                        }
                        if(level44.length>1){
                          for(var elements in level44[1].childList) {
                            level58 = level58 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level58.isNotEmpty){
                            for(var elements in level58[0].childList) {
                              level615 = level615 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level615.isNotEmpty){
                              for(var elements in level615[0].childList) {
                                level729 = level729 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level615.length>1){
                                for(var elements in level615[1].childList) {
                                  level730 = level730 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                            if(level58.length>1){
                              for(var elements in level58[1].childList) {
                                level616 = level616 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level616.isNotEmpty){
                                for(var elements in level616[0].childList) {
                                  level731 = level731 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                                if(level616.length>1){
                                  for(var elements in level616[1].childList) {
                                    level732 = level732 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }

                }

              }

              if(level1.length>1){
                for(var elements in level1[1].childList) {
                  level22 = level22 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                }

                if(level22.isNotEmpty){
                  for(var elements in level22[0].childList) {
                    level33 = level33 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                  }
                  if(level33.isNotEmpty){
                    for(var elements in level33[0].childList) {
                      level45 = level45 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                    }
                    if(level45.isNotEmpty){
                      for(var elements in level45[0].childList) {
                        level59 = level59 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                      }
                      if(level59.isNotEmpty){
                        for(var elements in level59[0].childList) {
                          level617 = level617 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level617.isNotEmpty){
                          for(var elements in level617[0].childList) {
                            level733 = level733 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level617.length>1){
                            for(var elements in level617[1].childList) {
                              level734 = level734 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                          }
                        }
                        if(level59.length>1){
                          for(var elements in level59[1].childList) {
                            level618 = level618 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level618.isNotEmpty){
                            for(var elements in level618[0].childList) {
                              level735 = level735 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level618.length>1){
                              for(var elements in level618[1].childList) {
                                level736 = level736 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                        }
                      }
                      if(level45.length>1){
                        for(var elements in level45[1].childList) {
                          level510 = level510 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level510.isNotEmpty){
                          for(var elements in level510[0].childList) {
                            level619 = level619 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level619.isNotEmpty){
                            for(var elements in level619[0].childList) {
                              level737 = level737 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level619.length>1){
                              for(var elements in level619[1].childList) {
                                level738 = level738 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                          if(level510.length>1){
                            for(var elements in level510[1].childList) {
                              level620 = level620 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level620.isNotEmpty){
                              for(var elements in level620[0].childList) {
                                level739 = level739 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level620.length>1){
                                for(var elements in level620[1].childList) {
                                  level740 = level740 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                    if(level33.length>1){
                      for(var elements in level33[1].childList) {
                        level46 = level46 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                      }
                      if(level46.isNotEmpty){
                        for(var elements in level46[0].childList) {
                          level511 = level511 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level511.isNotEmpty){
                          for(var elements in level511[0].childList) {
                            level621 = level621 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level621.isNotEmpty){
                            for(var elements in level621[0].childList) {
                              level741 = level741 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level621.length>1){
                              for(var elements in level621[1].childList) {
                                level742 = level742 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                          if(level511.length>1){
                            for(var elements in level511[1].childList) {
                              level622 = level622 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level622.isNotEmpty){
                              for(var elements in level622[0].childList) {
                                level743 = level743 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level622.length>1){
                                for(var elements in level622[1].childList) {
                                  level744 = level744 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                          }
                        }
                        if(level46.length>1){
                          for(var elements in level46[1].childList) {
                            level512 = level512 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level512.isNotEmpty){
                            for(var elements in level512[0].childList) {
                              level623 = level623 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level623.isNotEmpty){
                              for(var elements in level623[0].childList) {
                                level745 = level745 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level623.length>1){
                                for(var elements in level623[1].childList) {
                                  level746 = level746 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                            if(level512.length>1){
                              for(var elements in level512[1].childList) {
                                level624 = level624 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level624.isNotEmpty){
                                for(var elements in level624[0].childList) {
                                  level747 = level747 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                                if(level624.length>1){
                                  for(var elements in level624[1].childList) {
                                    level748 = level748 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }

                  if(level22.length>1){
                    for(var elements in level22[1].childList) {
                      level34 = level34 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                    }
                    if(level34.isNotEmpty){
                      for(var elements in level34[0].childList) {
                        level47 = level47 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                      }
                      if(level47.isNotEmpty){
                        for(var elements in level47[0].childList) {
                          level513 = level513 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level513.isNotEmpty){
                          for(var elements in level513[0].childList) {
                            level625 = level625 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level625.isNotEmpty){
                            for(var elements in level625[0].childList) {
                              level749 = level749 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level625.length>1){
                              for(var elements in level625[1].childList) {
                                level750 = level750 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                            }
                          }
                          if(level513.length>1){
                            for(var elements in level513[1].childList) {
                              level626 = level626 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level626.isNotEmpty){
                              for(var elements in level626[0].childList) {
                                level751 = level751 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level626.length>1){
                                for(var elements in level626[1].childList) {
                                  level752 = level752 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                          }
                        }
                        if(level47.length>1){
                          for(var elements in level47[1].childList) {
                            level514 = level514 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level514.isNotEmpty){
                            for(var elements in level514[0].childList) {
                              level627 = level627 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level627.isNotEmpty){
                              for(var elements in level627[0].childList) {
                                level753 = level753 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level627.length>1){
                                for(var elements in level627[1].childList) {
                                  level754 = level754 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                            if(level514.length>1){
                              for(var elements in level514[1].childList) {
                                level628 = level628 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level628.isNotEmpty){
                                for(var elements in level628[0].childList) {
                                  level755 = level755 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                                if(level628.length>1){
                                  for(var elements in level628[1].childList) {
                                    level756 = level756 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                      if(level34.length>1){
                        for(var elements in level34[1].childList) {
                          level48 = level48 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                        }
                        if(level48.isNotEmpty){
                          for(var elements in level48[0].childList) {
                            level515 = level515 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                          }
                          if(level515.isNotEmpty){
                            for(var elements in level515[0].childList) {
                              level629 = level629 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level629.isNotEmpty){
                              for(var elements in level629[0].childList) {
                                level757 = level757 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level629.length>1){
                                for(var elements in level629[1].childList) {
                                  level758 = level758 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                              }
                            }
                            if(level515.length>1){
                              for(var elements in level515[1].childList) {
                                level630 = level630 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level630.isNotEmpty){
                                for(var elements in level630[0].childList) {
                                  level759 = level759 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                                if(level630.length>1){
                                  for(var elements in level630[1].childList) {
                                    level760 = level760 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                  }
                                }
                              }
                            }
                          }
                          if(level48.length>1){
                            for(var elements in level48[1].childList) {
                              level516 = level516 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                            }
                            if(level516.isNotEmpty){
                              for(var elements in level516[0].childList) {
                                level631 = level631 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                              }
                              if(level631.isNotEmpty){
                                for(var elements in level631[0].childList) {
                                  level761 = level761 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                                if(level631.length>1){
                                  for(var elements in level631[1].childList) {
                                    level762 = level762 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                  }
                                }
                              }
                              if(level516.length>1){
                                for(var elements in level516[1].childList) {
                                  level632 = level632 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                }
                                if(level632.isNotEmpty){
                                  for(var elements in level632[0].childList) {
                                    level763 = level763 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                  }
                                  if(level632.length>1){
                                    for(var elements in level632[1].childList) {
                                      level764 = level764 + allChildrenList.where((element) => element.userDocId == elements).toSet().toList();
                                    }
                                  }
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }

                }

              }
            }
          }
          finish(context3);
          callNext(TreeViewPage(fromSection: from, fromTree: treeSection,), context3);
        }
        else{
          clearTreeLists();
          // Map<dynamic,dynamic>  parentMap = parentValue.data() as Map;
          // List<dynamic> parentChildList = parentMap["CHILDREN"]??[];
          // level0.add(HelpTreeModel(userId, userDocId, parentMap["NAME"],
          //     userImage, parentMap["PHONE"],parentChildList));
          finish(context3);
          finish(context3);
          //callNext(TreeViewPage(), context3);
          final snackBar = SnackBar(
            backgroundColor: myWhite,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(79),
            ),
            behavior: SnackBarBehavior.floating,

            content:  Text(
           from=="USER"?   "you have no children":"$userNameInAdmin have no children",
              style: const TextStyle(color: Colors.red),
            ),

          );
          ScaffoldMessenger.of(context3).showSnackBar(snackBar);
        }
        }
        else{
          finish(context3);
          finish(context3);

          final snackBar = SnackBar(
            backgroundColor: myWhite,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(79),
            ),
            behavior: SnackBarBehavior.floating,

            content:  Text(
              from=="USER"?   "you have no children":"$userNameInAdmin have no children",
              style: const TextStyle(color: Colors.red),
            ),

          );
          ScaffoldMessenger.of(context3).showSnackBar(snackBar);
        }
      });
    });
    notifyListeners();
  }


  String treeUserStatus ='';
  String treeUserGrade ='';
  String treeUserColor ='';
  String treeUserRegDate ='';
  String treeUserTreeEarnings ='';
  String treeUserTreeReferredBy ='';
  String treeUserTreeReferredNumber ='';
  var dateFormat = DateFormat('dd/MM/yyyy');

  fetchTreeUserDetails(String userId,String fromTree,BuildContext context) async {

    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.green),
          );
        });

    treeUserStatus ='';
    treeUserGrade ='';
    treeUserColor ='';
    treeUserRegDate ='';
    treeUserTreeEarnings ='';
    treeUserTreeReferredBy ='';
    treeUserTreeReferredNumber ='';
    await db.collection("USERS").doc(userId).get().then((userValue) async {
      if(userValue.exists){
        Map<dynamic, dynamic> useMap = userValue.data() as Map;
        await db.collection(fromTree).doc(useMap["DOCUMENT_ID"]).get().then((valuess) async {
          if(valuess.exists){
            Map<dynamic, dynamic> use = valuess.data() as Map;
            treeUserRegDate =dateFormat.format(use["REG_DATE"].toDate());
            treeUserStatus =use["STATUS"];
            treeUserGrade =use["GRADE"];
            treeUserTreeEarnings =useMap["TOTAL_EARNINGS"].toString();
            treeUserTreeReferredBy =useMap["REFERENCE_NAME"]??"";
            treeUserTreeReferredNumber =useMap["REFERENCE_NUMBER"]??"";
            notifyListeners();

            finish(context);
            // if(fromTree=="STAR CLUB"){
            //   if(treeUserGrade == "STAR CLUB ACHIEVER"){
            //     treeUserColor = "STARCLUBACHIEVER";
            //     notifyListeners();
            //   }else if(treeUserGrade.length>4){
            //     treeUserColor = treeUserGrade.substring(2)+treeUserGrade[0];
            //     notifyListeners();
            //   }else{
            //     treeUserColor = treeUserGrade;
            //     notifyListeners();
            //   }
            // }else{
            //   treeUserColor = treeUserGrade.replaceAll(' ', '');
            //   notifyListeners();
            // }
          }else{
            print("alilla");
            finish(context);
          }
          notifyListeners();
        });
        notifyListeners();
      }else{
        finish(context);
      }
    });
  }









// fetchHelpTree(String userId,String treeSection, BuildContext contexter){
//   clearTreeLists;
//   // db.collection(treeSection).where("MEMBER_ID",isEqualTo: userId).get().then((value) async {
//   //   if(value.docs.isNotEmpty){
//   //     Map<dynamic, dynamic> map1 = value.docs.first.data();
//   //     await db.collection("USERS").doc(userId).get().then((userFirstNode) {
//   //       Map<dynamic, dynamic> userMap = userFirstNode.data() as Map;
//   //       level0.add(HelpTreeModel(userId, map1["DOCUMENT_ID"]??"", userMap["NAME"],
//   //            userMap["ItemImage"]??"",userMap["PHONE"],));
//   //     });
//   //
//   //     List<dynamic> childList = map1["CHILDREN"]??[];
//   //     if(childList.isNotEmpty){
//   //       for(var elements in childList){
//   //         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements).get().then((userValue1) {
//   //           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //           level1.add(HelpTreeModel(userValue1.docs.first.id, elements, userMap["NAME"], userMap["ItemImage"]??"",
//   //               userMap["PHONE"]));
//   //         });
//   //       }
//   //
//   //       ///Level21
//   //         db.collection(treeSection).doc(level1[0].userDocId).get().then((userValue2) async {
//   //           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //           if(childList2.isNotEmpty){
//   //           for(var elements2 in childList2) {
//   //             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                 level21.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"], userMap["ItemImage"]??"",
//   //                     userMap["PHONE"]));
//   //               });
//   //
//   //           }
//   //           ///Level31
//   //             db.collection(treeSection).doc(level21[0].userDocId).get().then((userValue2) async {
//   //               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //               if(childList2.isNotEmpty){
//   //                 for(var elements2 in childList2) {
//   //                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                     level31.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                         userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                   });
//   //                 }
//   //
//   //                 ///Level41
//   //                   db.collection(treeSection).doc(level31[0].userDocId).get().then((userValue2) async {
//   //                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                     if(childList2.isNotEmpty){
//   //                       for(var elements2 in childList2) {
//   //                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                           level41.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                               userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                         });
//   //                       }
//   //                       ///Level51
//   //                         db.collection(treeSection).doc(level41[0].userDocId).get().then((userValue2) async {
//   //                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                           if(childList2.isNotEmpty){
//   //                             for(var elements2 in childList2) {
//   //                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                 level51.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                               });
//   //                             }
//   //
//   //                             ///Level61
//   //                             if(level51.isNotEmpty) {
//   //                               db.collection(treeSection).doc(level51[0].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level61.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //                                   ///Level71
//   //                                   if(level61.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level61[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level71.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level72
//   //                                   if(level61.length>1){
//   //                                     db.collection(treeSection).doc(level61[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level72.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                             ///Level62
//   //                             if(level51.length>1){
//   //                               db.collection(treeSection).doc(level51[1].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level62.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level73
//   //                                   if(level62.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level62[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level73.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level74
//   //                                   if(level62.length>1){
//   //                                     db.collection(treeSection).doc(level62[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level74.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //
//   //                           }
//   //                         });
//   //
//   //                       ///Level52
//   //                       if(level41.length>1){
//   //                         db.collection(treeSection).doc(level41[1].userDocId).get().then((userValue2) async {
//   //                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                           if(childList2.isNotEmpty){
//   //                             for(var elements2 in childList2) {
//   //                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                 level52.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                               });
//   //                             }
//   //
//   //                             ///Level63
//   //                             if(level52.isNotEmpty) {
//   //                               db.collection(treeSection).doc(level52[0].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level63.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level75
//   //                                   if(level63.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level63[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level75.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level76
//   //                                   if(level63.length>1){
//   //                                     db.collection(treeSection).doc(level63[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level76.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                             ///Level64
//   //                             if(level52.length>1){
//   //                               db.collection(treeSection).doc(level52[1].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level64.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level77
//   //                                   if(level64.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level64[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level77.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level78
//   //                                   if(level64.length>1){
//   //                                     db.collection(treeSection).doc(level64[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level78.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //
//   //                           }
//   //                         });
//   //                       }
//   //
//   //                     }
//   //                   });
//   //                 ///Level42
//   //                 if(level31.length>1){
//   //                   db.collection(treeSection).doc(level31[1].userDocId).get().then((userValue2) async {
//   //                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                     if(childList2.isNotEmpty){
//   //                       for(var elements2 in childList2) {
//   //                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                           level42.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                               userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                         });
//   //                       }
//   //
//   //                       ///Level53
//   //                         db.collection(treeSection).doc(level42[0].userDocId).get().then((userValue2) async {
//   //                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                           if(childList2.isNotEmpty){
//   //                             for(var elements2 in childList2) {
//   //                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                 level53.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                               });
//   //                             }
//   //
//   //                             ///Level65
//   //                             if(level53.isNotEmpty) {
//   //                               db.collection(treeSection).doc(level53[0].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level65.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level79
//   //                                   if(level65.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level65[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level79.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level710
//   //                                   if(level65.length>1){
//   //                                     db.collection(treeSection).doc(level65[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level710.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                             ///Level66
//   //                             if(level53.length>1){
//   //                               db.collection(treeSection).doc(level53[1].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level66.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level711
//   //                                   if(level66.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level66[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level711.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level712
//   //                                   if(level66.length>1){
//   //                                     db.collection(treeSection).doc(level66[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level712.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //
//   //                           }
//   //                         });
//   //                       ///Level54
//   //                       if(level42.length>1){
//   //                         db.collection(treeSection).doc(level42[1].userDocId).get().then((userValue2) async {
//   //                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                           if(childList2.isNotEmpty){
//   //                             for(var elements2 in childList2) {
//   //                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                 level54.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                               });
//   //                             }
//   //
//   //                             ///Level67
//   //                             if(level54.isNotEmpty) {
//   //                               db.collection(treeSection).doc(level54[0].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level67.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level713
//   //                                   if(level67.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level67[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level713.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level714
//   //                                   if(level67.length>1){
//   //                                     db.collection(treeSection).doc(level67[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level714.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                             ///Level68
//   //                             if(level54.length>1){
//   //                               db.collection(treeSection).doc(level54[1].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level68.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level715
//   //                                   if(level68.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level68[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level715.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level716
//   //                                   if(level68.length>1){
//   //                                     db.collection(treeSection).doc(level68[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level716.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //
//   //                           }
//   //                         });
//   //                       }
//   //                     }
//   //                   });
//   //                 }
//   //               }
//   //             });
//   //
//   //           ///Level32
//   //           if(level21.length>1){
//   //             db.collection(treeSection).doc(level21[1].userDocId).get().then((userValue2) async {
//   //               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //               if(childList2.isNotEmpty){
//   //                 for(var elements2 in childList2) {
//   //                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                     level32.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                         userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                   });
//   //                 }
//   //                 ///Level43
//   //                   db.collection(treeSection).doc(level32[0].userDocId).get().then((userValue2) async {
//   //                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                     if(childList2.isNotEmpty){
//   //                       for(var elements2 in childList2) {
//   //                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                           level43.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                               userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                         });
//   //                       }
//   //                       ///Level55
//   //                         db.collection(treeSection).doc(level43[0].userDocId).get().then((userValue2) async {
//   //                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                           if(childList2.isNotEmpty){
//   //                             for(var elements2 in childList2) {
//   //                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                 level55.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                               });
//   //                             }
//   //
//   //                             ///Level69
//   //                             if(level55.isNotEmpty) {
//   //                               db.collection(treeSection).doc(level55[0].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level69.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level717
//   //                                   if(level69.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level69[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level717.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level718
//   //                                   if(level69.length>1){
//   //                                     db.collection(treeSection).doc(level69[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level718.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                             ///Level610
//   //                             if(level55.length>1){
//   //                               db.collection(treeSection).doc(level55[1].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level610.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level719
//   //                                   if(level610.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level610[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level719.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level720
//   //                                   if(level610.length>1){
//   //                                     db.collection(treeSection).doc(level610[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level720.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //
//   //                           }
//   //                         });
//   //
//   //                       ///Level56
//   //                       if(level43.length>1){
//   //                         db.collection(treeSection).doc(level43[1].userDocId).get().then((userValue2) async {
//   //                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                           if(childList2.isNotEmpty){
//   //                             for(var elements2 in childList2) {
//   //                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                 level56.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                               });
//   //                             }
//   //
//   //
//   //                             ///Level611
//   //                             if(level56.isNotEmpty) {
//   //                               db.collection(treeSection).doc(level56[0].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level611.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level721
//   //                                   if(level611.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level611[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level721.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level722
//   //                                   if(level611.length>1){
//   //                                     db.collection(treeSection).doc(level611[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level722.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                             ///Level612
//   //                             if(level56.length>1){
//   //                               db.collection(treeSection).doc(level56[1].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level612.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level723
//   //                                   if(level612.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level612[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level723.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level724
//   //                                   if(level612.length>1){
//   //                                     db.collection(treeSection).doc(level612[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level724.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //
//   //                           }
//   //                         });
//   //                       }
//   //
//   //                     }
//   //                   });
//   //
//   //                 ///Level44
//   //                 if(level32.length>1){
//   //                   db.collection(treeSection).doc(level32[1].userDocId).get().then((userValue2) async {
//   //                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                     if(childList2.isNotEmpty){
//   //                       for(var elements2 in childList2) {
//   //                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                           level44.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                               userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                         });
//   //                       }
//   //
//   //                       ///Level57
//   //                         db.collection(treeSection).doc(level44[0].userDocId).get().then((userValue2) async {
//   //                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                           if(childList2.isNotEmpty){
//   //                             for(var elements2 in childList2) {
//   //                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                 level57.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                               });
//   //                             }
//   //
//   //                             ///Level613
//   //                             if(level57.isNotEmpty) {
//   //                               db.collection(treeSection).doc(level57[0].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level613.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level725
//   //                                   if(level613.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level613[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level725.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level726
//   //                                   if(level613.length>1){
//   //                                     db.collection(treeSection).doc(level613[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level726.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                             ///Level614
//   //                             if(level57.length>1){
//   //                               db.collection(treeSection).doc(level57[1].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level614.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level727
//   //                                   if(level614.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level614[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level727.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level728
//   //                                   if(level614.length>1){
//   //                                     db.collection(treeSection).doc(level614[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level728.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                           }
//   //                         });
//   //
//   //                       ///Level58
//   //                       if(level44.length>1){
//   //                         db.collection(treeSection).doc(level44[1].userDocId).get().then((userValue2) async {
//   //                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                           if(childList2.isNotEmpty){
//   //                             for(var elements2 in childList2) {
//   //                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                 level58.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                               });
//   //                             }
//   //
//   //                             ///Level615
//   //                             if(level58.isNotEmpty) {
//   //                               db.collection(treeSection).doc(level58[0].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level615.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //                                   ///Level729
//   //                                   if(level615.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level615[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level729.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level730
//   //                                   if(level615.length>1){
//   //                                     db.collection(treeSection).doc(level615[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level730.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                             ///Level616
//   //                             if(level58.length>1){
//   //                               db.collection(treeSection).doc(level58[1].userDocId).get().then((userValue2) async {
//   //                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                 if(childList2.isNotEmpty){
//   //                                   for(var elements2 in childList2) {
//   //                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                       level616.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                     });
//   //                                   }
//   //
//   //                                   ///Level731
//   //                                   if(level616.isNotEmpty) {
//   //                                     db.collection(treeSection).doc(level616[0].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level731.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                   ///Level732
//   //                                   if(level616.length>1){
//   //                                     db.collection(treeSection).doc(level616[1].userDocId).get().then((userValue2) async {
//   //                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                       if(childList2.isNotEmpty){
//   //                                         for(var elements2 in childList2) {
//   //                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                             level732.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                           });
//   //                                         }}
//   //                                     });
//   //                                   }
//   //                                 }
//   //                               });
//   //                             }
//   //                           }
//   //                         });
//   //                       }
//   //                     }
//   //                   });
//   //                 }
//   //
//   //               }
//   //             });
//   //           }
//   //           }
//   //         });
//   //
//   //
//   //
//   //       ///Level22
//   //       if(level1.length>1){
//   //         db.collection(treeSection).doc(level1[1].userDocId).get().then((userValue2) async {
//   //           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //           if(childList2.isNotEmpty){
//   //             for(var elements2 in childList2) {
//   //               print("child id  : $elements2");
//   //               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                 level22.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                      userMap["ItemImage"]??"",userMap["PHONE"],));
//   //               });
//   //             }
//   //
//   //             ///Level33
//   //               db.collection(treeSection).doc(level22[0].userDocId).get().then((userValue2) async {
//   //                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                 if(childList2.isNotEmpty){
//   //                   for(var elements2 in childList2) {
//   //                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                       level33.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                     });
//   //                   }
//   //                   ///Level45
//   //                     db.collection(treeSection).doc(level33[0].userDocId).get().then((userValue2) async {
//   //                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                       if(childList2.isNotEmpty){
//   //                         for(var elements2 in childList2) {
//   //                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                             level45.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                           });
//   //                         }
//   //                         ///Level59
//   //                           db.collection(treeSection).doc(level45[0].userDocId).get().then((userValue2) async {
//   //                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                             if(childList2.isNotEmpty){
//   //                               for(var elements2 in childList2) {
//   //                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                   level59.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                 });
//   //                               }
//   //
//   //                               ///Level617
//   //                               if(level59.isNotEmpty) {
//   //                                 db.collection(treeSection).doc(level59[0].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level617.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //                                     ///Level733
//   //                                     if(level617.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level617[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level733.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level734
//   //                                     if(level617.length>1){
//   //                                       db.collection(treeSection).doc(level617[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level734.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //                               ///Level618
//   //                               if(level59.length>1){
//   //                                 db.collection(treeSection).doc(level59[1].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level618.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level735
//   //                                     if(level618.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level618[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level735.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level736
//   //                                     if(level618.length>1){
//   //                                       db.collection(treeSection).doc(level618[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level736.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //
//   //                             }
//   //                           });
//   //
//   //                         ///Level510
//   //                         if(level45.length>1){
//   //                           db.collection(treeSection).doc(level45[1].userDocId).get().then((userValue2) async {
//   //                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                             if(childList2.isNotEmpty){
//   //                               for(var elements2 in childList2) {
//   //                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                   level510.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                 });
//   //                               }
//   //
//   //                               ///Level619
//   //                               if(level510.isNotEmpty) {
//   //                                 db.collection(treeSection).doc(level510[0].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level619.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level737
//   //                                     if(level619.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level619[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level737.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level738
//   //                                     if(level619.length>1){
//   //                                       db.collection(treeSection).doc(level619[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level738.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //                               ///Level620
//   //                               if(level510.length>1){
//   //                                 db.collection(treeSection).doc(level510[1].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level620.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level739
//   //                                     if(level620.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level620[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level739.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level740
//   //                                     if(level620.length>1){
//   //                                       db.collection(treeSection).doc(level620[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level740.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //
//   //                             }
//   //                           });
//   //                         }
//   //
//   //                       }
//   //                     });
//   //                   ///Level46
//   //                   if(level33.length>1){
//   //                     db.collection(treeSection).doc(level33[1].userDocId).get().then((userValue2) async {
//   //                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                       if(childList2.isNotEmpty){
//   //                         for(var elements2 in childList2) {
//   //                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                             level46.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                           });
//   //                         }
//   //
//   //                         ///Level511
//   //                           db.collection(treeSection).doc(level46[0].userDocId).get().then((userValue2) async {
//   //                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                             if(childList2.isNotEmpty){
//   //                               for(var elements2 in childList2) {
//   //                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                   level511.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                 });
//   //                               }
//   //
//   //                               ///Level621
//   //                               if(level511.isNotEmpty) {
//   //                                 db.collection(treeSection).doc(level511[0].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level621.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level741
//   //                                     if(level621.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level621[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level741.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level742
//   //                                     if(level621.length>1){
//   //                                       db.collection(treeSection).doc(level621[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level742.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //                               ///Level622
//   //                               if(level511.length>1){
//   //                                 db.collection(treeSection).doc(level511[1].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level622.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level743
//   //                                     if(level622.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level622[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level743.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level744
//   //                                     if(level622.length>1){
//   //                                       db.collection(treeSection).doc(level622[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level744.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //
//   //                             }
//   //                           });
//   //                         ///Level512
//   //                         if(level46.length>1){
//   //                           db.collection(treeSection).doc(level46[1].userDocId).get().then((userValue2) async {
//   //                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                             if(childList2.isNotEmpty){
//   //                               for(var elements2 in childList2) {
//   //                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                   level512.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                 });
//   //                               }
//   //
//   //
//   //                               ///Level623
//   //                               if(level512.isNotEmpty) {
//   //                                 db.collection(treeSection).doc(level512[0].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level623.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level745
//   //                                     if(level623.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level623[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level745.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level746
//   //                                     if(level623.length>1){
//   //                                       db.collection(treeSection).doc(level623[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level746.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //                               ///Level624
//   //                               if(level512.length>1){
//   //                                 db.collection(treeSection).doc(level512[1].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level624.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level747
//   //                                     if(level624.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level624[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level747.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level748
//   //                                     if(level624.length>1){
//   //                                       db.collection(treeSection).doc(level624[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level748.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //
//   //                             }
//   //                           });
//   //                         }
//   //
//   //                       }
//   //                     });
//   //                   }
//   //
//   //                 }
//   //               });
//   //             ///Level34
//   //             if(level22.length>1){
//   //               db.collection(treeSection).doc(level22[1].userDocId).get().then((userValue2) async {
//   //                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                 if(childList2.isNotEmpty){
//   //                   for(var elements2 in childList2) {
//   //                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                       level34.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                           userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                     });
//   //                   }
//   //                   ///Level47
//   //                     db.collection(treeSection).doc(level34[0].userDocId).get().then((userValue2) async {
//   //                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                       if(childList2.isNotEmpty){
//   //                         for(var elements2 in childList2) {
//   //                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                             level47.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                           });
//   //                         }
//   //
//   //                         ///Level513
//   //                           db.collection(treeSection).doc(level47[0].userDocId).get().then((userValue2) async {
//   //                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                             if(childList2.isNotEmpty){
//   //                               for(var elements2 in childList2) {
//   //                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                   level513.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                 });
//   //                               }
//   //
//   //                               ///Level625
//   //                               if(level513.isNotEmpty) {
//   //                                 db.collection(treeSection).doc(level513[0].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level625.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level749
//   //                                     if(level625.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level625[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level749.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level750
//   //                                     if(level625.length>1){
//   //                                       db.collection(treeSection).doc(level625[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level750.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //                               ///Level626
//   //                               if(level513.length>1){
//   //                                 db.collection(treeSection).doc(level513[1].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level626.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level751
//   //                                     if(level626.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level626[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level751.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level752
//   //                                     if(level626.length>1){
//   //                                       db.collection(treeSection).doc(level626[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level752.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //
//   //                             }
//   //                           });
//   //                         ///Level514
//   //                         if(level47.length>1){
//   //                           db.collection(treeSection).doc(level47[1].userDocId).get().then((userValue2) async {
//   //                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                             if(childList2.isNotEmpty){
//   //                               for(var elements2 in childList2) {
//   //                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                   level514.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                 });
//   //                               }
//   //
//   //                               ///Level627
//   //                               if(level514.isNotEmpty) {
//   //                                 db.collection(treeSection).doc(level514[0].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level627.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level753
//   //                                     if(level627.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level627[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level753.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level754
//   //                                     if(level627.length>1){
//   //                                       db.collection(treeSection).doc(level627[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level754.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //                               ///Level628
//   //                               if(level514.length>1){
//   //                                 db.collection(treeSection).doc(level514[1].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level628.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level755
//   //                                     if(level628.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level628[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level755.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level756
//   //                                     if(level628.length>1){
//   //                                       db.collection(treeSection).doc(level628[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level756.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //
//   //                             }
//   //                           });
//   //                         }
//   //
//   //                       }
//   //                     });
//   //                   ///Level48
//   //                   if(level34.length>1){
//   //                     db.collection(treeSection).doc(level34[1].userDocId).get().then((userValue2) async {
//   //                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                       if(childList2.isNotEmpty){
//   //                         for(var elements2 in childList2) {
//   //                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                             level48.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                           });
//   //                         }
//   //
//   //                         ///Level515
//   //                           db.collection(treeSection).doc(level48[0].userDocId).get().then((userValue2) async {
//   //                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                             if(childList2.isNotEmpty){
//   //                               for(var elements2 in childList2) {
//   //                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                   level515.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                 });
//   //                               }
//   //
//   //                               ///Level629
//   //                               if(level515.isNotEmpty) {
//   //                                 db.collection(treeSection).doc(level515[0].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level629.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level757
//   //                                     if(level629.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level629[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level757.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level758
//   //                                     if(level629.length>1){
//   //                                       db.collection(treeSection).doc(level629[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level758.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //                               ///Level630
//   //                               if(level515.length>1){
//   //                                 db.collection(treeSection).doc(level515[1].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level630.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level759
//   //                                     if(level630.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level630[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level759.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level760
//   //                                     if(level630.length>1){
//   //                                       db.collection(treeSection).doc(level630[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level760.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //
//   //                             }
//   //                           });
//   //                         ///Level516
//   //                         if(level48.length>1){
//   //                           db.collection(treeSection).doc(level48[1].userDocId).get().then((userValue2) async {
//   //                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                             if(childList2.isNotEmpty){
//   //                               for(var elements2 in childList2) {
//   //                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                   level516.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                 });
//   //                               }
//   //
//   //                               ///Level631
//   //                               if(level516.isNotEmpty) {
//   //                                 db.collection(treeSection).doc(level516[0].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level631.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level761
//   //                                     if(level631.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level631[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level761.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level762
//   //                                     if(level631.length>1){
//   //                                       db.collection(treeSection).doc(level631[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level762.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //                               ///Level632
//   //                               if(level516.length>1){
//   //                                 db.collection(treeSection).doc(level516[1].userDocId).get().then((userValue2) async {
//   //                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                   if(childList2.isNotEmpty){
//   //                                     for(var elements2 in childList2) {
//   //                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                         level632.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                       });
//   //                                     }
//   //
//   //                                     ///Level763
//   //                                     if(level632.isNotEmpty) {
//   //                                       db.collection(treeSection).doc(level632[0].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level763.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                     ///Level764
//   //                                     if(level632.length>1){
//   //                                       db.collection(treeSection).doc(level632[1].userDocId).get().then((userValue2) async {
//   //                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//   //                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//   //                                         if(childList2.isNotEmpty){
//   //                                           for(var elements2 in childList2) {
//   //                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//   //                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//   //                                               level764.add(HelpTreeModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//   //                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//   //                                             });
//   //                                           }}
//   //                                       });
//   //                                     }
//   //                                   }
//   //                                 });
//   //                               }
//   //
//   //                             }
//   //                           });
//   //                         }
//   //
//   //                       }
//   //                     });
//   //                   }
//   //
//   //                 }
//   //               });
//   //             }
//   //
//   //           }
//   //         });
//   //       }
//   //     }
//   //     // callNext(const HelpTreePage(), contexter);
//   //     callNext(const TreeNavigator(), contexter);
//   //   }
//   // });
//
//
//   db.collection(treeSection).where("MEMBER_ID",isEqualTo: userId).get().then((value) async {
//     if(value.docs.isNotEmpty){
//       Map<dynamic, dynamic> map1 = value.docs.first.data();
//       await db.collection("USERS").doc(userId).get().then((userFirstNode) {
//         Map<dynamic, dynamic> userMap = userFirstNode.data() as Map;
//
//         level0.add(HelpTreeOldModel(userId, map1["DOCUMENT_ID"]??"", userMap["NAME"],
//           userMap["ItemImage"]??"",userMap["PHONE"],));
//       });
//
//       List<dynamic> childList = map1["CHILDREN"]??[];
//       if(childList.isNotEmpty){
//         for(var elements in childList){
//           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements).get().then((userValue1) {
//             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//             level1.add(HelpTreeOldModel(userValue1.docs.first.id, elements, userMap["NAME"], userMap["ItemImage"]??"",
//                 userMap["PHONE"]));
//           });
//         }
//
//         ///Level21
//         await db.collection(treeSection).doc(level1[0].userDocId).get().then((userValue2) async {
//           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//           if(childList2.isNotEmpty){
//             for(var elements2 in childList2) {
//               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                 level21.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"], userMap["ItemImage"]??"",
//                     userMap["PHONE"]));
//               });
//
//             }
//             ///Level31
//             await db.collection(treeSection).doc(level21[0].userDocId).get().then((userValue2) async {
//               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//               if(childList2.isNotEmpty){
//                 for(var elements2 in childList2) {
//                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                     level31.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                   });
//                 }
//
//                 ///Level41
//                 await db.collection(treeSection).doc(level31[0].userDocId).get().then((userValue2) async {
//                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                   if(childList2.isNotEmpty){
//                     for(var elements2 in childList2) {
//                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                         level41.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                       });
//                     }
//                     ///Level51
//                     await db.collection(treeSection).doc(level41[0].userDocId).get().then((userValue2) async {
//                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                       if(childList2.isNotEmpty){
//                         for(var elements2 in childList2) {
//                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                             level51.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                           });
//                         }
//
//                         ///Level61
//                         if(level51.isNotEmpty) {
//                           await db.collection(treeSection).doc(level51[0].userDocId).get().then((userValue2) async {
//                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                             if(childList2.isNotEmpty){
//                               for(var elements2 in childList2) {
//                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                   level61.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//                                 });
//                               }
//                               ///Level71
//                               if(level61.isNotEmpty) {
//                                 db.collection(treeSection).doc(level61[0].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level71.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }}
//                                 });
//                               }
//                               ///Level72
//                               if(level61.length>1){
//                                 db.collection(treeSection).doc(level61[1].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level72.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }}
//                                 });
//                               }
//                             }
//                           });
//                         }
//                         ///Level62
//                         if(level51.length>1){
//                           await db.collection(treeSection).doc(level51[1].userDocId).get().then((userValue2) async {
//                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                             if(childList2.isNotEmpty){
//                               for(var elements2 in childList2) {
//                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                   level62.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//                                 });
//                               }
//
//                               ///Level73
//                               if(level62.isNotEmpty) {
//                                 db.collection(treeSection).doc(level62[0].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level73.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }}
//                                 });
//                               }
//                               ///Level74
//                               if(level62.length>1){
//                                 db.collection(treeSection).doc(level62[1].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level74.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }}
//                                 });
//                               }
//                             }
//                           });
//                         }
//
//                       }
//                     });
//
//                     ///Level52
//                     if(level41.length>1){
//                       await db.collection(treeSection).doc(level41[1].userDocId).get().then((userValue2) async {
//                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                         if(childList2.isNotEmpty){
//                           for(var elements2 in childList2) {
//                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                               level52.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                             });
//                           }
//
//                           ///Level63
//                           if(level52.isNotEmpty) {
//                             await db.collection(treeSection).doc(level52[0].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level63.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//
//                                 ///Level75
//                                 if(level63.isNotEmpty) {
//                                   db.collection(treeSection).doc(level63[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level75.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                                 ///Level76
//                                 if(level63.length>1){
//                                   db.collection(treeSection).doc(level63[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level76.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                               }
//                             });
//                           }
//                           ///Level64
//                           if(level52.length>1){
//                             db.collection(treeSection).doc(level52[1].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level64.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//
//                                 ///Level77
//                                 if(level64.isNotEmpty) {
//                                   db.collection(treeSection).doc(level64[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level77.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                                 ///Level78
//                                 if(level64.length>1){
//                                   db.collection(treeSection).doc(level64[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level78.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                               }
//                             });
//                           }
//
//                         }
//                       });
//                     }
//
//                   }
//                 });
//                 ///Level42
//                 if(level31.length>1){
//                   await db.collection(treeSection).doc(level31[1].userDocId).get().then((userValue2) async {
//                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                     if(childList2.isNotEmpty){
//                       for(var elements2 in childList2) {
//                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                           level42.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                         });
//                       }
//
//                       ///Level53
//                       await db.collection(treeSection).doc(level42[0].userDocId).get().then((userValue2) async {
//                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                         if(childList2.isNotEmpty){
//                           for(var elements2 in childList2) {
//                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                               level53.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                             });
//                           }
//
//                           ///Level65
//                           if(level53.isNotEmpty) {
//                             await db.collection(treeSection).doc(level53[0].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level65.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//
//                                 ///Level79
//                                 if(level65.isNotEmpty) {
//                                   db.collection(treeSection).doc(level65[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level79.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                                 ///Level710
//                                 if(level65.length>1){
//                                   db.collection(treeSection).doc(level65[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level710.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                               }
//                             });
//                           }
//                           ///Level66
//                           if(level53.length>1){
//                             await db.collection(treeSection).doc(level53[1].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level66.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//
//                                 ///Level711
//                                 if(level66.isNotEmpty) {
//                                   db.collection(treeSection).doc(level66[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level711.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                                 ///Level712
//                                 if(level66.length>1){
//                                   db.collection(treeSection).doc(level66[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level712.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                               }
//                             });
//                           }
//
//                         }
//                       });
//                       ///Level54
//                       if(level42.length>1){
//                         await db.collection(treeSection).doc(level42[1].userDocId).get().then((userValue2) async {
//                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                           if(childList2.isNotEmpty){
//                             for(var elements2 in childList2) {
//                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                 level54.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                               });
//                             }
//
//                             ///Level67
//                             if(level54.isNotEmpty) {
//                               await db.collection(treeSection).doc(level54[0].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level67.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level713
//                                   if(level67.isNotEmpty) {
//                                     db.collection(treeSection).doc(level67[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level713.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level714
//                                   if(level67.length>1){
//                                     db.collection(treeSection).doc(level67[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level714.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//                             ///Level68
//                             if(level54.length>1){
//                               await db.collection(treeSection).doc(level54[1].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level68.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level715
//                                   if(level68.isNotEmpty) {
//                                     db.collection(treeSection).doc(level68[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level715.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level716
//                                   if(level68.length>1){
//                                     db.collection(treeSection).doc(level68[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level716.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//
//                           }
//                         });
//                       }
//                     }
//                   });
//                 }
//               }
//             });
//
//             ///Level32
//             if(level21.length>1){
//               await db.collection(treeSection).doc(level21[1].userDocId).get().then((userValue2) async {
//                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                 if(childList2.isNotEmpty){
//                   for(var elements2 in childList2) {
//                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                       level32.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                     });
//                   }
//                   ///Level43
//                   await db.collection(treeSection).doc(level32[0].userDocId).get().then((userValue2) async {
//                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                     if(childList2.isNotEmpty){
//                       for(var elements2 in childList2) {
//                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                           level43.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                         });
//                       }
//                       ///Level55
//                       await db.collection(treeSection).doc(level43[0].userDocId).get().then((userValue2) async {
//                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                         if(childList2.isNotEmpty){
//                           for(var elements2 in childList2) {
//                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                               level55.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                             });
//                           }
//
//                           ///Level69
//                           if(level55.isNotEmpty) {
//                             await db.collection(treeSection).doc(level55[0].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level69.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//
//                                 ///Level717
//                                 if(level69.isNotEmpty) {
//                                   db.collection(treeSection).doc(level69[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level717.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                                 ///Level718
//                                 if(level69.length>1){
//                                   db.collection(treeSection).doc(level69[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level718.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                               }
//                             });
//                           }
//                           ///Level610
//                           if(level55.length>1){
//                             await db.collection(treeSection).doc(level55[1].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level610.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//
//                                 ///Level719
//                                 if(level610.isNotEmpty) {
//                                   db.collection(treeSection).doc(level610[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level719.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                                 ///Level720
//                                 if(level610.length>1){
//                                   db.collection(treeSection).doc(level610[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level720.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                               }
//                             });
//                           }
//
//                         }
//                       });
//
//                       ///Level56
//                       if(level43.length>1){
//                         await db.collection(treeSection).doc(level43[1].userDocId).get().then((userValue2) async {
//                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                           if(childList2.isNotEmpty){
//                             for(var elements2 in childList2) {
//                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                 level56.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                               });
//                             }
//
//
//                             ///Level611
//                             if(level56.isNotEmpty) {
//                               await db.collection(treeSection).doc(level56[0].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level611.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level721
//                                   if(level611.isNotEmpty) {
//                                     db.collection(treeSection).doc(level611[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level721.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level722
//                                   if(level611.length>1){
//                                     db.collection(treeSection).doc(level611[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level722.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//                             ///Level612
//                             if(level56.length>1){
//                               await db.collection(treeSection).doc(level56[1].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level612.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level723
//                                   if(level612.isNotEmpty) {
//                                     db.collection(treeSection).doc(level612[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level723.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level724
//                                   if(level612.length>1){
//                                     db.collection(treeSection).doc(level612[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level724.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//
//                           }
//                         });
//                       }
//
//                     }
//                   });
//
//                   ///Level44
//                   if(level32.length>1){
//                     await db.collection(treeSection).doc(level32[1].userDocId).get().then((userValue2) async {
//                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                       if(childList2.isNotEmpty){
//                         for(var elements2 in childList2) {
//                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                             level44.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                           });
//                         }
//
//                         ///Level57
//                         await db.collection(treeSection).doc(level44[0].userDocId).get().then((userValue2) async {
//                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                           if(childList2.isNotEmpty){
//                             for(var elements2 in childList2) {
//                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                 level57.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                               });
//                             }
//
//                             ///Level613
//                             if(level57.isNotEmpty) {
//                               await db.collection(treeSection).doc(level57[0].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level613.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level725
//                                   if(level613.isNotEmpty) {
//                                     db.collection(treeSection).doc(level613[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level725.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level726
//                                   if(level613.length>1){
//                                     db.collection(treeSection).doc(level613[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level726.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//                             ///Level614
//                             if(level57.length>1){
//                               await db.collection(treeSection).doc(level57[1].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level614.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level727
//                                   if(level614.isNotEmpty) {
//                                     db.collection(treeSection).doc(level614[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level727.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level728
//                                   if(level614.length>1){
//                                     db.collection(treeSection).doc(level614[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level728.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//                           }
//                         });
//
//                         ///Level58
//                         if(level44.length>1){
//                           await db.collection(treeSection).doc(level44[1].userDocId).get().then((userValue2) async {
//                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                             if(childList2.isNotEmpty){
//                               for(var elements2 in childList2) {
//                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                   level58.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//                                 });
//                               }
//
//                               ///Level615
//                               if(level58.isNotEmpty) {
//                                 await db.collection(treeSection).doc(level58[0].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level615.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }
//                                     ///Level729
//                                     if(level615.isNotEmpty) {
//                                       db.collection(treeSection).doc(level615[0].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level729.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                     ///Level730
//                                     if(level615.length>1){
//                                       db.collection(treeSection).doc(level615[1].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level730.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                   }
//                                 });
//                               }
//                               ///Level616
//                               if(level58.length>1){
//                                 await db.collection(treeSection).doc(level58[1].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level616.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }
//
//                                     ///Level731
//                                     if(level616.isNotEmpty) {
//                                       db.collection(treeSection).doc(level616[0].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level731.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                     ///Level732
//                                     if(level616.length>1){
//                                       db.collection(treeSection).doc(level616[1].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level732.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                   }
//                                 });
//                               }
//                             }
//                           });
//                         }
//                       }
//                     });
//                   }
//
//                 }
//               });
//             }
//           }
//         });
//
//
//
//         ///Level22
//         if(level1.length>1){
//           await db.collection(treeSection).doc(level1[1].userDocId).get().then((userValue2) async {
//             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//             if(childList2.isNotEmpty){
//               for(var elements2 in childList2) {
//                 print("child id  : $elements2");
//                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                   level22.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                     userMap["ItemImage"]??"",userMap["PHONE"],));
//                 });
//               }
//
//               ///Level33
//               await db.collection(treeSection).doc(level22[0].userDocId).get().then((userValue2) async {
//                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                 if(childList2.isNotEmpty){
//                   for(var elements2 in childList2) {
//                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                       level33.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                     });
//                   }
//                   ///Level45
//                   await db.collection(treeSection).doc(level33[0].userDocId).get().then((userValue2) async {
//                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                     if(childList2.isNotEmpty){
//                       for(var elements2 in childList2) {
//                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                           level45.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                         });
//                       }
//                       ///Level59
//                       await db.collection(treeSection).doc(level45[0].userDocId).get().then((userValue2) async {
//                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                         if(childList2.isNotEmpty){
//                           for(var elements2 in childList2) {
//                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                               level59.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                             });
//                           }
//
//                           ///Level617
//                           if(level59.isNotEmpty) {
//                             await db.collection(treeSection).doc(level59[0].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level617.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//                                 ///Level733
//                                 if(level617.isNotEmpty) {
//                                   db.collection(treeSection).doc(level617[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level733.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                                 ///Level734
//                                 if(level617.length>1){
//                                   db.collection(treeSection).doc(level617[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level734.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                               }
//                             });
//                           }
//                           ///Level618
//                           if(level59.length>1){
//                             await db.collection(treeSection).doc(level59[1].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level618.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//
//                                 ///Level735
//                                 if(level618.isNotEmpty) {
//                                   db.collection(treeSection).doc(level618[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level735.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                                 ///Level736
//                                 if(level618.length>1){
//                                   db.collection(treeSection).doc(level618[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level736.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }}
//                                   });
//                                 }
//                               }
//                             });
//                           }
//
//                         }
//                       });
//
//                       ///Level510
//                       if(level45.length>1){
//                         await db.collection(treeSection).doc(level45[1].userDocId).get().then((userValue2) async {
//                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                           if(childList2.isNotEmpty){
//                             for(var elements2 in childList2) {
//                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                 level510.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                               });
//                             }
//
//                             ///Level619
//                             if(level510.isNotEmpty) {
//                               await db.collection(treeSection).doc(level510[0].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level619.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level737
//                                   if(level619.isNotEmpty) {
//                                     db.collection(treeSection).doc(level619[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level737.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level738
//                                   if(level619.length>1){
//                                     db.collection(treeSection).doc(level619[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level738.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//                             ///Level620
//                             if(level510.length>1){
//                               await db.collection(treeSection).doc(level510[1].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level620.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level739
//                                   if(level620.isNotEmpty) {
//                                     db.collection(treeSection).doc(level620[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level739.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level740
//                                   if(level620.length>1){
//                                     db.collection(treeSection).doc(level620[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level740.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//
//                           }
//                         });
//                       }
//
//                     }
//                   });
//                   ///Level46
//                   if(level33.length>1){
//                     await db.collection(treeSection).doc(level33[1].userDocId).get().then((userValue2) async {
//                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                       if(childList2.isNotEmpty){
//                         for(var elements2 in childList2) {
//                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                             level46.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                           });
//                         }
//
//                         ///Level511
//                         await db.collection(treeSection).doc(level46[0].userDocId).get().then((userValue2) async {
//                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                           if(childList2.isNotEmpty){
//                             for(var elements2 in childList2) {
//                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                 level511.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                               });
//                             }
//
//                             ///Level621
//                             if(level511.isNotEmpty) {
//                               await db.collection(treeSection).doc(level511[0].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level621.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level741
//                                   if(level621.isNotEmpty) {
//                                     db.collection(treeSection).doc(level621[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level741.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level742
//                                   if(level621.length>1){
//                                     db.collection(treeSection).doc(level621[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level742.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//                             ///Level622
//                             if(level511.length>1){
//                               await db.collection(treeSection).doc(level511[1].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level622.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level743
//                                   if(level622.isNotEmpty) {
//                                     db.collection(treeSection).doc(level622[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level743.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level744
//                                   if(level622.length>1){
//                                     db.collection(treeSection).doc(level622[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level744.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//
//                           }
//                         });
//                         ///Level512
//                         if(level46.length>1){
//                           await db.collection(treeSection).doc(level46[1].userDocId).get().then((userValue2) async {
//                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                             if(childList2.isNotEmpty){
//                               for(var elements2 in childList2) {
//                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                   level512.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//                                 });
//                               }
//
//
//                               ///Level623
//                               if(level512.isNotEmpty) {
//                                 await db.collection(treeSection).doc(level512[0].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level623.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }
//
//                                     ///Level745
//                                     if(level623.isNotEmpty) {
//                                       db.collection(treeSection).doc(level623[0].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level745.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                     ///Level746
//                                     if(level623.length>1){
//                                       db.collection(treeSection).doc(level623[1].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level746.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                   }
//                                 });
//                               }
//                               ///Level624
//                               if(level512.length>1){
//                                 await db.collection(treeSection).doc(level512[1].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level624.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }
//
//                                     ///Level747
//                                     if(level624.isNotEmpty) {
//                                       db.collection(treeSection).doc(level624[0].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level747.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                     ///Level748
//                                     if(level624.length>1){
//                                       db.collection(treeSection).doc(level624[1].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level748.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                   }
//                                 });
//                               }
//
//                             }
//                           });
//                         }
//
//                       }
//                     });
//                   }
//
//                 }
//               });
//               ///Level34
//               if(level22.length>1){
//                 await db.collection(treeSection).doc(level22[1].userDocId).get().then((userValue2) async {
//                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                   if(childList2.isNotEmpty){
//                     for(var elements2 in childList2) {
//                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                         level34.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                       });
//                     }
//                     ///Level47
//                     await db.collection(treeSection).doc(level34[0].userDocId).get().then((userValue2) async {
//                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                       if(childList2.isNotEmpty){
//                         for(var elements2 in childList2) {
//                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                             level47.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                           });
//                         }
//
//                         ///Level513
//                         await db.collection(treeSection).doc(level47[0].userDocId).get().then((userValue2) async {
//                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                           if(childList2.isNotEmpty){
//                             for(var elements2 in childList2) {
//                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                 level513.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                               });
//                             }
//
//                             ///Level625
//                             if(level513.isNotEmpty) {
//                               await db.collection(treeSection).doc(level513[0].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level625.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level749
//                                   if(level625.isNotEmpty) {
//                                     db.collection(treeSection).doc(level625[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level749.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level750
//                                   if(level625.length>1){
//                                     db.collection(treeSection).doc(level625[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level750.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//                             ///Level626
//                             if(level513.length>1){
//                               await db.collection(treeSection).doc(level513[1].userDocId).get().then((userValue2) async {
//                                 Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                 List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                 if(childList2.isNotEmpty){
//                                   for(var elements2 in childList2) {
//                                     await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                       Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                       level626.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                         userMap["ItemImage"]??"",userMap["PHONE"],));
//                                     });
//                                   }
//
//                                   ///Level751
//                                   if(level626.isNotEmpty) {
//                                     db.collection(treeSection).doc(level626[0].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level751.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                   ///Level752
//                                   if(level626.length>1){
//                                     db.collection(treeSection).doc(level626[1].userDocId).get().then((userValue2) async {
//                                       Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                       List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                       if(childList2.isNotEmpty){
//                                         for(var elements2 in childList2) {
//                                           await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                             Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                             level752.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                               userMap["ItemImage"]??"",userMap["PHONE"],));
//                                           });
//                                         }}
//                                     });
//                                   }
//                                 }
//                               });
//                             }
//
//                           }
//                         });
//                         ///Level514
//                         if(level47.length>1){
//                           await db.collection(treeSection).doc(level47[1].userDocId).get().then((userValue2) async {
//                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                             if(childList2.isNotEmpty){
//                               for(var elements2 in childList2) {
//                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                   level514.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//                                 });
//                               }
//
//                               ///Level627
//                               if(level514.isNotEmpty) {
//                                 await db.collection(treeSection).doc(level514[0].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level627.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }
//
//                                     ///Level753
//                                     if(level627.isNotEmpty) {
//                                       db.collection(treeSection).doc(level627[0].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level753.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                     ///Level754
//                                     if(level627.length>1){
//                                       db.collection(treeSection).doc(level627[1].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level754.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                   }
//                                 });
//                               }
//                               ///Level628
//                               if(level514.length>1){
//                                 await db.collection(treeSection).doc(level514[1].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level628.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }
//
//                                     ///Level755
//                                     if(level628.isNotEmpty) {
//                                       db.collection(treeSection).doc(level628[0].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level755.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                     ///Level756
//                                     if(level628.length>1){
//                                       db.collection(treeSection).doc(level628[1].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level756.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                   }
//                                 });
//                               }
//
//                             }
//                           });
//                         }
//
//                       }
//                     });
//                     ///Level48
//                     if(level34.length>1){
//                       await db.collection(treeSection).doc(level34[1].userDocId).get().then((userValue2) async {
//                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                         if(childList2.isNotEmpty){
//                           for(var elements2 in childList2) {
//                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                               level48.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                             });
//                           }
//
//                           ///Level515
//                           await db.collection(treeSection).doc(level48[0].userDocId).get().then((userValue2) async {
//                             Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                             List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                             if(childList2.isNotEmpty){
//                               for(var elements2 in childList2) {
//                                 await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                   Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                   level515.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                     userMap["ItemImage"]??"",userMap["PHONE"],));
//                                 });
//                               }
//
//                               ///Level629
//                               if(level515.isNotEmpty) {
//                                 await db.collection(treeSection).doc(level515[0].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level629.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }
//
//                                     ///Level757
//                                     if(level629.isNotEmpty) {
//                                       db.collection(treeSection).doc(level629[0].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level757.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                     ///Level758
//                                     if(level629.length>1){
//                                       db.collection(treeSection).doc(level629[1].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level758.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                   }
//                                 });
//                               }
//                               ///Level630
//                               if(level515.length>1){
//                                 await db.collection(treeSection).doc(level515[1].userDocId).get().then((userValue2) async {
//                                   Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                   List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                   if(childList2.isNotEmpty){
//                                     for(var elements2 in childList2) {
//                                       await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                         Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                         level630.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                           userMap["ItemImage"]??"",userMap["PHONE"],));
//                                       });
//                                     }
//
//                                     ///Level759
//                                     if(level630.isNotEmpty) {
//                                       db.collection(treeSection).doc(level630[0].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level759.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                     ///Level760
//                                     if(level630.length>1){
//                                       db.collection(treeSection).doc(level630[1].userDocId).get().then((userValue2) async {
//                                         Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                         List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                         if(childList2.isNotEmpty){
//                                           for(var elements2 in childList2) {
//                                             await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                               Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                               level760.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                 userMap["ItemImage"]??"",userMap["PHONE"],));
//                                             });
//                                           }}
//                                       });
//                                     }
//                                   }
//                                 });
//                               }
//
//                             }
//                           });
//                           ///Level516
//                           if(level48.length>1){
//                             await db.collection(treeSection).doc(level48[1].userDocId).get().then((userValue2) async {
//                               Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                               List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                               if(childList2.isNotEmpty){
//                                 for(var elements2 in childList2) {
//                                   await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                     Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                     level516.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                       userMap["ItemImage"]??"",userMap["PHONE"],));
//                                   });
//                                 }
//
//                                 ///Level631
//                                 if(level516.isNotEmpty) {
//                                   await db.collection(treeSection).doc(level516[0].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level631.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }
//
//                                       ///Level761
//                                       if(level631.isNotEmpty) {
//                                         db.collection(treeSection).doc(level631[0].userDocId).get().then((userValue2) async {
//                                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                           if(childList2.isNotEmpty){
//                                             for(var elements2 in childList2) {
//                                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                                 level761.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                                               });
//                                             }}
//                                         });
//                                       }
//                                       ///Level762
//                                       if(level631.length>1){
//                                         db.collection(treeSection).doc(level631[1].userDocId).get().then((userValue2) async {
//                                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                           if(childList2.isNotEmpty){
//                                             for(var elements2 in childList2) {
//                                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                                 level762.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                                               });
//                                             }}
//                                         });
//                                       }
//                                     }
//                                   });
//                                 }
//                                 ///Level632
//                                 if(level516.length>1){
//                                   await db.collection(treeSection).doc(level516[1].userDocId).get().then((userValue2) async {
//                                     Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                     List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                     if(childList2.isNotEmpty){
//                                       for(var elements2 in childList2) {
//                                         await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                           Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                           level632.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                             userMap["ItemImage"]??"",userMap["PHONE"],));
//                                         });
//                                       }
//
//                                       ///Level763
//                                       if(level632.isNotEmpty) {
//                                         db.collection(treeSection).doc(level632[0].userDocId).get().then((userValue2) async {
//                                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                           if(childList2.isNotEmpty){
//                                             for(var elements2 in childList2) {
//                                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                                 level763.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                                               });
//                                             }}
//                                         });
//                                       }
//                                       ///Level764
//                                       if(level632.length>1){
//                                         db.collection(treeSection).doc(level632[1].userDocId).get().then((userValue2) async {
//                                           Map<dynamic, dynamic> userMap = userValue2.data() as Map;
//                                           List<dynamic> childList2 = userMap["CHILDREN"]??[];
//                                           if(childList2.isNotEmpty){
//                                             for(var elements2 in childList2) {
//                                               await db.collection("USERS").where("DOCUMENT_ID",isEqualTo: elements2).get().then((userValue1) {
//                                                 Map<dynamic, dynamic> userMap = userValue1.docs.first.data();
//                                                 level764.add(HelpTreeOldModel(userValue1.docs.first.id, elements2, userMap["NAME"],
//                                                   userMap["ItemImage"]??"",userMap["PHONE"],));
//                                               });
//                                             }}
//                                         });
//                                       }
//                                     }
//                                   });
//                                 }
//
//                               }
//                             });
//                           }
//
//                         }
//                       });
//                     }
//
//                   }
//                 });
//               }
//
//             }
//           });
//         }
//
//       }
//       callNext(const HelpTreePage(), contexter);
//     }
//   });
//
//
// }









createDummyTreeNodes(){
    int docId = 10000;
    int childDocId = 10001;
    int memberId = 1000;
    int i = 1;
    for(i=1;i<=257;i++){
      docId++;
      memberId++;
      HashMap<String, Object> userMap = HashMap();
      userMap["NAME"] = "USER_$i";
      userMap["PHONE"] = "9048001001";
      userMap["DOCUMENT_ID"] = "$docId";
      userMap["MEMBER_ID"] = "$memberId";
      db.collection("USERS").doc("$memberId").delete();
     // db.collection("USERS").doc("$memberId").set(userMap);
      HashMap<String, Object> treeMap = HashMap();
      List<dynamic> childList = ["${childDocId+1}","${childDocId+2}"];
      treeMap["NAME"] = "USER_$i";
      treeMap["PHONE"] = "9048001001";
      treeMap["DOCUMENT_ID"] = "$docId";
      treeMap["MEMBER_ID"] = "$memberId";
      treeMap["CHILDREN"] = childList;
      treeMap["ItemImage"] = "https://firebasestorage.googleapis.com/v0/b/lio-care.appspot.com/o/1688555141416?alt=media&token=661a603a-2539-4084-84dc-1e76400bc4fb";
      treeMap["PARENTS"] = ["10001"];

      db.collection("MASTER_CLUB").doc("$docId").delete();
      // db.collection("MASTER_CLUB").doc("$docId").set(treeMap);
      childDocId = childDocId+2;
    }

}
printListNames(){
    int i=0;
    int j=255;
    for(i=128;i<=255;i++){

      // print("nodes(nodeList: value2.level7$i, index: 0),");
      // print("nodes(nodeList: value2.level7$i, index: 1),");
      // final node8 = Node.Id(8);
print("final node$i = Node.Id($j);");
j--;
    }

}

loopPasswords(){
    db.collection("USERS").where("TYPE",isEqualTo: "ADMIN LEADER").get().then((value) {


      for(var elements in value.docs){
        db.collection("USERS").doc(elements.id).set({"PASSWORD":"lio123"},SetOptions(merge: true));
      }


    });
}

clearAllData(){
  // HashMap<String, Object> totalMap = HashMap();
  //
  // totalMap["GIVE_HELP"]=0;
  // totalMap["GIVE_HELP_COUNT"]=0;
  // totalMap["MEMBERS"]=8;
  // totalMap["PMC"]=0;
  // totalMap["PMC_COUNT"]=0;
  // totalMap["CMF"]=0;
  // totalMap["CMF_COUNT"]=0;
  // totalMap["REFERRAL"]=0;
  // totalMap["REFERRAL_COUNT"]=0;
  // totalMap["TREE_USER"]="ON";
  //
  // db.collection("TOTAL_AMOUNTS").doc("TOTAL_AMOUNTS").set(totalMap,SetOptions(merge: true));

  db.collection("USERS").where("TYPE",isEqualTo: "MEMBER").get().then((value) {
      if(value.docs.isNotEmpty){
        for(var elements in value.docs){
          db.collection("USERS").doc(elements.id).delete();
        }
      }
  });

  db.collection("MASTER_CLUB").where("TYPE",isEqualTo: "MEMBER").get().then((value) {
    if(value.docs.isNotEmpty){
      for(var elements in value.docs){
        db.collection("MASTER_CLUB").doc(elements.id).delete();
      }
    }
  });
  db.collection("CROWN_CLUB").where("TYPE",isEqualTo: "MEMBER").get().then((value) {
    if(value.docs.isNotEmpty){
      for(var elements in value.docs){
        db.collection("CROWN_CLUB").doc(elements.id).delete();
      }
    }
  });
  db.collection("STAR_CLUB").where("TYPE",isEqualTo: "MEMBER").get().then((value) {
    if(value.docs.isNotEmpty){
      for(var elements in value.docs){
        db.collection("STAR_CLUB").doc(elements.id).delete();
      }
    }
  });

  db.collection("USERS").doc("1703741244262rI").set({"CHILD_COUNT":0},SetOptions(merge: true));
  db.collection("USERS").doc("1703741244276MW").set({"CHILD_COUNT":0},SetOptions(merge: true));

  db.collection("MASTER_CLUB").doc("1703741244262204Sb").set({"CHILD_COUNT":0,"CHILDREN":[]},SetOptions(merge: true));
  db.collection("MASTER_CLUB").doc("1703741244276514pk").set({"CHILD_COUNT":0,"CHILDREN":[]},SetOptions(merge: true));
  db.collection("STAR_CLUB").doc("1703741244276514pk").set({"CHILD_COUNT":0,"CHILDREN":[]},SetOptions(merge: true));
  db.collection("STAR_CLUB").doc("1703741244262204Sb").set({"CHILD_COUNT":0,"CHILDREN":[]},SetOptions(merge: true));
  db.collection("CROWN_CLUB").doc("1703741244262204Sb").set({"CHILD_COUNT":0,"CHILDREN":[]},SetOptions(merge: true));
  db.collection("CROWN_CLUB").doc("1703741244276514pk").set({"CHILD_COUNT":0,"CHILDREN":[]},SetOptions(merge: true));

  db.collection("ATTEMPTS").get().then((snapshot) {
    if(snapshot.docs.isNotEmpty){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    }
  });
  db.collection("DISTRIBUTIONS").get().then((snapshot) {
    if(snapshot.docs.isNotEmpty){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    }
  });
  db.collection("MESSAGES").get().then((snapshot) {
    if(snapshot.docs.isNotEmpty){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    }
  });
  db.collection("NOTIFICATIONS").get().then((snapshot) {
    if(snapshot.docs.isNotEmpty){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    }
  });
  db.collection("TASKS").get().then((snapshot) {
    if(snapshot.docs.isNotEmpty){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    }
  });
  db.collection("PAYMENTS").get().then((snapshot) {
    if(snapshot.docs.isNotEmpty){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    }
  });
  db.collection("REFERENCES").get().then((snapshot) {
    if(snapshot.docs.isNotEmpty){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    }
  });
  db.collection("TRANSACTIONS").get().then((snapshot) {
    if(snapshot.docs.isNotEmpty){
      for (DocumentSnapshot ds in snapshot.docs){
        ds.reference.delete();
      }
    }
  });

}

changeLeadersData(){

  db.collection("USERS").where("TYPE",isEqualTo: "LEADER").get().then((value) {
    for(var elements in value.docs){
      db.collection("USERS").doc(elements.id).set({"TYPE":"ADMIN LEADER"},SetOptions(merge: true));
    }
  });

    db.collection("MASTER_CLUB").where("TYPE",isEqualTo: "LEADER").get().then((value) {
      for(var elements in value.docs){
        db.collection("USERS").doc(elements.id).delete();
        db.collection("MASTER_CLUB").doc(elements.id).set({"TYPE":"ADMIN LEADER"},SetOptions(merge: true));
      }
    });
    db.collection("STAR_CLUB").where("TYPE",isEqualTo: "LEADER").get().then((value) {
      for(var elements in value.docs){
        db.collection("STAR_CLUB").doc(elements.id).set({"TYPE":"ADMIN LEADER"},SetOptions(merge: true));
      }
    });
    db.collection("CROWN_CLUB").where("TYPE",isEqualTo: "LEADER").get().then((value) {
      for(var elements in value.docs){
        db.collection("CROWN_CLUB").doc(elements.id).set({"TYPE":"ADMIN LEADER"},SetOptions(merge: true));
      }
    });

}




  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController refNumberController = TextEditingController();


  userRegistration(String refMember, BuildContext context) async {

    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    bool numberStatus = await userProvider.checkNumberExist(numberController.text);
    bool refStatus = await userProvider.checkRefIdExist(refMember, context);
    if (refStatus) {
      if (!numberStatus) {
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  );
                });

              DateTime now = DateTime.now();
              String memberId = now.millisecondsSinceEpoch.toString() +
                  userProvider.generateRandomString(2);
              String documentId = now.microsecondsSinceEpoch.toString() +
                  userProvider.generateRandomString(2);
              HashMap<String, Object> userMap = HashMap();

              userMap['NAME'] = nameController.text.trim();
              userMap['EMAIL'] = "${nameController.text.trim()}@gmail.com";
              userMap['PHONE'] = numberController.text.trim();
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
              userMap["KYC_STATUS"] = "VERIFIED";
              userMap["TYPE"] = "MEMBER";
              userMap["ItemImage"] = "";
              userMap["FCM_ID"] = "ep2OYc9RTb6JesKbBkzW12:APA91bHXD7k9AHvRNDeCrPFdzJYZhYA3pUduRu6hF5yV3QKTIQFXhkBXgBbpDr8YxEUC5QF0NbA1t4fd509gR2-hBnab-1JQAc9lrIjN7x__kNVcc_qY6IsFayxdWiM3lMslxNV8gPvb";
              userMap["UPI_Id"] = nameController.text.trim();
              userMap["UPI_App"] = "Google Pay";
              userMap["UPI_Image"] = "assets/GooglePay.png";
              userMap["GRADE"] = "";
              userMap["CHILD_COUNT"] = 0;
              userMap["REFERENCE"] = userProvider.refereeId;
              userMap["REFERENCE_NAME"] = userProvider.refereeRegName;
              userMap["REFERENCE_NUMBER"] = refMember;
              userMap["REFERRAL_ID"] = numberController.text.trim();
              userMap["ACCOUNT_NUMBER"] = numberController.text.trim();
              userMap["ACTIVE_DATE"] = now;
              userMap["ADDRESS"] = nameController.text.trim();
              userMap["ID_IMAGE"] = "https://firebasestorage.googleapis.com/v0/b/lio-care.appspot.com/o/1696488746806?alt=media&token=0570a8a7-6f04-4596-a516-2da64070d27c";
              userMap["ID_NUMBER"] = numberController.text.trim();
              userMap["ID_PROOF"] = "Aadhaar";
              userMap["PIN_CODE"] = "676517";
              userMap["IFSC_CODE"] = numberController.text.trim();
              userMap["NOMINEE_AGE"] = "25";
              userMap["NOMINEE_NAME"] = "NOMINEE";
              userMap["NOMINEE_PHONE_NUMBER"] = numberController.text.trim();
              userMap["PAN_NUMBER"] = numberController.text.trim();
              userMap["NOMINEE_RELATION"] = "Spouse";
              userMap["PAN_IMAGE"] = "https://firebasestorage.googleapis.com/v0/b/lio-care.appspot.com/o/1696488746806?alt=media&token=0570a8a7-6f04-4596-a516-2da64070d27c";

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

            String distributionId = DateTime.now().millisecondsSinceEpoch.toString() +
                generateRandomString(4);
            await db
                .collection("DISTRIBUTIONS")
                .doc(distributionId).set(pmcMap, SetOptions(merge: true));

              db.collection("REFERENCES").doc(memberId).set({
                "REFERRED_ID": memberId,
                "REFERER_ID": userProvider.refereeId,
              }, SetOptions(merge: true));

    userProvider.isFirstTime = true;
    userProvider.getUserDetails(memberId);

              notifyListeners();
            finish(context);
              // callNextReplacement(LoginScreen(referralId: ''), context);
              registrationAlert(context, memberId);

            // finish(context);
      } else {
        userProvider.warningAlert(context, "Phone Number already exist.");
      }
    } else {
      userProvider.warningAlert(context, "Invalid Reference Id.");
    }


  }

  registrationAlert(BuildContext context,String memberID) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AlertDialog alert = AlertDialog(
      insetPadding: const EdgeInsets.all(39),

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      backgroundColor: clF8FAFF,
      scrollable: true,
      //alertContent
      title:   Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            width: 60,
            alignment: Alignment.center,
            decoration:  BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xff16B200))
            ),
            child: const Icon(Icons.check,color:Color(0xff16B200),size: 28, ),
          ),
          const SizedBox(height: 10,),
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
          const SizedBox(height: 10,),
          const Opacity(
            opacity: 0.80,
            child: Text(
              "Registration completed. Kindly pay PMC amount to become an active member",
              style: TextStyle(
                color: cl252525,
                fontSize: 15,
                fontFamily: 'PoppinsMedium',
                fontWeight: FontWeight.w400,

                height: 1.33,
              ),
            ),
          ),
          const SizedBox(height:15),
          InkWell(
            onTap: () async {
              numberController.clear();
              nameController.clear();
              refNumberController.clear();
              finish(context);
              // callNextReplacement(BottomNavigationScreen(Userid: memberID,), context);
            },
            child: Container(
              width:130,
              padding: const EdgeInsets.symmetric(vertical:10,horizontal: 15),
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
        return  WillPopScope(
            onWillPop: () async => false,
            child:alert);
      },
    );
  }

  logOutAlert(BuildContext context) {
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
                              // await cancelStreams();
                              UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
                              await userProvider.clearOnRegistration();
                              await userProvider.clearStreamSubscriptions();
                              FirebaseAuth auth = FirebaseAuth.instance;
                              auth.signOut();
                              finish(context);
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                  RegistrationTest()), (Route<dynamic> route) => false);

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

  changeName(){

    db.collection("USERS").doc("1703741243997sQ").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));
    db.collection("USERS").doc("1703741244123wF").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));
    db.collection("USERS").doc("1703741244138bs").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));
    db.collection("USERS").doc("1703741244174Mj").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));
    db.collection("USERS").doc("1703741244191di").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));
    db.collection("USERS").doc("1703741244221dz").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));
    db.collection("USERS").doc("1703741244249ad").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));
    db.collection("USERS").doc("1703741244262rI").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));
    db.collection("USERS").doc("1703741244276MW").set({
      "REFERENCE":"1703741243997sQ",
      "REFERENCE_NUMBER":"9744722719",
    },SetOptions(merge: true));




    //
    //
    // db.collection("MASTER_CLUB").doc("1703741243997656Tj").set({"CHILDREN":["1703741244123676LE"]},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741243997656Tj").set({"CHILDREN":["1703741244123676LE"]},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741243997656Tj").set({"CHILDREN":["1703741244123676LE"]},SetOptions(merge: true));
    //
    // //
    // db.collection("MASTER_CLUB").doc("1703741244123676LE").set({"CHILDREN":["1703741244138909Zg"]},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741244123676LE").set({"CHILDREN":["1703741244138909Zg"]},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741244123676LE").set({"CHILDREN":["1703741244138909Zg"]},SetOptions(merge: true));
    //
    // // db.collection("USERS").doc("1703741244138bs").set({"NAME":"ASHIK"},SetOptions(merge: true));
    // db.collection("MASTER_CLUB").doc("1703741244138909Zg").set({"CHILDREN":["1703741244174870Nx"]},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741244138909Zg").set({"CHILDREN":["1703741244174870Nx"]},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741244138909Zg").set({"CHILDREN":["1703741244174870Nx"]},SetOptions(merge: true));
    //
    // // db.collection("USERS").doc("1703741244174Mj").set({"NAME":"ANSIF CT"},SetOptions(merge: true));
    // db.collection("MASTER_CLUB").doc("1703741244174870Nx").set({"CHILDREN":["1703741244191205Oe"]},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741244174870Nx").set({"CHILDREN":["1703741244191205Oe"]},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741244174870Nx").set({"CHILDREN":["1703741244191205Oe"]},SetOptions(merge: true));
    //
    // // db.collection("USERS").doc("1703741244191di").set({"CHILDREN":["1703741244123676LE"]},SetOptions(merge: true));
    // db.collection("MASTER_CLUB").doc("1703741244191205Oe").set({"CHILDREN":["1703741244221878Ms"]},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741244191205Oe").set({"CHILDREN":["1703741244221878Ms"]},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741244191205Oe").set({"CHILDREN":["1703741244221878Ms"]},SetOptions(merge: true));
    //
    // // db.collection("USERS").doc("1703741244221dz").set({"NAME":"ASHIK KT"},SetOptions(merge: true));
    // db.collection("MASTER_CLUB").doc("1703741244221878Ms").set({"CHILDREN":["1703741244249678Db"]},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741244221878Ms").set({"CHILDREN":["1703741244249678Db"]},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741244221878Ms").set({"CHILDREN":["1703741244249678Db"]},SetOptions(merge: true));
    //
    // // db.collection("USERS").doc("1703741244249ad").set({"NAME":"MUHAMMED ANSIF"},SetOptions(merge: true));
    // db.collection("MASTER_CLUB").doc("1703741244249678Db").set({"CHILDREN":["1703741244262204Sb"]},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741244249678Db").set({"CHILDREN":["1703741244262204Sb"]},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741244249678Db").set({"CHILDREN":["1703741244262204Sb"]},SetOptions(merge: true));
    //
    // db.collection("USERS").doc("1703741244262rI").set({"NAME":"MUHAMMED ASHIK"},SetOptions(merge: true));
    // db.collection("MASTER_CLUB").doc("1703741244262204Sb").set({"NAME":"MUHAMMED ASHIK"},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741244262204Sb").set({"NAME":"MUHAMMED ASHIK"},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741244262204Sb").set({"NAME":"MUHAMMED ASHIK"},SetOptions(merge: true));
    //
    // db.collection("USERS").doc("1703741244276MW").set({"NAME":"AFSAL RAHMAN","PHONE":"9947422419"},SetOptions(merge: true));
    // db.collection("MASTER_CLUB").doc("1703741244276514pk").set({"NAME":"AFSAL RAHMAN","PHONE":"9947422419"},SetOptions(merge: true));
    // db.collection("STAR_CLUB").doc("1703741244276514pk").set({"NAME":"AFSAL RAHMAN","PHONE":"9947422419"},SetOptions(merge: true));
    // db.collection("CROWN_CLUB").doc("1703741244276514pk").set({"NAME":"AFSAL RAHMAN","PHONE":"9947422419"},SetOptions(merge: true));

  }
  loopReferenceName(){
    int i = 0;
    int j = 0;
    // db.collection("USERS").where("TYPE",isEqualTo: "ADMIN LEADER").get().then((value) {
    //   for(var elements in value.docs){
    //     db.collection("USERS").doc(elements.id).set({"REFERENCE_NAME":"ANSIF"},SetOptions(merge: true));
    //   }
    // });

    db.collection("USERS").where("TYPE",isEqualTo: "MEMBER").get().then((value) {
      print("total : ${value.docs.length}");
      for(var elements in value.docs){
        i++;
        Map<dynamic,dynamic> userMap = elements.data();
        db.collection("USERS").doc(userMap["REFERENCE"]).get().then((refValue) async {
          if(refValue.exists){
            Map<dynamic,dynamic> refMap = refValue.data() as Map;
            await db.collection("USERS").doc(elements.id).set({"REFERENCE_NAME":refMap["NAME"]},SetOptions(merge: true));
            print(".. $i");
          }
        });

      }
    });
    
  }
  
  loopInviteesCount() async {
    var activeMembers = await db.collection("USERS").where("STATUS",isEqualTo: "ACTIVE").get();
    if(activeMembers.docs.isNotEmpty){
      print("Total length : ${activeMembers.docs.length}");
      for(var elements in activeMembers.docs){
        var activeRefMembers = await db.collection("USERS")
            .where("STATUS",isEqualTo: "ACTIVE")
            .where("REFERENCE",isEqualTo: elements.id).count()
            .get();
        await db.collection("USERS").doc(elements.id)
            .set({"TOTAL_INVITEES_COUNT":activeRefMembers.count},SetOptions(merge: true));
        print("element ids : ${elements.id}");
      }
    }
  }


  nghfdfadsx(){
    List<String> parentList543 = [
      "1703741244221878Ms",
      "1703741244191205Oe",
      "1703741244174870Nx",
      "1703741244138909Zg",
      "1703741244123676LE",
      "1703741243997656Tj",
      "1703741243997656Tj",
    ];
    String id='1703741244249678Db';
    HashMap<String, Object> treeMap = HashMap();

    treeMap["PARENTS"] = parentList543;

    db.collection("MASTER_CLUB").doc(id).update(treeMap);
    db.collection("STAR_CLUB").doc(id).update(treeMap);
    db.collection("CROWN_CLUB").doc(id).update(treeMap);
  }

  void addDummyParents() {
    print("fgjhkjkl");
    int i = 1;
    String grade = "";
    String directParent = "";
    String directParentDoc = "";
    List<String> parentList = [];
    List<String> nameList = [
      "RAJANI",
      "SHIHAB",
      "NAJEEB",
      "JAMEELA",
      "MANOJ",
      "AFSAL",
      "ANSHIF",
      "ASHIQ",
      "ASLIYA NOOR",

];
    List<String> numberList = [
      "9744722719",
      "9061422419",
      "9048322319",
      "9946722719",
      "9961422419",
      "9539322319",
      "9846722719",
      "9846322319",
      "9947422419",

];














    List<String> parentList2 = [];
    FirebaseMessaging.instance.getToken().then((fcmValue) {
      for (i = 1; i <= 9; i++) {
        parentList.clear();
        DateTime now = DateTime.now();
        String memberId =
            now.millisecondsSinceEpoch.toString() + generateRandomString(2);
        String documentId =
            now.microsecondsSinceEpoch.toString() + generateRandomString(2);
        HashMap<String, Object> memberMap = HashMap();

        memberMap["NAME"] = nameList[i-1];
        memberMap["PHONE"] = numberList[i-1];
        memberMap["REG_DATE"] = now;
        memberMap["CHILD_COUNT"] = i < 8 ? 2 : 0;
        memberMap["STATUS"] = "ACTIVE";
        memberMap["EMAIL"] = "";
        memberMap["ItemImage"] = "";
        memberMap["TOTAL_EARNINGS"] = 0;
        memberMap["TOTAL_REFERRAL_AMOUNT"] = 0;
        memberMap["TOTAL_REFERRAL_COUNT"] = 0;
        memberMap["TOTAL_PMC"] = 0;
        memberMap["TOTAL_CMF"] = 0;
        memberMap["TOTAL_HELP"] = 0;
        memberMap["TOTAL_AUTO_ONE_HELP"] = 0;
        memberMap["TOTAL_AUTO_TWO_HELP"] = 0;
        memberMap["TYPE"] = "ADMIN LEADER";
        memberMap["GRADE"] = "MASTER ACHIEVER";
        memberMap["FCM_ID"] = fcmValue.toString();
        memberMap["UPI_Id"] = "";
        memberMap["MEMBER_ID"] = memberId;
        memberMap["DOCUMENT_ID"] = documentId;

        db.collection("USERS").doc(memberId).set(memberMap);

        HashMap<String, Object> treeMap = HashMap();
        treeMap["DOCUMENT_ID"] = documentId;
        treeMap["FCM_ID"] = fcmValue.toString();
        treeMap["MEMBER_ID"] = memberId;
        treeMap["STEP_ID"] = i;
        treeMap["DIRECT_PARENT_ID"] = directParent;
        treeMap["DIRECT_PARENT_DOC_ID"] = directParentDoc;
        treeMap["GRADE"] = "RED";
        treeMap["CHILD_COUNT"] = i <= 7 ? 2 : 0;
        treeMap["PARENTS"] = parentList2;
        memberMap["NAME"] = nameList[i-1];
        memberMap["PHONE"] = numberList[i-1];
        treeMap["REG_DATE"] = now;

        db.collection("MASTER_CLUB").doc(documentId).set(treeMap);
        db.collection("STAR_CLUB").doc(documentId).set(treeMap);
        db.collection("CROWN_CLUB").doc(documentId).set(treeMap);

        if(i<8){
        directParent = memberId;
        directParentDoc = documentId;
        parentList.add(documentId);
        parentList2 = parentList + parentList2;
        }
      }
    });
    print("dfhgjhkjlko;l'pk;jhgch");

  }

  void loopToClubs(){

    db.collection("USERS").get().then((value) {

      for(var elements in value.docs){
        Map<dynamic,dynamic> userMap = elements.data();
        HashMap<String, Object> userHashMap = HashMap();
        String userDocId = userMap["DOCUMENT_ID"];
        print("user doc id  $userDocId");
        userHashMap["PHONE"]=userMap["PHONE"];
        userHashMap["TYPE"]=userMap["TYPE"];
        userHashMap["NAME"]=userMap["NAME"];
        userHashMap["STATUS"]=userMap["STATUS"];
        userHashMap["GRADE"]=userMap["GRADE"];

        db.collection("MASTER_CLUB").doc(userDocId).set(userHashMap,SetOptions(merge: true));
        db.collection("STAR_CLUB").doc(userDocId).set(userHashMap,SetOptions(merge: true));
        db.collection("CROWN_CLUB").doc(userDocId).set(userHashMap,SetOptions(merge: true));
      }


    });

  }
  
  void castToNewName() {

        db.collection("MASTER_CLUB").where("TYPE",isEqualTo: "ADMIN LEADER").get().then((userValue) {
          for(var elements in userValue.docs){
            Map<dynamic,dynamic> userMap = elements.data();
            db.collection("MASTER_CLUB").doc(elements.id).set(userMap.cast());
          }
        });
        db.collection("STAR_CLUB").where("TYPE",isEqualTo: "ADMIN LEADER").get().then((userValue) {
          for(var elements in userValue.docs){
            Map<dynamic,dynamic> userMap = elements.data();
            db.collection("STAR_CLUB").doc(elements.id).set(userMap.cast());
          }
        });
        db.collection("CROWN_CLUB").where("TYPE",isEqualTo: "ADMIN LEADER").get().then((userValue) {
          for(var elements in userValue.docs){
            Map<dynamic,dynamic> userMap = elements.data();
            db.collection("CROWN_CLUB").doc(elements.id).set(userMap.cast());
          }
        });

  }
  
  void loopInTreeToDistributions(){
    int i = 0 ;
    db.collection("DISTRIBUTIONS")
        // .where("TYPE",whereIn: ["REFERRAL","HELP","STAR_CLUB","CROWN_CLUB"])
        .where("TYPE",whereIn: ["CROWN_CLUB"]).get().then((value) async {
          print("total length : ${value.docs.length}");
          for(var elements in value.docs){
            i++;
            print("now $i");
            Map<dynamic, dynamic> uMap = elements.data() as Map;
            await db.collection("DISTRIBUTIONS").doc(elements.id).set({"IN_TREE":"CROWN_CLUB"},SetOptions(merge: true));
          }
    });

    
    
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

}