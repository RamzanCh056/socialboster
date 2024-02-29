class UserModel {
  String userName;
  String userEmail;
  String userPassword;
  DateTime userAccountCreationDate;
  String userProfileImage;
  String userUid;
  bool premiumUser;
  int userPostsLimit;
  int userFollowing;
  int userFollowers;

  static const String name = "name";
  static const String email = "email";
  static const String password = "password";
  static const String accountCreationDate = "accountCreationDate";
  static const String profileImg="profileImage";
  static const String userId="userId";
  static const String isPremium="isPremium";
  static const String postLimit="postLimit";
  static const String following="following";
  static const String followers="followers";

  UserModel({
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userAccountCreationDate,
    required this.userProfileImage,
    required this.userUid,
    required this.userPostsLimit,
    required this.premiumUser,
    required this.userFollowers,
    required this.userFollowing
  });

  toMap() =>
      {
        name: userName,
        email: userEmail,
        password: userPassword,
        accountCreationDate: userAccountCreationDate,
        profileImg:userProfileImage,
        userId:userUid,
        postLimit:userPostsLimit,
        isPremium:premiumUser,
        following:userFollowing,
        followers:userFollowers
      };

  factory UserModel.fromJson(Map<String, dynamic> json)=>
      UserModel(
          userName: json[name],
          userEmail: json[email],
          userPassword: json[password],
          userAccountCreationDate: json[accountCreationDate].toDate(),
        userProfileImage: json[profileImg]??"",
        userUid: json[userId]??"",
        premiumUser: json[isPremium]??false,
        userPostsLimit: json[postLimit]??0,
        userFollowers: json[followers]??0,
        userFollowing: json[following]??0
      );

}