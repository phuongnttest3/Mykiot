*** Settings ***
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn

*** Keywords ***
Create Order no account from API
    [Arguments]    ${product_id}
    ${cart_token}=    Generate Random String    10    [LOWER]
    ${data}    Format String    {{ "code": "kiotviet", "products": [ {{ "product_id": {0}, "quantity": 1, "product_name": "hai sanr", "product_sku": "SP12000155", "note": null, "stock": 1000, "attributes": [], "images": [], "combo": [], "unit": [], "tradeMarkName": "", "price": 320000 }} ], "delivery": {{ "cod": false, "name": "Lê Thị Hương (test 3)", "phone": "0967214074", "address": "1b yet kieu hoan kiem ha noi, Quận Hoàng Mai - Hà Nội", "branchAddress": "1b yet kieu hoan kiem ha noi, Quận Hoàng Mai - Hà Nội", "description": "" }}, "surcharges": [], "cart_token": "{1}" }}    ${product_id}    ${cart_token}
    # ${data} =    Encode String To Bytes    ${data}    UTF-8
    log    ${data}
    ${headers}    Create Dictionary    store-id=${retailer_id}    Content-Type=application/json;charset=utf-8
    Create Session    ali    ${coreapi_url}    verify=True
    ${resp}=    post request    ali    /v1/customers/orders/create    headers=${headers}    data=${data}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
    Return from keyword    ${data}
