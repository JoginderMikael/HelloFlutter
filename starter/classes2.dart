void main(){
  //Classes. person class without initialization in constructor
  Person person1 = Person();
  person1.addData("John", 25, "Male");
  person1.display();
  
}

class Person{
  //properties
  String? name, sex;
  int? age;

  //Method
  void addData(String name, int age, String sex){
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