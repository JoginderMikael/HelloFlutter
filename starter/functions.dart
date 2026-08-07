void main(){
  //Functions
  myFunc(){
    print("Hello functions");
  }

  myFunc(); //calling the function

  //Function with parameters
  myFuncWithParams(String name){
    print("Hello $name");
  }

  myFuncWithParams("John"); //calling the function with parameter

  //Function with return type
  int myFuncWithReturnType(int num1, int num2){
    return num1 + num2;
  }

  var result = myFuncWithReturnType(5, 10); //calling the function with return type
  print(result);

}