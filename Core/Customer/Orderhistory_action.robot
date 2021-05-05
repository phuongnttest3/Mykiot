*** Settings ***
Library           SeleniumLibrary
Resource          ../Homepage/Homepage_locator.robot
Resource          ../Homepage/Quickcart_locator.robot
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot
Resource          Orderhistory_locator.robot


*** Keywords ***
Validate status orders in order history
    [Arguments]  ${order_code}   ${thanhtien}   ${status_order}
    click to element  ${acc_infor}
    click to element  ${ordershistory_link}
    wait until element is visible  ${status_allorder}  5s
    sendkey to element  ${txt_searchorder}   ${order_code}
    press keys   ${txt_searchorder}   ENTER
    ${order_status}   format string   ${status_line1}  ${order_code}  ${status_order}
    [Timeout]    15 minutes
     : FOR    ${time}    IN RANGE    20
    \   page should contain  ${order_code}
    \   ${status}=   run keyword and return status   wait until element is visible     ${order_status}   30s
    \    run keyword if       '${Status}'=='False'    reload page order history
    \    sendkey to element  ${txt_searchorder}   ${order_code}
    \    press keys   ${txt_searchorder}   ENTER
    \    ${tus}=  run keyword and return status      element should be visible    ${order_status}
    \    Exit For Loop If   '${tus}'=='True'
    element should be visible    ${order_status}


reload page order history
     reload page


