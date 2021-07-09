*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          ../API-KV/api_access_kv.robot
Resource          ../Share/Computation.robot

*** Keywords ***
Get product list
    [Arguments]    ${retailer_id}
    ${params}=    Create Dictionary    limit=10    allow_sort=ASC
    ${headers1}=    Create Dictionary    store-id=${retailer_id}
    Create Session    ali    ${coreapi_url}    verify=True
    ${resp}=    Get Request    ali    /v1/products    headers=${headers1}    params=${params}
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
    ${headers1}=    Create Dictionary    store-id=${retailer_id}
    Create Session    ali    ${coreapi_url}    verify=True
    ${uri}    Format String    /v1/products/{0}    ${product_id}
    ${resp}=    Get Request    ali    ${uri}    headers=${headers1}
    Should Be Equal As Strings    ${resp.status_code}    200
    log    ${resp.json()}
    Return from keyword    ${resp.json()}

Search product through api
    [Arguments]    ${key}
    ${params}=    Create Dictionary    key=${key}
    ${headers1}=    Create Dictionary    store-id=${retailer_id}
    Create Session    ali    ${coreapi_url}    verify=True
    ${resp}=    Get Request    ali    /v1/products/search    headers=${headers1}    params=${params}
    Log    ${resp.request.body}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
    Return from keyword    ${resp.json()}

Get product id through product code
    [Arguments]    ${product_code}
    ${resp.json()}=    Search product through api    ${product_code}
    ${product_id}=    JSONLibrary.Get Value From Json    ${resp.json()}    $.data.products[0].id
    ${product_id}=    Evaluate    $product_id[0] if $product_id else 0    modules=random, sys
    log    ${product_id}
    return from keyword    ${product_id}

Get product main infor from product detail
    [Arguments]    ${product_id}
    ${resp.json()}=    Get Product Detail    ${product_id}
    ${product_code}=    Get data from response json    ${resp.json()}    $.data.code
    ${product_name}=    Get data from response json    ${resp.json()}    $.data.name
    ${category_name}    Get data from response json    ${resp.json()}    $.data.categoryName
    ${jsonpath_onhand}    Format String    $.data.inventories[?(@.branchId=={0})].onHand    ${branch_id}
    ${onhand}    Get data from response json    ${resp.json()}    ${jsonpath_onhand}
    ${jsonpath_reserved}    Format String    $.data.inventories[?(@.branchId=={0})].reserved    ${branch_id}
    ${reserved}    Get data from response json    ${resp.json()}    ${jsonpath_reserved}
    ${stock}    Minus    ${onhand}    ${reserved}
    ${product_baseprice}    Get data from response json    ${resp.json()}    $.data.basePrice
    return from keyword    ${product_code}    ${product_name}    ${category_name}    ${stock}    ${product_baseprice}
    [Teardown]

Get list product category from api
    [Arguments]  ${category_name}   ${retailer_id}
    ${headers}=   create dictionary  store-id=${retailer_id}
    create session    ali    ${coreapi_url}     verify=True
    ${data_json}=   Get data category from api   ${retailer_id}
    ${json_category}  format string    $.data[?(@.name =='{0}')].id    ${category_name}
    ${category_id}=   JSONLibrary.Get Value From Json   ${data_json}   ${json_category}
    ${category_id}=   evaluate   $category_id[0]
    ${uri}=  format string   /v1/products/category/{0}    ${category_id}
    ${resp}=   get request   ali   ${uri}   ${headers}
    log  ${resp.json()}
    Should Be Equal As Strings    ${resp.status_code}    200
    ${prod_name}=   JSONLibrary.Get Value From Json      ${resp.json()}   $.data.products..name
    ${prod_name}=    Evaluate    $prod_name    modules=random, sys
    log    ${prod_name}
    ${category_namechild}=  JSONLibrary.Get Value From Json      ${resp.json()}   $.data.filter.categories..name
    ${category_namechild}=    Evaluate    $category_namechild   modules=random, sys
    log    ${category_namechild}
    ${attribute_name}=  JSONLibrary.Get Value From Json      ${resp.json()}   $.data.filter..attributes.*
    ${attribute_name}=    Evaluate   $attribute_name    modules=random, sys
    # ${attribute_name1}=     Get Dictionary Items     ${attribute_name}
    ${attribute_length}=   get length   ${attribute_name}
    ${attribute_list} =   create list
    : FOR  ${i}   IN RANGE   ${attribute_length}
    \   ${attribute_name1}=    Evaluate    $attribute_name[${i}]
    \   log   ${attribute_name1}
    \    ${a}=   combine lists  ${attribute_list}   ${attribute_name1}
    \    ${attribute_list} =  evaluate   $a
    \    log     ${attribute_list}
    return from keyword     ${prod_name}    ${category_namechild}    ${attribute_list}