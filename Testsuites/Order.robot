*** Settings ***
Suite Setup       init test env sync    live
Test Setup        before test    live
Library           SeleniumLibrary    #Test Teardown    after test
Library           RequestsLibrary
Library           Collections
Library           JSONLibrary
Resource          ../Core/Common.robot
Library           OperatingSystem
Resource          ../Core/Homepage/Homepage_locator.robot
Resource          ../Core/Homepage/Quickcart_locator.robot
Resource          ../Core/OrderPage/Orderpage_Locator.robot
Resource          ../Core/OrderPage/Orderpage_Action.robot
Resource          ../Core/Share/Javascript.robot
Resource          ../Core/SearchResult_Page/Searchpage_locator.robot
Resource          ../Core/Homepage/Homepage_action.robot
Resource          ../Core/Share/Computation.robot
Resource          ../Core/Share/Dictionary.robot
Resource          ../Core/SearchResult_Page/Searchpage_action.robot
Resource          ../Core/Share/Javascript.robot
Resource          ../Core/OrderPage/Orderpage_Locator.robot
Resource          ../Core/Share/Computation.robot
Resource          ../Core/ProductCategoryList_Page/ProductCategoryList_action.robot
Resource          ../Core/API-KV/api_hoadon.robot
Resource          ../Core/API-KV/api_order_kv.robot
Resource          ../Core/Customer/Orderhistory_action.robot

*** Variables ***
&{order_1}        SP000006=3    SP000007=4    SP000009=3

*** Test Cases ***
TC001
    [Tags]    All    Order
    [Template]    Them san pham noi bat vao cart va thanh toan
    phuong    0339786605    4

TC002
    [Tags]    All    Order    test
    [Template]    Tao don hang voi san pham moi nhat
    phuong    0987666555    434 TKC    phuong2610@gmail.com    as soon as possible    5

TC003
    [Tags]    All    Order
    [Template]    Them san pham cua category vao cart va thanh toan
    Huong Ha    0902100500    2

TC004
    [Tags]    All    Order
    [Template]    Them san pham noi bat vao cart thanh toan tai dia chi nguoi nhan
    phuong    0987666555    434 TKC    phuong2610@gmail.com    as soon as possible    6

TC005
    [Tags]    All    Order
    [Template]    Tim kiem san pham va thanh toan
    áo thun    phuong    0987666555    phuong2610@gmail.com    434 TKC    As soon as possible    3

TC006
    [Tags]    All    Order
    [Template]    them sp vao cart, cap nhat sl va thanh toan
    phuong    0339786605    4    5

TC007
    [Tags]    All    Order
    [Template]    Tao don hang voi nhieu san pham
    ${order_1}    phuong    0987666444

TC008
    [Tags]    All    Order
    [Template]    chon sp vao quickcart
    2    Bang    0901200122

TC009
    [Tags]    All    Order
    [Template]    Chon san pham thuoc category dau tien vao cart va thanh toan
    3    Huong    0902100200

TC010
    [Tags]    All    Order
    [Template]    xem chi tiet va thanh toan
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC011
    [Tags]    All    Order
    [Template]    Chon san pham thuoc category vao cart va thanh toan
    phuong    0987666555    phuong2610@gmail.com    434 TKC    As soon as possible    3

TC012
    [Tags]    All    Order
    [Template]    Cho sp vao don hang
    3    Le Huong    0902100200    huong@gmail.com    1B Yet Kieu    Don hang tao tu dong

TC013
    [Tags]    All    Order
    [Template]    Xem tat ca va thanh toan tai dia chi nguoi nhan
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC014
    [Tags]    All    Order
    [Template]    cho hang hoa cung loai vao gio hang va thanh toan
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC015
    [Tags]    All    Order
    [Template]    chon san pham thuoc tinh bien the vao cart va thanh toan
    áo phông dior    3    XL    đen    phuong    0987666555    phuong2610@gmail.com
    ...    434 TKC    As soon as possible

TC016
    [Tags]    All    Order
    [Template]    Bam da xem va cho vao gio
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC017
    [Tags]    All    Order
    [Template]    Bam yeu thich va cho vao gio hang
    phuong    0974544304    phuongtran27111994@gmail.com    1B    giao ban ngày    4

TC045
    [Tags]    All    Order    Account
    [Template]    Tim kiem san pham thanh toan va nhan hang tai chi nhanh khi dang nhap account
    SP000049    0972641413    3    1    Đang xử lý

