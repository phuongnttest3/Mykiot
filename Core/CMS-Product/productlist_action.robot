*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Library           SeleniumLibrary
Resource          ../Share/Computation.robot

*** Keywords ***
Assert saleprice is updated
    [Arguments]    ${sale_price_update}    ${locator}
    ${sale_price}    Convert price to number    ${locator}
    Should be equal as numbers    ${sale_price}    ${sale_price_update}

Assert product of pricebook is deleted
    [Arguments]    ${locator}
    ${price}    get text    ${locator}
    Should be equal as strings    ${price}    _

Assert product of pricebook is not deleted
    [Arguments]    ${locator}
    ${price}    get text    ${locator}
    Should not be equal as strings    ${price}    _
