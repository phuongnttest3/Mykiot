*** Settings ***
Resource          Checkoutpage_locator.robot
Library           SeleniumLibrary
Library           StringFormat
Resource          ../Share/Javascript.robot
Resource          ../Share/Computation.robot
Resource          ../Share/Dictionary.robot
Resource          ../Customer/Profilepage_locator.robot

*** Keywords ***
Thanh toan va nhan hang tai chi nhanh
   [Arguments]   ${tensp}   ${price}    ${total}    ${brach_name}
   #wait until element is visible  ${title_checkout}   5s
   ${name}    get text element  ${lbl_name}
   should be equal as strings    ${name}   ${tensp}
   ${giasp}    Convert price to number   ${lbl_gia}
   should be equal as numbers   ${price}   ${giasp}
   ${lbl_thanhtien}     Convert price to number   ${lbl_thanhtien}
   should be equal as numbers    ${lbl_thanhtien}   ${total}
   Chon chi nhanh nhan hang     ${brach_name}
   scroll element into view     ${total_thanhtoan}
   ${total_tt}    Convert price to number   ${total_thanhtoan}
   click to element   ${btn_dathang}
   ${order_code}   get text element    ${lblorder_code}
   click to element  ${btn_tieptucmuahang}
   return from keyword   ${order_code}   ${total_tt}



Chon chi nhanh nhan hang
   [Arguments]  ${brach_name}
   click to element  ${rb_nhantaichinhanh}
   ${chinhanh}   format string    ${rb_chinhanh}    ${brach_name}
   click to element   ${chinhanh}