TC046
    [Tags]    All    Order    Account
    [Template]    Them san pham noi bat vao cart thanh toan va nhan hang tai dia chi nguoi nhan khi dang nhap account
    testautomation113@gmail.com    test@123456    Kenvin    0972641413    1A yet kieu    As soon as possible    3

TC047
    [Tags]    All    Order    Account
    [Template]    Tim kiem san pham thanh toan va nhan hang tai chi nhanh khi dang nhap account
    SP000049    0972641413    3    3    Hoàn thành

TC048
    [Tags]    All    Order    Account
    [Template]    Tao don hang ben mykiot va huy don hang ben kv
    SP000049    3    0972641413    Đã hủy

test
    init test env    live
    init test env sync    live
    ${productid_1}    Get product ID    @{list_sp_noibat_hot}[0]
    ${productid_2}    Get product ID    @{list_sp_noibat_hot}[1]
    ${productid_3}    Get product ID    @{list_sp_noibat_hot}[2]
    ${productid_4}    Get product ID    @{list_sp_noibat_hot}[3]
    ${data_forstart}    Format String    ${data_start}    ${productid_1}    ${productid_2}    ${productid_3}    ${productid_4}
    #post request and validate request success    /config/save    {"theme":{"color":"#45A6AF","second_color":"#2C334D","backgroundColor":"#F9F9F9","backgroundColorHeader":"#fff","topMenuBackgroundColor":"#fff","verticalMenuBackgroundColor":"#fff","footerMenuBackgroundColor":"#fff","font":"'Roboto', sans-serif","headerBackgroundMode":"light-mode","topMenuBackgroundMode":"light-mode","verticalMenuBackgroundMode":"light-mode","horizontalMenuBackgroundMode":"dark-mode","footerMenuBackgroundMode":"light-mode"},"menu":{"main_menu":1,"sub_menu":1},"layoutProduct":3,"layoutFooter":4,"widthBanner":"boxed","bannerDisplay":"slider","profile":{"logo":"https://staging.citigo.dev:40001/assets/images/kiotvietLogo.jpg"},"category":{"layoutProduct":5,"autoLoad":1,"visibleSidebar":1},"defaultCategory":{"isShow":true,"displayType":"list"},"productDetail":{"displayDescription":1,"displayComment":1,"displayProductRelate":1,"displayWareHouse":1},"testimonial":{"isShow":false,"info":[],"items":[]},"customLayouts":[{"title":"Sản phẩm nổi bật","productIds":[11021617,11021609],"numberItem":4},{"title":"Sản phẩm mới","productIds":[11021617,11021609],"numberItem":4}],"quickEnableStatus":{"footerCopyright":true},"priceBook":{"regularPrice":-1},"branch":{"branchInventory":[20363],"branchOrder":20363},"listBranches":[{"id":20363,"branchName":"Chi nhánh trung tâm","address":"testautomykiot","locationName":"Hà Nội - Quận Hoàn Kiếm","wardName":"Phường Trần Hưng Đạo","retailerId":736403,"createdDate":"2020-09-07T17:20:46.4500000"}],"syncCategoryCompleted":true,"settingKV":{"ManagerCustomerByBranch":false,"AllowOrderWhenOutStock":true,"AllowSellWhenOrderOutStock":true,"SellAllowOrder":true},"isReady":true,"lastModifiedFromNodeSync":"2020-09-08T02:15:00.000000Z","banner":[{"alt":null,"index":0,"link":null,"url":"https://cdn.mykiot.vn/2020/09/159953204678a014b537db41dd0c20d9b410407a7a.png"}]}
    post request and validate request success    /config/save    {"theme":{"color":"#45A6AF","second_color":"#2C334D","backgroundColor":"#F9F9F9","backgroundColorHeader":"#fff","topMenuBackgroundColor":"#fff","verticalMenuBackgroundColor":"#fff","footerMenuBackgroundColor":"#fff","font":"'Roboto', sans-serif","headerBackgroundMode":"light-mode","topMenuBackgroundMode":"light-mode","verticalMenuBackgroundMode":"light-mode","horizontalMenuBackgroundMode":"dark-mode","footerMenuBackgroundMode":"light-mode"},"menu":{"main_menu":1,"sub_menu":1},"layoutProduct":3,"layoutFooter":4,"widthBanner":"boxed","bannerDisplay":"slider","profile":{"logo":"https://staging.citigo.dev:40001/assets/images/kiotvietLogo.jpg"},"category":{"layoutProduct":5,"autoLoad":1,"visibleSidebar":1},"defaultCategory":{"isShow":true,"displayType":"list"},"productDetail":{"displayDescription":1,"displayComment":1,"displayProductRelate":1,"displayWareHouse":1},"testimonial":{"isShow":false,"info":[],"items":[]},"customLayouts":[{"title":"Sản phẩm nổi bật","productIds":[1427904,1427908],"numberItem":4},{"title":"Sản phẩm mới","productIds":[1427873,1428008],"numberItem":4}],"quickEnableStatus":{"footerCopyright":true},"priceBook":{"regularPrice":-1},"branch":{"branchInventory":[20363],"branchOrder":20363},"listBranches":[{"id":20363,"branchName":"Chi nhánh trung tâm","address":"testautomykiot","locationName":"Hà Nội - Quận Hoàn Kiếm","wardName":"Phường Trần Hưng Đạo","retailerId":736403,"createdDate":"2020-09-07T17:20:46.4500000"}],"syncCategoryCompleted":true,"settingKV":{"ManagerCustomerByBranch":false,"AllowOrderWhenOutStock":true,"AllowSellWhenOrderOutStock":true,"SellAllowOrder":true},"isReady":true,"lastModifiedFromNodeSync":"2020-09-08T02:15:00.000000Z","banner":[{"alt":null,"index":0,"link":null,"url":"https://cdn.mykiot.vn/2020/09/159953204678a014b537db41dd0c20d9b410407a7a.png"}]}

