*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Library           RequestsLibrary

*** Keywords ***
Login customer get token from api
    [Arguments]    ${store-id}
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded
    ${data}=    create dictionary    id=107151798064347196088   provider=google    name=Automation Test    email=testautomation113@gmail.com
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    post request    lolo    v1/customers    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    ${token}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data
    ${token}=    Evaluate    $token[0] if $token else 0    modules=random, sys
    ${token}=    Catenate    Bearer    ${token}
    log    ${token}
    Should be equal as strings    ${resp1.status_code}    200
    return from keyword    ${token}

Get profile customer from api
    [Arguments]    ${store-id}
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    get request    lolo    v1/customers/profile    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    #    ${data1}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data
    #    ${data1}=    evaluate    $data1[0]
    #    log    ${data1}
    #    return from keyword    ${data1}

Update profile customer thr api
    [Arguments]    ${name_update}
    ${heades1}=    create dictionary    store-id=259596    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    ${data}=    create dictionary    gender=2    name=${name_update}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    post request    lolo    /v1/customers/profile    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer address from api
    [Arguments]    ${store-id}
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    get request    lolo    v1/customers/address    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer cart from api
    [Arguments]    ${store-id}
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    get request    lolo    v1/customers/carts    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${product_id}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data.data[0].product_id
    ${product_id}=    evaluate    $product_id[0] if $product_id else 0    modules=random, sys
    log    ${product_id}
    return from keyword    ${product_id}

update customer cart from api
    [Arguments]    ${store-id}
    ${product_id}    Get customer cart from api    ${store-id}
    ${data}=    create dictionary    product_id=${product_id}    quantity=150
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    create session    lolo    https://api-staging.citigo.dev:40001/api    headers=${heades1}
    ${resp1}=    post request    lolo    v1/customers/carts    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

detele customer cart from api
    [Arguments]    ${store-id}
    ${product_id}    Get customer cart from api    ${store-id}
    ${data}=    create dictionary    product_id=${product_id}
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    create session    lolo    https://api-staging.citigo.dev:40001/api    headers=${heades1}
    ${resp1}=    delete request    lolo    v1/customers/carts    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

get Customer favorite products from api
    [Arguments]    ${store-id}
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    get request    lolo    v1/customers/favorites    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Update favourite product thr api
    [Arguments]    ${product_id}
    ${heades1}=    create dictionary    store-id=259596    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    ${data}=    create dictionary    product_id=${product_id}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    post request    lolo    /v1/customers/favorites    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer order list
    [Arguments]    ${order_code}
    ${heades1}=    create dictionary    store-id=259596    Content-Type=application/x-www-form-urlencoded    Authorization=${bearer_token}
    ${endpoint}=    Format string    /v1/customers/orders?keyword={0}    ${order_code}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    get request    lolo    ${endpoint}    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    $..data.total_orders
    ${result} =    Evaluate    ${get_raw_data}[0] if ${get_raw_data} else 0
    ${result} =    Evaluate    $result or 0
    Return From Keyword    ${result}
Detele customer cart from api
    [Arguments]   ${store-id}
    ${product_id}      Get customer cart from api    ${store-id}
    ${data}=  create dictionary   product_id=${product_id}
    ${heades1}=  create dictionary      store-id=${store-id}  Content-Type=application/x-www-form-urlencoded   Authorization=${bearer_token}
    create session   lolo   https://api-staging.citigo.dev:40001/api   headers=${heades1}
    ${resp1}=  delete request   lolo   v1/customers/carts  headers=${heades1}   data=${data}
    log  ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer favorite products from api
    [Arguments]   ${store-id}
    ${bearer_token}       Login customer get token from api     ${store-id}
    ${heades1}=  create dictionary      store-id=${store-id}  Content-Type=application/x-www-form-urlencoded   Authorization=${bearer_token}
    create session   lolo   https://api-staging.citigo.dev:40001/api
    ${resp1}=  get request   lolo   v1/customers/favorites  headers=${heades1}
    log  ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${tensp}=   JSONLibrary.Get Value From Json    ${resp1.json()}   $.data.data[0].name
    ${tensp}=    evaluate  $tensp[0]
    log  ${tensp}
    return from keyword  ${tensp}

Get customer orders detail from api
    [Arguments]   ${store-id}
    ${order_id}  Get customer orders history from api   ${store-id}
    ${heades1}=  create dictionary      store-id=${store-id}  Content-Type=application/x-www-form-urlencoded   Authorization=${bearer_token}
    ${params}=  create dictionary       order_id=${order_id}
    create session   lolo   https://api-staging.citigo.dev:40001/api
    ${resp1}=  get request   lolo   v1/customers/orders/detail  headers=${heades1}  data= ${params}
    log  ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer products viewed from api
    [Arguments]   ${store-id}
    ${order_id}  Get customer orders history from api   ${store-id}
    ${heades1}=  create dictionary      store-id=${store-id}  Content-Type=application/x-www-form-urlencoded   Authorization=${bearer_token}
    create session   lolo   https://api-staging.citigo.dev:40001/api
    ${resp1}=  get request   lolo   v1/customers/viewed   headers=${heades1}
    log  ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200