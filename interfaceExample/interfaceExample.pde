interface Foo{
  String getName();
}

abstract class Baz implements Foo {

}

class Bar extends Baz {
  String getName(){
    return "Bar";
  }
}

void setup(){
  System.out.println("hello world");
}
