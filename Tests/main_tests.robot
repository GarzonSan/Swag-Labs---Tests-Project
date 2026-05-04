*** Settings ***
Documentation    This will carry the main/smoke tests for the app
Resource    ../PO/generics.robot
Resource    ../PO/login_page.robot

# Suite Setup    generics.Start Session
# Suite Teardown    generics.End Session No Cookies

*** Test Cases ***
# Login Scenarios #
Authorized User Can Access The Application
    # PRE CONDITION
    [Setup]    generics.Start Session   
     login_page.LogIn User    ${user_standard}
     login_page.Check If Error Was Not Raised
     Sleep    5
    [Teardown]    generics.End Session No Cookies

Locked User Cannot Access The Application
    # PRE CONDITION
    [Setup]    generics.Start Session    
    login_page.LogIn User    ${user_locked}
    login_page.Check If Error Was Raised Properly
    Sleep    5
    [Teardown]    generics.End Session No Cookies