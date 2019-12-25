class Comment {
  String loginName;
  String userPhoto;
  String content;

  Comment({
    this.loginName,
    this.userPhoto,
    this.content
  });

  factory Comment.fromJson(Map<String, dynamic> parsedJson) {
    return Comment(
      loginName: parsedJson['loginName'],
      userPhoto: parsedJson['userPhoto'],
      content: parsedJson['content'],
    );
  }
}