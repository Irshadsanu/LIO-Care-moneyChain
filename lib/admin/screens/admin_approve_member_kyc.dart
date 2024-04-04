import 'package:flutter/material.dart';
import 'package:lio_care/admin/screens/reject_kyc_screen.dart';
import 'package:lio_care/constants/functions.dart';
import 'package:provider/provider.dart';
import '../../Provider/admin_provider.dart';
import '../../constants/my_colors.dart';
import '../../constants/my_texts.dart';
import '../../view/Widgets/my_widgets.dart';
import 'admin_menu_screen.dart';

class ApproveMemberKYC extends StatelessWidget {
  final String memberRegId;

  const ApproveMemberKYC({Key? key, required this.memberRegId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AdminProvider adminProvider =
        Provider.of<AdminProvider>(context, listen: false);
    return Scaffold(
      endDrawer: Drawer(
        width: width,
        child: const AdminMenuScreen(),
      ),
      backgroundColor: bxkclr,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              finish(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: myWhite,
            )),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.92, -0.40),
              end: Alignment(-0.92, 0.4),
              colors: [cl2F7DC1, cl2FC1BC],
            ),
          ),
        ),
        elevation: 0,
        leadingWidth: 25,
        toolbarHeight: 65,
        title: Text(
          "KYC Status Change",
          style: appbarStyle,
        ),
        // actions: [
        //   Center(
        //     child: InkWell(
        //       onTap: (){},
        //       child: Container(
        //         margin: const EdgeInsets.only(right: 10),
        //         height:37,
        //         width:37,
        //         decoration: const BoxDecoration(
        //           shape: BoxShape.circle,
        //           gradient: LinearGradient(
        //             begin: Alignment(0.77, -0.63),
        //             end: Alignment(-0.77, 0.63),
        //             colors: [cl22A2B1,cl2EAEBD],
        //           ),
        //         ),
        //         child: const Icon(Icons.menu),
        //       ),
        //     ),
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: SingleChildScrollView(
          child: Consumer<AdminProvider>(builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Personal Details',
                  style: TextStyle(
                    color: cl303030,
                    fontSize: 16,
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.32,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                DetailsWidget(
                  head: "Name",
                  text: value.membrName,
                  style: TextStyle(
                    color: cl3C3B3B,
                    fontSize: 14,
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.28,
                  ),
                  style2: adAppMemStyle2,
                ), DetailsWidget(
                  head: "Phone",
                  text: value.memberPhn,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "Address",
                  text: value.address,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "Reg.No",
                  text: value.memberRegId,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "Account NO",
                  text: value.accNo,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "IFSC",
                  text: value.ifscCode,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "UPI ID",
                  text: value.upiID,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "PAN Number",
                  text: value.panId,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "Nominee Name",
                  text: value.nomineeName,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "Nominee Phone",
                  text: value.nomineePhone,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "Nominee Year Of Birth",
                  text: value.nomineeAge,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),DetailsWidget(
                  head: "Nominee Relation",
                  text: value.nomineeRelation,
                  style: adAppMemStyle1,
                  style2: adAppMemStyle2,
                ),

                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'PAN Card',
                  style: TextStyle(
                    color: cl303030,
                    fontSize: 16,
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.32,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Container(
                      width: width,
                      height: 250,
                      decoration: BoxDecoration(
                          color: cl303030.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(10)),
                      child: value.panImg == ''
                          ? const Center(child: CircularProgressIndicator())
                          : Image.network(
                              value.panImg,
                            ));
                }),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Aadhaar Image',
                  style: TextStyle(
                    color: cl303030,
                    fontSize: 16,
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.32,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Container(
                      width: width,
                      height: 250,
                      decoration: BoxDecoration(
                          color: cl303030.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(10)),
                      child: value.aadhaarImg == ''
                          ? const Center(child: CircularProgressIndicator())
                          : Image.network(
                              value.aadhaarImg,
                            ));
                }),
                const SizedBox(
                  height: 5,
                ),
                Consumer<AdminProvider>(builder: (context, value, child) {
                  return Container(
                      width: width,
                      height: 250,
                      decoration: BoxDecoration(
                          color: cl303030.withOpacity(0.10),
                          borderRadius: BorderRadius.circular(10)),
                      child: value.aadhaarSecondSideImg == ''
                          ? const Center(child: Text(
                        'Not Uploaded',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontFamily: 'PoppinsRegular',
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.24,
                        ),
                      ),)
                          : Image.network(
                              value.aadhaarSecondSideImg,
                            ));
                }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          // adminProvider.memberKYCStatusChange(
                          //     memberRegId, "REJECTED", context);
                          value.selectedReason="";
                          value.kycRejectReasonController.clear();
                          callNext(RejectKycScreen(name: value.nomineeName , memberRegId: memberRegId),context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              color: clFFFCF8,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 0.50, color: const Color(0xFF2F7DC1))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Reject',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cl2F7DC1,
                                fontSize: 14,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {
                          adminProvider.memberKYCStatusChange(
                              memberRegId, "VERIFIED", context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          decoration: BoxDecoration(
                              color: cl2F7DC1,
                              borderRadius: BorderRadius.circular(100)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Approve',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: cWhite,
                                fontSize: 14,
                                fontFamily: 'PoppinsRegular',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 0.24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20)
              ],
            );
          }),
        ),
      ),
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final String head;
  final String text;
  final TextStyle style;
  final TextStyle style2;

  const DetailsWidget(
      {super.key,
      required this.head,
      required this.text,
      required this.style,
      required this.style2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            head,
            style: style,
          ),
        ),
        Text(": "),
        Expanded(
          flex: 7,
          child: Text(
            text,
            style: style2,
          ),
        )
      ],
    );
  }
}
