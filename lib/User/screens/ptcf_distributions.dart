import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Constants/functions.dart';
import '../../Provider/user_provider.dart';
import '../../constants/my_colors.dart';
import '../../models/distributionModel.dart';
import 'help_Screen.dart';

class PTCFDistributions extends StatelessWidget {
  String from ;
   PTCFDistributions({Key? key,required this.from}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate = '';

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgrnd,
      appBar: AppBar(
        backgroundColor: backgrnd,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/bluelogo.png',
              scale: 18,
            ),
            Text(
              "CMF Distributions",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  fontFamily: "PoppinsRegular"),
            ),
            const SizedBox()
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Consumer<UserProvider>(builder: (context2, val565, child) {
            return Container(
              // color: Colors.cyan,
              padding: const EdgeInsets.all(8),
              width: width,
              height: height-125,
              child:  val565.filterPtcfDistributionsList.isNotEmpty
                  ?ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemCount: val565.companyAllLevelList.length,
                  itemBuilder: (BuildContext context, int index) {
                    List<DistributionModel> filteredPMCList = val565
                        .filterPtcfDistributionsList
                        .where((element) =>
                    val565.companyAllLevelList[index].levelName ==
                        element.fromGrade)
                        .toList();
                    filteredPMCList.sort((a, b) => a.installment.compareTo(b.installment));
                    return val565.companyAllLevelList.isNotEmpty&&filteredPMCList.isNotEmpty
                        ? Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, bottom: 6, top: 5),
                              child: Text(
                                val565.companyAllLevelList[index].levelName,
                                style: const TextStyle(
                                  color: cl5F5F5F,
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              itemCount: filteredPMCList.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                var item = filteredPMCList[index];
                                return InkWell(
                                  onTap: () {
                                    print("distribution id ${item.distributionId}");
                                    String txnID=DateTime.now().millisecondsSinceEpoch.toString() + val565.generateRandomString(2);
                                    if (item.status != "PAID") {
                                      if(index==0){
                                        val565.gstCalc(double.parse(
                                            item.amount));
                                        val565.gatewayShowFun();
                                        callNext(
                                            PMCPaymentScreen(
                                              name: item.type,
                                              amount:item.amount,
                                              grade: item.fromGrade,
                                              tree: item.tree,
                                              fromId:item.fromId,
                                              distributionId: item.distributionId,
                                              userName:item.name ,
                                              phoneNumber: val565.userPhone, installment: item.installment, txnID: txnID),
                                            context);
                                        val565.attemptPmCmf(context,  txnID, item.amount,item.type,
                                            item.fromGrade, item.fromId, item.tree, item.distributionId, item.installment);
                                        val565.clearBooleans();
                                      }else{
                                        if(filteredPMCList[index-1].status=="PAID"){
                                          val565.gstCalc(double.parse(
                                              item.amount));
                                          val565.gatewayShowFun();
                                          callNext(
                                              PMCPaymentScreen(
                                                name: item.type,
                                                amount:item.amount,
                                                grade: item.fromGrade,
                                                tree: item.tree,
                                                fromId:item.fromId,
                                                distributionId: item.distributionId,
                                                userName:item.name ,
                                                phoneNumber: val565.userPhone, installment: item.installment, txnID: txnID),
                                              context);
                                          val565.attemptPmCmf(context,  txnID, item.amount,item.type,
                                              item.fromGrade, item.fromId, item.tree, item.distributionId, item.installment);
                                          val565.clearBooleans();
                                        }else{
                                          var snackBar = SnackBar(
                                            content: Text("Please complete CMF ${item.installment-1} payment first."),
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                        }
                                      }
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.only(top: 0,bottom: 5),
                                        decoration: BoxDecoration(color: bck),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: width / 2.5,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,

                                                children: [
                                                  Text(
                                                    item.type,
                                                    style: const TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 14),
                                                  ),
                                                  Text(

                                                    item.tree,
                                                    style:  TextStyle(
                                                        fontWeight: FontWeight.w500, fontSize: 10,
                                                        color: item.tree == "MASTER_CLUB"
                                                            ?cl7aefba
                                                            :item.tree == "STAR_CLUB"
                                                            ?cl22A2B1:cl00369F),
                                                  ),
                                                  Text(
                                                    item.fromGrade,
                                                    style:  TextStyle(fontWeight: FontWeight.w400, fontSize: 10,
                                                        color: item.tree == "MASTER_CLUB"
                                                            ?cl7aefba
                                                            :item.tree == "STAR_CLUB"
                                                            ?cl22A2B1:cl00369F),
                                                  ),

                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: width / 2.5,
                                              child:
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text("CMF ${item.installment}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontSize: 12,
                                                            color: item.status !=
                                                                "PAID"
                                                                ? clFFA500
                                                                : cl16B200)),
                                                    Text(item.status,
                                                        style: TextStyle(
                                                            fontWeight:
                                                            FontWeight.w600,
                                                            fontSize: 12,
                                                            color: item.status !=
                                                                "PAID"
                                                                ? clFFA500
                                                                : cl16B200)),
                                                    Text(
                                                      "₹${item.amount}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                          FontWeight.w600,
                                                          fontSize: 12),
                                                    ),

                                                    const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      index!=0
                                      ?filteredPMCList[index-1].status!="PAID"
                                      ?Container(
                                        padding: const EdgeInsets.all(5),
                                        clipBehavior: Clip.antiAlias,
                                        margin: const EdgeInsets.only(top: 0,bottom: 5),
                                        decoration: BoxDecoration(color: textclr2.withOpacity(0.3)),
                                        height: 70,
                                        width: width,
                                        child:  Icon( Icons.lock_outline_rounded,color:textclr2,size: 30,),
                                      )
                                          :const SizedBox():const SizedBox(),
                                    ],
                                  ),
                                );
                              })
                        ],
                      ),
                    )
                        : const SizedBox();
                  })
                  : const SizedBox(
                height: 80,
                child: Center(
                    child: Text("No Distributions Yet.")),
              ),
            );
          }),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
