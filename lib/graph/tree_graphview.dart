import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lio_care/help_tree/tree_provider.dart';
import 'package:provider/provider.dart';

import '../Constants/functions.dart';
import '../Provider/user_provider.dart';
import '../constants/my_colors.dart';
import '../help_tree/help_tree_model.dart';
import '../help_tree/help_tree_page.dart';
import 'GraphView.dart';

class TreeViewPage extends StatefulWidget {
  String fromSection;
  String fromTree;

  TreeViewPage({Key? key, required this.fromSection, required this.fromTree}) : super(key: key);
  @override
  _TreeViewPageState createState() => _TreeViewPageState();
}

class _TreeViewPageState extends State<TreeViewPage> {
  // final viewTransformationController = TransformationController();


  TransformationController _getInitialTransformation() {
    // Calculate the initial transformation matrix for a zoomed-out view
    final matrix = Matrix4.identity();
    const initialScale = 0.18; // Adjust this value for the desired initial zoom level
    matrix.scale(initialScale, initialScale);
    return TransformationController()..value = matrix;
  }
  @override
  Widget build(BuildContext context) {

    print("fromSection  ${widget.fromSection}");
    print("fromTree  ${widget.fromTree}");

    return Scaffold(
      backgroundColor: bck,
        appBar:  AppBar(
          leadingWidth: 18,
          backgroundColor: bck,
          elevation: 0,
          // automaticallyImplyLeading: true,
          leading: InkWell(
              onTap: () {
                finish(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Icon(Icons.arrow_back_ios,color: textColor,),
              )),
          title: InkWell(
            onTap: () {
              finish(context);
            },
            child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child:Image.asset("assets/bluelogo.png",scale: 18,)
              // Text("Leo Care",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Textcolor,fontFamily: "PoppinsRegular"),),
            ),
          ),
        ),
        body: InteractiveViewer(
            // transformationController: viewTransformationController,
            constrained: false,
            // boundaryMargin: const EdgeInsets.all(100),
          trackpadScrollCausesScale: true,
          scaleFactor: 8,
            minScale: 0.1,
            maxScale: .6,
            boundaryMargin: const EdgeInsets.all(20.0),
            transformationController: _getInitialTransformation(),
            child: GraphView(
              graph: graph,
              algorithm: BuchheimWalkerAlgorithm(builder, TreeEdgeRenderer(builder)),
              paint: Paint()
                ..color = Colors.green
                ..strokeWidth = 3
                ..style = PaintingStyle.stroke,
              builder: (Node node) {
                // I can decide what widget should be shown here based on the id
                var a = node.key!.value as int?;
                return rectangleWidget(a);
              },
            )));
  }

  Widget nodes(
      {required List<HelpTreeModel> nodeList,required int index}) {
    UserProvider use=Provider.of<UserProvider>(context,listen: false);

    return Consumer<TreeProvider>(
      builder: (context75,val545,child) {
        return InkWell(
          onTap: () async {
            print(widget.fromSection);
            await val545.fetchTreeUserDetails(nodeList[index].userId,widget.fromTree,context);
            showModalBottomSheet<void>(
              shape: const RoundedRectangleBorder( // <-- SEE HERE
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              context: context,
              builder: (BuildContext context) {
                final width=MediaQuery.of(context).size.width;
                return SizedBox(
                  height: 370,
                  child: Center(
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Consumer<TreeProvider>(
                          builder: (context,val343,child) {
                            return Container(
                              width:width,
                              height: 50,
                              decoration:  BoxDecoration(
                                color: val343.treeUserGrade=="VIOLET"?VIOLET
                                    :val343.treeUserGrade=="INDIGO"?INDIGO
                                    :val343.treeUserGrade=="BLUE"?BLUE
                                    :val343.treeUserGrade=="GREEN"?GREEN
                                    :val343.treeUserGrade=="YELLOW"?YELLOW
                                    :val343.treeUserGrade=="ORANGE"?ORANGE
                                    :val343.treeUserGrade=="RED"?RED
                                    :val343.treeUserGrade=="MASTER ACHIEVER"?MASTERACHIEVER
                                    :val343.treeUserGrade=="STAR"?STAR
                                    :val343.treeUserGrade=="2 STAR"?STAR2
                                    :val343.treeUserGrade=="3 STAR"?STAR3
                                    :val343.treeUserGrade=="4 STAR"?STAR4
                                    :val343.treeUserGrade=="5 STAR"?STAR5
                                    :val343.treeUserGrade=="6 STAR"?STAR6
                                    :val343.treeUserGrade=="7 STAR"?STAR7
                                    :val343.treeUserGrade=="STAR CLUB ACHIEVER"?STARCLUBACHIEVER
                                    :val343.treeUserGrade=="SILVER"?SILVER
                                    :val343.treeUserGrade=="GOLD"?GOLD
                                    :val343.treeUserGrade=="PLATINUM"?PLATINUM
                                    :val343.treeUserGrade=="DIAMOND"?DIAMOND
                                    :val343.treeUserGrade=="ROYAL"?ROYAL
                                    :val343.treeUserGrade=="CROWN"?CROWN
                                    :val343.treeUserGrade=="CROWN CLUB ACHIEVER"?CROWNCLUBACHIEVER
                                    :Colors.grey,
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(25.0),),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x30000000),
                                    blurRadius: 5,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children:[
                                  Image.asset("assets/downArrow.png",scale: 3,),
                                   Text(
                                   val545.treeUserGrade,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: cWhite,
                                      fontSize: 15,
                                      fontFamily: 'PoppinsMedium',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ]
                              ),
                            );
                          }
                        ),
                        const SizedBox(height: 5,),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 8, 12, 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                nodeList[index].userImage!=""?
                                Container(
                                  width: 88,
                                  height: 88,
                                  decoration:  ShapeDecoration(
                                    color: clBABABA,
                                    image: DecorationImage(
                                      image: NetworkImage(nodeList[index].userImage),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: const OvalBorder(),
                                  ),
                                ):
                                Container(
                                  width: 88,
                                  height: 88,
                                  alignment: Alignment.center,
                                  decoration:  const ShapeDecoration(
                                    color: clBABABA,

                                    shape: OvalBorder(),
                                  ),
                                  child: const Icon(Icons.person),
                                ),

                                 Text(
                                  nodeList[index].userName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color:cl252525,
                                    fontSize: 15,
                                    fontFamily: 'PoppinsRegular',
                                    fontWeight: FontWeight.w600,
                                    height: 1.04,
                                  ),
                                ),

                                Container(

                                  width: 372,
                                  // height: 93,
                                  padding: const EdgeInsets.all( 10),
                                  alignment: Alignment.center,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFFDF8F4),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                    ),
                                  ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child:const Text(
                                              'ID',
                                              style: TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                        ),
                                      ),
                                      const SizedBox(width:5),
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              nodeList[index].userId,
                                              style: const TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child:const Text(
                                              'Phone',
                                              style: TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                        ),
                                      ),
                                      const SizedBox(width:5),
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                widget.fromSection=="USER"
                                              ?"****${nodeList[index].userPhone.substring(4)}"
                                              :nodeList[index].userPhone,
                                              style: const TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child:const Text(
                                              'Referred By',
                                              style: TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                        ),
                                      ),
                                      const SizedBox(width:5),
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              val545.treeUserTreeReferredBy,
                                              style: const TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 2,
                                            )
                                        ),
                                      ),
                                    ],
                                  ),

                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              child:const Text(
                                                'Referred Number',
                                                style: TextStyle(
                                                  color: cl434343,
                                                  fontSize: 15,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                          ),
                                        ),
                                        const SizedBox(width:5),
                                        Expanded(
                                          flex:1,
                                          child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                widget.fromSection=="USER"
                                                    ?"****${val545.treeUserTreeReferredNumber.substring(4)}"
                                                    :val545.treeUserTreeReferredNumber,
                                                style: const TextStyle(
                                                  color: cl434343,
                                                  fontSize: 15,
                                                  fontFamily: 'PoppinsRegular',
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              )
                                          ),
                                        ),
                                      ],
                                    ),

                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child:const Text(
                                              'Earnings',
                                              style: TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                        ),
                                      ),
                                      const SizedBox(width:5),
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              val545.treeUserTreeEarnings,
                                              style: const TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                              maxLines: 2,
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child:const Text(
                                              'Join Date',
                                              style: TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                        ),
                                      ),
                                      const SizedBox(width:5),
                                      Expanded(
                                        flex:1,
                                        child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              val545.treeUserRegDate,
                                              style: const TextStyle(
                                                color: cl434343,
                                                fontSize: 15,
                                                fontFamily: 'PoppinsRegular',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                        ),
                                      ),
                                    ],
                                  ),
                                ],),
                                )

                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: 220,
