import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants/functions.dart';
import '../../constants/my_colors.dart';
import '../../models/basic_treeListModel.dart';

// ignore: must_be_immutable
class MessageScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String memberId;
  String memberDocID;
  String userName;

  MessageScreen(
      {super.key,
      required this.memberId,
      required this.memberDocID,
      required this.userName});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: bxkclr,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          Consumer<UserProvider>(
            builder: (context,va,child) {
              return IconButton(
                icon: const Icon(
                  Icons.tune,
                  color: cl2F7DC1,
                ),
                onPressed: () {
                  va.isSelectedFilter();
                  va.clearBoolFun();
                  // _showTopSheet(context);
                  // openEndDrawer();
                  // _showTopSheet(context);
                },
              );
            }
          )
        ],
        backgroundColor: bxkclr,
        elevation: 0,
        leadingWidth: 100,
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
            onTap: () {
              finish(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: textColor,
                  ),
                  Image.asset(
                    "assets/bluelogo.png",
                    scale: 18,
                  ),
                ],
              ),
            )),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Send Message',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Consumer<UserProvider>(builder: (context, value1, child) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10,),
                    if(value1.filterSelect)
                    Column(children: [
                       Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: [
                            const Text(
                              'Filter',
                              style: TextStyle(
                                color: Color(0xFF252525),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                value1.clearBoolFun();
                              },
                              child: const Icon(
                                Icons.refresh,
                                color: Color(0xFF2F7DC1),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFFCF8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 7,
                              offset: Offset(1, 1),
                              spreadRadius: -1,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Tree',
                                    style: TextStyle(
                                      color: Color(0xFF252525),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  value: value1.isSelectedTree,
                                  onChanged: (bool? value) {
                                    value1.isSelectedTreeF(value!);
                                  },
                                ),
                              ],
                            ),
                            if(value1.isSelectedTree)
                              SizedBox(
                                height: 35,
                                width: width,
                                child: ListView.builder(
                                  itemCount: value1.treeList.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index1) {
                                    var item = value1.treeList[index1];
                                    bool isSelected = index1 == value1.selectedIndex;
                                    return InkWell(
                                      onTap: () {

                                        if(index1==0&&value1.allBasicChildrenListForMessage.isNotEmpty) {
                                          value1.sendMessTree=value1.treeList[index1].levelName;
                                          value1.containerColorChange(index1);
                                        }else if(index1==1&&value1.allAutoOneChildrenListForMessage.isNotEmpty){
                                          value1.sendMessTree=value1.treeList[index1].levelName;
                                          value1.containerColorChange(index1);
                                        }else if(index1==2&&value1.allAutoTwoChildrenListForMessage.isNotEmpty){
                                          value1.sendMessTree=value1.treeList[index1].levelName;
                                          value1.containerColorChange(index1);
                                        }
                                      },
                                      child: Container(
                                        width: width / 3.275,
                                        height: 50,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        alignment: Alignment.center,
                                        decoration: ShapeDecoration(
                                          color: isSelected
                                              ? const Color(0xFF2F7DC1)
                                              : Colors.white,
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 0.25,
                                                color: Color(0xFFC4C4C4)),
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        child: Text(
                                          item.levelName,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : Colors.black,
                                            fontSize: 12,
                                            fontFamily: 'PoppinsRegular',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 119,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 2, top: 10, bottom: 10),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFFFCF8),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      blurRadius: 7,
                                      offset: Offset(1, 1),
                                      spreadRadius: -1,
                                    )
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Level',
                                            style: TextStyle(
                                              color: Color(0xFF252525),
                                              fontSize: 12,
                                              fontFamily: 'PoppinsRegular',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Checkbox(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(5.0)),
                                          value: value1.isSelectedLevel,
                                          onChanged: (bool? value) {
                                            value1.isSelectedLevelF(value!);
                                          },
                                        ),
                                      ],
                                    ),
                                    if(value1.isSelectedLevel)
                                      Container(
                                        height: 50,
                                        width: width,
                                        // width: width/2.62, // Adjust the width as needed
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: const Color(0xff2F7DC1),
                                              width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: PopupMenuButton<String>(
                                          icon: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(value1.selLevel),

                                              const Icon(CupertinoIcons.chevron_down),
                                            ],
                                          ),
                                          initialValue: "STARTER",
                                          onSelected: (newValue) {
                                            value1.levelSelectionSendMess(newValue);
                                            value1.filterForSendMessage(newValue);
                                          },
                                          itemBuilder: (BuildContext context) {
                                            return value1.fullItemList.map((TreeListModel option) {
                                              return PopupMenuItem<String>(
                                                value: option.levelName,
                                                child: Text(option.levelName),
                                              );
                                            }).toList();
                                          },
                                        ),
                                      ),

                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 3,),
                            Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 2, top: 10, bottom: 10),
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFFFCF8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)),
                                    shadows: const [
                                      BoxShadow(
                                        color: Color(0x19000000),
                                        blurRadius: 7,
                                        offset: Offset(1, 1),
                                        spreadRadius: -1,
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              'Number of Child',
                                              style: TextStyle(
                                                color: Color(0xFF252525),
                                                fontSize: 12,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Checkbox(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(5.0)),
                                            value: value1.isSelectedChild,
                                            onChanged: (bool? value) {
                                              value1.isSelectedChildF(value!);
                                            },
                                          ),
                                        ],
                                      ),
                                      if(value1.isSelectedChild)

                                        SizedBox(
                                          //width: width/1.965,
                                          height: 50,
                                          child: ListView.builder(
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            itemCount: value1.childCountListNew.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index2) {
                                              var item = value1.childCountListNew[index2];
                                              bool isSelected1 = index2 == value1.selectedIndex1;

                                              return InkWell(
                                                onTap: () {
                                                  value1.containerColorChange1(index2);
                                                },
                                                child: Container(
                                                  width: width / 7.20,
                                                  height: 50,
                                                  margin: const EdgeInsets.symmetric(
                                                      horizontal: 2),
                                                  alignment: Alignment.center,
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: ShapeDecoration(
                                                    color: isSelected1
                                                        ? const Color(0xFF2F7DC1)
                                                        : Colors.white,
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          width: 0.25,
                                                          color: Color(0xFFC4C4C4)),
                                                      borderRadius:
                                                      BorderRadius.circular(4),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    item.toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: isSelected1
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontSize: 12,
                                                      fontFamily: 'PoppinsRegular',
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFFFFFCF8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 7,
                              offset: Offset(1, 1),
                              spreadRadius: -1,
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Auto Polls',
                                  style: TextStyle(
                                    color: Color(0xFF252525),
                                    fontSize: 12,
                                    fontFamily: 'PoppinsRegular',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  value: value1.isSelectedAutoPoll,
                                  onChanged: (bool? value) {
                                    value1.isSelectedAutoPollF(value!);
                                  },
                                ),
                              ],
                            ),
                            if(value1.isSelectedAutoPoll)
                              Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: width / 1.572,
                                  height: 35,
                                  child: Row(children: [
                                    value1.sendMessTree=="MASTER_CLUB"
                                        ?  Padding(
                                          padding:  const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: InkWell(
                                            onTap: () {

                                               value1.isColorChanged(0,value1.treeListWithoutBasicTree[0]);

                                            },
                                            child: Container(
                                              width: width / 3.275,
                                              height: 35,
                                              alignment: Alignment.center,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                                color:value1.selectedIndex2==0
                                                    ?  const Color(0xFF2F7DC1)
                                                    : Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 0.25,
                                                      color: Color(0xFFC4C4C4)),
                                                  borderRadius:
                                                  BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                              "STAR_CLUB",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color:value1.selectedIndex2==0
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ):SizedBox(),
                                    value1.sendMessTree!="CROWN_CLUB"?   Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2),
                                          child: InkWell(
                                            onTap: () {

                                               value1.isColorChanged(1,value1.treeListWithoutBasicTree[1]);

                                            },
                                            child: Container(
                                              width: width / 3.275,
                                              height: 35,
                                              alignment: Alignment.center,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: ShapeDecoration(
                                             color:   value1.selectedIndex2==1
                                                    ?  const Color(0xFF2F7DC1)
                                                    : Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  side: const BorderSide(
                                                      width: 0.25,
                                                      color: Color(0xFFC4C4C4)),
                                                  borderRadius:
                                                  BorderRadius.circular(4),
                                                ),
                                              ),
                                              child: Text(
                                              "CROWN_CLUB",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color:value1.selectedIndex2==1
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 12,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ):SizedBox(),

                                  ],),
                                  // child: ListView.builder(
                                  //   itemCount:
                                  //   value1.treeListWithoutBasicTree.length,
                                  //   scrollDirection: Axis.horizontal,
                                  //   itemBuilder: (context, index3) {
                                  //     var item =
                                  //     value1.treeListWithoutBasicTree[index3];
                                  //     bool isSelected2 =
                                  //         index3 == value1.selectedIndex2;
                                  //     return  Padding(
                                  //       padding: const EdgeInsets.symmetric(
                                  //           horizontal: 2),
                                  //       child: InkWell(
                                  //         onTap: () {
                                  //
                                  //           value1.isColorChanged(index3,value1.treeListWithoutBasicTree[index3]);
                                  //
                                  //         },
                                  //         child: Container(
                                  //           width: width / 3.275,
                                  //           height: 35,
                                  //           alignment: Alignment.center,
                                  //           clipBehavior: Clip.antiAlias,
                                  //           decoration: ShapeDecoration(
                                  //             color: isSelected2
                                  //                 ? const Color(0xFF2F7DC1)
                                  //                 : Colors.white,
                                  //             shape: RoundedRectangleBorder(
                                  //               side: const BorderSide(
                                  //                   width: 0.25,
                                  //                   color: Color(0xFFC4C4C4)),
                                  //               borderRadius:
                                  //               BorderRadius.circular(4),
                                  //             ),
                                  //           ),
                                  //           child: Text(
                                  //             item.toString(),
                                  //             textAlign: TextAlign.center,
                                  //             style: TextStyle(
                                  //               color: isSelected2
                                  //                   ? Colors.white
                                  //                   : Colors.black,
                                  //               fontSize: 12,
                                  //               fontFamily: 'PoppinsRegular',
                                  //               fontWeight: FontWeight.w400,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       ),
                                  //     );
                                  //   },
                                  // ),
                                ),
                              ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: height / 50,
                      ),
                    ],),









                    Container(
                      alignment: Alignment.center,
                      width: width / 1.1,
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.only(left: 7),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFCF8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 7,
                            offset: Offset(1, 1),
                            spreadRadius: -1,
                          )
                        ],
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        controller: value1.messageController,
                        maxLines: null,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 12,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          height: 1.31,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Message';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter your Message here',
                          // This is the hintText
                          hintStyle: TextStyle(fontSize: 14),
                          // This is the hintText
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 1),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 9,
                    ),
                    InkWell(
                      onTap: () {
                        value1.showBottomSheet(context, 'MessageSend');
                      },
                      child: value1.MessageFileImage == null
                          ? Container(
                              width: width / 1.1,
                              height: height / 3.300395256916996,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 118),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFFCF8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 7,
                                    offset: Offset(1, 1),
                                    spreadRadius: -1,
                                  )
                                ],
                              ),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.image_outlined,
                                    size: 80,
                                    color: Color(0xFF5E5E5E),
                                  ),
                                  Text(
                                    'Upload Image',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF7F7F7F),
                                      fontSize: 16,
                                      fontFamily: 'PoppinsRegular',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              width: width / 1.1,
                              height: height / 3.300395256916996,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 118),
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFFFCF8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x19000000),
                                    blurRadius: 7,
                                    offset: Offset(1, 1),
                                    spreadRadius: -1,
                                  )
                                ],
                              ),
                              child: Image.file(value1.MessageFileImage!,fit: BoxFit.fill),
                            ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),

                    Container(
                      width: width / 1.1,
                      padding: const EdgeInsets.only(left: 8),
                      clipBehavior: Clip.antiAlias,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFFFCF8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x19000000),
                            blurRadius: 6,
                            offset: Offset(0, 4),
                            spreadRadius: -2,
                          )
                        ],
                      ),
                      child: TextFormField(
                        minLines: 1,
                        maxLines: null,
                        controller: value1.messagePasteLinkController,
                        style: const TextStyle(
                          color: Color(0xFF252525),
                          fontSize: 12,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          height: 1.31,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Paste link',
                          hintStyle: TextStyle(
                            color: Color(0xFF7F7F7F),
                            fontSize: 14,
                            fontFamily: 'PoppinsRegular',
                            fontWeight: FontWeight.w400,
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.transparent, width: 1),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 9,
                    ),

                    InkWell(
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await value1.assignToIdList();

                          if (value1.filterSendMesssFilterList.isNotEmpty) {
                        print("first ${value1.filterSendMesssFilterList.map((e) => e.userName)}");

                        value1.userMessageSend(
                                memberId, memberDocID, userName, context, []);
                          } else {
                            FocusScope.of(context).unfocus();

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('No senders Selected')),
                            );
                          }
                        }
                      },
                      child: Container(
                        width: width / 1.1,
                        height: 49,
                        clipBehavior: Clip.antiAlias,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF2F7DC1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x19000000),
                              blurRadius: 6,
                              offset: Offset(0, 4),
                              spreadRadius: -2,
                            )
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Text(
                                'Send',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15,),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
