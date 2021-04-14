*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn

*** Keywords ***
Get list comment of product
    [Arguments]    ${product_id}
    ${params}=    Create Dictionary    product_id=${product_id}
    ${headers1}=    Create Dictionary    store-id=259596
    Create Session    ali    https://api-staging.citigo.dev:40001/api    verify=True
    ${resp}=    Get Request    ali    /v1/comments    headers=${headers1}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}

Get list comment of customer
    [Arguments]    ${keyword}
    ${param}=    create dictionary    keyword=${keyword}    limit=10
    ${heades1}=    create dictionary    store-id=259596    Authorization=${bearer_token}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    get request    lolo    /v1/comments/me    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Create comment through api
    [Arguments]    ${product_id}    ${content}
    ${heades1}=    create dictionary    store-id=259596    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    ${data}=    create dictionary    product_id=${product_id}    content=${content}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    post request    lolo    /v1/comments/create    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
