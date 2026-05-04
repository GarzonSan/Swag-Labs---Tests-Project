*** Settings ***
Documentation    This will carry the main/smoke tests for the app
Resource    ../PO/generics.robot

Suite Setup    generics.Start Session
Suite Teardown    generics.End Session No Cookies

*** Test Cases ***
# Login Scenarios #
Authorized User Can Access The Application
    # PRE CONDITION
    # The pre condition for this case is already met during this suite's setup
     Sleep    2
     Log    Testing the environment configuration