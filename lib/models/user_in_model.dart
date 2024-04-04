class UserInModel{

  String id ;
  String flow ;
  String memberId ;
  String image ;
  String screenShot ;
  String name ;
  String number ;
  String status ;
  String showStatus ;
  String amount ;
  String date;
  String time ;
  String grade ;
  String tree ;
  String inTree ;
  String userDoc ;
  String paymentType ;

  UserInModel(this.id,this.memberId, this.image, this.screenShot, this.name, this.number,
      this.status, this.showStatus, this.amount,this.date,this.time,this.grade,this.tree,this.inTree,this.paymentType,this.userDoc,this.flow);
}


class MyTaskModel{

  String id;
  String heading;
  String task;
  String link;
  String duration;
  String addedTime;
  String status;
  MyTaskModel(this.id,this.heading,this.task,this.link,this.duration,this.addedTime,this.status);
}