*** Settings ***
Library           RequestsLibrary
Resource          ../Core/API/api_core_product.robot

*** Test Cases ***
TCA001
    [Documentation]    Get Product list with category_id
    [Template]    Get product list
    72820

TCA002
    [Template]    Get Product Detail
    340372599
