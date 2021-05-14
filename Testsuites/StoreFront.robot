*** Settings ***
Suite Setup       init test env sync    stagingtest
Suite Teardown
Test Teardown     after test
Library           SeleniumLibrary
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Library           OperatingSystem
Resource          ../Core/API/api_core_product.robot
Resource          ../Core/API-KV/api_access_kv.robot
Resource          ../Core/API-KV/api_hanghoa_kv.robot
Resource          ../Core/CMS-Product/productlist_locator.robot
Resource          ../Core/Share/Computation.robot
Resource          ../Config/Env/envi.robot
Resource          ../Core/Product_Detail_Page_New/Product_Detail_locator.robot
Resource          ../Core/Common.robot
Resource          ../Core/Product_Detail_Page_New/Product_Detail_Action.robot

*** Test Cases ***
Add product and check detail
    [Template]    Add product and check detail
    Hoa cúc đại đóa    Hoa    100000    50000    120

*** Keywords ***
Add product and check detail
    [Arguments]    ${product_name}    ${category_name}    ${base_price}    ${cost}    ${stock}
    ${product_code}    Generate code automatically    MYK
    Add kv product thr api    ${product_code}    ${product_name}    ${category_name}    ${base_price}    ${cost}    ${stock}
    open browser    ${access_url}    gc
    Maximize browser window
    ${url_productlist}    Format string    {0}/product    ${url}
    go to    ${url_productlist}
    wait until element is visible    ${txt_mahanghoa}
    set selenium speed    1s
    click element    ${btn_sync}
    ${productcode_locator}    Format string    ${firstproduct_code}    ${product_code}
    : FOR    ${time}    IN RANGE    10
    \    sleep    5s
    \    sendkey to element    ${txt_mahanghoa}    ${product_code}
    \    click to element    ${btn_loctimkiem}
    \    ${present}=    Run keyword and return status    wait until element is visible    ${productcode_locator}
    \    Exit for loop if    '${present}'=='True'
    ${ma_sp}    get text    ${productcode_locator}
    Should be equal as strings    ${product_code}    ${ma_sp}
    ${product_id}    Get product id through product code    ${product_code}
    ${product_code_api}    ${product_name_api}    ${category_name_api}    ${stock_api}    ${baseprice_api}    Get product main infor from product detail    ${product_id}
    should be equal as strings    ${product_code_api}    ${product_code}
    Should be equal as strings    ${product_name_api}    ${product_name}
    Should be equal as strings    ${category_name_api}    ${category_name}
    ${stock_input}    Convert to number    ${stock}
    Should be equal as numbers    ${stock_api}    ${stock_input}
    ${baseprice_input}    Convert to number    ${base_price}
    Should be equal as numbers    ${baseprice_api}    ${baseprice_input}
    ${product_url}    Get url product detail    ${product_name}    ${product_id}
    go to    ${product_url}
    reload page
    ${product_code_locator}    Format string    ${lbl_productcode}    ${product_code}
    ${product_name_locator}    Format string    ${lbl_productname}    ${product_name}
    ${product_categoryname_locator}    Format string    ${link_category_breadcrumb}    ${category_name}
    Page should contain element    ${product_code_locator}
    Page should contain element    ${product_name_locator}
    Page should contain element    ${product_categoryname_locator}
    ${get_stock}    Get text    ${lbl_stock}
    ${stock_storefront}    Get stock of product in product detail    ${get_stock}
    should be equal as numbers    ${stock_storefront}    ${stock_input}
    ${price_storefront}    Convert price to number    ${lbl_productprice}
    should be equal as numbers    ${price_storefront}    ${baseprice_input}
    Delete kv product thr API    ${product_code}
