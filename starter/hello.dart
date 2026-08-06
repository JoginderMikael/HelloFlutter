void main(){
  print('Hello Joginder!');
  print(1+1);

  int a = 10;
  print(a);
  for(int i=0; i<5; i++){
    print(i);
  }

  if (a>5){
    print('a is greater than 5');
  } else {
    print('a is less than or equal to 5');
  }

  print(a>5 ? 'a is greater than 5' : 'a is less than or equal to 5');

  String name = 'Joginder'; // String interpolation
  var name1 = 'Joginder'; // Type inference
  var x = 32;
  dynamic y = 32; // Dynamic type

  const String name2 = 'Joginder'; // Constant variable
  final String name3 = 'Joginder'; // Final variable

  var myName;
  print(myName); // null

  myName = 'Joginder';
  print(myName); // Joginder

  


}