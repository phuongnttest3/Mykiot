*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Library           RequestsLibrary
Resource          api_core_product.robot

*** Keywords ***
Login customer get token from api
    [Arguments]    ${retailer_id}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded
    ${data}=    create dictionary    id=${provider_id}    provider=google    name=Automation Test    email=${google_account}
    create session    lolo    ${coreapi_url}
    ${resp1}=    post request    lolo    v1/customers    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    ${token}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data
    ${token}=    Evaluate    $token[0] if $token else 0    modules=random, sys
    ${token}=    Catenate    Bearer    ${token}
    log    ${token}
    Should be equal as strings    ${resp1.status_code}    200
    return from keyword    ${token}

Get profile customer from api
    [Arguments]    ${retailer_id}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    /v1/customers/profile    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    #    ${data1}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data
    #    ${data1}=    evaluate    $data1[0]
    #    log    ${data1}
    #    return from keyword    ${data1}

Update profile customer thr api
    [Arguments]    ${name_update}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    ${data}=    create dictionary    gender=2    name=${name_update}
    create session    lolo    ${coreapi_url}
    ${resp1}=    post request    lolo    /v1/customers/profile    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer address from api
   # [Arguments]    ${store-id}
    ${heades1}=    create dictionary    store-id=${retailer_id}     Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    v1/customers/address    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    return from keyword     ${resp1.json()}

Delete customer address from api
    [Arguments]    ${id_address}
    ${payload}=  create dictionary  id=${id_address}
    ${heades1}=    create dictionary    store-id=${retailer_id}   Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}
    ${resp1}=    post request    lolo    v1/customers/address/delete   headers=${heades1}  data=${payload}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer cart from api
    [Arguments]    ${store-id}
    ${heades1}=    create dictionary    store-id=${store-id}  Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    v1/customers/carts    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${product_id}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data[0].id
    ${product_id}=    evaluate    $product_id[0] if $product_id else 0    modules=random, sys
    ${product_quantity}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data[0].quantity
    ${product_quantity}=    evaluate    $product_quantity[0] if $product_quantity else 0    modules=random, sys
    ${product_code}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data[0].code
    ${product_code}=    evaluate    $product_code[0] if $product_code else 0    modules=random, sys
    log    ${product_id}
    return from keyword    ${product_id}    ${product_quantity}    ${product_code}

update customer cart from api
    [Arguments]    ${product_code}    ${quanlity}
    ${product_id}    Get product id through product code    ${product_code}
    ${data}=    create dictionary    product_id=${product_id}    quantity=${quanlity}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}    headers=${heades1}
    ${resp1}=    post request    lolo    v1/customers/carts    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Detele customer carts from api
    [Arguments]    ${product_code}
    ${product_id}    Get product id through product code    ${product_code}
    ${data}=    create dictionary    product_id=${product_id}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}    headers=${heades1}
    ${resp1}=    post request    lolo    v1/customers/carts/delete    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer favourite products from api
    [Arguments]    ${store-id}
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    v1/customers/favorites    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Update favourite product thr api
    [Arguments]    ${product_code}
    ${product_id}    Get product id through product code    ${product_code}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    ${data}=    create dictionary    product_id=${product_id}
    create session    lolo    ${coreapi_url}
    ${resp1}=    post request    lolo    /v1/customers/favorites    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Get customer order list
    [Arguments]    ${order_code}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    ${endpoint}=    Format string    /v1/customers/orders?keyword={0}    ${order_code}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    ${endpoint}    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    $..data.total_orders
    ${result} =    Evaluate    ${get_raw_data}[0] if ${get_raw_data} else 0
    ${result} =    Evaluate    $result or 0
    ${get_order_id}    Get Value From Json    ${resp1.json()}    $..data.data[0].order_id
    ${order_id} =    Evaluate    ${get_order_id}[0] if ${get_order_id} else 0
    ${order_id} =    Evaluate    $order_id or 0
    Return From Keyword    ${result}    ${order_id}

Get customer favorite products from api
    [Arguments]    ${store-id}
    ${bearer_token}    Login customer get token from api    ${store-id}
    ${heades1}=    create dictionary    store-id=${store-id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    https://api-staging.citigo.dev:40001/api
    ${resp1}=    get request    lolo    v1/customers/favorites    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${tensp}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $.data.data..name
    # ${tensp}=    evaluate    $tensp[0]
    ${tensp}=    evaluate    $tensp
    log    ${tensp}
    return from keyword    ${tensp}

Get customer orders detail from api
    [Arguments]    ${order_code}
    ${result}    ${order_id}    Get customer order list    ${order_code}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    ${params}=    create dictionary    order_id=${order_id}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    v1/customers/orders/detail    headers=${heades1}    params=${params}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    return from keyword   ${resp1.json()}

Get customer products viewed from api
    [Arguments]    ${order_code}
    ${result}    ${order_id}    Get customer order list    ${order_code}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    v1/customers/viewed    headers=${heades1}
    log    ${resp1.json()}
    ${name_viewed}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $.data..name
    ${name_viewed}=    evaluate    $name_viewed
    log    ${name_viewed}
    Should be equal as strings    ${resp1.status_code}    200
    return from keyword    ${name_viewed}

Create order customer from api
    [Arguments]    ${product_sku}
    ${cart_token}=    Generate Random String    10    [LOWER]
    ${data}    Format String    {{ "code": "kiotviet", "products": [ {{ "product_id": 5091,"quantity": 1, "product_name": "Vòng chống muỗi Nhật Bản", "product_sku": "{0}", "note": null, "stock": 1000, "attributes": [], "images": [], "combo": [], "unit": [], "tradeMarkName": "", "price": 290070 }} ], "delivery": {{ "cod": false, "name": "Test Automation", "phone": "0967214074", "address": "434 Trần Khát Chân, Quận Hoàn Kiếm - Hà Nội", "branchAddress": "434 Trần Khát Chân, Quận Hoàn Kiếm - Hà Nội", "description": "" }}, "surcharges": [], "cart_token": "{1}" }}    ${product_sku}    ${cart_token}
    ${data} =    Encode String To Bytes    ${data}    UTF-8
    log    ${data}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/json;charset=utf-8    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}    verify=True
    ${resp1}=    post request    lolo    /v1/customers/orders/create    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200

Delete product from customer cart through api
    [Arguments]    ${product_id}
    ${data}=    create dictionary    product_id=${product_id}
    ${heades1}=    create dictionary    store-id=${retailer_id}    Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}    headers=${heades1}
    ${resp1}=    post request    lolo    v1/customers/carts/delete    headers=${heades1}    data=${data}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
