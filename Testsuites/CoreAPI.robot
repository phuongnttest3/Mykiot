*** Settings ***
Library           RequestsLibrary
Resource          ../Core/API/api_core_product.robot
Resource          ../Core/API/api_core_store.robot
Resource          ../Core/API/api_core_menu.robot
Resource          ../Core/API/api_core_customer.robot
Resource          ../Core/API/api_core_page.robot
Resource          ../Core/API/api_core_category.robot

*** Test Cases ***
TCA001
    [Documentation]    Get Product list with category_id
    [Template]    Get product list
    72820

TCA002
    [Template]    Get Product Detail
    340372599

TCA003
    [Template]  Get data store from Api
    longopss

TCA004
    [Template]  Get config store from Api
    525011

TCA005
    [Template]  Get list menu from Api
    525011

TCA006
    [Template]  Login customer get token from api
    785673
TCA007
    [Template]  Get profile customer from api
    785673
TCA008
     [Template]   Get data page from api
     785673
TCA009
     [Template]   Get data category from api
     785673