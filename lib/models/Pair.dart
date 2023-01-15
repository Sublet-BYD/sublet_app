import 'package:flutter/material.dart';

// This class is an object which holds two other objects within it. It will mostly be used for the combination of Property and Owner_data, such as in 'Asset_Page.dart', but might be useful for other pairings.

class Pair<T1, T2> implements Comparable<Pair>{
  final T1 obj1;
  final T2 obj2;

  Pair(this.obj1, this.obj2);

  @override
  int compareTo(Pair other){ // This function is used to compare the first element of two pairs. It is used in Guest_Feed to localy sort the properties by price.
    if(other.obj1 > obj1){
      return -1;
    }
    if(other.obj1 < obj1){
      return 1;
    }
    return 0;
  }
} 