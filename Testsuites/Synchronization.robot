*** Settings ***
Suite Setup       init test env sync    stagingnew
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          ../Config/Env/envi.robot
Resource          ../Core/API-KV/api_hanghoa_kv.robot
Resource          ../Core/API-KV/api_access_kv.robot
Resource          ../Core/Share/Computation.robot
Resource          ../Core/CMS-Product/productlist_locator.robot
Resource          ../Core/Share/Computation.robot
Resource          ../Core/API-KV/api_banggia.robot
Resource          ../Core/API-KV/api_banggia.robot
Resource          ../Core/CMS-Product/productlist_action.robot
Resource          ../Core/API-KV/api_hoadon.robot
Library           ExcelLibrary
Resource          ../Core/Share/Excel.robot
Resource          ../Core/Common.robot

*** Test Cases ***
STC001
    [Tags]    All    sync    test
    [Template]    Check sync name, baseprice, stock of new product
    Test thêm mới    Hàng Anh    135000    62000    17
    [Teardown]    after test

STC002
    [Tags]    all    sync
    [Template]    Check sync update name, baseprice, stock
    SP000077    Soy Isoflavones Natrol mầm đậu nành nguyên chất thùng    499000    11000
    [Teardown]    after test

STC003
    [Tags]    All    sync
    [Template]    Check sync update pricebook detail
    test bảng giá    SP001494    6450000
    [Teardown]    after test

STC004
    [Tags]    all    sync
    [Template]    Check sync remove and add product in pricebook
    test bảng giá    SP001448
    [Teardown]    after test

MTC-001
    [Template]    Check sync prod and measure time
    Test đo time    Hàng Anh    135000    62000    17
    [Teardown]    after test

*** Keywords ***
Check sync name, baseprice, stock of new product
    [Arguments]    ${product_name}    ${category_name}    ${base_price}    ${cost}    ${stock}
    ${product_code}    Generate code automatically    MYK
    Add kv product thr api    ${product_code}    ${product_name}    ${category_name}    ${base_price}    ${cost}    ${stock}
    open browser    ${access_url}    gc
    Maximize browser window
    ${url_productlist}    Format string    {0}/product    ${url}
    go to    ${url_productlist}
    wait until element is visible    ${txt_mahanghoa}
    set selenium speed    1s
    ${productcode_locator}    Format string    ${firstproduct_code}    ${product_code}
    ${productname_locator}    Format string    ${firstproduct_name}    ${product_code}
    ${productstock_locator}    Format string    ${firstproduct_stock}    ${product_code}
    ${productbaseprice_locator}    Format string    ${firstproduct_baseprice}    ${product_code}
    : FOR    ${time}    IN RANGE    10
    \    sleep    5s
    \    sendkey to element    ${txt_mahanghoa}    ${product_code}
    \    click to element    ${btn_loctimkiem}
    \    ${present}=    Run keyword and return status    wait until element is visible    ${productcode_locator}
    \    Exit for loop if    '${present}'=='True'
    ${ma_sp}    get text    ${productcode_locator}
    #${ten_sp}    get text    ${productname_locator}
    ${ten_sp}    get element attribute    ${productname_locator}    data-original-title
    ${ton_sp}    get text    ${productstock_locator}
    ${baseprice_sp}    convert price to number    ${productbaseprice_locator}
    Should be equal as strings    ${product_code}    ${ma_sp}
    Should be equal as strings    ${product_name}    ${ten_sp}
    Should be equal as strings    ${stock}    ${ton_sp}
    ${base_price_cv}    convert to number    ${base_price}
    Should be equal as strings    ${base_price_cv}    ${baseprice_sp}
    Delete kv product thr API    ${product_code}
    : FOR    ${time}    IN RANGE    10
    \    sleep    20s
    \    reload page
    \    ${present}=    Run keyword and return status    wait until element is not visible    ${productcode_locator}
    \    Exit for loop if    '${present}'=='True'
    page should not contain element    ${productcode_locator}

test
    [Arguments]    ${product_code}    ${saleprice_update}
    delete product of price book thr api    Test bảng giá    SP001448
    Changing price in price book thr API    Test bảng giá    SP001448    120000

