*** Settings ***
Library           SeleniumLibrary
Resource          ../Homepage/Homepage_locator.robot
Resource          ../Homepage/Quickcart_locator.robot
Resource          ../Share/Computation.robot
Resource          ../Share/Javascript.robot
Resource          Addresspage_locator.robot
Resource          Profilepage_locator.robot
*** Keywords ***
Xoa address
  click to element   ${acc_infor}
  click to element   ${link_profile}
  click to element   ${link_address}
  :FOR  ${i}  IN RANGE  10
  \  ${status_delete}=   run keyword and return status    wait until element is visible    ${btn_delete}  5s
  \  run keyword if   '${status_delete}'=='True'    click to element     ${btn_delete}
  \  click to element   ${btn_popup_delete}
  \  ${status_delete}=   run keyword and return status    wait until element is visible    ${btn_delete}  5s
  \  exit for loop if  '${status_delete}'=='False'

