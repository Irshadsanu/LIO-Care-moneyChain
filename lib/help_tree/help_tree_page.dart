import 'package:flutter/material.dart';
import 'package:lio_care/constants/my_colors.dart';
import 'package:lio_care/help_tree/tree_provider.dart';
import 'package:provider/provider.dart';

import 'help_tree_model.dart';

class HelpTreePage extends StatelessWidget {
  const HelpTreePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Consumer<TreeProvider>(
        builder: (context2,value2,child) {
          return InteractiveViewer(
            constrained: false,
            boundaryMargin: const EdgeInsets.all(100),
            minScale: 0.08,
            maxScale: 5.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                SizedBox(height: 30,),
                nodes(nodeList: value2.level0, index: 0),
                Row(
                  children: [
                    nodes(nodeList: value2.level1, index: 0),
                    nodes(nodeList: value2.level1, index: 1),
                  ],
                ),
                Row(
                  children: [
                    nodes(nodeList: value2.level21, index: 0),
                    nodes(nodeList: value2.level21, index: 1),
                    nodes(nodeList: value2.level22, index: 0),
                    nodes(nodeList: value2.level22, index: 1),
                  ],
                ),
                Row(
                  children: [
                    nodes(nodeList: value2.level31, index: 0),
                    nodes(nodeList: value2.level31, index: 1),
                    nodes(nodeList: value2.level32, index: 0),
                    nodes(nodeList: value2.level32, index: 1),
                    nodes(nodeList: value2.level33, index: 0),
                    nodes(nodeList: value2.level33, index: 1),
                    nodes(nodeList: value2.level34, index: 0),
                    nodes(nodeList: value2.level34, index: 1),
                  ],
                ),
                Row(
                  children: [
                    nodes(nodeList: value2.level41, index: 0),
                    nodes(nodeList: value2.level41, index: 1),
                    nodes(nodeList: value2.level42, index: 0),
                    nodes(nodeList: value2.level42, index: 1),
                    nodes(nodeList: value2.level43, index: 0),
                    nodes(nodeList: value2.level43, index: 1),
                    nodes(nodeList: value2.level44, index: 0),
                    nodes(nodeList: value2.level44, index: 1),
                    nodes(nodeList: value2.level45, index: 0),
                    nodes(nodeList: value2.level45, index: 1),
                    nodes(nodeList: value2.level46, index: 0),
                    nodes(nodeList: value2.level46, index: 1),
                    nodes(nodeList: value2.level47, index: 0),
                    nodes(nodeList: value2.level47, index: 1),
                    nodes(nodeList: value2.level48, index: 0),
                    nodes(nodeList: value2.level48, index: 1),
                  ],
                ),
                Row(
                  children: [
                    nodes(nodeList: value2.level51, index: 0),
                    nodes(nodeList: value2.level51, index: 1),
                    nodes(nodeList: value2.level52, index: 0),
                    nodes(nodeList: value2.level52, index: 1),
                    nodes(nodeList: value2.level53, index: 0),
                    nodes(nodeList: value2.level53, index: 1),
                    nodes(nodeList: value2.level54, index: 0),
                    nodes(nodeList: value2.level54, index: 1),
                    nodes(nodeList: value2.level55, index: 0),
                    nodes(nodeList: value2.level55, index: 1),
                    nodes(nodeList: value2.level56, index: 0),
                    nodes(nodeList: value2.level56, index: 1),
                    nodes(nodeList: value2.level57, index: 0),
                    nodes(nodeList: value2.level57, index: 1),
                    nodes(nodeList: value2.level58, index: 0),
                    nodes(nodeList: value2.level58, index: 1),
                    nodes(nodeList: value2.level59, index: 0),
                    nodes(nodeList: value2.level59, index: 1),
                    nodes(nodeList: value2.level510, index: 0),
                    nodes(nodeList: value2.level510, index: 1),
                    nodes(nodeList: value2.level511, index: 0),
                    nodes(nodeList: value2.level511, index: 1),
                    nodes(nodeList: value2.level512, index: 0),
                    nodes(nodeList: value2.level512, index: 1),
                    nodes(nodeList: value2.level513, index: 0),
                    nodes(nodeList: value2.level513, index: 1),
                    nodes(nodeList: value2.level514, index: 0),
                    nodes(nodeList: value2.level514, index: 1),
                    nodes(nodeList: value2.level515, index: 0),
                    nodes(nodeList: value2.level515, index: 1),
                    nodes(nodeList: value2.level516, index: 0),
                    nodes(nodeList: value2.level516, index: 1),
                  ],
                ),
                Row(
                  children: [
                    nodes(nodeList: value2.level61, index: 0),
                    nodes(nodeList: value2.level61, index: 1),
                    nodes(nodeList: value2.level62, index: 0),
                    nodes(nodeList: value2.level62, index: 1),
                    nodes(nodeList: value2.level63, index: 0),
                    nodes(nodeList: value2.level63, index: 1),
                    nodes(nodeList: value2.level64, index: 0),
                    nodes(nodeList: value2.level64, index: 1),
                    nodes(nodeList: value2.level65, index: 0),
                    nodes(nodeList: value2.level65, index: 1),
                    nodes(nodeList: value2.level66, index: 0),
                    nodes(nodeList: value2.level66, index: 1),
                    nodes(nodeList: value2.level67, index: 0),
                    nodes(nodeList: value2.level67, index: 1),
                    nodes(nodeList: value2.level68, index: 0),
                    nodes(nodeList: value2.level68, index: 1),
                    nodes(nodeList: value2.level69, index: 0),
                    nodes(nodeList: value2.level69, index: 1),
                    nodes(nodeList: value2.level610, index: 0),
                    nodes(nodeList: value2.level610, index: 1),
                    nodes(nodeList: value2.level611, index: 0),
                    nodes(nodeList: value2.level611, index: 1),
                    nodes(nodeList: value2.level612, index: 0),
                    nodes(nodeList: value2.level612, index: 1),
                    nodes(nodeList: value2.level613, index: 0),
                    nodes(nodeList: value2.level613, index: 1),
                    nodes(nodeList: value2.level614, index: 0),
                    nodes(nodeList: value2.level614, index: 1),
                    nodes(nodeList: value2.level615, index: 0),
                    nodes(nodeList: value2.level615, index: 1),
                    nodes(nodeList: value2.level616, index: 0),
                    nodes(nodeList: value2.level616, index: 1),
                    nodes(nodeList: value2.level617, index: 0),
                    nodes(nodeList: value2.level617, index: 0),
                    nodes(nodeList: value2.level618, index: 0),
                    nodes(nodeList: value2.level618, index: 1),
                    nodes(nodeList: value2.level619, index: 0),
                    nodes(nodeList: value2.level619, index: 1),
                    nodes(nodeList: value2.level620, index: 0),
                    nodes(nodeList: value2.level620, index: 1),
                    nodes(nodeList: value2.level621, index: 0),
                    nodes(nodeList: value2.level621, index: 1),
                    nodes(nodeList: value2.level622, index: 0),
                    nodes(nodeList: value2.level622, index: 1),
                    nodes(nodeList: value2.level623, index: 0),
                    nodes(nodeList: value2.level623, index: 1),
                    nodes(nodeList: value2.level624, index: 0),
                    nodes(nodeList: value2.level624, index: 1),
                    nodes(nodeList: value2.level625, index: 0),
                    nodes(nodeList: value2.level625, index: 1),
                    nodes(nodeList: value2.level626, index: 0),
                    nodes(nodeList: value2.level626, index: 1),
                    nodes(nodeList: value2.level627, index: 0),
                    nodes(nodeList: value2.level627, index: 1),
                    nodes(nodeList: value2.level628, index: 0),
                    nodes(nodeList: value2.level628, index: 1),
                    nodes(nodeList: value2.level629, index: 0),
                    nodes(nodeList: value2.level629, index: 1),
                    nodes(nodeList: value2.level630, index: 0),
                    nodes(nodeList: value2.level630, index: 1),
                    nodes(nodeList: value2.level631, index: 0),
                    nodes(nodeList: value2.level631, index: 1),
                    nodes(nodeList: value2.level632, index: 0),
                    nodes(nodeList: value2.level632, index: 1),
                  ],
                ),
                Row(
                  children: [
                    nodes(nodeList: value2.level71, index: 0),
                    nodes(nodeList: value2.level71, index: 1),
                    nodes(nodeList: value2.level72, index: 0),
                    nodes(nodeList: value2.level72, index: 1),
                    nodes(nodeList: value2.level73, index: 0),
                    nodes(nodeList: value2.level73, index: 1),
                    nodes(nodeList: value2.level74, index: 0),
                    nodes(nodeList: value2.level74, index: 1),
                    nodes(nodeList: value2.level75, index: 0),
                    nodes(nodeList: value2.level75, index: 1),
                    nodes(nodeList: value2.level76, index: 0),
                    nodes(nodeList: value2.level76, index: 1),
                    nodes(nodeList: value2.level77, index: 0),
                    nodes(nodeList: value2.level77, index: 1),
                    nodes(nodeList: value2.level78, index: 0),
                    nodes(nodeList: value2.level78, index: 1),
                    nodes(nodeList: value2.level79, index: 0),
                    nodes(nodeList: value2.level79, index: 1),
                    nodes(nodeList: value2.level710, index: 0),
                    nodes(nodeList: value2.level710, index: 1),
                    nodes(nodeList: value2.level711, index: 0),
                    nodes(nodeList: value2.level711, index: 1),
                    nodes(nodeList: value2.level712, index: 0),
                    nodes(nodeList: value2.level712, index: 1),
                    nodes(nodeList: value2.level713, index: 0),
                    nodes(nodeList: value2.level713, index: 1),
                    nodes(nodeList: value2.level714, index: 0),
                    nodes(nodeList: value2.level714, index: 1),
                    nodes(nodeList: value2.level715, index: 0),
                    nodes(nodeList: value2.level715, index: 1),
                    nodes(nodeList: value2.level716, index: 0),
                    nodes(nodeList: value2.level716, index: 1),
                    nodes(nodeList: value2.level717, index: 0),
                    nodes(nodeList: value2.level717, index: 1),
                    nodes(nodeList: value2.level718, index: 0),
                    nodes(nodeList: value2.level718, index: 1),
                    nodes(nodeList: value2.level719, index: 0),
                    nodes(nodeList: value2.level719, index: 1),
                    nodes(nodeList: value2.level720, index: 0),
                    nodes(nodeList: value2.level720, index: 1),
                    nodes(nodeList: value2.level721, index: 0),
                    nodes(nodeList: value2.level721, index: 1),
                    nodes(nodeList: value2.level722, index: 0),
                    nodes(nodeList: value2.level722, index: 1),
                    nodes(nodeList: value2.level723, index: 0),
                    nodes(nodeList: value2.level723, index: 1),
                    nodes(nodeList: value2.level724, index: 0),
                    nodes(nodeList: value2.level724, index: 1),
                    nodes(nodeList: value2.level725, index: 0),
                    nodes(nodeList: value2.level725, index: 1),
                    nodes(nodeList: value2.level726, index: 0),
                    nodes(nodeList: value2.level726, index: 1),
                    nodes(nodeList: value2.level727, index: 0),
                    nodes(nodeList: value2.level727, index: 1),
                    nodes(nodeList: value2.level728, index: 0),
                    nodes(nodeList: value2.level728, index: 1),
                    nodes(nodeList: value2.level729, index: 0),
                    nodes(nodeList: value2.level729, index: 1),
                    nodes(nodeList: value2.level730, index: 0),
                    nodes(nodeList: value2.level730, index: 1),
                    nodes(nodeList: value2.level731, index: 0),
                    nodes(nodeList: value2.level731, index: 1),
                    nodes(nodeList: value2.level732, index: 0),
                    nodes(nodeList: value2.level732, index: 1),
                    nodes(nodeList: value2.level733, index: 0),
                    nodes(nodeList: value2.level733, index: 1),
                    nodes(nodeList: value2.level734, index: 0),
                    nodes(nodeList: value2.level734, index: 1),
                    nodes(nodeList: value2.level735, index: 0),
                    nodes(nodeList: value2.level735, index: 1),
                    nodes(nodeList: value2.level736, index: 0),
                    nodes(nodeList: value2.level736, index: 1),
                    nodes(nodeList: value2.level737, index: 0),
                    nodes(nodeList: value2.level737, index: 1),
                    nodes(nodeList: value2.level738, index: 0),
                    nodes(nodeList: value2.level738, index: 1),
                    nodes(nodeList: value2.level739, index: 0),
                    nodes(nodeList: value2.level739, index: 1),
                    nodes(nodeList: value2.level740, index: 0),
                    nodes(nodeList: value2.level740, index: 1),
                    nodes(nodeList: value2.level741, index: 0),
                    nodes(nodeList: value2.level741, index: 1),
                    nodes(nodeList: value2.level742, index: 0),
                    nodes(nodeList: value2.level742, index: 1),
                    nodes(nodeList: value2.level743, index: 0),
                    nodes(nodeList: value2.level743, index: 1),
                    nodes(nodeList: value2.level744, index: 0),
                    nodes(nodeList: value2.level744, index: 1),
                    nodes(nodeList: value2.level745, index: 0),
                    nodes(nodeList: value2.level745, index: 1),
                    nodes(nodeList: value2.level746, index: 0),
                    nodes(nodeList: value2.level746, index: 1),
                    nodes(nodeList: value2.level747, index: 0),
                    nodes(nodeList: value2.level747, index: 1),
                    nodes(nodeList: value2.level748, index: 0),
                    nodes(nodeList: value2.level748, index: 1),
                    nodes(nodeList: value2.level749, index: 0),
                    nodes(nodeList: value2.level749, index: 1),
                    nodes(nodeList: value2.level750, index: 0),
                    nodes(nodeList: value2.level750, index: 1),
                    nodes(nodeList: value2.level751, index: 0),
                    nodes(nodeList: value2.level751, index: 1),
                    nodes(nodeList: value2.level752, index: 0),
                    nodes(nodeList: value2.level752, index: 1),
                    nodes(nodeList: value2.level753, index: 0),
                    nodes(nodeList: value2.level753, index: 1),
                    nodes(nodeList: value2.level754, index: 0),
                    nodes(nodeList: value2.level754, index: 1),
                    nodes(nodeList: value2.level755, index: 0),
                    nodes(nodeList: value2.level755, index: 1),
                    nodes(nodeList: value2.level756, index: 0),
                    nodes(nodeList: value2.level756, index: 1),
                    nodes(nodeList: value2.level757, index: 0),
                    nodes(nodeList: value2.level757, index: 1),
                    nodes(nodeList: value2.level758, index: 0),
                    nodes(nodeList: value2.level758, index: 1),
                    nodes(nodeList: value2.level759, index: 0),
                    nodes(nodeList: value2.level759, index: 1),
                    nodes(nodeList: value2.level760, index: 0),
                    nodes(nodeList: value2.level760, index: 1),
                    nodes(nodeList: value2.level761, index: 0),
                    nodes(nodeList: value2.level761, index: 1),
                    nodes(nodeList: value2.level762, index: 0),
                    nodes(nodeList: value2.level762, index: 1),
                    nodes(nodeList: value2.level763, index: 0),
                    nodes(nodeList: value2.level763, index: 1),
                    nodes(nodeList: value2.level764, index: 0),
                    nodes(nodeList: value2.level764, index: 1),
                  ],
                ),


              ],

            ),
          );
        }
      ),


    );
  }
}

Widget nodes(
    {required List<HelpTreeModel> nodeList,required int index}) {
  return Container(
    width: 180,
    height: 44,

    decoration: ShapeDecoration(
      color:index==0? Color(0xFFFF731D):Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(7),
          bottomRight: Radius.circular(7),
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
      ),
      shadows: [
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
      children: [
        const CircleAvatar(radius: 22,),
        Spacer(),
        Column(
          children: [
            Text(nodeList[index].userName,style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),),
            Text(nodeList[index].userPhone),
          ],
        ),
       Spacer()

      ],
    )
        :SizedBox(),
  );
}