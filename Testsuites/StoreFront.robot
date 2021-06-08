*** Settings ***
Suite Setup       init test storefront    stagingtest
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
Resource          ../Core/HomePage_New/Homepage_action.robot
Resource          ../Core/Common_/Common_locator.robot
Resource          ../Core/API/api_core_customer.robot
Resource          ../Core/Common_/Common_action.robot
Resource          ../Core/SearchResult_Page/Searchpage_locator.robot
Resource          ../Core/SearchResult_Page/Searchpagenew_action.robot
Resource          ../Core/CheckoutPage/Checkoutpage_action.robot
Resource          ../Core/API/api_core_comment.robot
Resource          ../Core/Account_Page/Account_locator.robot
Resource          ../Core/SearchResult_Page/Searchpagenew_locator.robot

*** Test Cases ***
TCS001
    [Template]    Add product and check detail
    Hoa cúc đại đóa    Hoa    100000    50000    120

TCS002
    [Template]    Add product to quickcart through api and validate
    PK023    3

TCS003
    [Template]    Get list product category api and check data
    140    810032

TCS004
    [Template]    search result product and check data
    hoa

TCS005
    [Template]    Add product to cart and check out at branch
    SP9555556987    3    1B Yết Kiêu, Phường Trần Hưng Đạo, Quận Hoàn Kiếm - Hà Nội

TCS006
    [Template]    Add product to quickcart and validate through api
    SP9555556916    33

TCS007
    [Template]    Add product to cart and check out at address
    SP9555556987    3    Nguyen van 2    0972654546    1A yết kiêu    An Giang - Huyện Tri Tôn    Xã Vĩnh Phước

TCS008
    [Template]    Add comment through api and validate UI
    GB00012    Thỏ rất xinh

TCS009
    [Template]    Add comment UI and validate through api
    HH07    Hoa rất đẹp
TCS010
    Get order detail api and check data

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

Add product to quickcart through api and validate
    [Arguments]    ${product_code}    ${quantity}
    update customer cart from api    ${product_code}    ${quantity}
    ${product_id}    Get product id through product code    ${product_code}
    ${product_code}    ${product_name}    ${category_name}    ${stock}    ${product_baseprice}    get product main infor from product detail    ${product_id}
    open browser    https://fe-staging.citigo.dev:40001    gc
    Maximize browser window
    Dang nhap account fe    ${google_account}    ${google_pass}
    wait until element is visible    ${btn_giohang}    5s
    click element    ${btn_giohang}
    ${productname_locator}    Format string    ${link_tensp_giohang}    ${product_name}
    Page should contain element    ${productname_locator}
    Delete product from customer cart through api    ${product_id}

Get list product category api and check data
    [Arguments]    ${category_id}    ${retailer_id}
    ${product_name}    ${category_child}    ${attribute_name}    Get list product category from api    ${category_id}    ${retailer_id}
    open browser    https://fe-staging.citigo.dev:40001/thuc-pham.c140.html    gc
    maximize browser window
    sleep    2s
    Execute Javascript    window.location.reload(true);
    sleep    5s
    ${length_productname}=    get length    ${product_name}
    ${length_category}=    get length    ${category_child}
    ${length_attribute}=    get length    ${attribute_name}
    #kiểm tra danh sach ten san pham hiển thị có ở page 1
    : FOR    ${i}    IN RANGE    ${length_productname}
    \    ${name}    get from list    ${product_name}    ${i}
    \    page should contain    ${name}
    \    exit for loop if    '${i}'=='${length_productname}'
    # kiểm tra danh sach các category được hiển thị
    : FOR    ${j}    IN RANGE    ${length_category}
    \    ${category}    get from list    ${category_child}    ${j}
    \    page should contain    ${category}
    \    exit for loop if    '${j}'=='${length_category}'
    # Kiểm tra các thuộc tính hiển thị ở page product listing
    : FOR    ${x}    IN RANGE    ${length_attribute}
    \    ${attribute}    get from list    ${attribute_name}    ${x}
    \    page should contain    ${attribute}
    \    exit for loop if    '${x}'=='${length_attribute}'

Search result product and check data
    [Arguments]    ${key}
    ${valjson}    Search product through api    ${key}
    ${listname}    JSONLibrary.Get Value From Json    ${valjson}    $.data.products..name
    ${listname}    evaluate    $listname
    log    ${listname}
    open browser    https://fe-staging.citigo.dev:40001/    gc
    maximize browser window
    sleep    2s
    Execute Javascript    window.location.reload(true);
    sleep    5s
    sendkey to element    ${txt_searchfe}    ${key}
    click element js    ${btn_searchfe}
    ${length_listname}=    get length    ${listname}
    : FOR    ${i}    IN RANGE    ${length_listname}
    \    ${name}    get from list    ${listname}    ${i}
    \    page should contain    ${name}
    \    exit for loop if    '${i}'=='${length_listname}'