padding: const EdgeInsets.only(right: 5),
margin:nodeList[index].userId==
          use.registerID
          ?const EdgeInsets.only(left: 25):const EdgeInsets.only(left: 0) ,
            decoration: ShapeDecoration(
              color:nodeList[index].userId==
                  use.registerID
                ? const Color(0xFFFF731D):Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                  topLeft: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                ),
              ),
              shadows: const [
                BoxShadow(
                  color: Color(0x26000000),
                  blurRadius: 11,
                  offset: Offset(2, 3),
                  spreadRadius: 0,
                )
              ],
            ),
            child: nodeList.isNotEmpty
                ?Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                nodeList[index].userImage!=""? CircleAvatar(radius: 22,backgroundImage: NetworkImage(nodeList[index].userImage),)
                    :const CircleAvatar(radius: 22,backgroundColor: Color(0xFFD0E9FF), child: Center(child: Icon(Icons.person),)),
             const SizedBox(width: 10,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    SizedBox(
                      width: 150,
                      child: Text(nodeList[index].userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,

                        style: TextStyle(
                        color:nodeList[index].userId==
                            use.registerID
                              ? Colors.white:Colors.black,

                        fontSize: 15,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w600,
                      ),),
                    ),
                    SizedBox(
                      width: 130,

                      child: Text(
                        widget.fromSection=="USER"
                            ?"****${nodeList[index].userPhone.substring(4)}"
                            :nodeList[index].userPhone, style: TextStyle(
                        color:nodeList[index].userId==
                            use.registerID
                              ? Colors.white:Colors.black,
                        fontSize: 10,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.w400,
                      ),),
                    ),
                  ],
                ),


              ],
            )
                :const SizedBox(),
          ),
        );
      }
    );

  }



  Random r = Random();
  final List<Color> colors = <Color>[Colors.red, Colors.blue,Colors.amber];
  Widget rectangleWidget(int? a) {
    return InkWell(
      onTap: () {
        print('Node ${a}');
      },
      child: Consumer<TreeProvider>(
        builder: (context2,value2,child) {

          switch (a) {
            case 1:
             return nodes(nodeList: value2.level0, index: 0);

            case 2:
              return nodes(nodeList: value2.level1, index: 0);

            case 3:
              return nodes(nodeList: value2.level1, index: 1);

            case 4:
              return nodes(nodeList: value2.level21, index: 0);

            case 5:
              return nodes(nodeList: value2.level21, index: 1);

            case 6:
              return nodes(nodeList: value2.level22, index: 0);

            case 7:
              return nodes(nodeList: value2.level22, index: 1);

            case 8:
              return nodes(nodeList: value2.level31, index: 0);

            case 9:
              return nodes(nodeList: value2.level31, index: 1);

            case 10:
              return nodes(nodeList: value2.level32, index: 0);

            case 11:
              return nodes(nodeList: value2.level32, index: 1);

            case 12:
              return nodes(nodeList: value2.level33, index: 0);

            case 13:
              return nodes(nodeList: value2.level33, index: 1);

            case 14:
              return nodes(nodeList: value2.level34, index: 0);

            case 15:
              return nodes(nodeList: value2.level34, index: 1);

            case 16:
              return nodes(nodeList: value2.level41, index: 0);

            case 17:
              return nodes(nodeList: value2.level41, index: 1);

            case 18:
              return nodes(nodeList: value2.level42, index: 0);

            case 19:
              return nodes(nodeList: value2.level42, index: 1);

            case 20:
              return nodes(nodeList: value2.level43, index: 0);

            case 21:
              return nodes(nodeList: value2.level43, index: 1);

            case 22:
              return nodes(nodeList: value2.level44, index: 0);

            case 23:
              return nodes(nodeList: value2.level44, index: 1);

            case 24:
              return nodes(nodeList: value2.level45, index: 0);

            case 25:
              return nodes(nodeList: value2.level45, index: 1);

            case 26:
              return nodes(nodeList: value2.level46, index: 0);

            case 27:
              return nodes(nodeList: value2.level46, index: 1);

            case 28:
              return nodes(nodeList: value2.level47, index: 0);

            case 29:
              return nodes(nodeList: value2.level47, index: 1);

            case 30:
              return nodes(nodeList: value2.level48, index: 0);

            case 31:
              return nodes(nodeList: value2.level48, index: 1);

            case 32:
              return nodes(nodeList: value2.level51, index: 0);

            case 33:
              return nodes(nodeList: value2.level51, index: 1);

            case 34:
              return nodes(nodeList: value2.level52, index: 0);

            case 35:
              return nodes(nodeList: value2.level52, index: 1);

            case 36:
              return nodes(nodeList: value2.level53, index: 0);

            case 37:
              return nodes(nodeList: value2.level53, index: 1);

            case 38:
              return nodes(nodeList: value2.level54, index: 0);

            case 39:
              return nodes(nodeList: value2.level54, index: 1);

            case 40:
              return nodes(nodeList: value2.level55, index: 0);

            case 41:
              return nodes(nodeList: value2.level55, index: 1);

            case 42:
              return nodes(nodeList: value2.level56, index: 0);

            case 43:
              return nodes(nodeList: value2.level56, index: 1);

            case 44:
              return nodes(nodeList: value2.level57, index: 0);

            case 45:
              return nodes(nodeList: value2.level57, index: 1);

            case 46:
              return nodes(nodeList: value2.level58, index: 0);

            case 47:
              return nodes(nodeList: value2.level58, index: 1);

            case 48:
              return nodes(nodeList: value2.level59, index: 0);

            case 49:
              return nodes(nodeList: value2.level59, index: 1);

            case 50:
              return nodes(nodeList: value2.level510, index: 0);

            case 51:
              return nodes(nodeList: value2.level510, index: 1);

            case 52:
              return nodes(nodeList: value2.level511, index: 0);

            case 53:
              return nodes(nodeList: value2.level511, index: 1);

            case 54:
              return nodes(nodeList: value2.level512, index: 0);

            case 55:
              return nodes(nodeList: value2.level512, index: 1);

            case 56:
              return nodes(nodeList: value2.level513, index: 0);

            case 57:
              return nodes(nodeList: value2.level513, index: 1);

            case 58:
              return nodes(nodeList: value2.level514, index: 0);

            case 59:
              return nodes(nodeList: value2.level514, index: 1);

            case 60:
              return nodes(nodeList: value2.level515, index: 0);

            case 61:
              return nodes(nodeList: value2.level515, index: 1);

            case 62:
              return nodes(nodeList: value2.level516, index: 0);

            case 63:
              return nodes(nodeList: value2.level516, index: 1);

            case 64:
              return nodes(nodeList: value2.level61, index: 0);

            case 65:
              return nodes(nodeList: value2.level61, index: 1);

            case 66:
              return nodes(nodeList: value2.level62, index: 0);

            case 67:
              return nodes(nodeList: value2.level62, index: 1);

            case 68:
              return nodes(nodeList: value2.level63, index: 0);

            case 69:
              return nodes(nodeList: value2.level63, index: 1);

            case 70:
              return nodes(nodeList: value2.level64, index: 0);

            case 71:
              return nodes(nodeList: value2.level64, index: 1);

            case 72:
              return nodes(nodeList: value2.level65, index: 0);

            case 73:
              return nodes(nodeList: value2.level65, index: 1);

            case 74:
              return nodes(nodeList: value2.level66, index: 0);

            case 75:
              return nodes(nodeList: value2.level66, index: 1);

            case 76:
              return nodes(nodeList: value2.level67, index: 0);

            case 77:
              return nodes(nodeList: value2.level67, index: 1);

            case 78:
              return nodes(nodeList: value2.level68, index: 0);

            case 79:
              return nodes(nodeList: value2.level68, index: 1);

            case 80:
              return nodes(nodeList: value2.level69, index: 0);

            case 81:
              return nodes(nodeList: value2.level69, index: 1);

            case 82:
              return nodes(nodeList: value2.level610, index: 0);

            case 83:
              return nodes(nodeList: value2.level610, index: 1);

            case 84:
              return nodes(nodeList: value2.level611, index: 0);

            case 85:
              return nodes(nodeList: value2.level611, index: 1);

            case 86:
              return nodes(nodeList: value2.level612, index: 0);

            case 87:
              return nodes(nodeList: value2.level612, index: 1);

            case 88:
              return nodes(nodeList: value2.level613, index: 0);

            case 89:
              return nodes(nodeList: value2.level613, index: 1);

            case 90:
              return nodes(nodeList: value2.level614, index: 0);

            case 91:
              return nodes(nodeList: value2.level614, index: 1);

            case 92:
              return nodes(nodeList: value2.level615, index: 0);

            case 93:
              return nodes(nodeList: value2.level615, index: 1);

            case 94:
              return nodes(nodeList: value2.level616, index: 0);

            case 95:
              return nodes(nodeList: value2.level616, index: 1);

            case 96:
              return nodes(nodeList: value2.level617, index: 0);

            case 97:
              return nodes(nodeList: value2.level617, index: 1);

            case 98:
              return nodes(nodeList: value2.level618, index: 0);

            case 99:
              return nodes(nodeList: value2.level618, index: 1);

            case 100:
              return nodes(nodeList: value2.level619, index: 0);

            case 101:
              return nodes(nodeList: value2.level619, index: 1);

            case 102:
              return nodes(nodeList: value2.level620, index: 0);

            case 103:
              return nodes(nodeList: value2.level620, index: 1);

            case 104:
              return nodes(nodeList: value2.level621, index: 0);

            case 105:
              return nodes(nodeList: value2.level621, index: 1);

            case 106:
              return nodes(nodeList: value2.level622, index: 0);

            case 107:
              return nodes(nodeList: value2.level622, index: 1);

            case 108:
              return nodes(nodeList: value2.level623, index: 0);

            case 109:
              return nodes(nodeList: value2.level623, index: 1);

            case 110:
              return nodes(nodeList: value2.level624, index: 0);

            case 111:
              return nodes(nodeList: value2.level624, index: 1);

            case 112:
              return nodes(nodeList: value2.level625, index: 0);

            case 113:
              return nodes(nodeList: value2.level625, index: 1);

            case 114:
              return nodes(nodeList: value2.level626, index: 0);

            case 115:
              return nodes(nodeList: value2.level626, index: 1);

            case 116:
              return nodes(nodeList: value2.level627, index: 0);

            case 117:
              return nodes(nodeList: value2.level627, index: 1);

            case 118:
              return nodes(nodeList: value2.level628, index: 0);

            case 119:
              return nodes(nodeList: value2.level628, index: 1);

            case 120:
              return nodes(nodeList: value2.level629, index: 0);

            case 121:
              return nodes(nodeList: value2.level629, index: 1);

            case 122:
              return nodes(nodeList: value2.level630, index: 0);

            case 123:
              return nodes(nodeList: value2.level630, index: 1);

            case 124:
              return nodes(nodeList: value2.level631, index: 0);

            case 125:
              return nodes(nodeList: value2.level631, index: 1);

            case 126:
              return nodes(nodeList: value2.level632, index: 0);

            case 127:
              return nodes(nodeList: value2.level632, index: 1);

            case 128:
              return nodes(nodeList: value2.level71, index: 0);

            case 129:
              return nodes(nodeList: value2.level71, index: 1);

            case 130:
              return nodes(nodeList: value2.level72, index: 0);

            case 131:
              return nodes(nodeList: value2.level72, index: 1);

            case 132:
              return nodes(nodeList: value2.level73, index: 0);

            case 133:
              return nodes(nodeList: value2.level73, index: 1);

            case 134:
              return nodes(nodeList: value2.level74, index: 0);

            case 135:
              return nodes(nodeList: value2.level74, index: 1);

            case 136:
              return nodes(nodeList: value2.level75, index: 0);

            case 137:
              return nodes(nodeList: value2.level75, index: 1);

            case 138:
              return nodes(nodeList: value2.level76, index: 0);

            case 139:
              return nodes(nodeList: value2.level76, index: 1);

            case 140:
              return nodes(nodeList: value2.level77, index: 0);

            case 141:
              return nodes(nodeList: value2.level77, index: 1);

            case 142:
              return nodes(nodeList: value2.level78, index: 0);

            case 143:
              return nodes(nodeList: value2.level78, index: 1);

            case 144:
              return nodes(nodeList: value2.level79, index: 0);

            case 145:
              return nodes(nodeList: value2.level79, index: 1);

            case 146:
              return nodes(nodeList: value2.level710, index: 0);

            case 147:
              return nodes(nodeList: value2.level710, index: 1);

            case 148:
              return nodes(nodeList: value2.level711, index: 0);

            case 149:
              return nodes(nodeList: value2.level711, index: 1);

            case 150:
              return nodes(nodeList: value2.level712, index: 0);

            case 151:
              return nodes(nodeList: value2.level712, index: 1);

            case 152:
              return nodes(nodeList: value2.level713, index: 0);

            case 153:
              return nodes(nodeList: value2.level713, index: 1);

            case 154:
              return nodes(nodeList: value2.level714, index: 0);

            case 155:
              return nodes(nodeList: value2.level714, index: 1);

            case 156:
              return nodes(nodeList: value2.level715, index: 0);

            case 157:
              return nodes(nodeList: value2.level715, index: 1);

            case 158:
              return nodes(nodeList: value2.level716, index: 0);

            case 159:
              return nodes(nodeList: value2.level716, index: 1);

            case 160:
              return nodes(nodeList: value2.level717, index: 0);

            case 161:
              return nodes(nodeList: value2.level717, index: 1);

            case 162:
              return nodes(nodeList: value2.level718, index: 0);

            case 163:
              return nodes(nodeList: value2.level718, index: 1);

            case 164:
              return nodes(nodeList: value2.level719, index: 0);

            case 165:
              return nodes(nodeList: value2.level719, index: 1);

            case 166:
              return nodes(nodeList: value2.level720, index: 0);

            case 167:
              return nodes(nodeList: value2.level720, index: 1);

            case 168:
              return nodes(nodeList: value2.level721, index: 0);

            case 169:
              return nodes(nodeList: value2.level721, index: 1);

            case 170:
              return nodes(nodeList: value2.level722, index: 0);

            case 171:
              return nodes(nodeList: value2.level722, index: 1);

            case 172:
              return nodes(nodeList: value2.level723, index: 0);

            case 173:
              return nodes(nodeList: value2.level723, index: 1);

            case 174:
              return nodes(nodeList: value2.level724, index: 0);

            case 175:
              return nodes(nodeList: value2.level724, index: 1);

            case 176:
              return nodes(nodeList: value2.level725, index: 0);

            case 177:
              return nodes(nodeList: value2.level725, index: 1);

            case 178:
              return nodes(nodeList: value2.level726, index: 0);

            case 179:
              return nodes(nodeList: value2.level726, index: 1);

            case 180:
              return nodes(nodeList: value2.level727, index: 0);

            case 181:
              return nodes(nodeList: value2.level727, index: 1);

            case 182:
              return nodes(nodeList: value2.level728, index: 0);

            case 183:
              return nodes(nodeList: value2.level728, index: 1);

            case 184:
              return nodes(nodeList: value2.level729, index: 0);

            case 185:
              return nodes(nodeList: value2.level729, index: 1);

            case 186:
              return nodes(nodeList: value2.level730, index: 0);

            case 187:
              return nodes(nodeList: value2.level730, index: 1);

            case 188:
              return nodes(nodeList: value2.level731, index: 0);

            case 189:
              return nodes(nodeList: value2.level731, index: 1);

            case 190:
              return nodes(nodeList: value2.level732, index: 0);

            case 191:
              return nodes(nodeList: value2.level732, index: 1);

            case 192:
              return nodes(nodeList: value2.level733, index: 0);

            case 193:
              return nodes(nodeList: value2.level733, index: 1);

            case 194:
              return nodes(nodeList: value2.level734, index: 0);

            case 195:
              return nodes(nodeList: value2.level734, index: 1);

            case 196:
              return nodes(nodeList: value2.level735, index: 0);

            case 197:
              return nodes(nodeList: value2.level735, index: 1);

            case 198:
              return nodes(nodeList: value2.level736, index: 0);

            case 199:
              return nodes(nodeList: value2.level736, index: 1);

            case 200:
              return nodes(nodeList: value2.level737, index: 0);

            case 201:
              return nodes(nodeList: value2.level737, index: 1);

            case 202:
              return nodes(nodeList: value2.level738, index: 0);

            case 203:
              return nodes(nodeList: value2.level738, index: 1);

            case 204:
              return nodes(nodeList: value2.level739, index: 0);

            case 205:
              return nodes(nodeList: value2.level739, index: 1);

            case 206:
              return nodes(nodeList: value2.level740, index: 0);

            case 207:
              return nodes(nodeList: value2.level740, index: 1);

            case 208:
              return nodes(nodeList: value2.level741, index: 0);

            case 209:
              return nodes(nodeList: value2.level741, index: 1);

            case 210:
              return nodes(nodeList: value2.level742, index: 0);

            case 211:
              return nodes(nodeList: value2.level742, index: 1);

            case 212:
              return nodes(nodeList: value2.level743, index: 0);

            case 213:
              return nodes(nodeList: value2.level743, index: 1);

            case 214:
              return nodes(nodeList: value2.level744, index: 0);

            case 215:
              return nodes(nodeList: value2.level744, index: 1);

            case 216:
              return nodes(nodeList: value2.level745, index: 0);

            case 217:
              return nodes(nodeList: value2.level745, index: 1);

            case 218:
              return nodes(nodeList: value2.level746, index: 0);

            case 219:
              return nodes(nodeList: value2.level746, index: 1);

            case 220:
              return nodes(nodeList: value2.level747, index: 0);

            case 221:
              return nodes(nodeList: value2.level747, index: 1);

            case 222:
              return nodes(nodeList: value2.level748, index: 0);

            case 223:
              return nodes(nodeList: value2.level748, index: 1);

            case 224:
              return nodes(nodeList: value2.level749, index: 0);

            case 225:
              return nodes(nodeList: value2.level749, index: 1);

            case 226:
              return nodes(nodeList: value2.level750, index: 0);

            case 227:
              return nodes(nodeList: value2.level750, index: 1);

            case 228:
              return nodes(nodeList: value2.level751, index: 0);

            case 229:
              return nodes(nodeList: value2.level751, index: 1);

            case 230:
              return nodes(nodeList: value2.level752, index: 0);

            case 231:
              return nodes(nodeList: value2.level752, index: 1);

            case 232:
              return nodes(nodeList: value2.level753, index: 0);

            case 233:
              return nodes(nodeList: value2.level753, index: 1);

            case 234:
              return nodes(nodeList: value2.level754, index: 0);

            case 235:
              return nodes(nodeList: value2.level754, index: 1);

            case 236:
              return nodes(nodeList: value2.level755, index: 0);

            case 237:
              return nodes(nodeList: value2.level755, index: 1);

            case 238:
              return nodes(nodeList: value2.level756, index: 0);

            case 239:
              return nodes(nodeList: value2.level756, index: 1);

            case 240:
              return nodes(nodeList: value2.level757, index: 0);

            case 241:
              return nodes(nodeList: value2.level757, index: 1);

            case 242:
              return nodes(nodeList: value2.level758, index: 0);

            case 243:
              return nodes(nodeList: value2.level758, index: 1);

            case 244:
              return nodes(nodeList: value2.level759, index: 0);

            case 245:
              return nodes(nodeList: value2.level759, index: 1);

            case 246:
              return nodes(nodeList: value2.level760, index: 0);

            case 247:
              return nodes(nodeList: value2.level760, index: 1);

            case 248:
              return nodes(nodeList: value2.level761, index: 0);

            case 249:
              return nodes(nodeList: value2.level761, index: 1);

            case 250:
              return nodes(nodeList: value2.level762, index: 0);

            case 251:
              return nodes(nodeList: value2.level762, index: 1);

            case 252:
              return nodes(nodeList: value2.level763, index: 0);

            case 253:
              return nodes(nodeList: value2.level763, index: 1);

            case 254:
              return nodes(nodeList: value2.level764, index: 0);

            case 255:
              return nodes(nodeList: value2.level764, index: 1);

             default:
              return Container(
                child: const Center(
                  child: Text("Bir şeyler ters gitti!"),
                ),
              );
          }


          if (a==1) {
            return nodes(nodeList: value2.level0, index: 0);
          } else if (a==3){
            return nodes(nodeList: value2.level1, index: 0);
          }else {
            return nodes(nodeList: value2.level1, index: 1);
          }
        }
        //   return Container(
        //       padding: const EdgeInsets.all(16),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(15),
        //         boxShadow: [
        //           BoxShadow(color: colors[a!%3], spreadRadius: 1),
        //         ],
        //       ),
        //       child: Text('${}'));
        // }
      ),
    );
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override

  void initState() {
    // final zoomFactor = 1.0;
    // final xTranslate = 300.0;
    // final yTranslate = 300.0;
    // viewTransformationController.value.setEntry(0, 0, zoomFactor);
    // viewTransformationController.value.setEntry(1, 1, zoomFactor);
    // viewTransformationController.value.setEntry(2, 2, zoomFactor);
    // viewTransformationController.value.setEntry(0, 3, -xTranslate);
    // viewTransformationController.value.setEntry(1, 3, -yTranslate);
    TreeProvider user=Provider.of<TreeProvider>(context,listen: false);
    super.initState();
    final node1 = Node.Id(1);
     final node2 = Node.Id(2);
     final node3 = Node.Id(3);
     final node4 = Node.Id(4);
     final node5 = Node.Id(5);
     final node6 = Node.Id(6);
     final node7 = Node.Id(7);
     final node8 = Node.Id(8);
     final node9 = Node.Id(9);
     final node10 = Node.Id(10);
     final node11 = Node.Id(11);
     final node12 = Node.Id(12);
     final node13 = Node.Id(13);
     final node14 = Node.Id(14);
     final node15 = Node.Id(15);
     final node16 = Node.Id(16);
     final node17 = Node.Id(17);
     final node18 = Node.Id(18);
     final node19 = Node.Id(19);
     final node20 = Node.Id(20);
     final node21 = Node.Id(21);
     final node22 = Node.Id(22);
     final node23 = Node.Id(23);
     final node24 = Node.Id(24);
     final node25 = Node.Id(25);
     final node26 = Node.Id(26);
     final node27 = Node.Id(27);
     final node28 = Node.Id(28);
     final node29 = Node.Id(29);
     final node30 = Node.Id(30);
     final node31 = Node.Id(31);
     final node32 = Node.Id(32);
     final node33 = Node.Id(33);
     final node34 = Node.Id(34);
     final node35 = Node.Id(35);
     final node36 = Node.Id(36);
     final node37 = Node.Id(37);
     final node38 = Node.Id(38);
     final node39 = Node.Id(39);
     final node40 = Node.Id(40);
     final node41 = Node.Id(41);
     final node42 = Node.Id(42);
     final node43 = Node.Id(43);
     final node44 = Node.Id(44);
     final node45 = Node.Id(45);
     final node46 = Node.Id(46);
     final node47 = Node.Id(47);
     final node48 = Node.Id(48);
     final node49 = Node.Id(49);
     final node50 = Node.Id(50);
     final node51 = Node.Id(51);
     final node52 = Node.Id(52);
     final node53 = Node.Id(53);
     final node54 = Node.Id(54);
     final node55 = Node.Id(55);
     final node56 = Node.Id(56);
     final node57 = Node.Id(57);
     final node58 = Node.Id(58);
     final node59 = Node.Id(59);
     final node60 = Node.Id(60);
     final node61 = Node.Id(61);
     final node62 = Node.Id(62);
     final node63 = Node.Id(63);
     final node64 = Node.Id(64);
     final node65 = Node.Id(65);
     final node66 = Node.Id(66);
     final node67 = Node.Id(67);
     final node68 = Node.Id(68);
     final node69 = Node.Id(69);
     final node70 = Node.Id(70);
     final node71 = Node.Id(71);
     final node72 = Node.Id(72);
     final node73 = Node.Id(73);
     final node74 = Node.Id(74);
     final node75 = Node.Id(75);
     final node76 = Node.Id(76);
     final node77 = Node.Id(77);
     final node78 = Node.Id(78);
     final node79 = Node.Id(79);
     final node80 = Node.Id(80);
     final node81 = Node.Id(81);
     final node82 = Node.Id(82);
     final node83 = Node.Id(83);
     final node84 = Node.Id(84);
     final node85 = Node.Id(85);
     final node86 = Node.Id(86);
     final node87 = Node.Id(87);
     final node88 = Node.Id(88);
     final node89 = Node.Id(89);
     final node90 = Node.Id(90);
     final node91 = Node.Id(91);
     final node92 = Node.Id(92);
     final node93 = Node.Id(93);
     final node94 = Node.Id(94);
     final node95 = Node.Id(95);
     final node96 = Node.Id(96);
     final node97 = Node.Id(97);
     final node98 = Node.Id(98);
     final node99 = Node.Id(99);
     final node100 = Node.Id(100);
     final node101 = Node.Id(101);
     final node102 = Node.Id(102);
     final node103 = Node.Id(103);
     final node104 = Node.Id(104);
     final node105 = Node.Id(105);
     final node106 = Node.Id(106);
     final node107 = Node.Id(107);
     final node108 = Node.Id(108);
     final node109 = Node.Id(109);
     final node110 = Node.Id(110);
     final node111 = Node.Id(111);
     final node112 = Node.Id(112);
     final node113 = Node.Id(113);
     final node114 = Node.Id(114);
     final node115 = Node.Id(115);
     final node116 = Node.Id(116);
     final node117 = Node.Id(117);
     final node118 = Node.Id(118);
     final node119 = Node.Id(119);
     final node120 = Node.Id(120);
     final node121 = Node.Id(121);
     final node122 = Node.Id(122);
     final node123 = Node.Id(123);
     final node124 = Node.Id(124);
     final node125 = Node.Id(125);
     final node126 = Node.Id(126);
     final node127 = Node.Id(127);
     final node128 = Node.Id(128);
     final node129 = Node.Id(129);
     final node130 = Node.Id(130);
     final node131 = Node.Id(131);
     final node132 = Node.Id(132);
     final node133 = Node.Id(133);
     final node134 = Node.Id(134);
     final node135 = Node.Id(135);
     final node136 = Node.Id(136);
     final node137 = Node.Id(137);
     final node138 = Node.Id(138);
     final node139 = Node.Id(139);
     final node140 = Node.Id(140);
     final node141 = Node.Id(141);
     final node142 = Node.Id(142);
     final node143 = Node.Id(143);
     final node144 = Node.Id(144);
     final node145 = Node.Id(145);
     final node146 = Node.Id(146);
     final node147 = Node.Id(147);
     final node148 = Node.Id(148);
     final node149 = Node.Id(149);
     final node150 = Node.Id(150);
     final node151 = Node.Id(151);
     final node152 = Node.Id(152);
     final node153 = Node.Id(153);
     final node154 = Node.Id(154);
     final node155 = Node.Id(155);
     final node156 = Node.Id(156);
     final node157 = Node.Id(157);
     final node158 = Node.Id(158);
     final node159 = Node.Id(159);
     final node160 = Node.Id(160);
     final node161 = Node.Id(161);
     final node162 = Node.Id(162);
     final node163 = Node.Id(163);
     final node164 = Node.Id(164);
     final node165 = Node.Id(165);
     final node166 = Node.Id(166);
     final node167 = Node.Id(167);
     final node168 = Node.Id(168);
     final node169 = Node.Id(169);
     final node170 = Node.Id(170);
     final node171 = Node.Id(171);
     final node172 = Node.Id(172);
     final node173 = Node.Id(173);
     final node174 = Node.Id(174);
     final node175 = Node.Id(175);
     final node176 = Node.Id(176);
     final node177 = Node.Id(177);
     final node178 = Node.Id(178);
     final node179 = Node.Id(179);
     final node180 = Node.Id(180);
     final node181 = Node.Id(181);
     final node182 = Node.Id(182);
     final node183 = Node.Id(183);
     final node184 = Node.Id(184);
     final node185 = Node.Id(185);
     final node186 = Node.Id(186);
     final node187 = Node.Id(187);
     final node188 = Node.Id(188);
     final node189 = Node.Id(189);
     final node190 = Node.Id(190);
     final node191 = Node.Id(191);
     final node192 = Node.Id(192);
     final node193 = Node.Id(193);
     final node194 = Node.Id(194);
     final node195 = Node.Id(195);
     final node196 = Node.Id(196);
     final node197 = Node.Id(197);
     final node198 = Node.Id(198);
     final node199 = Node.Id(199);
     final node200 = Node.Id(200);
     final node201 = Node.Id(201);
     final node202 = Node.Id(202);
     final node203 = Node.Id(203);
     final node204 = Node.Id(204);
     final node205 = Node.Id(205);
     final node206 = Node.Id(206);
     final node207 = Node.Id(207);
     final node208 = Node.Id(208);
     final node209 = Node.Id(209);
     final node210 = Node.Id(210);
     final node211 = Node.Id(211);
     final node212 = Node.Id(212);
     final node213 = Node.Id(213);
     final node214 = Node.Id(214);
     final node215 = Node.Id(215);
     final node216 = Node.Id(216);
     final node217 = Node.Id(217);
     final node218 = Node.Id(218);
     final node219 = Node.Id(219);
     final node220 = Node.Id(220);
     final node221 = Node.Id(221);
     final node222 = Node.Id(222);
     final node223 = Node.Id(223);
     final node224 = Node.Id(224);
     final node225 = Node.Id(225);
     final node226 = Node.Id(226);
     final node227 = Node.Id(227);
     final node228 = Node.Id(228);
     final node229 = Node.Id(229);
     final node230 = Node.Id(230);
     final node231 = Node.Id(231);
     final node232 = Node.Id(232);
     final node233 = Node.Id(233);
     final node234 = Node.Id(234);
     final node235 = Node.Id(235);
     final node236 = Node.Id(236);
     final node237 = Node.Id(237);
     final node238 = Node.Id(238);
     final node239 = Node.Id(239);
     final node240 = Node.Id(240);
     final node241 = Node.Id(241);
     final node242 = Node.Id(242);
     final node243 = Node.Id(243);
     final node244 = Node.Id(244);
     final node245 = Node.Id(245);
     final node246 = Node.Id(246);
     final node247 = Node.Id(247);
     final node248 = Node.Id(248);
     final node249 = Node.Id(249);
     final node250 = Node.Id(250);
     final node251 = Node.Id(251);
     final node252 = Node.Id(252);
     final node253 = Node.Id(253);
     final node254 = Node.Id(254);
     final node255 = Node.Id(255);


    if(user.level1.isNotEmpty){
      graph.addEdge(node1, node2,paint: Paint()..color = const Color(0xff9400D3));
      if(user.level21.isNotEmpty){
        graph.addEdge(node2, node4,paint: Paint()..color = const Color(0xff4B0082));
        if(user.level31.isNotEmpty){
          graph.addEdge(node4, node8,paint: Paint()..color = const Color(0xff0000FF));
          if(user.level41.isNotEmpty){
            graph.addEdge(node8, node16,paint: Paint()..color =const Color(0xff00FF00) );
            if(user.level51.isNotEmpty){
              graph.addEdge(node16, node32,paint: Paint()..color = const Color(0xffFFFF00));
              if(user.level61.isNotEmpty){
                graph.addEdge(node32, node64,paint: Paint()..color = const Color(0xffFF7F00));
                if(user.level71.isNotEmpty){
                  graph.addEdge(node64, node128,paint: Paint()..color =  const Color(0xffFF0000));
                  if(user.level71.length>1){
                    graph.addEdge(node64, node129,paint: Paint()..color =const Color(0xffFF0000));
                  }
                }
                if(user.level61.length>1){
                  graph.addEdge(node32, node65,paint: Paint()..color = const Color(0xffFF7F00));
                  if(user.level72.isNotEmpty){
                    graph.addEdge(node65, node130,paint: Paint()..color =const Color(0xffFF0000));
                    if(user.level72.length>1){
                      graph.addEdge(node65, node131,paint: Paint()..color =const Color(0xffFF0000));
                    }
                  }
                }
              }
              if(user.level51.length>1){
                graph.addEdge(node16, node33,paint: Paint()..color = const Color(0xffFFFF00));
                if(user.level62.isNotEmpty){
                  graph.addEdge(node33, node66,paint: Paint()..color = const Color(0xffFF7F00));
                  if(user.level73.isNotEmpty){
                    graph.addEdge(node66, node132,paint: Paint()..color =const Color(0xffFF0000));
                    if(user.level73.length>1){
                      graph.addEdge(node66, node133,paint: Paint()..color =const Color(0xffFF0000));
                    }
                  }
                  if(user.level62.length>1){
                    graph.addEdge(node33, node67,paint: Paint()..color = const Color(0xffFF7F00));
                    if(user.level74.isNotEmpty){
                      graph.addEdge(node67, node134,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level74.length>1){
                        graph.addEdge(node67, node135,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }

                  }
                }
              }
            }
            if(user.level41.length>1){
              graph.addEdge(node8, node17,paint: Paint()..color = const Color(0xff00FF00));
              if(user.level52.isNotEmpty){
                graph.addEdge(node17, node34,paint: Paint()..color =const Color(0xffFFFF00));
                if(user.level63.isNotEmpty){
                  graph.addEdge(node34, node68,paint: Paint()..color = const Color(0xffFF7F00));
                  if(user.level75.isNotEmpty){
                    graph.addEdge(node68, node136,paint: Paint()..color =const Color(0xffFF0000));
                    if(user.level75.length>1){
                      graph.addEdge(node68, node137,paint: Paint()..color =const Color(0xffFF0000));
                    }
                  }
                  if(user.level63.length>1){
                    graph.addEdge(node34, node69,paint: Paint()..color = const Color(0xffFF7F00));
                    if(user.level76.isNotEmpty){
                      graph.addEdge(node69, node138,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level76.length>1){
                        graph.addEdge(node69, node139,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                  }
                }
                if(user.level52.length>1){
                  graph.addEdge(node17, node35,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level64.isNotEmpty){
                    graph.addEdge(node35, node70,paint: Paint()..color = const Color(0xffFF7F00));
                    if(user.level77.isNotEmpty){
                      graph.addEdge(node70, node140,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level77.length>1){
                        graph.addEdge(node70, node141,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level64.length>1){
                      graph.addEdge(node35, node71,paint: Paint()..color =const Color(0xffFF7F00));
                      if(user.level78.isNotEmpty){
                        graph.addEdge(node71, node142,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level78.length>1){
                          graph.addEdge(node71, node143,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }

                }
              }

            }
          }
          if(user.level31.length>1){
            graph.addEdge(node4, node9,paint: Paint()..color = const Color(0xff0000FF));
            if(user.level42.isNotEmpty){
              graph.addEdge(node9, node18,paint: Paint()..color = const Color(0xff00FF00));
              if(user.level53.isNotEmpty){
                graph.addEdge(node18, node36,paint: Paint()..color = const Color(0xffFFFF00));
                if(user.level65.isNotEmpty){
                  graph.addEdge(node36, node72,paint: Paint()..color = const Color(0xffFF7F00));
                  if(user.level79.isNotEmpty){
                    graph.addEdge(node72, node144,paint: Paint()..color =const Color(0xffFF0000));
                    if(user.level79.length>1){
                      graph.addEdge(node72, node145,paint: Paint()..color =const Color(0xffFF0000));
                    }
                  }
                  if(user.level65.length>1){
                    graph.addEdge(node36, node73,paint: Paint()..color = const Color(0xffFF7F00));
                    if(user.level710.isNotEmpty){
                      graph.addEdge(node73, node146,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level710.length>1){
                        graph.addEdge(node73, node147,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }

                  }
                }
                if(user.level53.length>1){
                  graph.addEdge(node18, node37,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level66.isNotEmpty){
                    graph.addEdge(node37, node74,paint: Paint()..color = const Color(0xffFF7F00));
                    if(user.level711.isNotEmpty){
                      graph.addEdge(node74, node148,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level711.length>1){
                        graph.addEdge(node74, node149,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level66.length>1){
                      graph.addEdge(node37, node75,paint: Paint()..color = const Color(0xffFF7F00));
                      if(user.level712.isNotEmpty){
                        graph.addEdge(node75, node150,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level712.length>1){
                          graph.addEdge(node75, node151,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }

                }
              }
              if(user.level42.length>1){
                graph.addEdge(node9, node19,paint: Paint()..color = const Color(0xff00FF00));
                if(user.level54.isNotEmpty){
                  graph.addEdge(node19, node38,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level67.isNotEmpty){
                    graph.addEdge(node38, node76,paint: Paint()..color = const Color(0xffFF7F00));
                    if(user.level713.isNotEmpty){
                      graph.addEdge(node76, node152,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level713.length>1){
                        graph.addEdge(node76, node153,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level67.length>1){
                      graph.addEdge(node38, node77,paint: Paint()..color = const Color(0xffFF7F00));
                      if(user.level714.isNotEmpty){
                        graph.addEdge(node77, node154,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level714.length>1){
                          graph.addEdge(node77, node155,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }
                  if(user.level54.length>1){
                    graph.addEdge(node19, node39,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level68.isNotEmpty){
                      graph.addEdge(node39, node78,paint: Paint()..color = const Color(0xffFF7F00));
                      if(user.level715.isNotEmpty){
                        graph.addEdge(node78, node156,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level715.length>1){
                          graph.addEdge(node78, node157,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level68.length>1){
                        graph.addEdge(node39, node79,paint: Paint()..color = const Color(0xffFF7F00));
                        if(user.level716.isNotEmpty){
                          graph.addEdge(node79, node158,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level716.length>1){
                            graph.addEdge(node79, node159,paint: Paint()..color =const Color(0xffFF0000));
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
        if(user.level21.length>1){
          graph.addEdge(node2, node5,paint: Paint()..color = const Color(0xff4B0082));
          if(user.level32.isNotEmpty){
            graph.addEdge(node5, node10,paint: Paint()..color = const Color(0xff0000FF));
            if(user.level43.isNotEmpty){
              graph.addEdge(node10, node20,paint: Paint()..color = const Color(0xff00FF00));
              if(user.level55.isNotEmpty){
                graph.addEdge(node20, node40,paint: Paint()..color = const Color(0xffFFFF00));
                if(user.level69.isNotEmpty){
                  graph.addEdge(node40, node80,paint: Paint()..color =  const Color(0xffFF7F00));
                  if(user.level717.isNotEmpty){
                    graph.addEdge(node80, node160,paint: Paint()..color =const Color(0xffFF0000));
                    if(user.level717.length>1){
                      graph.addEdge(node80, node161,paint: Paint()..color =const Color(0xffFF0000));
                    }
                  }
                  if(user.level69.length>1){
                    graph.addEdge(node40, node81,paint: Paint()..color =  const Color(0xffFF7F00));
                    if(user.level718.isNotEmpty){
                      graph.addEdge(node81, node162,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level718.length>1){
                        graph.addEdge(node81, node163,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }

                  }
                }
                if(user.level55.length>1){
                  graph.addEdge(node20, node41,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level610.isNotEmpty){
                    graph.addEdge(node41, node82,paint: Paint()..color = const Color(0xffFF7F00));
                    if(user.level719.isNotEmpty){
                      graph.addEdge(node82, node164,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level719.length>1){
                        graph.addEdge(node82, node165,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level610.length>1){
                      graph.addEdge(node41, node83,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level720.isNotEmpty){
                        graph.addEdge(node83, node166,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level720.length>1){
                          graph.addEdge(node83, node167,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }

                }
              }
              if(user.level43.length>1){
                graph.addEdge(node10, node21,paint: Paint()..color = const Color(0xff00FF00));
                if(user.level56.isNotEmpty){
                  graph.addEdge(node21, node42,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level611.isNotEmpty){
                    graph.addEdge(node42, node84,paint: Paint()..color =  const Color(0xffFF7F00));
                    if(user.level721.isNotEmpty){
                      graph.addEdge(node84, node168,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level721.length>1){
                        graph.addEdge(node84, node169,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level611.length>1){
                      graph.addEdge(node42, node85,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level722.isNotEmpty){
                        graph.addEdge(node85, node170,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level722.length>1){
                          graph.addEdge(node85, node171,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }
                  if(user.level56.length>1){
                    graph.addEdge(node21, node43,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level612.isNotEmpty){
                      graph.addEdge(node43, node86,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level723.isNotEmpty){
                        graph.addEdge(node86, node172,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level723.length>1){
                          graph.addEdge(node86, node173,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level612.length>1){
                        graph.addEdge(node43, node87,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level724.isNotEmpty){
                          graph.addEdge(node87, node174,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level724.length>1){
                            graph.addEdge(node87, node175,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }

                      }
                    }

                  }
                }

              }
            }
            if(user.level32.length>1){
              graph.addEdge(node5, node11,paint: Paint()..color = const Color(0xff0000FF));
              if(user.level44.isNotEmpty){
                graph.addEdge(node11, node22,paint: Paint()..color = const Color(0xff00FF00));
                if(user.level57.isNotEmpty){
                  graph.addEdge(node22, node44,paint: Paint()..color =const Color(0xffFFFF00));
                  if(user.level613.isNotEmpty){
                    graph.addEdge(node44, node88,paint: Paint()..color =  const Color(0xffFF7F00));
                    if(user.level725.isNotEmpty){
                      graph.addEdge(node88, node176,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level725.length>1){
                        graph.addEdge(node88, node177,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level613.length>1){
                      graph.addEdge(node44, node89,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level726.isNotEmpty){
                        graph.addEdge(node89, node178,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level726.length>1){
                          graph.addEdge(node89, node179,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }
                  if(user.level57.length>1){
                    graph.addEdge(node22, node45,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level614.isNotEmpty){
                      graph.addEdge(node45, node90,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level727.isNotEmpty){
                        graph.addEdge(node90, node180,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level727.length>1){
                          graph.addEdge(node90, node181,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level614.length>1){
                        graph.addEdge(node45, node91,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level728.isNotEmpty){
                          graph.addEdge(node91, node182,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level728.length>1){
                            graph.addEdge(node91, node183,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }

                      }
                    }

                  }
                }
                if(user.level44.length>1){
                  graph.addEdge(node11, node23,paint: Paint()..color = const Color(0xff00FF00));
                  if(user.level58.isNotEmpty){
                    graph.addEdge(node23, node46,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level615.isNotEmpty){
                      graph.addEdge(node46, node92,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level729.isNotEmpty){
                        graph.addEdge(node92, node184,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level729.length>1){
                          graph.addEdge(node92, node185,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level615.length>1){
                        graph.addEdge(node46, node93,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level730.isNotEmpty){
                          graph.addEdge(node93, node186,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level730.length>1){
                            graph.addEdge(node93, node187,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }

                      }
                    }
                    if(user.level58.length>1){
                      graph.addEdge(node23, node47,paint: Paint()..color = const Color(0xffFFFF00));
                      if(user.level616.isNotEmpty){
                        graph.addEdge(node47, node94,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level731.isNotEmpty){
                          graph.addEdge(node94, node188,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level731.length>1){
                            graph.addEdge(node94, node189,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }
                        if(user.level616.length>1){
                          graph.addEdge(node47, node95,paint: Paint()..color =  const Color(0xffFF7F00));
                          if(user.level732.isNotEmpty){
                            graph.addEdge(node95, node190,paint: Paint()..color =const Color(0xffFF0000));
                            if(user.level732.length>1){
                              graph.addEdge(node95, node191,paint: Paint()..color =const Color(0xffFF0000));
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
      if(user.level1.length>1){
        graph.addEdge(node1, node3, paint: Paint()..color = const Color(0xff9400D3));
        if(user.level22.isNotEmpty){
          graph.addEdge(node3, node6,paint: Paint()..color = const Color(0xff4B0082));
          if(user.level33.isNotEmpty){
            graph.addEdge(node6, node12,paint: Paint()..color = const Color(0xff0000FF));
            if(user.level45.isNotEmpty){
              graph.addEdge(node12, node24,paint: Paint()..color = const Color(0xff00FF00));
              if(user.level59.isNotEmpty){
                graph.addEdge(node24, node48,paint: Paint()..color = const Color(0xffFFFF00));
                if(user.level617.isNotEmpty){
                  graph.addEdge(node48, node96,paint: Paint()..color =  const Color(0xffFF7F00));
                  if(user.level733.isNotEmpty){
                    graph.addEdge(node96, node192,paint: Paint()..color =const Color(0xffFF0000));
                    if(user.level733.length>1){
                      graph.addEdge(node96, node193,paint: Paint()..color =const Color(0xffFF0000));
                    }
                  }
                  if(user.level617.length>1){
                    graph.addEdge(node48, node97,paint: Paint()..color =  const Color(0xffFF7F00));
                    if(user.level734.isNotEmpty){
                      graph.addEdge(node97, node194,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level734.length>1){
                        graph.addEdge(node97, node195,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }

                  }
                }
                if(user.level59.length>1){
                  graph.addEdge(node24, node49,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level618.isNotEmpty){
                    graph.addEdge(node49, node98,paint: Paint()..color =  const Color(0xffFF7F00));
                    if(user.level735.isNotEmpty){
                      graph.addEdge(node98, node196,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level735.length>1){
                        graph.addEdge(node98, node197,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level618.length>1){
                      graph.addEdge(node49, node99,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level736.isNotEmpty){
                        graph.addEdge(node99, node198,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level736.length>1){
                          graph.addEdge(node99, node199,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }

                }
              }
              if(user.level45.length>1){
                graph.addEdge(node12, node25,paint: Paint()..color = const Color(0xff00FF00));
                if(user.level510.isNotEmpty){
                  graph.addEdge(node25, node50,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level619.isNotEmpty){
                    graph.addEdge(node50, node100,paint: Paint()..color =  const Color(0xffFF7F00));
                    if(user.level737.isNotEmpty){
                      graph.addEdge(node100, node200,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level737.length>1){
                        graph.addEdge(node100, node201,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level619.length>1){
                      graph.addEdge(node50, node101,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level738.isNotEmpty){
                        graph.addEdge(node101, node202,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level738.length>1){
                          graph.addEdge(node101, node203,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }
                  if(user.level510.length>1){
                    graph.addEdge(node25, node51,paint: Paint()..color =const Color(0xffFFFF00));
                    if(user.level620.isNotEmpty){
                      graph.addEdge(node51, node102,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level739.isNotEmpty){
                        graph.addEdge(node102, node204,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level739.length>1){
                          graph.addEdge(node102, node205,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level620.length>1){
                        graph.addEdge(node51, node103,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level740.isNotEmpty){
                          graph.addEdge(node103, node206,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level740.length>1){
                            graph.addEdge(node103, node207,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }

                      }
                    }

                  }
                }

              }
            }
            if(user.level33.length>1){
              graph.addEdge(node6, node13,paint: Paint()..color = const Color(0xff0000FF));
              if(user.level46.isNotEmpty){
                graph.addEdge(node13, node26,paint: Paint()..color = const Color(0xff00FF00));
                if(user.level511.isNotEmpty){
                  graph.addEdge(node26, node52,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level621.isNotEmpty){
                    graph.addEdge(node52, node104,paint: Paint()..color =  const Color(0xffFF7F00));
                    if(user.level741.isNotEmpty){
                      graph.addEdge(node104, node208,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level741.length>1){
                        graph.addEdge(node104, node209,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level621.length>1){
                      graph.addEdge(node52, node105,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level742.isNotEmpty){
                        graph.addEdge(node105, node210,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level742.length>1){
                          graph.addEdge(node105, node211,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }
                  if(user.level511.length>1){
                    graph.addEdge(node26, node53,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level622.isNotEmpty){
                      graph.addEdge(node53, node106,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level743.isNotEmpty){
                        graph.addEdge(node106, node212,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level743.length>1){
                          graph.addEdge(node106, node213,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level622.length>1){
                        graph.addEdge(node53, node107,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level744.isNotEmpty){
                          graph.addEdge(node106, node214,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level744.length>1){
                            graph.addEdge(node106, node215,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }

                      }
                    }

                  }
                }
                if(user.level46.length>1){
                  graph.addEdge(node13, node27,paint: Paint()..color = const Color(0xff00FF00));
                  if(user.level512.isNotEmpty){
                    graph.addEdge(node27, node54,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level623.isNotEmpty){
                      graph.addEdge(node54, node108,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level745.isNotEmpty){
                        graph.addEdge(node108, node216,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level745.length>1){
                          graph.addEdge(node108, node217,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level623.length>1){
                        graph.addEdge(node54, node109,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level746.isNotEmpty){
                          graph.addEdge(node109, node218,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level746.length>1){
                            graph.addEdge(node109, node219,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }

                      }
                    }
                    if(user.level512.length>1){
                      graph.addEdge(node27, node55,paint: Paint()..color = const Color(0xffFFFF00));
                      if(user.level624.isNotEmpty){
                        graph.addEdge(node55, node110,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level747.isNotEmpty){
                          graph.addEdge(node110, node220,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level747.length>1){
                            graph.addEdge(node110, node221,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }
                        if(user.level624.length>1){
                          graph.addEdge(node55, node111,paint: Paint()..color =  const Color(0xffFF7F00));
                          if(user.level748.isNotEmpty){
                            graph.addEdge(node111, node222,paint: Paint()..color =const Color(0xffFF0000));
                            if(user.level748.length>1){
                              graph.addEdge(node111, node223,paint: Paint()..color =const Color(0xffFF0000));
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
          if(user.level22.length>1){
            graph.addEdge(node3, node7,paint: Paint()..color = const Color(0xff4B0082));
            if(user.level34.isNotEmpty){
              graph.addEdge(node7, node14,paint: Paint()..color = const Color(0xff0000FF));
              if(user.level47.isNotEmpty){
                graph.addEdge(node14, node28,paint: Paint()..color = const Color(0xff00FF00));
                if(user.level513.isNotEmpty){
                  graph.addEdge(node28, node56,paint: Paint()..color = const Color(0xffFFFF00));
                  if(user.level625.isNotEmpty){
                    graph.addEdge(node56, node112,paint: Paint()..color =  const Color(0xffFF7F00));
                    if(user.level749.isNotEmpty){
                      graph.addEdge(node112, node224,paint: Paint()..color =const Color(0xffFF0000));
                      if(user.level749.length>1){
                        graph.addEdge(node112, node225,paint: Paint()..color =const Color(0xffFF0000));
                      }
                    }
                    if(user.level625.length>1){
                      graph.addEdge(node56, node113,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level750.isNotEmpty){
                        graph.addEdge(node113, node226,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level750.length>1){
                          graph.addEdge(node113, node227,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }

                    }
                  }
                  if(user.level513.length>1){
                    graph.addEdge(node28, node57,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level626.isNotEmpty){
                      graph.addEdge(node57, node114,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level751.isNotEmpty){
                        graph.addEdge(node114, node228,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level751.length>1){
                          graph.addEdge(node114, node229,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level626.length>1){
                        graph.addEdge(node57, node115,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level752.isNotEmpty){
                          graph.addEdge(node115, node230,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level752.length>1){
                            graph.addEdge(node115, node231,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }

                      }
                    }

                  }
                }
                if(user.level47.length>1){
                  graph.addEdge(node14, node29,paint: Paint()..color = const Color(0xff00FF00));
                  if(user.level514.isNotEmpty){
                    graph.addEdge(node29, node58,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level627.isNotEmpty){
                      graph.addEdge(node58, node116,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level753.isNotEmpty){
                        graph.addEdge(node116, node232,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level753.length>1){
                          graph.addEdge(node116, node233,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level627.length>1){
                        graph.addEdge(node58, node117,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level754.isNotEmpty){
                          graph.addEdge(node117, node234,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level754.length>1){
                            graph.addEdge(node117, node235,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }
                      }
                    }
                    if(user.level514.length>1){
                      graph.addEdge(node29, node59,paint: Paint()..color = const Color(0xffFFFF00));
                      if(user.level628.isNotEmpty){
                        graph.addEdge(node59, node118,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level755.isNotEmpty){
                          graph.addEdge(node118, node236,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level755.length>1){
                            graph.addEdge(node118, node237,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }
                        if(user.level628.length>1){
                          graph.addEdge(node59, node119,paint: Paint()..color =  const Color(0xffFF7F00));
                          if(user.level756.isNotEmpty){
                            graph.addEdge(node119, node238,paint: Paint()..color =const Color(0xffFF0000));
                            if(user.level756.length>1){
                              graph.addEdge(node119, node239,paint: Paint()..color =const Color(0xffFF0000));
                            }
                          }
                        }
                      }

                    }
                  }

                }
              }
              if(user.level34.length>1){
                graph.addEdge(node7, node15,paint: Paint()..color = const Color(0xff0000FF));
                if(user.level48.isNotEmpty){
                  graph.addEdge(node15, node30,paint: Paint()..color = const Color(0xff00FF00));
                  if(user.level515.isNotEmpty){
                    graph.addEdge(node30, node60,paint: Paint()..color = const Color(0xffFFFF00));
                    if(user.level629.isNotEmpty){
                      graph.addEdge(node60, node120,paint: Paint()..color =  const Color(0xffFF7F00));
                      if(user.level757.isNotEmpty){
                        graph.addEdge(node120, node240,paint: Paint()..color =const Color(0xffFF0000));
                        if(user.level757.length>1){
                          graph.addEdge(node120, node241,paint: Paint()..color =const Color(0xffFF0000));
                        }
                      }
                      if(user.level629.length>1){
                        graph.addEdge(node60, node121,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level758.isNotEmpty){
                          graph.addEdge(node121, node242,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level758.length>1){
                            graph.addEdge(node121, node243,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }
                      }
                    }
                    if(user.level515.length>1){
                      graph.addEdge(node30, node61,paint: Paint()..color = const Color(0xffFFFF00));
                      if(user.level630.isNotEmpty){
                        graph.addEdge(node61, node122,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level759.isNotEmpty){
                          graph.addEdge(node122, node244,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level759.length>1){
                            graph.addEdge(node122, node245,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }
                        if(user.level630.length>1){
                          graph.addEdge(node61, node123,paint: Paint()..color =  const Color(0xffFF7F00));
                          if(user.level760.isNotEmpty){
                            graph.addEdge(node123, node246,paint: Paint()..color =const Color(0xffFF0000));
                            if(user.level760.length>1){
                              graph.addEdge(node123, node247,paint: Paint()..color =const Color(0xffFF0000));
                            }
                          }
                        }
                      }

                    }
                  }
                  if(user.level48.length>1){
                    graph.addEdge(node15, node31,paint: Paint()..color = const Color(0xff00FF00));
                    if(user.level516.isNotEmpty){
                      graph.addEdge(node31, node62,paint: Paint()..color = const Color(0xffFFFF00));
                      if(user.level631.isNotEmpty){
                        graph.addEdge(node62, node124,paint: Paint()..color =  const Color(0xffFF7F00));
                        if(user.level761.isNotEmpty){
                          graph.addEdge(node124, node248,paint: Paint()..color =const Color(0xffFF0000));
                          if(user.level761.length>1){
                            graph.addEdge(node124, node249,paint: Paint()..color =const Color(0xffFF0000));
                          }
                        }
                        if(user.level631.length>1){
                          graph.addEdge(node62, node125,paint: Paint()..color =  const Color(0xffFF7F00));
                          if(user.level762.isNotEmpty){
                            graph.addEdge(node125, node250,paint: Paint()..color =const Color(0xffFF0000));
                            if(user.level762.length>1){
                              graph.addEdge(node125, node251,paint: Paint()..color =const Color(0xffFF0000));
                            }
                          }
                        }
                      }
                      if(user.level516.length>1){
                        graph.addEdge(node31, node63,paint: Paint()..color = const Color(0xffFFFF00));
                        if(user.level632.isNotEmpty){
                          graph.addEdge(node63, node126,paint: Paint()..color =  const Color(0xffFF7F00));
                          if(user.level763.isNotEmpty){
                            graph.addEdge(node126, node252,paint: Paint()..color =const Color(0xffFF0000));
                            if(user.level763.length>1){
                              graph.addEdge(node126, node253,paint: Paint()..color =const Color(0xffFF0000));
                            }
                          }
                          if(user.level632.length>1){
                            graph.addEdge(node63, node127,paint: Paint()..color =  const Color(0xffFF7F00));
                            if(user.level764.isNotEmpty){
                              graph.addEdge(node127, node254,paint: Paint()..color =const Color(0xffFF0000));
                              if(user.level764.length>1){
                                graph.addEdge(node127, node255,paint: Paint()..color =const Color(0xffFF0000));
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



    builder
      ..siblingSeparation = (50)//100
      ..levelSeparation = (50)//150
      ..subtreeSeparation = (50)//150
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_LEFT_RIGHT);//ORIENTATION_LEFT_RIGHT
  }
}