Check sync update name, baseprice, stock
    [Arguments]    ${product_code}    ${name_update}    ${baseprice_update}    ${stock_update}
    ${old_name}    ${old_baseprice}    ${old_stock}    Update name, price, stock product thr API    ${product_code}    pro    ${baseprice_update}
    ...    ${stock_update}    ${name_update}
    open browser    ${access_url}    gc
    Maximize browser window
    ${url_productlist}    Format string    {0}/product    ${url}
    go to    ${url_productlist}
    wait until element is visible    ${txt_mahanghoa}
    set selenium speed    1s
    ${productcode_locator}    Format string    ${firstproduct_code}    ${product_code}
    ${productname_locator}    Format string    ${firstproduct_name}    ${product_code}
    ${productstock_locator}    Format string    ${firstproduct_stock}    ${product_code}
    ${productbaseprice_locator}    Format string    ${firstproduct_baseprice}    ${product_code}
    : FOR    ${time}    IN RANGE    10
    \    sleep    20s
    \    input text    ${txt_mahanghoa}    ${product_code}
    \    click element    ${btn_loctimkiem}
    \    ${present}=    Run keyword and return status    wait until element is visible    ${productcode_locator}
    \    Exit for loop if    '${present}'=='True'
    ${ma_sp}    get text    ${productcode_locator}
    #${ten_sp}    get text    ${productname_locator}
    ${ten_sp}    get element attribute    ${productname_locator}    data-original-title
    ${ton_sp}    get text    ${productstock_locator}
    ${ton_sp}    remove string    ${ton_sp}    ,    ${EMPTY}
    ${baseprice_sp}    convert price to number    ${productbaseprice_locator}
    Should be equal as strings    ${product_code}    ${ma_sp}
    Should be equal as strings    ${name_update}    ${ten_sp}
    Should be equal as strings    ${stock_update}    ${ton_sp}
    ${base_price_cv}    convert to number    ${baseprice_update}
    Should be equal as strings    ${base_price_cv}    ${baseprice_sp}
    Update name, price, stock product thr API    ${product_code}    pro    ${old_baseprice}    ${old_stock}    ${old_name}

Check sync update pricebook detail
    [Arguments]    ${pricebook_name}    ${product_code}    ${saleprice_update}
    ${old_price}    Get price of product in price book thr api    ${pricebook_name}    ${product_code}
    Changing price in price book thr API    ${pricebook_name}    ${product_code}    ${saleprice_update}
    open browser    ${access_url}    gc
    Maximize browser window
    ${url_productlist}    Format string    {0}/product    ${url}
    go to    ${url_productlist}
    wait until element is visible    ${txt_mahanghoa}
    set selenium speed    1s
    ${locator_saleprice}    Format String    ${firstproduct_saleprice}    ${product_code}
    : FOR    ${time}    IN RANGE    10
    \    sleep    20s
    \    input text    ${txt_mahanghoa}    ${product_code}
    \    click element    ${btn_loctimkiem}
    \    ${present}=    Run keyword and return status    Assert saleprice is updated    ${saleprice_update}    ${locator_saleprice}
    \    Exit for loop if    '${present}'=='True'
    Assert saleprice is updated    ${saleprice_update}    ${locator_saleprice}
    Changing price in price book thr API    ${pricebook_name}    ${product_code}    ${old_price}
    : FOR    ${time}    IN RANGE    10
    \    sleep    20s
    \    input text    ${txt_mahanghoa}    ${product_code}
    \    click element    ${btn_loctimkiem}
    \    ${present}=    Run keyword and return status    Assert saleprice is updated    ${old_price}    ${locator_saleprice}
    \    Exit for loop if    '${present}'=='True'
    Assert saleprice is updated    ${old_price}    ${locator_saleprice}

Check sync remove and add product in pricebook
    [Arguments]    ${pricebook_name}    ${product_code}
    delete product of price book thr api    ${pricebook_name}    ${product_code}
    open browser    ${access_url}    gc
    Maximize browser window
    ${url_productlist}    Format string    {0}/product    ${url}
    go to    ${url_productlist}
    wait until element is visible    ${txt_mahanghoa}
    set selenium speed    1s
    ${locator_saleprice}    Format String    ${firstproduct_saleprice}    ${product_code}
    : FOR    ${time}    IN RANGE    10
    \    sleep    20s
    \    input text    ${txt_mahanghoa}    ${product_code}
    \    click element    ${btn_loctimkiem}
    \    ${present}=    Run keyword and return status    Assert product of pricebook is deleted    ${locator_saleprice}
    \    Exit for loop if    '${present}'=='True'
    Assert product of pricebook is deleted    ${locator_saleprice}
    Add product in price book thr API    ${pricebook_name}    ${product_code}
    : FOR    ${time}    IN RANGE    10
    \    sleep    20s
    \    input text    ${txt_mahanghoa}    ${product_code}
    \    click element    ${btn_loctimkiem}
    \    ${present}=    Run keyword and return status    Assert product of pricebook is not deleted    ${locator_saleprice}
    \    Exit for loop if    '${present}'=='True'
    Assert product of pricebook is not deleted    ${locator_saleprice}

