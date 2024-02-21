class HMWModel {
  String problemContent;
  List hmws;

  HMWModel({required this.problemContent, required this.hmws});

  HMWModel.fromJson(Map<String, dynamic> json)
      : problemContent = json['problem_content'] ?? "",
        hmws = json['hmws'] ?? [];
}
