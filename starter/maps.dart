void main(){
  //Maps! Key/Value pairs
  var toppings = {
    "John":"Pepperoni",
    "Mary":"Sausage",
  };

  print(toppings); // {John: Pepperoni, Mary: Sausage}
  print(toppings["John"]); // Pepperoni

  //show values
  print(toppings.values);

  //show keys
  print(toppings.keys);

  //show length
  print(toppings.length);


  //add something
  toppings["Bob"] = "Mushrooms";
  print(toppings); // {John: Pepperoni, Mary: Sausage, Bob: Mushrooms}

  //add many things
  toppings.addAll({
    "Alice":"Onions",
    "Eve":"Green Peppers",
  });


  //remove something
  toppings.remove("Mary");
  print(toppings); // {John: Pepperoni, Bob: Mushrooms, Alice: Onions, Eve: Green Peppers}
  //remove everything
  toppings.clear();
  print(toppings); // {}

}