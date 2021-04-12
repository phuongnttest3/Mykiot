*** Settings ***
Suite Setup       init test core api
Library           RequestsLibrary
Resource          ../Core/API/api_core_product.robot
Resource          ../Core/API/api_core_store.robot
Resource          ../Core/API/api_core_menu.robot
Resource          ../Core/API/api_core_customer.robot
Resource          ../Core/API/api_core_page.robot
Resource          ../Core/API/api_core_category.robot
Resource          ../Config/Env/envi.robot

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
     [Template]   Get customer cart from api
     259596
TCA011
     [Template]   update customer cart from api
     259596
TCA012
     [Template]   detele customer cart from api
     259596
TCA013
    [Template]    Update profile customer thr api
    phuongphuong
TCA014
     [Template]   Get customer favorite products from api
     259596
TCA015
     [Template]   Get customer address from api
     259596

TCA016
     [Template]   Get customer products viewed from api
     259596



