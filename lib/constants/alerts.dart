import 'package:flutter/material.dart';
import 'package:lio_care/Provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'functions.dart';
import 'my_colors.dart';
void alertContact(context){
  UserProvider homeProvider =
  Provider.of<UserProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title:  Consumer<UserProvider>(
              builder: (context,value,child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(),
                        Text('Contact Us', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: cl7aefba)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text('${homeProvider.appName}',
                        style: const TextStyle(color: Colors.black,fontSize: 13,fontFamily: "PoppinsMedium",fontWeight: FontWeight.w800)),
                    // const Text("Address:",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 14) ,),
                    const Text("3rd Floor, JC Chamber, Building No v8 ,60/49,\nPanampilly Nagar, Kochi,Kerala 682036",style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "PoppinsMedium"),),
                    Text(value.contactUs,style: const TextStyle(color: Colors.black,fontSize: 13),),
                    const SizedBox(height:10 ,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Website ',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "PoppinsMedium"),),
                        // Image.asset('assets/spine.png',scale:4,),
                      ],
                    ),
                    InkWell(
                        onTap: (){
                          _launchURL('https://www.lioclub.in/');
                          finish(context);
                        },
                        child: const Text('https://www.lioclub.in/',style: TextStyle(color: Colors.blueAccent,fontSize: 13,fontFamily: "PoppinsMedium"))),
                    const SizedBox(height:10 ,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Email',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "PoppinsMedium"),),
                        // Image.asset('assets/spine.png',scale:4,),
                      ],
                    ),
                    InkWell(
                        onTap: (){
                          // _launchURL('enterplexlioclub@gmail.com');
                          // finish(context);
                        },
                        child: const Text('enterplexlioclub@gmail.com',style: TextStyle(color: Colors.blueAccent,fontSize: 13,fontFamily: "PoppinsMedium"))),
                    const SizedBox(height:10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Mobile',style: TextStyle(color: Colors.black,fontSize: 13,fontFamily: "PoppinsMedium"),),
                        // Image.asset('assets/neurobots.png',scale:4,),
                      ],
                    ),
                    InkWell(
                        onTap: (){
                          launch("tel://${9847515518}");
                          finish(context);
                        },
                        child: const Text('+91 9847515518',style: TextStyle(color: Colors.blueAccent,fontSize: 13,fontFamily: "PoppinsMedium")))
                  ],
                );
              }
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: InkWell(
                  onTap:(){
                    finish(context);
                  },
                  child: Container(
                    width: 120,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                        color: cl1848A3
                    ),
                    alignment: Alignment.center,
                    child:Text(
                      'Ok',
                      style: TextStyle(
                          fontFamily: "argentumRg",
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )],
        );
      });
}

