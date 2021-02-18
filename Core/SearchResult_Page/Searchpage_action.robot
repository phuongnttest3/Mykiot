*** Settings ***
Library           SeleniumLibrary
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot
Resource          Searchpage_locator.robot
Resource          ../Homepage/Quickcart_locator.robot
Resource          ../Homepage/Homepage_locator.robot

*** Keywords ***
Them san pham tim kiem vao cart
    [Arguments]    ${input_text}    ${sl}
    wait until element is visible    ${msg_kqtimkiem}
    ${mes}=    Get text    ${msg_kqtimkiem}
    Should contain any    ${mes}    ${input_text}
    Click Element JS    ${btn_addtocart_kqtk}
    wait until element is visible    ${btn_addtocart}
    sendkey to element    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    Click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}

Tim kiem va add nhieu san pham vao cart
    [Arguments]    ${dict_product_num}
    wait until element is visible    ${txt_timkiem}
    ${list_product}    Get Dictionary Keys    ${dict_product_num}
    ${list_num}    Get Dictionary Values    ${dict_product_num}
    ${list_thanhtien}    Create list
    : FOR    ${item_product}    ${item_num}    IN ZIP    ${list_product}    ${list_num}
    \    Input text    ${txt_timkiem}    ${item_product}
    \    Click Element JS    ${btn_timkiem}
    \    wait until element is visible    ${msg_kqtimkiem}
    \    ${mes}=    Get text    ${msg_kqtimkiem}
    \    Should contain any    ${mes}    ${item_product}
    \    Click Element JS    ${btn_addtocart_kqtk}
    \    wait until element is visible    ${btn_addtocart}
    \    input text    ${txt_soluong}    ${item_num}
    \    ${price}    convert price to number    ${lbl_giasp}
    \    ${total}    Multiplication    ${price}    ${item_num}
    \    append to list    ${list_thanhtien}    ${total}
    \    Click element    ${btn_addtocart}
    \    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    click element js    ${btn_orderincart}
    ${tongtienhang}    Sum values in list    ${list_thanhtien}
    Return from keyword    ${tongtienhang}    ${list_thanhtien}

Chon san pham thuoc tinh vao cart
    [Arguments]    ${input_text}    ${sl}    ${thuoctinh_1}    ${thuoctinh_2}
    wait until element is visible    ${msg_kqtimkiem}
    ${mes}=    Get text    ${msg_kqtimkiem}
    Should contain any    ${mes}    ${input_text}
    Click Element JS    ${btn_addtocart_kqtk}
    wait until element is visible    ${btn_addtocart}
    ${thuoctinh1}    Format string    ${btn_thuoctinh1}    ${thuoctinh_1}
    ${thuoctinh2}    Format string    ${btn_thuoctinh2}    ${thuoctinh_2}
    click element    ${thuoctinh1}
    sleep    3
    click element    ${thuoctinh2}
    sleep    3
    input text    ${txt_soluong}    ${sl}
    ${price}    convert price to number    ${lbl_giasp}
    ${total}    Multiplication    ${price}    ${sl}
    Click element    ${btn_addtocart}
    click element    ${btn_close}
    wait until page contains element    ${btn_orderincart}
    click element js    ${btn_orderincart}
    Return from keyword    ${total}    ${price}
tim kiem san pham va kiem tra
