*** Settings ***
Library           SeleniumLibrary
Resource          Common_locator.robot
Resource          ../API/api_core_customer.robot

*** Keywords ***
Tim kiem san pham
    [Arguments]    ${input_text}
    Wait until element is visible    ${txt_searchfe}
    input text    ${txt_searchfe}    ${input_text}
    click element    ${btn_searchfe}

Clear customer cart
    ${product_code}    Get customer cart
    ${length_code}=    get length    ${product_code}
    : FOR    ${i}    IN RANGE    ${length_code}
    \    ${item_code}    get from list    ${product_code}    ${i}
    \    Detele customer carts from api    ${item_code}
    \    exit for loop if    '${i}'=='${length_code}'
