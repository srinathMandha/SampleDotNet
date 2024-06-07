REM Define the parameter store key
set ParamStoreKey=FYTC_Current_Deploying_App

REM Retrieve the parameter value using AWS CLI
for /f "delims=" %%i in ('aws ssm get-parameter --name "%ParamStoreKey%" --query "Parameter.Value" --output text') do set AppPoolName=%%i

REM Check if the AppPoolName is set
if "%AppPoolName%"=="" (
    echo Failed to retrieve the application pool name from the parameter store.
    exit /b 1
)
echo "%ParamStoreKey%"
