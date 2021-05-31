*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          api_access_kv.robot
Resource          api_hanghoa_kv.robot

*** Variables ***
${endpoint_ds_bang_gia}    /pricebook/filter?includeAll=true&Includes=PriceBookBranches&Includes=PriceBookCustomerGroups&Includes=PriceBookUsers&Includes=PriceBookDependency&IncludeSortName=true&%24inlinecount=allpages
${endpoint_hh_trong_banggia}    /pricebook/getitems?PriceBookId={0}&%24inlinecount=allpages
${endpoint_delete_price_book}    /pricebook/{0}
${endpoint_delete_price_book_detail}    /pricebook/pricebookdeleteitems?PriceBookIds={0}&ProductIds={1}
${endpoint_add_price_book_detail}    /pricebook/addItemsIntoPricebookDetails

*** Keywords ***
Get price of product in price book thr API
    [Arguments]    ${ten_bang_gia}    ${ma_sp}
    [Timeout]    5 minute
    ${get_pricebook_id}    Get price book id    ${ten_bang_gia}
    ${endpoint_bg}    Format String    ${endpoint_hh_trong_banggia}    ${get_pricebook_id}
    ${resp}    Get KV Request and return body    ${endpoint_bg}
    ${jsonpath_giaban}    Format String    $..Data[?(@.Code=="{0}")].Price    ${ma_sp}
    ${giaban}    Get data from response json    ${resp}    ${jsonpath_giaban}
    Return From Keyword    ${giaban}

Changing price in price book thr API
    [Arguments]    ${ten_bang_gia}    ${ma_sp}    ${gia_moi}
    [Timeout]    3 minutes
    ${get_pb_id}    Get price book id    ${ten_bang_gia}
    ${get_prd_id}    Get product ID    ${ma_sp}
    ${payload}    Format String    {{"PricebookId":{0},"ItemCalc":{{"PricebookId":{0},"ProductId":{1},"PriceDirect":{2}}}}}    ${get_pb_id}    ${get_prd_id}    ${gia_moi}
    Log    ${payload}
    ${headers1}=    Create Dictionary    Authorization=${bearertoken}    Content-Type=application/json;charset=utf-8
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${resp1}=    Post Request    lolo    /pricebook/calcPriceForAllItems    data=${payload}    headers=${headers1}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    Log    ${resp1.status_code}
    Should Be Equal As Strings    ${resp1.status_code}    200
    Log to Console    ${resp1.json()}

Get price book id
    [Arguments]    ${name}
    [Timeout]    3 minute
    ${jsonpath_price_book_id}    Format String    $..Data[?(@.Name=="{0}")].Id    ${name}
    ${get_pricet_id}    Get data from KV API    ${endpoint_ds_bang_gia}    ${jsonpath_price_book_id}
    Return From Keyword    ${get_pricet_id}

Delete price book thr API
    [Arguments]    ${name}
    [Timeout]    3 minute
    ${get_pricet_id}    Get price book id    ${name}
    ${endpoint_dl_price}    Format String    ${endpoint_delete_price_book}    ${get_pricet_id}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${resp1}=    Delete Request    lolo    ${endpoint_dl_price}

Delete product of price book thr API
    [Arguments]    ${pricebook_name}    ${product_code}
    [Timeout]    3 minute
    ${get_pricet_id}    Get price book id    ${pricebook_name}
    ${get_product_id}    Get product ID    ${product_code}
    ${endpoint_dl_price}    Format String    ${endpoint_delete_price_book_detail}    ${get_pricet_id}    ${get_product_id}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${resp1}=    Delete Request    lolo    ${endpoint_dl_price}

Add product in price book thr API
    [Arguments]    ${ten_bang_gia}    ${ma_sp}
    [Timeout]    3 minutes
    ${get_pb_id}    Get price book id    ${ten_bang_gia}
    ${get_prd_id}    Get product ID    ${ma_sp}
    ${payload}    Format String    {{"ProductId": {1}, "PriceBookIds": [{0}]}}    ${get_pb_id}    ${get_prd_id}
    Log    ${payload}
    ${headers1}=    Create Dictionary    Authorization=${bearertoken}    Content-Type=application/json;charset=utf-8
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${resp1}=    Post Request    lolo    ${endpoint_add_price_book_detail}    data=${payload}    headers=${headers1}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    Log    ${resp1.status_code}
    Should Be Equal As Strings    ${resp1.status_code}    200
    Log to Console    ${resp1.json()}
