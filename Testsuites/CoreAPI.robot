*** Settings ***
Suite Setup       init test core api
Library           RequestsLibrary
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
    [Documentation]    Get Product list with category_id
    [Template]    Get product list
    72820

TCA002
    [Template]    Get Product Detail
    340372599

TCA003
    [Template]    Get data store from Api
    longopss

TCA004
    [Template]    Get config store from Api
    525011

TCA005
    [Template]    Get list menu from Api
    525011

TCA006
    [Template]    Login customer get token from api
    259596

TCA007
    [Template]    Get profile customer from api
    259596

TCA008
    [Template]    Get data page from api
    259596

TCA009
    [Template]    Get data category from api
    259596

TCA010
    [Template]    Get customer cart from api
    259596

TCA011
    [Template]    update customer cart from api
    259596

TCA012
    [Template]    detele customer cart from api
    259596

TCA013
    [Template]    Update profile customer thr api
    phuongphuong

TCA014
    [Template]    get Customer favorite products from api
    259596

TCA015
    [Template]    Get customer address from api
    259596

TCA016
    [Template]    Update favourite product thr api
    340372623

TCA017
    [Template]    Get customer order list
    DHMK

TCA018
    [Template]    Search product through api
    áo sơ mi

TCA019
    [Template]    get list comment of product
    340371043

TCA020
    [Template]    get list comment of customer
    ${EMPTY}

TCA021
    [Template]    Create comment through api
    340371066    Bình luận sản phẩm
TCA022
        [Template]    Update Comment Through API
        340371066    617

TCA023
        [Template]    Delete comment
        340371066    Thêm mới bình \ luận

*** Keywords ***
Delete comment
        [Arguments]    ${product_id}    ${content}
        ${comment_id}    Create comment through api    ${product_id}    ${content}
        Delete comment through api    ${product_id}    ${comment_id}
