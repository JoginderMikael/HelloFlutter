void main() {
  // Lists
  var myList = [1, 2, 3, 4, 5];
  print(myList); // [1, 2, 3, 4, 5]
  print(myList[0]); // 1

  //Change an item
  myList[0] = 10;
  print(myList); // [10, 2, 3, 4, 5]

  //Create an empty list
  var emptyList = [];
  print(emptyList); // []

  //Add multiple to empty list
  emptyList.add(5);
  print(emptyList); // [5]

  emptyList.addAll([1, 2, 3]);
  print(emptyList); // [5, 1, 2, 3]

  //Insert a specific position (position, item)
  myList.insert(1, 15);
  print(myList); // [10, 15, 2, 3, 4, 5]

  //Insert many

  myList.insertAll(2, [20, 25]);
  print(myList); // [10, 15, 20, 25, 2, 3, 4, 5]

  //Mixed list
  var mixedList = [1, 'Joginder', true, 3.14];
  print(mixedList); // [1, Joginder, true, 3.14

  //remove from list
  myList.remove(25);
  print(myList); // [10, 15, 20, 2, 3, 4, 5]

  //remove from specific location (position)
  myList.removeAt(1);
  print(myList); // [10, 20, 2, 3, 4, 5]
}