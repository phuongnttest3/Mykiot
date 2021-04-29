*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          api_core_product.robot

*** Keywords ***
Get list comment of product
    [Arguments]    ${product_code}
    ${product_id}    Get product id through product code    ${product_code}
    ${params}=    Create Dictionary    product_id=${product_id}
    ${headers1}=    Create Dictionary    store-id=${retailer_id}
    Create Session    ali    ${coreapi_url}    verify=True
    ${resp}=    Get Request    ali    /v1/comments    headers=${headers1}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
    Return from keyword    ${resp.json()}

Get list comment of customer
    [Arguments]    ${keyword}
    ${param}=    create dictionary    keyword=${keyword}    limit=10
    ${heades1}=    create dictionary    store-id=${retailer_id}    Authorization=${bearer_token}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    /v1/comments/me    headers=${heades1}    params=${param}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    Return from keyword    ${resp1.json()}

Create comment through api
    [Arguments]    ${product_code}    ${content}
    ${product_id}    Get product id through product code    ${product_code}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    ${data}=    create dictionary    product_id=${product_id}    content=${content}
    create session    lolo    ${coreapi_url}
    ${resp1}=    post request    lolo    /v1/comments/create    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${comment_id}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $.data.id
    ${comment_id}=    Evaluate    $comment_id[0] if $comment_id else 0    modules=random, sys
    Return from keyword    ${comment_id}

Update comment through api
    [Arguments]    ${product_code}
    ${hex} =    Generate Random String    6    [NUMBERS]abcdef
    ${content}    format string    Sửa bình luận {0}    ${hex}
    ${product_id}    Get product id through product code    ${product_code}
    ${comment_id}    Get comment id through product code    ${product_code}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    ${data}=    create dictionary    product_id=${product_id}    content=${content}    comment_id=${comment_id}
    create session    lolo    ${coreapi_url}
    ${resp1}=    post request    lolo    /v1/comments/update    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${content_update}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $.data.content
    ${content_update}=    Evaluate    $content_update[0] if $content_update else 0    modules=random, sys
    should be equal as strings    ${content_update}    ${content}

Delete comment through api
    [Arguments]    ${product_code}
    ${product_id}    Get product id through product code    ${product_code}
    ${comment_id}    Get comment id through product code    ${product_code}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    ${data}=    create dictionary    product_id=${product_id}    comment_id=${comment_id}
    create session    lolo    ${coreapi_url}
    ${resp1}=    delete request    lolo    /v1/comments/delete    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get comment id through product code
    [Arguments]    ${product_code}
    ${resp.json()}    Get list comment of customer    ${product_code}
    ${comment_id}=    JSONLibrary.Get Value From Json    ${resp.json()}    $.data.data[0].comment_id
    ${comment_id}=    Evaluate    $comment_id[0] if $comment_id else 0    modules=random, sys
    log    ${comment_id}
    return from keyword    ${comment_id}
