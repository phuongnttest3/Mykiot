*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn
*** Keywords ***
Get data category from api
    [Arguments]   ${store-id}
    ${heades1}=  create dictionary      store-id=${store-id}
    create session   lolo   https://api-staging.citigo.dev:40001/api
    ${resp1}=  get request   lolo   v1/categories   headers=${heades1}
    log  ${resp1.json()}
    ${data}=  JSONLibrary.Get Value From Json    ${resp1.json()}    $..data
    Should be equal as strings    ${resp1.status_code}    200
    log   ${data}