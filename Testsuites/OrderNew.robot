*** Settings ***
Suite Setup       init test storefront    live
#Test Teardown     after test
Library           SeleniumLibrary
Library           JSONLibrary
Library           OperatingSystem
Resource          ../Config/Env/envi.robot
Resource          ../Core/Common.robot
Resource          ../Core/Share/Computation.robot
Resource          ../Core/Share/Computation.robot
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
Resource          ../Core/Customer/Orderhistory_action.robot
Resource          ../Core/API-KV/api_hoadon.robot
Resource          ../Core/API-KV/api_order_kv.robot
*** Test Cases ***
TC001
    [Tags]    All    Order     Account
    [Setup]    Clear customer cart
    [Template]    Search product add to cart and check out at branch with status order wait confirm
    SP001481    0972641413    3       Chờ xác nhận
TC002
    [Tags]    All    Order     Account
    [Setup]    Clear customer cart
    [Template]    Search product add to cart and check out at address customer with status order processing
    SP001481     3    2   Đang xử lý     Nhat Minh    0972641413     1A yết kiêu   Bình Phước - Huyện Bù Đốp    Xã Tân Thành

*** Keywords ***
Search product add to cart and check out at branch with status order wait confirm
    [Arguments]    ${key}   ${sdt}   ${sl}     ${status_donhang}
    open browser   ${storefront_url}   gc
    maximize browser window
    Dang nhap account fe    ${google_account}    ${google_pass}
    ${tensp}    ${price}    ${total}   Them san pham tim kiem vao gio hang   ${key}    ${sl}
    ${order_code}    ${total_tt}    Thanh toan va nhan hang tai chi nhanh    ${tensp}    ${price}    ${total}
    Validate status orders in order history account   ${order_code}    ${total_tt}    ${status_donhang}


Search product add to cart and check out at address customer with status order processing
    [Arguments]    ${product_code}     ${sl}   ${sl_lay}   ${status_donhang}    ${username}   ${sdt}   ${diachi}  ${tinh_tp}  ${phuong_xa}
    open browser   ${storefront_url}   gc
    maximize browser window
    Dang nhap account fe    ${google_account}    ${google_pass}
    ${tensp}    ${price}    ${total}   Them san pham tim kiem vao gio hang   ${product_code}    ${sl}
    ${order_code}    ${total_tt}    Thanh toan va nhan hang tai dia chi    ${tensp}   ${price}    ${total}    ${username}   ${sdt}   ${diachi}  ${tinh_tp}  ${phuong_xa}
    ${order_id}    Get orderid    ${order_code}
    Create invoice of order incl one product frm api    ${product_code}    ${sl_lay}    ${customer_code_google_account}    10000    ${order_id}
    Validate status orders in order history account   ${order_code}    ${total_tt}    ${status_donhang}
