void main(){
  //Classes. person class
  Person person1 = Person("John", 25, "Male");
  person1.display();
}

class Person{
  //properties
  String? name, sex;
  int? age;

  //constructor
  Person(String name, int age, String sex){
    this.name = name;
    this.age = age;
    this.sex = sex;
  }

  //method
  void display(){
    print("Name: $name");
    print("Age: $age");
    print("Sex: $sex");
  }
}