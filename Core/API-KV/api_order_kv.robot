*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          ../API/api_access.robot
Resource          api_access_kv.robot

*** Variables ***
${endpoint_order}    /orders
${endpoint_delete_order}    /orders/{0}?CompareCode={1}&IsVoidPayment=false

*** Keywords ***
Get orderid
    [Arguments]    ${order_code}
    ${endpoint_get_order}    Format String    ${endpoint_order}    ${BRANCH_ID}
    ${resp}    Get KV Request and return body    ${endpoint_get_order}
    ${jsonpath_id_sp}    Format String    $..Data[?(@.Code == '{0}')].Id    ${order_code}
    ${get_order_id}    Get data from response json    ${resp}    ${jsonpath_id_sp}
    Return From Keyword    ${get_order_id}

Delete order by order code
    [Arguments]    ${order_code}
    [Timeout]    5 mins
    ${jsonpath_id_order}    Format String    $..Data[?(@.Code == '{0}')].Id    ${order_code}
    ${endpoint_order_by_branch}    Format String    ${endpoint_order}    ${branch_id}
    ${get_id_hd}    Get data from KV API    ${endpoint_order_by_branch}    ${jsonpath_id_order}
    ${endpoint_delete_order}    Format String    ${endpoint_delete_order}    ${get_id_hd}    ${order_code}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${headers}=    Create Dictionary    Authorization=${bearertoken}    Content-Type=application/x-www-form-urlencoded
    ${resp}=    RequestsLibrary.Delete Request    lolo    ${endpoint_delete_order}    headers=${headers}    allow_redirects=True
    Log    ${resp.request.body}
    Log    ${resp.json()}
    log    ${resp.status_code}
    Should Be Equal As Strings    ${resp.status_code}    200
