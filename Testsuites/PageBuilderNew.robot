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
Resource          ../Core/Common_/Common_locator.robot
Resource          ../Core/Common_/Common_action.robot



*** Test Cases ***
TCP001
   [Template]  update products list 2 products in row
    2   4
TCP002
   [Template]  update products list 3 products in row
    3   4
TCP003
   [Template]  update products list 4 products in row
    4   4
TCP004
   [Template]  update products list 5 products in row
    5   4
TCP005
   [Template]  update products list 6 products in row
    6   4

*** Keywords ***

update products list 2 products in row
   [Arguments]    ${item_in_row}   ${row}
   open browser    https://fe-staging.citigo.dev:40001/admin/page-builder.html   gc
   maximize browser window
   sleep  15s
   click to element     //a[@href='/admin/page-builder/page-settings.html']     # ${link_page_setting}
   click to element     //a[@href='/admin/page-builder/page-settings/product-list.html']    # ${link_product_list}
   wait until element is visible    //div[@class='mk-custom-select']//select[@class='custom-select']   5s
   select from list by label   //div[@class='mk-custom-select']//select[@class='custom-select']    ${item_in_row}      #${dropdown_number_product}
   click to element      //button[@class='mk-topbar-publish-save mk-btn mk-btn-third']   #${btn_luuconfig}
   handle alert    action=ACCEPT
   sleep  3s
   open browser   https://fe-staging.citigo.dev:40001/chuhueman/1momobile.c566960.html  gc
   maximize browser window
   sleep  3s
   wait until element is visible      //div[@class='category-product mk-product-list grid']/div[contains(@style,'grid-template-columns:repeat(2,1fr)')]   10s  # ${item_style_2sp}
   ${count_item}=       get element count      //div[@class='category-product mk-product-list grid']//div[@class='mk-product-item']    #{item_number}
   ${so_item} =  Multiplication and round   ${item_in_row}   ${row}
   should be equal as numbers   ${so_item}   ${count_item}
   close all browsers

update products list 3 products in row
   [Arguments]    ${item_in_row}   ${row}
   open browser    https://fe-staging.citigo.dev:40001/admin/page-builder.html   gc
   maximize browser window
   sleep  15s
   click to element     //a[@href='/admin/page-builder/page-settings.html']     # ${link_page_setting}
   click to element     //a[@href='/admin/page-builder/page-settings/product-list.html']    # ${link_product_list}
   wait until element is visible    //div[@class='mk-custom-select']//select[@class='custom-select']   5s
   select from list by label   //div[@class='mk-custom-select']//select[@class='custom-select']    ${item_in_row}      #${dropdown_number_product}
   click to element      //button[@class='mk-topbar-publish-save mk-btn mk-btn-third']   #${btn_luuconfig}
   handle alert    action=ACCEPT
   sleep  3s
   open browser   https://fe-staging.citigo.dev:40001/chuhueman/1momobile.c566960.html  gc
   maximize browser window
   sleep  3s
   wait until element is visible      //div[@class='category-product mk-product-list grid']/div[contains(@style,'grid-template-columns:repeat(3,1fr)')]   10s  # ${item_style_2sp}
   ${count_item}=       get element count      //div[@class='category-product mk-product-list grid']//div[@class='mk-product-item']    #{item_number}
   ${so_item} =  Multiplication and round   ${item_in_row}   ${row}
   should be equal as numbers   ${so_item}   ${count_item}
   close all browsers