void alertTerm(context){
  UserProvider homeProvider = Provider.of<UserProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          scrollable: true,
          backgroundColor: myWhite,
          title: Consumer<UserProvider>(
              builder: (context,value,child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(),
                        Text('Privacy Policy',
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: cl7aefba),
                        ) ],
                    ),
                    const SizedBox(height: 10,),
                    Text("Thank you for visiting the website / mobile app of ${homeProvider.appName}(Site) The Privacy Policy is applicable to the websites of ${homeProvider.appName}. This privacy statement also does not apply to the websites of our partners, affiliates, agents or to any other third parties, even if their websites are linked to Site. We recommend you review the privacy statements of the other parties with whom you interact.For the purposes of this privacy policy, \"affiliates\" means any entity or project or venture that is wholly or partially owned or controlled by ${homeProvider.appName}.\"agents\" means any subcontractor, vendor or other entity with whom we have an ongoing business relationship to provide products, services, or information. The following terms governs the collection, use and protection of your personalInformation by the Site. This Privacy Policy shall be applicable to users who visit theSite. By visiting and/ or using the Site you have agreed to the following Privacy Policy.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    const Text("Introduction",style:TextStyle(color: Color(0xFF000000),fontFamily: "argentumRg",fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18)),
                    const SizedBox(height: 10,),
                    Text("As a registered member of the Site and/or as a visitor (if applicable and as the case may be), you will get an insight on the updates and information of the happenings and developments within and by the organisation. In addition, look forward to receiving monthly news letters and updates from the  ${homeProvider.appName}.That's why we've provided this Privacy Policy, which sets forth our policies regarding the collection, use and protection of the Personal Information of those using or visiting the Site. ",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    const Text("Personal Information Collection",style:TextStyle(color: Color(0xFF000000),fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18,fontFamily: "argentumRg")),
                    const SizedBox(height: 10,),
                    Text("The website may collect and use the following kinds of personal information:",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                              width: 5,
                              height: 5,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: myWhite)),
                        ),
                        const SizedBox(width: 3),
                        Flexible(child: Text("Information about your use of this website (including browsing patterns and behaviour)",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,),
                        Flexible(child: Text("Information that you provide using for the purpose of registering with the website (including contact details)",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("Information about transaction carried out over this website ",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("Information that you provide for the purpose of subscribing to the website services (including SMS and email alerts) and any other information that you send to fellow users and webmaster.",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)))
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(width: 16,),Flexible(child: Text("Using Personal Information",style:TextStyle(color: Color(0xFF000000),fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18,fontFamily: "argentumRg") ,)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const SizedBox(width: 16,),Flexible(child: Text("The website may use your personal information to: ",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("administer this website;",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("personalize the website for you;",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("enable your access to and use of the website services;",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("publish information about you on the website;",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite ),),
                        ),const SizedBox(width: 3,), Text("send you communications.",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:16),
                      child: Text("Where the website discloses your personal information to its agents or sub contractors for these purposes, the agent or sub-contractor in question will be obligated to use that personal information in accordance with the terms of this privacy statement ",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:16),
                      child: Text("In addition to the disclosures reasonably necessary for the purposes identified elsewhere above, the website may disclose your personal information to the extent that it is required to do so by law, in connection with any legal proceedings or prospective legal proceedings, and in order to establish, exercise or defend its legal rights. ",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),),
                    ),
                    const  SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const[
                        SizedBox(width: 16,),Text("Securing your Data",style:TextStyle(color: Color(0xFF000000),fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18,fontFamily: "argentumRg") ,),
                      ],
                    ),
                    const  SizedBox(height: 10,),
                    Padding(
                      padding:  const EdgeInsets.only(left:16),
                      child: Text("The website will take reasonable technical and organisational precautions to prevent the loss, misuse or alteration of your personal information. The website will store all the personal information you provide on its secure servers.",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const[
                        SizedBox(width: 16,),Flexible(child: Text("Updating this Statement ",style:TextStyle(color: Color(0xFF000000),fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18,fontFamily: "argentumRg") ,)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding:  const EdgeInsets.only(left:16),
                      child: Text("The website may update this privacy policy by posting a new version on this website. You should check this page occasionally to ensure you are familiar with any changes.",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:const [
                        SizedBox(width: 16,), Text("Other Websites",style:TextStyle(color: Color(0xFF000000),fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18,fontFamily: "argentumRg") ,),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Padding(
                      padding:  const EdgeInsets.only(left:16),
                      child: Text("This website may contain links to other Websites.The website is not responsible for the privacy policies or practices of any third party.",style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),),
                    ),
                  ],
                );
              }
          ),
          actions: [
            Center(
              child: InkWell(
                onTap:(){
                  finish(context);
                },
                child: Container(
                  width: 120,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                      color: cl1848A3
                  ),
                  alignment: Alignment.center,
                  child:Text(
                    'Ok',
                    style:  TextStyle(
                        fontFamily: "argentumRg",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],

        );
      });
}
void alertTermsAndConditions(context){
  UserProvider homeProvider =
  Provider.of<UserProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          scrollable: true,
          backgroundColor: myWhite,
          title:  Consumer<UserProvider>(
              builder: (context,value,child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(),
                        Text('Terms And Conditions', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22, color: cl7aefba)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text("1. Consent and Responsibility:\nI agree to cooperate or register with Lio Club only after reading and understanding each term and condition. I am solely responsible for any consequences, financial, social, psychological, or legal, resulting from my lack of knowledge or intentional or unintentional misguidance.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("2. Eligibility:\nI understand that only Indian citizens above 18 years with good character can associate with Lio Club with the company's approval.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("3. Requirements:\nA smartphone is required for the Lio Club application. I acknowledge the necessity of valid PAN card, Aadhaar card, mobile number, email address, bank account, and UPI ID for a single consumership.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("4. Unconditional Financial Help:\nI commit to providing unconditional direct financial help to registered Lio Club consumers in financial need.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("5. KYC Information:\nI agree to provide KYC information at the time of registering with Lio Club.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("6. Member Recruitment:\nI am responsible for explaining the Lio Club concept, recruiting more than two individuals, and providing financial assistance using my referral link.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("7. Personal Development Programs:\nI understand and commit to participating in personal development programs conducted by Lio Club.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("8. Three Clubs Structure:\nI am aware of the three clubs (MasterClub, StarClub, Crown Club) and their stages, responsibilities, and financial transactions", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("9. Sponsorship Income:\nBy understanding the concept, I agree to earn sponsorship income from new members using my referral link.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("10. Platform Maintenance Charges (PMC) and Club Maintenance Fund (CMF):\n\nI am ready to pay PMC and CMF in phases, acknowledging that the amount paid will not be refunded.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("11. Termination:\nLio Club reserves the right to terminate users engaging in criminal activities or violating terms. Termination may result in a lifetime ban from the platform.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("12. Business Promotion:\nI agree that promoting other businesses using Lio Club consumer information may lead to revocation of consumership.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("13. Punishment Transfer:\nLio Club can transfer consumership to another person as punishment for violating terms and conditions.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("14. Consumer Activation and Deactivation:\nI commit to inviting at least two consumers within 30 days of registration. Failure may result in deactivation of my consumership.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("15. Payment Modes:\nI understand that all financial transactions, including PMC and CMF, will be through UPI only.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("16. Legal Responsibility:\nI take full responsibility for legal consequences if I act against the terms and conditions.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("17. Consumer Transfer:\nLio Club has the right to transfer consumership if a consumer interferes with others' activities.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("18. Digital Transactions:\nUnconditional financial help is allowed only through UPI transactions for a digital India.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("19. Social Media Responsibility:\nOfficial social media accounts are solely responsible for announcements. Lio Club is not liable for statements made by others on social media.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("20. Tax Obligations:\nI acknowledge the personal duty to pay taxes to support the nation's growth.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("21. Legal Action:\nLio Club reserves the right to take legal action against individuals acting against the concept or terms and conditions.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("22. Consent to Share Information:\nI consent to sharing personal information with other consumers for direct financial help through the platform.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("23. Protection Against Insults:\nLio Club has the authority to take legal action if members are insulted or interfered with.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("24. Rule Amendments:\nI acknowledge that Enterplex Digital Solutions LLP reserves the right to make changes for the betterment of Lio Club operations.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                    Text("25. Agreement:\nI have read, understood, and agree to all the terms and conditions listed above.", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 10,),
                  ],
                );
              }
          ),
          actions: [
            Center(
              child: InkWell(
                onTap:(){
                  finish(context);
                },
                child: Container(
                  width: 120,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: cl1848A3
                    // gradient: const LinearGradient(
                    //   begin: Alignment(-1.00, -0.00),
                    //   end: Alignment(1, 0),
                    //   colors: [ Color(0xFF073F85),Color(0xFF32B18A),],
                    // ),
                  ),
                  alignment: Alignment.center,
                  child:const Text(
                    'Ok',
                    style: TextStyle(
                        fontFamily: "argentumRg",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        );
      });

}

void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}