Add product to cart and check out at branch
    [Arguments]    ${key}    ${sl}    ${brach_name}
    open browser    https://fe-staging.citigo.dev:40001/    gc
    maximize browser window
    sleep    5s
    Dang nhap account fe    ${google_account}    ${google_pass}
    ${tensp}    ${price}    ${total}    Them san pham tim kiem vao gio hang    ${key}    ${sl}
    ${order_code}    ${total_tt}    Thanh toan va nhan hang tai chi nhanh    ${tensp}    ${price}    ${total}    ${brach_name}
    ${json}    Get customer orders detail from api    ${order_code}
    ${namesp}=    JSONLibrary.Get Value From Json    ${json}    $.data.order..name
    ${namesp}=    Evaluate    $namesp[0]
    log    ${namesp}
    should be equal    ${namesp}    ${tensp}
    ${total_thanhtien}=    JSONLibrary.Get Value From Json    ${json}    $.data.order.amount
    ${total_thanhtien}=    Evaluate    $total_thanhtien[0]
    ${total_thanhtien}    remove string    ${total_thanhtien}    ,    đ    ${EMPTY}
    ${total_thanhtien}    convert to number    ${total_thanhtien}
    log    ${total_thanhtien}
    should be equal as numbers    ${total_thanhtien}    ${total_tt}

Add product to quickcart and validate through api
    [Arguments]    ${product_code}    ${quantity}
    open browser    https://fe-staging.citigo.dev:40001    gc
    Maximize browser window
    Dang nhap account fe    ${google_account}    ${google_pass}
    Them san pham tim kiem vao gio hang    ${product_code}    ${quantity}
    ${product_id}    ${product_quantity}    ${product_code_info}    Get customer cart from api    ${retailer_id}
    should be equal as strings    ${product_quantity}    ${quantity}
    should be equal as strings    ${product_code_info}    ${product_code}
    Delete product from customer cart through api    ${product_id}

Add product to cart and check out at address
    [Arguments]    ${key}    ${sl}    ${username}   ${phone}   ${diachi}  ${tinh_tp}  ${phuong_xa}
    ${product_code}  Get customer cart
    ${length_code}=   get length  ${product_code}
    : FOR    ${i}   IN RANGE    ${length_code}
     \  ${item_code}   get from list   ${product_code}   ${i}
     \   Detele customer carts from api   ${item_code}
     \   exit for loop if  '${i}'=='${length_code}'
    open browser    https://fe-staging.citigo.dev:40001/    gc
    maximize browser window
    sleep    5s
    Dang nhap account fe    ${google_account}    ${google_pass}
    ${tensp}    ${price}    ${total}    Them san pham tim kiem vao gio hang    ${key}    ${sl}
    ${order_code}    ${total_tt}    Thanh toan va nhan hang tai dia chi    ${tensp}    ${price}    ${total}    ${username}
    ...    ${phone}    ${diachi}    ${tinh_tp}    ${phuong_xa}
    ${json}    Get customer orders detail from api    ${order_code}
    ${namesp}=    JSONLibrary.Get Value From Json    ${json}    $.data.order..name
    ${namesp}=    Evaluate    $namesp[0]
    log    ${namesp}
    should be equal    ${namesp}    ${tensp}
    ${total_thanhtien}=    JSONLibrary.Get Value From Json    ${json}    $.data.order.amount
    ${total_thanhtien}=    Evaluate    $total_thanhtien[0]
    ${total_thanhtien}    remove string    ${total_thanhtien}    ,    đ    ${EMPTY}
    ${total_thanhtien}    convert to number    ${total_thanhtien}
    log    ${total_thanhtien}
    should be equal as numbers    ${total_thanhtien}    ${total_tt}

Add comment through api and validate UI
    [Arguments]    ${product_code}    ${content}
    ${hex} =    Generate Random String    6    [NUMBERS]abcdef
    ${content_input}    format string    {0} {1}    ${content}    ${hex}
    ${comment_id}    Create comment through api    ${product_code}    ${content_input}
    open browser    ${storefront_url}    gc
    Maximize browser window
    Dang nhap account fe    ${google_account}    ${google_pass}
    wait until element is visible    ${btn_taikhoan_sdn}
    ${customercomment_url}    Format string    {0}/customer/comment.html    ${storefront_url}
    go to    ${customercomment_url}
    ${comment_locator}    Format string    ${lbl_comment_content}    ${content_input}    ${product_code}
    sleep    5s
    page should contain element    ${comment_locator}
    ${product_id}    Get product_id through product_code    ${product_code}
    Delete comment through comment_id    ${comment_id}    ${product_id}

