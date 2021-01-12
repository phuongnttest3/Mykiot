*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Library           Collections

*** Variables ***
${endpoint_currentsession}    /retailers/currentsession
${endpoint_nguoitao}    /retailers/currentsession
${endpoint_user}    /users

*** Keywords ***
Get BearerToken from API
    [Timeout]    5 minutes
    # post to get bearer token
    ${credential}=    Create Dictionary    UserName=${user_name}    Password=${password}
    ${headers1}=    Create Dictionary    Content-Type=application/json    Retailer=${retailer_code}
    Create Session    ali    ${kv_url}    headers=${headers1}    verify=True
    ${resp}=    Post Request    ali    /api/auth/salelogin    data=${credential}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
    Log    ${resp.cookies}
    ${bearertoken}    Get Value From Json    ${resp.json()}    $..BearerToken
    Log    ${bearertoken}
    ${bearertoken}=    Evaluate    $bearertoken[0] if $bearertoken else 0    modules=random, sys
    ${bearertoken}=    Catenate    Bearer    ${bearertoken}
    Log    ${bearertoken}
    Return From Keyword    ${bearertoken}    ${resp.cookies}

Get KV Request and validate status code
    [Arguments]    ${END_POINT}
    [Timeout]    1 minute
    # post to get bearer token
    ${header}    Create Dictionary    retailer=${retailer_code}    Authorization=${bearertoken}
    ${params}    Create Dictionary    format=json
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${resp1}=    RequestsLibrary.Get Request    lolo    ${END_POINT}    params=${params}    headers=${header}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Return From Keyword    ${resp1}    ${resp1.status_code}

Get data from KV API
    [Arguments]    ${END_POINT}    ${json_path}
    [Timeout]    1 minute
    : FOR    ${time}    IN RANGE    5
    \    ${resp1}    ${resp1.status_code}    Get KV Request and validate status code    ${END_POINT}
    \    Exit For Loop If    '${resp1.status_code}'=='200'
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    ${json_path}
    ${result} =    Evaluate    $get_raw_data[0] if $get_raw_data else 0
    ${result} =    Evaluate    $result or 0
    Return From Keyword    ${result}

Get KV Request and return body
    [Arguments]    ${END_POINT}
    [Timeout]    5 minutes
    : FOR    ${time}    IN RANGE    5
    \    ${resp1}    ${resp1.status_code}    Get KV Request and validate status code    ${END_POINT}
    \    Exit For Loop If    '${resp1.status_code}'=='200'
    Should Be Equal As Strings    ${resp1.status_code}    200
    Return From Keyword    ${resp1.json()}

Get data from response json
    [Arguments]    ${resp1.json}    ${json_path}
    [Timeout]    5 minutes
    ${get_raw_data}    Get Value From Json    ${resp1.json}    ${json_path}
    ${result} =    Evaluate    $get_raw_data[0] if $get_raw_data else 0
    ${result} =    Evaluate    $result or 0
    Return From Keyword    ${result}

Get data from API by BranchID
    [Arguments]    ${branchid_bybranch}    ${END_POINT}    ${json_path}
    [Timeout]    5 minutes
    : FOR    ${time}    IN RANGE    5
    \    ${resp1}    ${resp1.status_code}    Get Request from API by BranchID and validate status code    ${branchid_bybranch}    ${END_POINT}
    \    Exit For Loop If    '${resp1.status_code}'=='200'
    Should Be Equal As Strings    ${resp1.status_code}    200
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    ${json_path}
    ${result} =    Evaluate    $get_raw_data[0] if $get_raw_data else 0
    ${result} =    Evaluate    $result or 0
    Return From Keyword    ${result}

Get User ID
    [Timeout]    3 minutes
    ${get_nguoitao}    Get data from KV API    ${endpoint_nguoitao}    $..UserId
    Return From Keyword    ${get_nguoitao}

Get Request from API by BranchID and validate status code
    [Arguments]    ${branchid_bybranch}    ${END_POINT}
    [Timeout]    5 minutes
    ${header}    Create Dictionary    Authorization=${bearertoken}
    ${params}    Create Dictionary    format=json
    ${ss-tok-r}    Get From Dictionary    ${resp.cookies}    ss-tok
    ${ss-tok}    Catenate    ${ss-tok-r}
    ${ss-id-r}    Get From Dictionary    ${resp.cookies}    ss-id
    ${ss-id}    Catenate    ${ss-id-r}
    #${ss-opt-r}    Get From Dictionary    ${resp.cookies}    ss-opt
    #${ss-opt}    Catenate    ${ss-opt-r}
    ${ss-pid-r}    Get From Dictionary    ${resp.cookies}    ss-pid
    ${ss-pid}    Catenate    ${ss-pid-r}
    ${branchid_bybranch}    Catenate    ${branchid_bybranch}
    ${get_user_id}    Get User ID by UserName    admin
    ${get_retailer_id}    Get RetailerID
    ${result_lastestbranch}    Format String    LatestBranch_{0}_{1}    ${get_retailer_id}    ${get_user_id}
    ${cookies_by_br}    Create Dictionary    ss-id=${ss-id}    ss-pid=${ss-pid}    ss-tok=${ss-tok}    ${result_lastestbranch}=${branchid_bybranch}    #ss-opt=${ss-opt}
    log    ${cookies_by_br}
    Create Session    lolo    ${kvapi_url}    cookies=${cookies_by_br}
    ${resp1}=    RequestsLibrary.Get Request    lolo    ${END_POINT}    params=${params}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Return From Keyword    ${resp1}    ${resp1.status_code}

Get RetailerID
    [Timeout]    3 minutes
    ${get_retailer_id}    Get data from KV API    ${endpoint_currentsession}    $..Retailer.Id
    Return From Keyword    ${get_retailer_id}

Get User ID by UserName
    [Arguments]    ${username}
    ${jsonpath_user_id}    Format String    $..Data[?(@.UserName=="{0}")].Id    ${username}
    ${get_user_id}    Get data from KV API    ${endpoint_user}    ${jsonpath_user_id}
    Return From Keyword    ${get_user_id}