TCxxxx
    open browser    https://testautomykiot.kiotviet.com/    gc
    Maximize browser window
    input text    //input[@id='UserName']    admin
    input text    //input[@id='Password']    123
    click button    //input[@name='quan-ly']
    sleep    5s
    go to    https://testautomykiot.kiotviet.com/#/PosParameter#tab-mykiot
    sleep    5s
    click element    //a[@class='popup-close']
    sleep    5s
    select frame    //iframe[contains(@src,'iframe')]
    click element    //button[@id='btn-redirect-ecatalog']
    sleep    5s
    Select Window    NEW
    title should be    Dashboard
    close all browsers

*** Keywords ***
Them san pham noi bat vao cart va thanh toan
    [Arguments]    ${username}    ${mobilephone}    ${sl}
    ${thanhtien}    ${gia}    Them san pham noi bat vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${username}    ${mobilephone}    ${thanhtien}    ${gia}

Tim kiem san pham thanh toan va nhan hang tai chi nhanh khi dang nhap account
    [Arguments]    ${product_code}    ${phone}    ${sl}    ${sl_lay}    ${status_order}
    Dang nhap account    ${google_account}    ${google_pass}
    kiem tra gio hang
    Tim kiem san pham    ${product_code}
    ${thanhtien}    ${gia}    Them san pham tim kiem vao cart    ${product_code}    ${sl}
    sleep    2s
    ${order_code}    Thanh toan nhan hang tai chi nhanh khi dang nhap account    ${google_account}    ${phone}    ${thanhtien}    ${gia}
    ${order_id}    Get orderid    ${order_code}
    Create invoice of order incl one product frm api    ${product_code}    ${sl_lay}    ${customer_code_google_account}    10000    ${order_id}
    Validate status orders in order history    ${order_code}    ${thanhtien}    ${status_order}

Them san pham noi bat vao cart thanh toan va nhan hang tai dia chi nguoi nhan khi dang nhap account
    [Arguments]    ${email}    ${pass}    ${ten}    ${sdt}    ${diachi}    ${ghichu}
    ...    ${sl}
    Dang nhap account    ${email}    ${pass}
    kiem tra gio hang
    ${thanhtien}    ${gia}    Them san pham noi bat vao cart    ${sl}
    sleep    2s
    Thanh toan nhan hang tai dia chi nguoi nhan khi dang nhap account    ${ten}    ${email}    ${sdt}    ${diachi}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Them san pham noi bat vao cart thanh toan tai dia chi nguoi nhan
    [Arguments]    ${ten}    ${sdt}    ${email}    ${diachi}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Them san pham noi bat vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Tim kiem san pham va thanh toan
    [Arguments]    ${input_text}    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}
    ...    ${sl}
    Tim kiem san pham    ${input_text}
    ${total}    ${price}    Them san pham tim kiem vao cart    ${input_text}    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${total}
    ...    ${price}

