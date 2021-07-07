*** Settings ***
Suite Setup       init test core api    live
Library           RequestsLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          ../Core/API/api_core_product.robot
Resource          ../Core/API/api_core_store.robot
Resource          ../Core/API/api_core_menu.robot
Resource          ../Core/API/api_core_customer.robot
Resource          ../Core/API/api_core_page.robot
Resource          ../Core/API/api_core_category.robot
Resource          ../Core/API/api_core_order.robot
Resource          ../Config/Env/envi.robot
Resource          ../Core/API/api_core_comment.robot

*** Test Cases ***
TCA001
    [Documentation]    Get Product list
    [Template]    Get product list
    ${retailer_id}

TCA002
    [Template]    Get product detail through product code
    SP001456

TCA003
    [Template]    Get data store from Api
    ${retailer_code}

TCA004
    [Template]    Get config store from Api
    ${retailer_id}

TCA005
    [Template]    Get list menu from Api
    ${retailer_id}

TCA006
    [Template]    Login customer get token from api
    ${retailer_id}

TCA007
    [Template]    Get profile customer from api
    ${retailer_id}

TCA008
    [Template]    Get data page from api
    ${retailer_id}

TCA009
    [Template]    Get data category from api
    ${retailer_id}

TCA010
    [Template]    Get customer cart from api
    ${retailer_id}

TCA011
    [Template]    update customer cart from api
    SP001452    12

TCA012
    [Template]    Detele customer carts from api
    SP001452

TCA013
    [Template]    Update profile customer thr api
    phuongphuong

TCA014
    [Template]    Get customer favourite products from api
    ${retailer_id}

TCA015
    [Template]    Get customer address from api
    ${retailer_id}

TCA016
    [Template]    Update favourite product thr api
    SP001449

TCA017
    [Template]    Get customer order list
    DHMK

TCA018
    [Template]    Search product through api
    áo sơ mi

TCA019
    [Template]    get list comment of product
    SP001448

TCA020
    [Template]    get list comment of customer
    ${EMPTY}

TCA021
    [Template]    Create comment through api
    SP001355    Bình luận sản phẩm

TCA022
    [Template]    Update Comment Through API
    SP000233

TCA023
    [Template]    Delete comment
    SP000233    Thêm mới bình \ luận

TCA024
    [Template]    Get customer products viewed from api
    DHMK

TCA025
    [Template]    Create Order no account from API
    SP000188

TCA026
    [Template]    Create order customer from api
    SP000188

TCA027
    [Template]    Get customer orders detail from api
    DHMK

TCA028
    [Template]    Get list product category from api
    339    810060

*** Keywords ***
Delete comment
    [Arguments]    ${product_code}    ${content}
    ${comment_id}    Create comment through api    ${product_code}    ${content}
    Delete comment through api    ${product_code}

add products cart from api
    [Arguments]    ${product_code}    ${quantity}
    update customer cart from api    ${product_code}    ${quantity}

Get product detail through product code
    [Arguments]    ${product_code}
    ${product_id}    Get product id through product code    ${product_code}
    Get product detail    ${product_id}
