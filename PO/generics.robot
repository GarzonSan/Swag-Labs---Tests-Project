*** Settings ***
Documentation    This file contains all keywords that might be shared
...              between the scripts.

Library    SeleniumLibrary

*** Variables ***
${target_browser}    Chrome
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
    Open Browser    ${base_app_url}    ${target_browser}

End Session No Cookies
    Delete All Cookies
    Close Browser

End Session
    Close Browser

Goto Page URL
    [Arguments]    ${url_complement}
    Go To    ${base_app_url}${url_complement}
    Sleep    4