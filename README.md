# NSOperationDemo
NSOperation相对于GCD也有不少的优势
(1)、可以随时查看一个operation操作的运行状态
(2)、可以取消一个operation和queue (在网络请求中比较实用，GCD虽然是异步执行，
     但是如果网络请求没有返回，那么就无法取消，该线程就会被一直占用，知道请求超时，
    其他任务也只能GCD再开一个新的线程来执行，也会导致资源消耗)
(3)、可以暂停一个queue
(4)、可以等待一个operation完成，但是不要主线程中，会导致UI卡死
(5)、可以设置最大并发数量
(6)、设置operation的优先级
(7)、设置每个opeartion之间的依赖关系