update products list 4 products in row
   [Arguments]    ${item_in_row}   ${row}
   open browser    https://fe-staging.citigo.dev:40001/admin/page-builder.html   gc
   maximize browser window
   sleep  15s
   click to element     //a[@href='/admin/page-builder/page-settings.html']     # ${link_page_setting}
   click to element     //a[@href='/admin/page-builder/page-settings/product-list.html']    # ${link_product_list}
   wait until element is visible    //div[@class='mk-custom-select']//select[@class='custom-select']   5s
   select from list by label   //div[@class='mk-custom-select']//select[@class='custom-select']    ${item_in_row}      #${dropdown_number_product}
   click to element      //button[@class='mk-topbar-publish-save mk-btn mk-btn-third']   #${btn_luuconfig}
   handle alert    action=ACCEPT
   sleep  3s
   open browser   https://fe-staging.citigo.dev:40001/chuhueman/1momobile.c566960.html  gc
   maximize browser window
   sleep  3s
   wait until element is visible      //div[@class='category-product mk-product-list grid']/div[contains(@style,'grid-template-columns:repeat(4,1fr)')]   10s  # ${item_style_2sp}
   ${count_item}=       get element count      //div[@class='category-product mk-product-list grid']//div[@class='mk-product-item']    #{item_number}
   ${so_item} =  Multiplication and round   ${item_in_row}   ${row}
   should be equal as numbers   ${so_item}   ${count_item}
   close all browsers


update products list 5 products in row
   [Arguments]    ${item_in_row}   ${row}
   open browser    https://fe-staging.citigo.dev:40001/admin/page-builder.html   gc
   maximize browser window
   sleep  15s
   click to element     //a[@href='/admin/page-builder/page-settings.html']     # ${link_page_setting}
   click to element     //a[@href='/admin/page-builder/page-settings/product-list.html']    # ${link_product_list}
   wait until element is visible    //div[@class='mk-custom-select']//select[@class='custom-select']   5s
   select from list by label   //div[@class='mk-custom-select']//select[@class='custom-select']    ${item_in_row}      #${dropdown_number_product}
   click to element      //button[@class='mk-topbar-publish-save mk-btn mk-btn-third']   #${btn_luuconfig}
   handle alert    action=ACCEPT
   sleep  3s
   open browser   https://fe-staging.citigo.dev:40001/chuhueman/1momobile.c566960.html  gc
   maximize browser window
   sleep  3s
   wait until element is visible      //div[@class='category-product mk-product-list grid']/div[contains(@style,'grid-template-columns:repeat(5,1fr)')]   10s  # ${item_style_2sp}
   ${count_item}=       get element count      //div[@class='category-product mk-product-list grid']//div[@class='mk-product-item']    #{item_number}
   ${so_item} =  Multiplication and round   ${item_in_row}   ${row}
   should be equal as numbers   ${so_item}   ${count_item}
   close all browsers


update products list 6 products in row
   [Arguments]    ${item_in_row}   ${row}
   open browser    https://fe-staging.citigo.dev:40001/admin/page-builder.html   gc
   maximize browser window
   sleep  15s
   click to element     //a[@href='/admin/page-builder/page-settings.html']     # ${link_page_setting}
   click to element     //a[@href='/admin/page-builder/page-settings/product-list.html']    # ${link_product_list}
   wait until element is visible    //div[@class='mk-custom-select']//select[@class='custom-select']   5s
   select from list by label   //div[@class='mk-custom-select']//select[@class='custom-select']    ${item_in_row}      #${dropdown_number_product}
   click to element      //button[@class='mk-topbar-publish-save mk-btn mk-btn-third']   #${btn_luuconfig}
   handle alert    action=ACCEPT
   sleep  3s
   open browser   https://fe-staging.citigo.dev:40001/chuhueman/1momobile.c566960.html  gc
   maximize browser window
   sleep  3s
   wait until element is visible      //div[@class='category-product mk-product-list grid']/div[contains(@style,'grid-template-columns:repeat(6,1fr)')]   10s  # ${item_style_2sp}
   ${count_item}=       get element count      //div[@class='category-product mk-product-list grid']//div[@class='mk-product-item']    #{item_number}
   ${so_item} =  Multiplication and round   ${item_in_row}   ${row}
   should be equal as numbers   ${so_item}   ${count_item}
   close all browsers

