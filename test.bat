@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET /A ALL_COUNT = 10
for /L %%A IN (1, %NUMBER_OF_PROCESSORS%, %ALL_COUNT%) do (
  REM 現在のcmd.exeの起動プロセス数を保存しておく
  FOR /F "usebackq delims=" %%B IN (`TASKLIST ^| FIND /C "cmd.exe"`) do SET /A TASK_LIST_BASE = %%B
  SET /A END = "%%A + %NUMBER_OF_PROCESSORS% - 1"
  IF /I !END! GTR %ALL_COUNT% (
    SET /A END = %ALL_COUNT%
  )
  for /L %%B IN (%%A, 1, !END!) do (
    REM ここがループしたい処理
    start test_timeout
  )

  REM 終了確認のループここから
  :CHECK_FINISH
    REM 現在のcmd.exeの起動プロセス数をループ前と同じだったら次の処理へ進む
    FOR /F "usebackq delims=" %%B IN (`TASKLIST ^| FIND /C "cmd.exe"`) do SET /A TASK_LIST_NOW = %%B
    IF /I !TASK_LIST_BASE! NEQ !TASK_LIST_NOW! (
      REM PowerShellを使うかはお好みで（PowerShellでないとミリ秒単位で確認できない）
      REM TIMEOUT 1 > NUL
      REM PowerShell sleep -m 1
      PowerShell sleep -m 1
      CALL :CHECK_FINISH
    )
  REM 終了確認のループここまで
)
