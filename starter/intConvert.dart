void main(){
  //Convert Strings, ints and doubles
  String str = "5";
  int num = int.parse(str); //convert string to int
  print(num);

//to int
  var a, b, c;

  a = 40;
  b = "20";
  c = a + int.parse(b); //convert string to int
  print(c);


  //to double

  var d, e, f;
  d = 40;
  e = "20.5";
  f = d + double.parse(e); //convert string to double
  print(f);


  //int to string
  var g, h, i;
  g = 40;
  h = "1";
  i = g.toString() + h; //convert int to string
  print(i);

}