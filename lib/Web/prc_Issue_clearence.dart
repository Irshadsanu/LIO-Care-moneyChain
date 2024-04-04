import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lio_care/Provider/donation_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../Constants/functions.dart';
import '../Provider/admin_provider.dart';
import '../Provider/user_provider.dart';
import '../constants/my_colors.dart';

class PrcIssueClearance extends StatelessWidget {
  const PrcIssueClearance({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Consumer<DonationProvider>(builder: (context4, donPro, _) {
        return SizedBox(
          width: width,
          height: height,
          child: SizedBox(
            width: width / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: width / 3,
                  child: TextFormField(
                    controller: donPro.prcClearPhoneCt,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                          onTap: () {
                            donPro.getPrcClearanceDetails(
                                donPro.prcClearPhoneCt.text, "");
                          },
                          child: const SizedBox(child: Icon(Icons.search))),
                      labelText: "Enter Phone Number",
                    ),
                  ),
                ),
                SizedBox(
                  height: width / 50,
                ),
                Container(
                  width: width / 3,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        18,
                      ),
                      color: clFFECE5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Member ID :${donPro.prcClearanceMemberId}"),
                      Text("Name :${donPro.prcClearanceUserName}"),
                      Text("Phone :${donPro.prcClearancePhoneNumber}"),
                      Text(
                          "Distribution ID:${donPro.prcClearanceDistributionId}"),
                      Text("Status :${donPro.prcClearanceDistributionStatus}"),
                      Text("Amount :${donPro.prcClearanceDistributionAmount}"),
                    ],
                  ),
                ),
                SizedBox(
                  height: width / 50,
                ),
                SizedBox(
                  width: width / 3,
                  child: TextFormField(
                    controller: donPro.prcClearTransactionCt,
                    inputFormatters: [LengthLimitingTextInputFormatter(15)],
                    decoration: const InputDecoration(
                      labelText: "Transaction ID",
                    ),
                  ),
                ),
                SizedBox(
                  height: width / 50,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              clFFAC7B, // Change the background color here
                        ),
                        onPressed: () {
                          if(donPro.prcClearTransactionCt.text.trim().length==15){
                          donPro.clearPrcIssue(
                              context, donPro.prcClearTransactionCt.text.trim());
                          }
                        },
                        child: const Text('APPROVE'),
                      ),
                      SizedBox(width: 20,),
                      Consumer<UserProvider>(builder: (context4, userPro, _) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                              clFFAC7B, // Change the background color here
                            ),
                            onPressed: () async {
                              // print("donPro.prcClearanceMemberId ${donPro.prcClearanceMemberId},"
                              //     "donPro.prcClearanceUserFcmValue ${donPro.prcClearanceUserFcmValue}, ");
                              donPro.prcIssuePlaceMemberOnly(
                                  context, donPro.prcClearTransactionCt.text.trim());
                              // await userPro.prcIssuePlaceMemberInTree(donPro.prcClearanceMemberId,donPro.prcClearanceUserFcmValue, context);
                            },
                            child: const Text('Place in Tree'),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }


}
