class PMCModel {

  String id;
  String date;
  String status;
  String amount;
  String levelName;
  String tree;
  String time;
  String installment;


  PMCModel(this.id,this.date,this.status,this.amount,this.levelName,this.tree,this.time,this.installment);
}

class DonationModel {

  String id;
  String name;
  String number;
  String profileImage;



  DonationModel(this.id,this.name,this.number,this.profileImage,);
}

class InvitationModel {
  String name;
  String id;
  String phone;
  String date;
  String status;
  String amount;
  InvitationModel(this.name,this.id,this.phone,this.date,this.status,this.amount,);
}

class UpgradeModel{
  String name;
  String id;
  String phone;
  String amount;
  UpgradeModel(this.name,this.id,this.phone,this.amount,);
}

class AdminPMCDetails{
  String id;
  String name;
  String regId;
  String transactionId;
  String level;
  String gst;
  String amount;
  String date;
  String time;
  String phone;
  DateTime pmcDateTime;



  AdminPMCDetails(this.id,this.name,this.regId,this.transactionId,
      this.level,this.gst,this.amount,this.date,this.time,this.phone,this.pmcDateTime);
}

class AdminDonationDetails{
  String id;
  String name;
  String distribution;
  String phoneNo;
  String amount;
  String date;
  String time;
  DateTime dateTime;
AdminDonationDetails(this.id,this.name,this.distribution,this.phoneNo,this.amount,this.date,this.time,this.dateTime);
}
