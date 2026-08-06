void main(){
  //Number, String, Boolean, List, Map, Set, dynamic

  //Strings
  String name = 'Joginder'; // String interpolation
  var name1 = 'Joginder'; // Type inference

  print("String interpolation: My name is $name");
  print("Type inference: My name is $name1");

//Integers
  var x = 32;
  dynamic y = 32; // Dynamic type

  print("Integer: $x");
  print("Dynamic: $y");

  //Constants and Final
  const String name2 = 'Joginder'; // Constant variable
  final String name3 = 'Joginder'; // Final variable

  print("Constant: $name2");
  print("Final: $name3");

  //Null safety
  var myName;
  print(myName); // null

  myName = 'Joginder';
  print(myName); // Joginder

  //Double
  double pi = 3.14;
  print("Double: $pi");

  //Dynamic
  dynamic myVariable = 'Hello';
  print("Dynamic: $myVariable");
}