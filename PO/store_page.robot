*** Settings ***
Documentation    This file must contain all store front related keywords for this automation

Resource    generics.robot


*** Variables ***
${store_item_locator_base}    xpath:(//div[@class='inventory_list']//div[@class='inventory_item'])
${store_item_list_locator}    xpath://div[@class='inventory_list']
${store_add_to_cart_button_locator}    xpath:(//button[contains(@id,'add-to-cart-sauce-labs')])
${store_cart_badge_locator}    xpath://span[@class='shopping_cart_badge']

${store_cart_items_amount}    0

*** Keywords ***
Get Initial Cart Items Amount
    ${is_cart_badge_visible}=    Run Keyword And Return Status    Element Should Be Visible    ${store_cart_badge_locator}
    IF    ${is_cart_badge_visible}==False
        Set Suite Variable    ${store_cart_items_amount}    0
    ELSE
        ${store_cart_items_amount}=    Get Text    ${store_cart_badge_locator}
    END

Add Product To Cart
    [Arguments]    ${product_index}

    Log    ${product_index}
    
    Wait Until Element Is Enabled    ${store_add_to_cart_button_locator}\[${product_index}\]    5s
    Click Element    ${store_add_to_cart_button_locator}\[${product_index}\]
    Sleep    1s
    
    Capture Element Screenshot    ${store_item_locator_base}\[${product_index}\]
    
    Wait Until Element Is Visible    ${store_cart_badge_locator}    timeout=5s
    ${current_cart_amount}=    Get Text    ${store_cart_badge_locator}

    IF    ${current_cart_amount}>${store_cart_items_amount}
        Set Suite Variable    ${store_cart_items_amount}    ${current_cart_amount}
    ELSE
        Capture Page Screenshot
        Fail    Cart Badge didn't increase count after adding item.
    END
    