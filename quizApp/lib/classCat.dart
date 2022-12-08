class Cat{
  // defing properties

  String? name;
  // may hold a null value
  
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

   // null safety


    
}

    // ElevatedButton(
    //     onPressed: () => print('anonymous pressed'),
    //     child: Text('Second')),
    // ElevatedButton(
    //     onPressed: () {
    //       //..
    //       print('serie of commands button pressed');
    //     },
    //     child: Text('Third'))

    // re painted
    // re created 
    