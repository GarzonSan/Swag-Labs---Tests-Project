*** Settings ***
Documentation    This file contains all keywords that might be shared
...              between the scripts.

Library    SeleniumLibrary

*** Variables ***
${target_browser}    chrome
${base_app_url}    https://www.saucedemo.com/

# user names
${user_standard}    standard_user
${user_locked}    locked_out_user
${user_problem}    problem_user
${user_performance_glitch}    performance_glitch_user
${user_error}    error_user
${user_visual}    visual_user

# default passwords used for all users
${test_env_password}    secret_sauce

*** Keywords ***


Start Session
    IF    '${target_browser}' == 'chrome'
        ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

        # Disable common popups
        Call Method    ${options}    add_argument    --disable-notifications
        Call Method    ${options}    add_argument    --disable-infobars
        Call Method    ${options}    add_argument    --disable-geolocation
        Call Method    ${options}    add_argument    --disable-extensions

        # Disabling password manager and password leak protection popups due to the nature of this test application
        # as it has default users and dont let an account to be created for testing. So this password is already leaked for obvious reasons thus I took the decision in ignore this as this occurs due to this test application's intended deesign
        ${prefs}=    Evaluate    {"credentials_enable_service": False, "profile.password_manager_enabled": False, "profile.password_manager_leak_detection": False}
        Call Method    ${options}    add_experimental_option    prefs    ${prefs}

        Create WebDriver    Chrome    options=${options}
    END
    Go To    ${base_app_url}

End Session No Cookies
    Delete All Cookies
    Close Browser

End Session
    Close Browser

Goto Page URL
    [Arguments]    ${url_complement}
    Go To    ${base_app_url}${url_complement}
    Sleep    4