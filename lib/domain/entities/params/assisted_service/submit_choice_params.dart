//{
//     "userId": 236,
//     "userQuizeChoices": [{
//         "quizeChoiceMapId": 5
//     }]
// }

class SubmitChoiceParams {
  final int userId;
  final List<int> userQuizeChoices;

  SubmitChoiceParams({
    required this.userId,
    required this.userQuizeChoices,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userQuizeChoices': userQuizeChoices
          .map((e) => {
                "quizeChoiceMapId": e,
              })
          .toList(),
    };
  }
}
