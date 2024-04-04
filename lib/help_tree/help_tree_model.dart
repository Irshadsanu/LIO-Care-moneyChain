class HelpTreeOldModel{

  String userId;
  String userDocId;
  String userName;
  String userImage;
  String userPhone;

  HelpTreeOldModel(this.userId, this.userDocId, this.userName, this.userImage, this.userPhone);
}

class HelpTreeModel{

  String userId;
  String userDocId;
  String userName;
  String userImage;
  String userPhone;
  List<dynamic> childList;
  HelpTreeModel(this.userId, this.userDocId, this.userName, this.userImage, this.userPhone, this.childList);
}
class ChildrenListModel{

  String userId;
  String tree;
  String userDocId;
  String userName;
  String userPhone;
  int childCount;
  List<dynamic> treeList;
  String grade;
  ChildrenListModel(this.userId, this.userDocId, this.userName,this.userPhone,this.tree, this.childCount,this.treeList,this.grade);
}
