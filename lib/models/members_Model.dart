class MembersModel{

  String docID;
  String name;
  String memberReferredBy;
  String phone;
  String regid;
  String regDate;
  DateTime regDateTime;
  String pmc;
  String donations;
  String giveHelp;
  String receiveHelp;
  String proImage;
  String invitor;
  String kycStatus;
  String type;
  String kycSubmittedDate;
  String kycVerifiedDate;
  String kycRejectedDate;
  String kycRejectedReason;

  MembersModel(this.docID,this.name,this.memberReferredBy,
      this.phone,this.regid,this.regDate,this.regDateTime,this.pmc,
      this.donations,this.giveHelp,this.receiveHelp,this.proImage,
      this.invitor,this.kycStatus,this.type,this.kycSubmittedDate,
      this.kycVerifiedDate,this.kycRejectedDate,this.kycRejectedReason,);
}