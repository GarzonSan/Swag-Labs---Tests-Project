*** Settings ***
Documentation    This file must contain all store front related keywords for this automation

Resource    generics.robot


*** Variables ***
${store_item_locator_base}    //div[@class='inventory_list']//div[@class='inventory_item']
${store_item_list_locator}    //div[@class='inventory_list']
${store_add_to_cart_button_locator}    //button[contains(@id,'add-to-cart-sauce-labs')]
${store_cart_badge_locator}    //span[@class='shopping_cart_badge']

${store_cart_items_amount}    0

*** Keywords ***
Get Initial Cart Items Amount
    ${is_cart_badge_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath:${store_cart_badge_locator}
    IF    ${is_cart_badge_visible}==False
        Set Suite Variable    ${store_cart_items_amount}    0
    ELSE
        ${store_cart_items_amount}=    Get Text    xpath:${store_cart_badge_locator}
    END

Add Product To Cart
    [Arguments]    ${product_index}

    Log    ${product_index}
    
    Wait Until Element Is Enabled    xpath:(${store_add_to_cart_button_locator})[${product_index}]    4s
    Click Element    xpath:(${store_add_to_cart_button_locator})[${product_index}]
    Sleep    1s
    
    Capture Element Screenshot    xpath:(${store_item_locator_base})[${product_index}]
    
    Wait Until Element Is Visible    xpath:${store_cart_badge_locator}    timeout=5s
    ${current_cart_amount}=    Get Text    xpath:${store_cart_badge_locator}

    IF    ${current_cart_amount}>${store_cart_items_amount}
        Set Suite Variable    ${store_cart_items_amount}    ${current_cart_amount}
    ELSE
        Capture Page Screenshot
        Fail    Cart Badge didn't increase count after adding item.
    END
    