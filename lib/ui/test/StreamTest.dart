

void main()=>Stream.fromIterable([1,2,3,4]).listen((e)=>print(e),onDone: ()=>print('Done'));
class StreamTest {

  var data = [1, 2, 3, 4];


  void test1() {
    var stream = Stream.fromIterable(data);

    stream.listen(
        (e)=>print(e),
    );



  }


}