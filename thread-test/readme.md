My understanding after these tests:

* You can't access directly to variables declared in another thread (except for [inheritance](https://sonic-pi.net/tutorial.html#section-5-4)).
* But you can access to methods declared in another thread, and these methods can access to variables declared in the same thread.
  * /!\ So you can indirectly access and modify variables declared in another thread throught methods calls!! /!\
* If you want to be sure that no other thread will access to a local variable, even throught methods calls, you have to use Thread.current[:my_variable].
* If a method declared in any thread uses Thread.current[:my_variable], you can use this method from any other thread as long as you set Thread.current[:my_variable] in each thread using the method.