*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn

*** Keywords ***
Get data page from api
    [Arguments]    ${retailer_id}
    ${heades1}=    create dictionary    store-id=${retailer_id}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    v1/pages    headers=${heades1}
    log    ${resp1.json()}
    ${data}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data
    Should be equal as strings    ${resp1.status_code}    200
    log    ${data}
