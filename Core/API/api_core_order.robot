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
    [Arguments]    ${product_code}
    ${cart_token}=    Generate Random String    10    [LOWER]
    ${data}    Format String     {{ "code": "kiotviet", "products": [ {{ "product_id": 5091,"quantity": 1, "product_name": "Vòng chống muỗi Nhật Bản", "product_sku": "{0}", "note": null, "stock": 1000, "attributes": [], "images": [], "combo": [], "unit": [], "tradeMarkName": "", "price": 290070 }} ], "delivery": {{ "cod": false, "name": "Test Automation", "phone": "0967214074", "address": "434 Trần Khát Chân, Quận Hoàn Kiếm - Hà Nội", "branchAddress": "434 Trần Khát Chân, Quận Hoàn Kiếm - Hà Nội", "description": "" }}, "surcharges": [], "cart_token": "{1}" }}   ${product_code}    ${cart_token}
    # ${data} =    Encode String To Bytes    ${data}    UTF-8
    log    ${data}
    ${headers}    Create Dictionary    store-id=${retailer_id}    Content-Type=application/json;charset=utf-8
    Create Session    ali    ${coreapi_url}    verify=True
    ${resp}=    post request    ali    /v1/customers/orders/create    headers=${headers}    data=${data}
    Should Be Equal As Strings    ${resp.status_code}    200
    Log    ${resp.json()}
    Return from keyword    ${data}
