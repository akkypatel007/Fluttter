import 'AbstractEx.dart';
import 'Demo.dart';
import 'HierarchicalEx.dart';
import 'HybridEx.dart';
import 'MultilevelEx.dart';
import 'MultipleEx.dart';
import 'OverridingEx.dart';
import 'SingleEx.dart';
import 'StaticEx.dart';
import 'SuperEx.dart';

void main() {
//SingleEx
  // var b = B();
  // b.a();
  // b.b();

//MultilevelEx
  // var r = R();
  // r.p();
  // r.q();
  // r.r();

//HierarchicalEx
  // var c = Current();
  // var s = Save();

  // c.current();
  // s.save();
  // c.bank();

//MultipleEx
  // var c = C1();
  // c.a1();
  // c.b1();

//demo
  // var tv = Television();
  // tv.volumeUp();
  // tv.volumeDown();

//HybridEx
  // var s =S1();
  // s.p1();
  // s.q1();
  // s.r1();

//OverRidingEx
  // var s = Sbi();
  // var i = Icici();
  // var a = Axis();

  // var b = BOI();
  // var H = HDFC();
  // var r = RDCB();

  // print(s.rate());
  // print(i.rate());
  // print(a.rate());

  // print(b.rate());
  // print(H.rate());
  // print(r.rate());

  // or

  // var b = Bank1();

  // b = Sbi();
  // print(b.rate());

  // b = Icici();
  // print(b.rate());

  // b = Axis();
  // print(b.rate());

//AbstractEx
  // var s= Circle();
  // s.draw();

  // var s2= Rectangle();
  // s2.draw();

//StaticEx
  var c1 = Counter();
  var c2 = Counter();
  var c3 = Counter();

  Counter.xyz();

//SuperEx
  // var b = B12();
  // b.colors();
}