// void _showTopSheet(BuildContext context) {
//   showGeneralDialog<void>(
//     barrierColor: Colors.black.withOpacity(0.5),
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//     // barrierColor: Colors.black54,
//     transitionDuration: const Duration(milliseconds: 400),
//     pageBuilder: (BuildContext context, Animation<double> animation,
//         Animation<double> secondaryAnimation) {
//       return Align(
//           alignment: Alignment.topCenter,
//           child: Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Consumer<UserProvider>(builder: (context, value6, child) {
//                 return Container(
//                     height: value6.isSecondDropdownEnabled ? 330 : 280,
//                     width: 600,
//                     decoration: BoxDecoration(
//                         color: Colors.amber,
//                         borderRadius: BorderRadius.circular(100),
//                         border: Border.all(
//                           color: cl2F7DC1,
//                           width: 1,
//                         )),
//                     child: Consumer<UserProvider>(
//                         builder: (context, value5, child) {
//                           return Drawer(
//                               shape: const RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(30),
//                                     bottomRight: Radius.circular(30)),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(height: 30),
//                                     Align(
//                                         alignment: Alignment.centerRight,
//                                         child: InkWell(
//                                           onTap: () {
//                                             finish(context);
//                                           },
//                                           child: const Icon(Icons.close,
//                                               color: Color(0xff2F7DC1)),
//                                         )),
//                                     const SizedBox(height: 20),
//                                     const Text('TREE',
//                                         style: TextStyle(color: Colors.grey)),
//                                     const SizedBox(height: 10),
//                                     Container(
//                                       height: 50,
//                                       decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         //background color of dropdown button
//                                         border: Border.all(
//                                             color: const Color(0xff2F7DC1),
//                                             width: 1),
//                                         //border of dropdown button
//                                         borderRadius: BorderRadius.circular(
//                                             10), //border raiuds of dropdown button
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10),
//                                         child: DropdownButton<String>(
//                                           isExpanded: true,
//                                           value: value5.selectedUserTree,
//                                           onChanged: (String? newValue) {
//                                             value5.selectedUserTree = newValue;
//                                             value5.filterListForDropDown(newValue!);
//                                             value5.enableSecondDropdown();
//                                           },
//                                           icon: const Icon(
//                                               CupertinoIcons.chevron_down),
//                                           items:
//                                           value5.treeList.map((String option) {
//                                             return DropdownMenuItem<String>(
//                                               value: option,
//                                               child: Text(option),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(height: 20),
//                                     if (value5.isSecondDropdownEnabled)
//                                       const Row(
//                                         children: [
//                                           Text('Level',
//                                               style: TextStyle(color: Colors.grey)),
//                                           Spacer(),
//                                           Text('Child Count',
//                                               style: TextStyle(color: Colors.grey)),
//                                           SizedBox(width:100)
//                                         ],
//                                       ),
//                                     const SizedBox(height: 10),
//                                       Row(
//                                         children: [
//                                           Expanded(
//                                             child: Container(
//                                               height: 50,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 border: Border.all(color: const Color(0xff2F7DC1), width: 1),
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                                                 child: DropdownButton<String>(
//                                                   icon: const Icon(CupertinoIcons.chevron_down),
//                                                   value: "RED",
//                                                   onChanged: (newValue) {
//                                                     // value5.valueUpdate(newValue!);
//                                                   },
//                                                   isExpanded: true,
//                                                   items: value5.fullItemList.map((String option) {
//                                                     return DropdownMenuItem<String>(
//                                                       value: option,
//                                                       child: Text(option),
//                                                     );
//                                                   }).toList(),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           const SizedBox(width: 10),
//                                           // Add some spacing
//                                           Expanded(
//                                             child: Container(
//                                               height: 50,
//                                               decoration: BoxDecoration(
//                                                 color: Colors.white,
//                                                 border: Border.all(color: const Color(0xff2F7DC1), width: 1),
//                                                 borderRadius: BorderRadius.circular(10),
//                                               ),
//                                               child: Padding(
//                                                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                                                 child: DropdownButton<int>(
//
//                                                   icon: const Icon(CupertinoIcons.chevron_down),
//                                                   value: value5.selectedChildCountList,
//                                                   onChanged: (newValue) {
//                                                     value5.valueUpdateChildCount(newValue!);
//                                                   },
//                                                   isExpanded: true,
//                                                   items: value5.childCountList.map((int option) {
//                                                     return DropdownMenuItem<int>(
//                                                       value: option,
//                                                       child: Text(option.toString()),
//                                                     );
//                                                   }).toList(),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//
//                                         ],
//                                       ),
//
//                                     const SizedBox(height: 15),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             // value5.clearFilter();
//                                             finish(context);
//                                           },
//                                           child: Container(
//                                             width: 155,
//                                             height: 45,
//                                             padding: const EdgeInsets.only(
//                                                 top: 14, bottom: 15),
//                                             clipBehavior: Clip.antiAlias,
//                                             decoration: ShapeDecoration(
//                                               color: Colors.white,
//                                               shape: RoundedRectangleBorder(
//                                                 side: const BorderSide(
//                                                     width: 0.50,
//                                                     color: Color(0xFF2F7DC1)),
//                                                 borderRadius:
//                                                 BorderRadius.circular(61.71),
//                                               ),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 'Reset',
//                                                 style: TextStyle(
//                                                     color: const Color(0xff2F7DC1),
//                                                     fontSize: MediaQuery.of(context)
//                                                         .size
//                                                         .width /
//                                                         30),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(width: 12),
//                                         InkWell(
//                                           onTap: () {
//                                           value5.filterForSendMessage(value5.selectedUserTree!,value5.selectedUserGrade!,value5. selectedChildCountList);
//                                             finish(context);
//                                           },
//                                           child: Container(
//                                             width: 155,
//                                             height: 45,
//                                             padding: const EdgeInsets.only(
//                                                 top: 14, bottom: 15),
//                                             clipBehavior: Clip.antiAlias,
//                                             decoration: ShapeDecoration(
//                                               color: const Color(0xFF2F7DC1),
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                 BorderRadius.circular(61.71),
//                                               ),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 'Done',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: MediaQuery.of(context)
//                                                         .size
//                                                         .width /
//                                                         30),
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ));
//                         }));
//               })));
//     },
//   );
// }
// void _showTopSheet(BuildContext context) {
//   showGeneralDialog<void>(
//     barrierColor: Colors.black.withOpacity(0.5),
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
//     // barrierColor: Colors.black54,
//     transitionDuration: const Duration(milliseconds: 400),
//     pageBuilder: (BuildContext context, Animation<double> animation,
//         Animation<double> secondaryAnimation) {
//       return Align(
//         alignment: Alignment.topCenter,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Consumer<UserProvider>(
//             builder: (context, value6, child) {
//               return Container(
//
//                 child: Consumer<UserProvider>(
//                   builder: (context, value5, child) {
//                     return Drawer(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(30),
//                             bottomRight: Radius.circular(30)),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // ... your existing widgets
//
//                             if (value5.isSecondDropdownEnabled)
//                               Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       height: value6.isSecondDropdownEnabled ? 330 : 280,
//                                       width: 600,
//                                       decoration: BoxDecoration(
//                                           color: Colors.amber,
//                                           borderRadius: BorderRadius.circular(100),
//                                           border: Border.all(
//                                             color: cl2F7DC1,
//                                             width: 1,
//                                           )),                                      child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10),
//                                         child: DropdownButton<String>(
//                                           icon: const Icon(
//                                             CupertinoIcons.chevron_down,
//                                           ),
//                                           value: value5.selectedUserGrade,
//                                           onChanged: (newValue) {
//                                             value5.valueUpdate(newValue!);
//                                             // Scroll to the top
//                                             _scrollController.animateTo(
//                                               0,
//                                               duration:
//                                               Duration(milliseconds: 300),
//                                               curve: Curves.easeInOut,
//                                             );
//                                           },
//                                           isExpanded: true,
//                                           items: value5.partialItemList
//                                               .map((String option) {
//                                             return DropdownMenuItem<String>(
//                                               value: option,
//                                               child: Text(option),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   // Add some spacing
//                                   Expanded(
//                                     child: Container(
//                                       // ... your existing container properties
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 10),
//                                         child: DropdownButton<int>(
//                                           icon: const Icon(
//                                             CupertinoIcons.chevron_down,
//                                           ),
//                                           value: value5.selectedChildCountList,
//                                           onChanged: (newValue) {
//                                             value5.valueUpdateChildCount(
//                                                 newValue!);
//                                             // Scroll to the top
//                                             _scrollController.animateTo(
//                                               0,
//                                               duration:
//                                               Duration(milliseconds: 300),
//                                               curve: Curves.easeInOut,
//                                             );
//                                           },
//                                           isExpanded: true,
//                                           items: value5.childCountList
//                                               .map((int option) {
//                                             return DropdownMenuItem<int>(
//                                               value: option,
//                                               child: Text(option.toString()),
//                                             );
//                                           }).toList(),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//
//                             // ... your existing widgets
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//     },
//   );
// }
