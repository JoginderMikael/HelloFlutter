import 'dart:io';

void main(){
  //User input type conversion.
  print("Enter your age: ");
  String? age = stdin.readLineSync(); //read input as string
  //print(age + 10);

  //convert string to int
  int ageInt = int.parse(age!); //convert string to int
  print(ageInt + 10); //add 10 to the age
}