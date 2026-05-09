*** Settings ***
Documentation    This script contains all keywords used to interact directly with the cart page within the application

# Due to the nature of the page structure, some structures from the store page are carried to the cart page thus, making it possible to reuse functions from the store page's automations
Resource    store_page.robot


*** Variables ***
# processing
${cart_continue_shopping_button_locator}    xpath://button[@id='continue-shopping']
${cart_checkout_button_locator}    xpath://button[@id='checkout']

# items interactions
${cart_list_item_locator}    xpath:(//div[@class='cart_item'])
${cart_item_remove_button_locator}    xpath:(//div[@class='cart_item']//div[@class='item_pricebar']//button[contains(@id,'remove-sauce-labs')])

# test variables
${cart_items_amount}    0

*** Keywords ***
Get Cart Items Amount
    @{items}=    Get WebElements    ${cart_list_item_locator}
    ${cart_items_amount}=    Get Length    ${items}
    Log    ${items}
    Log    ${cart_items_amount}