*** Settings ***
Documentation    This script contains all Login Page related functions
Library    SeleniumLibrary
Library    ../venv/Lib/site-packages/robot/libraries/XML.py
Resource    generics.robot

*** Variables ***
${login_field_locator}    xpath://input[@id='user-name']
${passw_field_locator}    xpath://input[@id='password']
${submit_button_locator}    xpath://input[@id='login-button']
${error_message_container_locator}    xpath://div[@class='error-message-container error']


*** Keywords ***
Enter Username
    [Arguments]    ${username}
    Input Text    ${login_field_locator}    ${username}

Enter Password
    Input Text    ${passw_field_locator}    ${test_env_password}

Submit LogIn Form
    Click Button    ${submit_button_locator}

Check If Error Was Not Raised
    Wait Until Element Is Not Visible    ${error_message_container_locator}  

Check If Error Was Raised Properly
    Wait Until Element Is Visible    ${error_message_container_locator}

## LOGIN PAGE TASKS
LogIn User
    [Arguments]    ${username}
    Enter Username    ${username}
    Enter Password
    Submit LogIn Form
    Sleep    4