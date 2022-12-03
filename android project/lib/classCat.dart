class Cat{
  // defing properties
  String? name;
  String? color;
  // none nulleable field ?
  //var dataType = value;
  
  //named arguments dont care about order but they need propperties names
  //used when lots or arguments are being used
  
  Cat({this.color, this.name = "Tom"}); // tom as a default argumnt, @require field flutter
  
}

// named arguments
//constructors

void giveNewColor(){
  var newColor = Cat();
  print(newColor.color = "brown");
}


 void main() {
   giveNewColor();
   
   var notTomCat = Cat( name: 'insaneCat', color:'Yellow');
   print(notTomCat.name);
    
}
