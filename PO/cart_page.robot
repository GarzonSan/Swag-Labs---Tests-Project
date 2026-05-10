*** Settings ***
Documentation    This script contains all keywords used to interact directly with the cart page within the application

# Due to the nature of the page structure, some structures from the store page are carried to the cart page thus, making it possible to reuse functions from the store page's automations
Resource    store_page.robot


*** Variables ***
# page
${cart_page_url_complement}    cart.html

# processing
${cart_continue_shopping_button_locator}    xpath://button[@id='continue-shopping']
${cart_checkout_button_locator}    xpath://button[@id='checkout']

# items interactions
${cart_list_item_locator}    xpath:(//div[@class='cart_item'])
${cart_item_remove_button_locator}    xpath:(//div[@class='cart_item']//div[@class='item_pricebar']//button[contains(@id,'remove-sauce-labs')])

# test variables
${cart_items_amount}    0

*** Keywords ***
Update Cart Items Amount
    @{items}=    Get WebElements    ${cart_list_item_locator}
    ${cart_items_amount}=    Get Length    ${items}

Remove Top Item From Cart
    [Setup]    Update Cart Items Amount
    ${current_items_amount}=    Set Variable    ${cart_items_amount}

    Click Element    ${cart_item_remove_button_locator}
    Sleep    0.5
    Update Cart Items Amount

    IF    ${current_items_amount}>=${cart_items_amount}
        Fail    Cart item count didnt update after item removal.
        Capture Page Screenshot
    ELSE
        Log    Cart item updated accordingly after item removal.
    END

Add New Item To The Cart
    [Arguments]    ${item_index}
    [Setup]    Update Cart Items Amount
    ${current_items_amount}=    Set Variable    ${cart_items_amount}

    # Goto previous/store page
    Click Element    ${cart_continue_shopping_button_locator}
    Sleep    2
    # add new item from store page
    store_page.Add Product To Cart    ${item_index}
    # return to cart page
    generics.Goto Page URL    ${cart_page_url_complement}

    Update Cart Items Amount
    IF    ${current_items_amount}>=${cart_items_amount}
        Fail    Cart item count didnt update after adding a new item.
        Capture Page Screenshot
    ELSE
        Log    Cart item updated accordingly after adding a new item.
    END

