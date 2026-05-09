*** Settings ***
Documentation    This will carry the main/smoke tests for the app
Resource    ../PO/generics.robot
Resource    ../PO/login_page.robot
Resource    ../PO/store_page.robot
Resource    ../PO/cart_page.robot

# Suite Setup    generics.Start Session
# Suite Teardown    generics.End Session No Cookies

*** Test Cases ***
# Login Scenarios #
Authorized User Can Access The Application
    # PRE CONDITION
    [Setup]    generics.Start Session   
     login_page.LogIn User    ${user_standard}
     login_page.Check If Error Was Not Raised
    [Teardown]    generics.End Session No Cookies

Locked User Cannot Access The Application
    # PRE CONDITION
    [Setup]    generics.Start Session    
    login_page.LogIn User    ${user_locked}
    login_page.Check If Error Was Raised Properly
    [Teardown]    generics.End Session No Cookies

# Store Page Scenarios
User Can Access Store Page Properly
    # PRE CONDITION
    [Setup]    generics.Start Session
    login_page.LogIn User    ${user_standard}
    Get Initial Cart Items Amount

User Can Add Items To The Cart
    store_page.Add Product To Cart    2
    store_page.Add Product To Cart    3

# Cart Page Scenarios [WIP]
Cart Items Amount Was Correctly Placed
    Goto Page URL    cart.html
    cart_page.Get Cart Items Amount