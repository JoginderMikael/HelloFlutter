import 'dart:io';
void main(){
  //User Inputs
  print("Enter your name: ");
 // var name = stdin.readLineSync();
 String? name = stdin.readLineSync(); //cant read ints. String? is nullable type. It can be null. If you want to read int, you have to use int.parse() method.
  print("Hello $name");
}