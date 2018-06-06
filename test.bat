@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
SET /A ALL_COUNT = 10
for /L %%A IN (1, %NUMBER_OF_PROCESSORS%, %ALL_COUNT%) do (
  REM ���݂�cmd.exe�̋N���v���Z�X����ۑ����Ă���
  FOR /F "usebackq delims=" %%B IN (`TASKLIST ^| FIND /C "cmd.exe"`) do SET /A TASK_LIST_BASE = %%B
  SET /A END = "%%A + %NUMBER_OF_PROCESSORS% - 1"
  IF /I !END! GTR %ALL_COUNT% (
    SET /A END = %ALL_COUNT%
  )
  for /L %%B IN (%%A, 1, !END!) do (
    REM ���������[�v����������
    start test_timeout
  )

  REM �I���m�F�̃��[�v��������
  :CHECK_FINISH
    REM ���݂�cmd.exe�̋N���v���Z�X�������[�v�O�Ɠ����������玟�̏����֐i��
    FOR /F "usebackq delims=" %%B IN (`TASKLIST ^| FIND /C "cmd.exe"`) do SET /A TASK_LIST_NOW = %%B
    IF /I !TASK_LIST_BASE! NEQ !TASK_LIST_NOW! (
      REM PowerShell���g�����͂��D�݂ŁiPowerShell�łȂ��ƃ~���b�P�ʂŊm�F�ł��Ȃ��j
      REM TIMEOUT 1 > NUL
      REM PowerShell sleep -m 1
      PowerShell sleep -m 1
      CALL :CHECK_FINISH
    )
  REM �I���m�F�̃��[�v�����܂�
)