Them sp vao cart, cap nhat sl va thanh toan
    [Arguments]    ${ten}    ${sdt}    ${sl}    ${sl_update}
    ${thanhtien}    ${gia}    Them san pham noi bat vao cart    ${sl}
    sleep    3
    Cap nhat gio hang va thanh toan nhan hang tai chi nhanh    ${ten}    ${sdt}    ${thanhtien}    ${gia}    ${sl_update}

Tao don hang voi san pham moi nhat
    [Arguments]    ${ten}    ${sdt}    ${email}    ${diachi}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Them san pham moi nhat vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Tao don hang voi nhieu san pham
    [Arguments]    ${dict_product_num}    ${ten}    ${sdt}
    ${tongtienhang}    ${list_thanhtien}    Tim kiem va add nhieu san pham vao cart    ${dict_product_num}
    Thanh toan nhieu san pham nhan hang tai chi nhanh    ${ten}    ${sdt}    ${list_thanhtien}    ${tongtienhang}

Them san pham cua category vao cart va thanh toan
    [Arguments]    ${user_name}    ${user_sdt}    ${sl}
    ${thanhtien}    ${gia}    Them san pham cua category vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Chon sp vao quickcart
    [Arguments]    ${sl}    ${user_name}    ${user_sdt}
    ${thanhtien}    ${gia}    Chon sp mua ngay    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Xem tat ca va thanh toan tai dia chi nguoi nhan
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Xem tat ca va them san pham vao cart    ${sl}
    sleep    3
    thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Chon san pham thuoc category dau tien vao cart va thanh toan
    [Arguments]    ${sl}    ${user_name}    ${user_sdt}
    ${thanhtien}    ${gia}    Xem chi tiet sp dau va them vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai chi nhanh    ${user_name}    ${user_sdt}    ${thanhtien}    ${gia}

Chon san pham thuoc category vao cart va thanh toan
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    Chon category tu menu
    ${total}    ${price}    Them san pham cua trang category vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${total}
    ...    ${price}

Cho sp vao don hang
    [Arguments]    ${sl}    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}
    ${thanhtien}    ${gia}    Cho sp vao gio hang    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Xem chi tiet va thanh toan
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Xem chi tiet va add vao cart    ${sl}
    sleep    3
    thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Cho hang hoa cung loai vao gio hang va thanh toan
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Xem chi tiet va add hang hoa cung loai vao gio hang    ${sl}
    sleep    3
    thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Chon san pham thuoc tinh bien the vao cart va thanh toan
    [Arguments]    ${input_text}    ${sl}    ${thuoctinh_1}    ${thuoctinh_2}    ${ten}    ${sdt}
    ...    ${diachi}    ${email}    ${ghichu}
    Tim kiem san pham    ${input_text}
    ${total}    ${price}    Chon san pham thuoc tinh vao cart    ${input_text}    ${sl}    ${thuoctinh_1}    ${thuoctinh_2}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${total}
    ...    ${price}

Bam yeu thich va cho vao gio hang
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Bam yeu thich va add vao cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Bam da xem va cho vao gio
    [Arguments]    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${sl}
    ${thanhtien}    ${gia}    Bam da xem va add cart    ${sl}
    sleep    3
    Thanh toan nhan hang tai dia chi nguoi nhan    ${ten}    ${sdt}    ${diachi}    ${email}    ${ghichu}    ${thanhtien}
    ...    ${gia}

Tao don hang ben mykiot va huy don hang ben kv
    [Arguments]    ${product_code}    ${sl}    ${phone}    ${status_order}
    Dang nhap account    ${google_account}    ${google_pass}
    Tim kiem san pham    ${product_code}
    ${thanhtien}    ${gia}    Them san pham tim kiem vao cart    ${product_code}    ${sl}
    sleep    3
    ${order_code}    Thanh toan nhan hang tai chi nhanh khi dang nhap account    ${google_account}    ${phone}    ${thanhtien}    ${gia}
    Delete order by order code    ${order_code}
    Validate status orders in order history    ${order_code}    ${thanhtien}    ${status_order}
