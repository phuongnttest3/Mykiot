*** Settings ***
Library           ExcelLibrary

*** Keywords ***
Write Excel and exit loop
    [Arguments]    ${item_cell}    ${result}    ${time_update_at_kv}    ${time_recieve}    ${time_get_update_at}
    write excel cell    ${item_cell}    1    ${result}
    write excel cell    ${item_cell}    2    ${time_update_at_kv}
    write excel cell    ${item_cell}    3    ${time_recieve}
    write excel cell    ${item_cell}    4    ${time_get_update_at}
    Exit for loop
