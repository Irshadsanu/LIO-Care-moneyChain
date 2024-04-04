import 'package:flutter/material.dart';
import 'package:lio_care/help_tree/tree_provider.dart';
import 'package:provider/provider.dart';

import '../Constants/functions.dart';
import '../constants/my_colors.dart';
import '../graph/tree_graphview.dart';
import 'help_tree_page.dart';

class TreeNavigator extends StatelessWidget {
  const TreeNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Consumer<TreeProvider>(
              builder: (context5,value123,child) {
              return InkWell(
                onTap: () async {


                  if(value123.level0.isNotEmpty) {
                    // callNext(const HelpTreePage(), context);
                    callNext(TreeViewPage(fromSection: '', fromTree: '',), context);
                  }
                },
                child: Container(
                  margin: EdgeInsets.all(15),
                  height: 80,
                  width: 200,
                  color: cl004CA8,
                  alignment: Alignment.center,
                  child: Text("GO"),
                ),
              );
            }
          ),
        ],
      ),
    );
  }
}
