# multi-thread-windows-bat

WindowsのバッチでマルチスレッドとCPUスレッド分の処理が終わってから次の処理を行うことを仮想的に実現するための構文です  
タスクが10個あってCPUのスレッドが4個なら最初に4つ並列実行し、その4つが全部終わったタイミングで再び4つ実行し、その4つが終わったタイミングで2つ実行します  
これで全てが終わったときに合計で10個分のタスクが完了しています

この判定は正確ではなく、単純にcmd.exeの実行プロセス数を見ているだけなのでこの処理中に別途cmd.exeを実行してしまうとタイミングによっては終了判定が取れず詰みます  
この構文で判定を取ることも考えましたが、非常に面倒なので止めました
~~~
wmic process where "name = 'cmd.exe'" get ProcessId
~~~
