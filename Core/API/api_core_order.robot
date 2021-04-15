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
    [Arguments]    ${product_sku}
    ${data}     Format String   {{ "code": "kiotviet", "products": [ {{ "product_id": 340369183, "quantity": 1, "product_name": "hai sanr", "product_sku": "{0}", "note": null, "stock": 1000, "attributes": [], "images": [], "combo": [], "unit": [], "tradeMarkName": "", "price": 320000 }} ], "delivery": {{ "cod": false, "name": "Lê Thị Hương (test 3)", "phone": "0967214074", "address": "1b yet kieu hoan kiem ha noi, Quận Hoàng Mai - Hà Nội", "branchAddress": "1b yet kieu hoan kiem ha noi, Quận Hoàng Mai - Hà Nội", "description": "" }}, "surcharges": [], "cart_token": "b6985f9e-deec-4da3-83eb-844cb5142f19" }}    ${product_sku}
    # ${data} =    Encode String To Bytes    ${data}    UTF-8
    log   ${data}
    ${headers}    Create Dictionary    store-id=652920    Content-Type=application/json;charset=utf-8
    Create Session    ali    https://api-staging.citigo.dev:40001/api    verify=True
    ${resp}=    post request    ali    /v1/customers/orders/create    headers=${headers}    data=${data}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
    Return from keyword    ${data}