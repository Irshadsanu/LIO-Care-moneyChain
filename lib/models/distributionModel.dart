class DistributionModel{

  String amount;
  String toId;
  String distributionId;
  String screenShot;
  String type ;
  String status;
  String toStatus;
  String fromGrade;
  String toDocId;
  String tree;
  String proImage;
  String name;
  String phoneNumber;
  String upiId;
  String fromId;
  String date;
  int installment;


  DistributionModel(this.amount,this.toId,this.distributionId,this.screenShot,this.type,
      this.status,this.toStatus,this.fromGrade,this.toDocId,this.tree,this.proImage,this.name,
      this.phoneNumber,this.upiId,this.fromId,this.date,this.installment);
}

class CompanyLevelModel{
  String levelName;
  String levelTree;
  bool color;
  CompanyLevelModel(this.levelName, this.levelTree,this.color);
}

class CompanyTreeModel{
  String levelName;
  bool color;
  CompanyTreeModel(this.levelName,this.color);
}