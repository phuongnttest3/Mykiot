*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Library           SeleniumLibrary
Resource          ../Share/Computation.robot
Resource          ../CMS-Product/cms_locator.robot
*** Keywords ***

open page thietlap
    click to element  ${menu_thietlap}
    title should be    Thiết lập hàng hóa
    click to element  ${menu_thietlapdathang}
    title should be   Thiết lập đặt hàng
    click to element  ${menu_thietlapdongbo}
    title should be    Thiết lập đồng bộ
    click to element  ${menu_thietlapthongtin}
    title should be    Thông tin
    click to element  ${menu_thietlapphaply}
    title should be     Thiết lập thông tin Pháp lý Footer
    click to element  ${menu_thietlapmenu}
    title should be      Thiết lập menu
    click to element   ${menu_thietlaphinhthuc}
    title should be       Hình thức
    click to element  ${menu_thietlaphethong}
    title should be     Thiết lập hệ thống
    click to element  ${menu_thietlaptenmien}
    title should be     Thiết lập Domain

open page hanghoa
    click to element  ${menu_hanghoa}
    title should be   Danh sách hàng hóa
    mouse out   ${menu_hanghoa}
    click to element  ${menu_danhmuchanghoa}
    title should be  Danh sách danh mục
    mouse out   ${menu_hanghoa}
    click to element  ${menu_danhgiahanghoa}
    title should be  Danh sách đánh giá
open page baiviet
    click to element  ${menu_baiviet}
    title should be    Danh sách bài viết
    mouse out  ${menu_baiviet}
    click to element  ${menu_danhmucbaiviet}
    title should be    Danh mục bài viết
open page donhang
    click to element  ${menu_donhang}
    title should be     Quản lý đơn hàng
open storefront page
     wait until element is visible   ${btn_viewstorefront}  5s
     click element js  ${btn_viewstorefront}
     click to element  ${btn_view}
     click element js  ${btn_viewstorefront}