Add comment UI and validate through api
    [Arguments]    ${product_code}    ${content}
    ${product_id}    get product_id through product code    ${product_code}
    ${product_code}    ${product_name}    ${category_name}    ${stock}    ${product_baseprice}    get product main infor from product detail    ${product_id}
    ${hex} =    Generate Random String    6    [NUMBERS]abcdef
    ${content_input}    format string    {0} {1}    ${content}    ${hex}
    open browser    ${storefront_url}    gc
    Maximize browser window
    Dang nhap account fe    ${google_account}    ${google_pass}
    Tim kiem san pham    ${product_code}
    ${link_tensp_locator}    Format string    ${link_tensp_timkiem}    ${product_name}
    click element    ${link_tensp_locator}
    Wait until element is visible    ${txt_comment_sdn}
    input text    ${txt_comment_sdn}    ${content_input}
    click button    ${btn_comment_sdn}
    ${comment_content}    ${comment_id}    Get comment infor of customer    ${product_code}
    should be equal as strings    ${comment_content}    ${content_input}
    Delete comment through comment_id    ${comment_id}    ${product_id}
    log   ${total_thanhtien}
    should be equal as numbers  ${total_thanhtien}  ${total_tt}


Get customer cart
    ${heades1}=    create dictionary    store-id=810032  Content-Type=application/x-www-form-urlencoded    Authorization=${mykiot_token}
    create session    lolo    ${coreapi_url}
    ${resp1}=    get request    lolo    v1/customers/carts    headers=${heades1}
    log    ${resp1.json()}
    Should be equal as strings    ${resp1.status_code}    200
    ${product_code}=    JSONLibrary.Get Value From Json    ${resp1.json()}    $..data..code
    ${product_code}=    evaluate    $product_code    modules=random, sys
    log    ${product_code}
    return from keyword     ${product_code}

Get order detail api and check data
    open browser    ${storefront_url}    gc
    Maximize browser window
    sleep    5s
    Dang nhap account fe    ${google_account}    ${google_pass}
    sleep  2s
    click to element   ${acc_header_link}
    click to element   ${order_history_link}
    ${order_code}  get text  ${odercode_text}
    click to element  ${odercode_text}
    ${jsonvalue}    Get customer orders detail from api    ${order_code}
    ${total_sl}=   JSONLibrary.Get Value From Json     ${jsonvalue}      $..data.order.quantity
    ${total_sl}=    evaluate    ${total_sl}[0] if ${total_sl} else 0
    log  ${total_sl}
    ${total_sluong}    convert to number    ${total_sl}
    ${quantity}=  Get text and convert to number   ${total_quantity}
    should be equal as numbers    ${quantity}   ${total_sluong}

    ${amount}=   JSONLibrary.Get Value From Json     ${jsonvalue}      $..data.order.amount
    ${amount}=    Evaluate     $amount[0]
    log  ${amount}
    ${amount}    remove string    ${amount}    ,    đ    ${EMPTY}
    ${amount}    convert to number    ${amount}
    log    ${amount}
    ${tongtien}=    convert price to number   ${total_tongtien}
    should be equal as numbers   ${tongtien}   ${amount}

    ${list_sp}=    JSONLibrary.Get Value From Json     ${jsonvalue}     $..data.order..name
    ${list_sp}=    evaluate    $list_sp      modules=random, sys
    log   ${list_sp}
    ${count_listsp}=   get length   ${list_sp}
    : FOR  ${i}  IN RANGE   ${count_listsp}
    \  ${item}  get from list    ${list_sp}  ${i}
    \  page should contain   ${item}
    \  exit for loop if    '${i}'=='${count_listsp}'


    ${list_info_customer}=    JSONLibrary.Get Value From Json     ${jsonvalue}     $..data.customer.*
    ${list_info_customer}=    evaluate      $list_info_customer   modules=random, sys
    log     ${list_info_customer}
     ${lengt_list_customer}=  get length     ${list_info_customer}
    : FOR  ${j}  IN RANGE     ${lengt_list_customer}
    \  ${itemx}  get from list    ${list_info_customer}  ${j}
    \  page should contain    ${itemx}
    \  exit for loop if  '${j}'=='${lengt_list_customer}'

    ${address_shipping}=    JSONLibrary.Get Value From Json     ${jsonvalue}   $..data.order.address
    ${address_shipping}=      evaluate      $address_shipping[0]
    log     ${address_shipping}
    page should contain    ${address_shipping}

    ${phone_shipping}=    JSONLibrary.Get Value From Json     ${jsonvalue}   $..data.order.phone
    ${phone_shipping}=      evaluate      $phone_shipping[0]
    log     ${phone_shipping}
    page should contain    ${phone_shipping}

