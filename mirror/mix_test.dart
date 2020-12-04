// abstract class PP{
//   void pp();
// }
//
// class A extends PP{
//   @override
//   void pp(){
//     print('in A');
//   }
// }
//
//
//
// mixin B on A, PP{
//   @override
//   void pp(){
//     print('in B');
//     super.pp();
//   }
// }
//
// class C extends A on B{}
//
//
// void main(){
//   var b = B();
//   b.pp();
// }
