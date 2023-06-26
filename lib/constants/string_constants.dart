class Screens {
  static const String askAi = "Ask AI";
  static const String automateResults = "Automate results";
}

String getReq(String fullName, String city, String classNum, String subject) =>
    "I am $fullName live in $city, India and just have completed $classNum th class, suggest me next steps can be taken for my career according to indian education system if my favourite subject is $subject";