write excel
    [Arguments]    ${item_cell}    ${result}    ${time_update_at_kv}    ${time_recieve}    ${time_get_update_at}
    write excel cell    ${item_cell}    1    ${result}
    write excel cell    ${item_cell}    2    ${time_update_at_kv}
    write excel cell    ${item_cell}    3    ${time_recieve}
    write excel cell    ${item_cell}    4    ${time_get_update_at}
    Exit for loop

Check sync prod and measure time
    [Arguments]    ${product_name}    ${category_name}    ${base_price}    ${cost}    ${stock}
    ${product_code}    Generate code automatically    MYK
    Add kv product thr api    ${product_code}    ${product_name}    ${category_name}    ${base_price}    ${cost}    ${stock}
    Create Session    lolo    ${webhook_url}
    ${resp1}=    RequestsLibrary.Get Request    lolo    /job/current_job
    Should Be Equal As Strings    ${resp1.status_code}    200
    Log    ${resp1.json()}
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    $..data.webhook_queue
    ${result} =    Evaluate    ${get_raw_data}[0] if ${get_raw_data} else 0
    ${result} =    Evaluate    $result or 0
    log    ${result}
    ${product_id}    Get product id    ${product_code}
    open browser    ${access_url}    gc
    Maximize browser window
    ${url_productlist}    Format string    {0}/product    ${url}
    go to    ${url_productlist}
    wait until element is visible    ${txt_mahanghoa}
    set selenium speed    1s
    ${productcode_locator}    Format string    ${firstproduct_code}    ${product_code}
    ${productname_locator}    Format string    ${firstproduct_name}    ${product_code}
    ${productstock_locator}    Format string    ${firstproduct_stock}    ${product_code}
    ${productbaseprice_locator}    Format string    ${firstproduct_baseprice}    ${product_code}
    : FOR    ${time}    IN RANGE    100
    \    sleep    20s
    \    input text    ${txt_mahanghoa}    ${product_code}
    \    click element    ${btn_loctimkiem}
    \    ${present}=    Run keyword and return status    wait until element is visible    ${productcode_locator}
    \    Exit for loop if    '${present}'=='True'
    ${ma_sp}    get text    ${productcode_locator}
    #${ten_sp}    get text    ${productname_locator}
    ${ten_sp}    get element attribute    ${productname_locator}    data-original-title
    ${ton_sp}    get text    ${productstock_locator}
    ${baseprice_sp}    convert price to number    ${productbaseprice_locator}
    Should be equal as strings    ${product_code}    ${ma_sp}
    Should be equal as strings    ${product_name}    ${ten_sp}
    Should be equal as strings    ${stock}    ${ton_sp}
    ${base_price_cv}    convert to number    ${base_price}
    Should be equal as strings    ${base_price_cv}    ${baseprice_sp}
    open excel document    testthuti.xlsx    test1
    ${uri}    Format string    /product/get-time-sync/{0}/{1}    ${product_id}    ${retailer_id}
    Create Session    lolo    ${webhook_url}
    ${resp1}=    RequestsLibrary.Get Request    lolo    ${uri}
    Should Be Equal As Strings    ${resp1.status_code}    200
    Log    ${resp1.json()}
    ${get_update_at_kv}    Get Value From Json    ${resp1.json()}    $..data.updated_at_kv
    ${time_update_at_kv} =    Evaluate    ${get_update_at_kv}[0] if ${get_update_at_kv} else 0
    ${time_update_at_kv} =    Evaluate    $time_update_at_kv or 0
    ${get_receive}    Get Value From Json    ${resp1.json()}    $..data.receive
    ${time_recieve} =    Evaluate    ${get_receive}[0] if ${get_receive} else 0
    ${time_recieve} =    Evaluate    $time_recieve or 0
    ${get_updated_at}    Get Value From Json    ${resp1.json()}    $..data.updated_at
    ${time_get_update_at} =    Evaluate    ${get_updated_at}[0] if ${get_updated_at} else 0
    ${time_get_update_at} =    Evaluate    $time_get_update_at or 0
    log    ${time_update_at_kv}
    log    ${time_recieve}
    log    ${time_get_update_at}
    ${item_cell}    set variable    0
    : FOR    ${index}    IN RANGE    1000
    \    ${item_cell}    Sum    ${item_cell}    1
    \    ${get_data_col}    Read excel cell    ${item_cell}    1
    \    ${data_col}    convert to string    ${get_data_col}
    \    log    ${data_col}
    \    Run keyword if    '${data_col}'=='${None}'    write excel and exit loop    ${item_cell}    ${result}    ${time_update_at_kv}
    \    ...    ${time_recieve}    ${time_get_update_at}
    save excel document    testthuti.xlsx
    Delete kv product thr API    ${product_code}

after test add product
    [Arguments]    ${product_code}
    Delete kv product thr API    ${product_code}
