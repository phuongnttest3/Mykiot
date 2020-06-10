*** Settings ***
Library           String
Library           StringFormat
Library           DateTime
Library           Collections

*** Keywords ***
Multiplication
    [Arguments]    ${num1}    ${num2}
    [Timeout]    15 seconds
    ${num1}    Convert To Number    ${num1}    #sl
    ${num2}    Convert Any To Number    ${num2}    #gia
    ${result_ns}    Create Dictionary    x=${num1}    y=${num2}
    ${result}    Evaluate    x*y    namespace=${result_ns}
    Return From Keyword    ${result}

Assert Equals Number
    [Arguments]    ${num1}    ${num2}
    [Timeout]    15 seconds
    ${num1}    Convert Any To Number    ${num1}
    ${num2}    Convert Any To Number    ${num2}
    Should Be Equal As Numbers    ${num1}    ${num2}

Sum
    [Arguments]    ${num1}    ${num2}
    ${num1}    Convert To Number    ${num1}
    ${num2}    Convert To Number    ${num2}
    ${result_ns}    Create Dictionary    x=${num1}    y=${num2}
    ${result}    Evaluate    x+y    namespace=${result_ns}
    Return From Keyword    ${result}

Convert Any To Number
    [Arguments]    ${param}
    ${param_type}    Evaluate    type($param).__name__
    ${param}=    Run Keyword If    '${param_type}' == 'unicode'    Convert To String    ${param}
    ${value}=    Run Keyword If    '${param_type}' == 'str' or '${param_type}' == 'unicode'    Replace String    ${param}    ,    ${EMPTY}
    ...    ELSE    Set Variable    ${param}
    ${value}    Convert To Number    ${value}
    Return From Keyword    ${value}

Minus
    [Arguments]    ${num1}    ${num2}
    ${num1}    Convert To Number    ${num1}
    ${num2}    Convert To Number    ${num2}
    ${result_ns}    Create Dictionary    x=${num1}    y=${num2}
    ${result}    Evaluate    x-y    namespace=${result_ns}
    Return From Keyword    ${result}

Replace floating point
    [Arguments]    ${dec}
    ${dec}    Convert To String    ${dec}
    ${dec}    Replace String    ${dec}    .0    ${EMPTY}
    Return From Keyword    ${dec}

Sum values in list
    [Arguments]    ${list_values}
    ${indext_to_sum}    Set Variable    -1
    ${result_sum}    Set Variable    0
    : FOR    ${item}    IN    @{list_values}
    \    ${indext_to_sum}    Evaluate    ${indext_to_sum} + 1
    \    ${item}    Get From List    ${list_values}    ${indext_to_sum}
    \    ${result_sum}    Sum    ${result_sum}    ${item}
    Return From Keyword    ${result_sum}

Get text and convert to number
    [Arguments]    ${location}
    ${get_text}    Get text    ${location}
    ${get_text}    Replace String    ${get_text}    ,    ${EMPTY}
    ${number}    Convert To Number    ${get_text}
    Return From Keyword    ${number}
