*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn

*** Keywords ***
get access token from api
    ${params}=    Create Dictionary    client_id=${client_id}    secret_key=${secret_key}    retailer_code=${retailer_code}    retailer_id=${retailer_id}
    ${headers1}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer mykiot123456a@!
    Create Session    ali    ${api_url}    verify=True
    ${resp}=    Get Request    ali    /get-token    headers=${headers1}    params=${params}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
    Log    ${resp.cookies}
    ${token}    Get Value From Json    ${resp.json()}    $..data
    Log    ${token}
    ${token}=    Evaluate    ${token}[0] if ${token} else 0    modules=random, sys
    ${bearertoken}=    Catenate    Bearer    ${token}
    Log    ${token}
    Log    ${bearertoken}
    Return From Keyword    ${bearertoken}

Get Request and validate status code
    [Arguments]    ${END_POINT}
    [Timeout]    1 minute
    # post to get bearer token
    ${header}    Create Dictionary    retailer=${retailer_code}    Authorization=${bearertoken}
    ${params}    Create Dictionary    format=json
    Create Session    lolo    ${api_url}    cookies=${resp.cookies}
    ${resp1}=    RequestsLibrary.Get Request    lolo    ${END_POINT}    params=${params}    headers=${header}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Return From Keyword    ${resp1}    ${resp1.status_code}

Get data from API
    [Arguments]    ${END_POINT}    ${json_path}
    [Timeout]    1 minute
    : FOR    ${time}    IN RANGE    5
    \    ${resp1}    ${resp1.status_code}    Get Request and validate status code    ${END_POINT}
    \    Exit For Loop If    '${resp1.status_code}'=='200'
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    ${json_path}
    ${result} =    Evaluate    ${get_raw_data}[0] if ${get_raw_data} else 0
    ${result} =    Evaluate    $result or 0
    Return From Keyword    ${result}

get request and validate request success
    [Arguments]    ${END_POINT}
    [Timeout]    1 minute
    # post to get bearer token
    ${header}    Create Dictionary    retailer=${retailer_code}    Authorization=${bearertoken}
    ${params}    Create Dictionary    format=json
    Create Session    lolo    ${api_url}    cookies=${resp.cookies}
    ${resp1}=    RequestsLibrary.Get Request    lolo    ${END_POINT}    params=${params}    headers=${header}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    Log    ${resp1.status_code}
    Should Be Equal As Strings    ${resp1.status_code}    200

get response json from api
    [Arguments]    ${END_POINT}
    [Timeout]    1 minute
    # post to get bearer token
    ${header}    Create Dictionary    retailer=${retailer_code}    Authorization=${bearertoken}
    ${params}    Create Dictionary    format=json
    Create Session    lolo    ${api_url}    cookies=${resp.cookies}
    ${resp1}=    RequestsLibrary.Get Request    lolo    ${END_POINT}    params=${params}    headers=${header}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Should be equal as strings    ${resp1.status_code}    200
    Return from keyword    ${resp1.json()}

post request and validate request success
    [Arguments]    ${END_POINT}    ${data}
    ${headers}=    Create Dictionary    Content-Type=application/json    Authorization=${bearertoken}
    Create Session    lolo    ${url}    verify=True    debug=1
    ${resp1}=    post request    lolo    config/save    data=${data}    headers=${headers}
    log    ${resp1.request.body}
    log    ${resp1.json()}
    log    ${resp1.status_code}
    Should be equal as strings    ${resp1.status_code}    200
