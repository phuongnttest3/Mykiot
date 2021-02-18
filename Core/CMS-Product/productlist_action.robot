*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Library           SeleniumLibrary
Resource          ../Share/Computation.robot
Resource          ../CMS-Product/productlist_locator.robot


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

click off product va kiem tra
    click to element  ${btn_onproductactive}
    wait until element is visible  ${message_success}  10s
    click to element  ${xemsanpham_storefront}
    select window   title= MyKiot
    page should not contain element  ${product_show}

click on product va kiem tra
    click to element  ${btn_offproductactive}
    wait until element is visible  ${message_success}  10s
    click to element  ${xemsanpham_storefront}
    select window   title= Hàng thành phần
    page should contain element  ${product_show}
