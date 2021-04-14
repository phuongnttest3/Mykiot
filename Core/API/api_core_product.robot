*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn

*** Keywords ***
Get product list
    [Arguments]    ${category_id}
    ${params}=    Create Dictionary    limit=10    allow_sort=ASC    category=${category_id}
    ${headers1}=    Create Dictionary    store-id=259596
    Create Session    ali    https://api-staging.citigo.dev:40001/api/v1    verify=True
    ${resp}=    Get Request    ali    /products    headers=${headers1}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
    #${token}    Get Value From Json    ${resp.json()}    $..data
    #Log    ${token}
    #${token}=    Evaluate    $token[0]    modules=random, sys
    #${bearertoken}=    Catenate    Bearer    ${token}
    #Log    ${token}
    #Log    ${bearertoken}
    #Return From Keyword    ${bearertoken}

Get Product Detail
    [Arguments]    ${product_id}
    ${headers1}=    Create Dictionary    store-id=259596
    Create Session    ali    https://api-staging.citigo.dev:40001/api/v1    verify=True
    ${uri}    Format String    products/{0}    ${product_id}
    ${resp}=    Get Request    ali    ${uri}    headers=${headers1}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}

Search product through api
    [Arguments]    ${key}
    ${params}=    Create Dictionary    key=${key}
    ${headers1}=    Create Dictionary    store-id=259596
    Create Session    ali    https://api-staging.citigo.dev:40001/api/v1    verify=True
    ${resp}=    Get Request    ali    /products/search    headers=${headers1}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
