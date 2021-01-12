*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          ../API/api_access.robot
Resource          api_access_kv.robot
Resource          api_hanghoa_kv.robot
Resource          ../Share/Computation.robot

*** Variables ***
${endpoint_khachhang}    /customers?format=json&Includes=TotalInvoiced&Includes=Location&Includes=WardName&ForManageScreen=true
${endpoint_hoadon}    /invoices?format=json&Includes=BranchName&Includes=Branch&Includes=DeliveryInfoes&Includes=DeliveryPackages&Includes=TableAndRoom&Includes=Customer&Includes=Payments&Includes=SoldBy&Includes=User&Includes=InvoiceOrderSurcharges&Includes=Order&ForSummaryRow=true&Includes=SaleChannel&UsingStoreProcedure=false&%24inlinecount=allpages&%24top=100&ExpectedDeliveryFilterType=alltime&%24filter=(BranchId+eq+{0}+and+PurchaseDate+eq+%27year%27+and+(Status+eq+3+or+Status+eq+1+or+Status+eq+5+or+Status+eq+2))    # 0: branchid
${endpoint_delete_hd}    /invoices/{0}?CompareCode={1}&IsVoidPayment=true    #0: id hóa đơn - 1: mã hd

*** Keywords ***
Create invoice incl one product frm API
    [Arguments]    ${product_code}    ${quantity}    ${customer_code}    ${cus_payment}
    ${Uuid}    Generate Random String    4    [NUMBERS][NUMBERS]
    ${Uuid_code}    Catenate    SEPARATOR=    WA    ${Uuid}
    ${jsonpath_id_kh}    Format String    $..Data[?(@.Code == '{0}')].Id    ${customer_code}
    ${jsonpath_id_sp}    Format String    $..Data[?(@.Code == '{0}')].Id    ${product_code}
    ${jsonpath_gia_ban}    Format String    $..Data[?(@.Code == '{0}')].BasePrice    ${product_code}
    ${get_id_kh}    Get data from API by BranchID    ${branch_id}    ${endpoint_khachhang}    ${jsonpath_id_kh}
    ${endpoint_danhmuc_hh_co_dvt}    Format String    ${endpoint_danhmuc_hh_co_dvt}    ${branch_id}
    ${get_id_sp}    Get data from API by BranchID    ${branch_id}    ${endpoint_danhmuc_hh_co_dvt}    ${jsonpath_id_sp}
    ${get_gia_ban}    Get data from API by BranchID    ${branch_id}    ${endpoint_danhmuc_hh_co_dvt}    ${jsonpath_gia_ban}
    ${get_id_nguoitao}    Get RetailerID
    ${get_id_nguoiban}    Get User ID
    ${result_thanhtien}    Multiplication and round    ${get_gia_ban}    ${quantity}
    ${resull_khtt_all}    Set Variable If    '${cus_payment}' == 'all'    ${result_thanhtien}    ${cus_payment}
    ${request_payload}    Format String    {{"Invoice":{{"BranchId":{0},"RetailerId":{1},"CustomerId":{2},"SoldById":{3},"SoldBy":{{"CreatedBy":0,"CreatedDate":"2018-07-30T08:27:36.800Z","Email":"","GivenName":"anh.lv","Id":{4},"IsActive":true,"IsAdmin":true,"Language":"vi-VN","Type":0,"UserName":"admin","isDeleted":false}},"SaleChannelId":0,"SaleChannel":null,"Seller":{{"CreatedBy":0,"CreatedDate":"2018-07-30T08:27:36.800Z","Email":"","GivenName":"anh.lv","Id":{5},"IsActive":true,"IsAdmin":true,"Language":"vi-VN","Type":0,"UserName":"admin","isDeleted":false}},"OrderCode":"","Code":"Hóa đơn 1","InvoiceDetails":[{{"BasePrice":200000,"IsLotSerialControl":false,"IsRewardPoint":false,"Note":"","Price":{6},"ProductId":{7},"Quantity":{8},"ProductCode":"Combo01","ProductName":"Set nước hoa Vial 01","SalePromotionId":null,"PriceByPromotion":null,"PromotionParentProductId":null,"ProductBatchExpireId":null,"CategoryId":680823,"MasterProductId":15128664,"Unit":"","Uuid":"","ProductWarranty":[]}}],"InvoiceOrderSurcharges":[],"InvoicePromotions":[],"Payments":[{{"Method":"Cash","MethodStr":"Tiền mặt","Amount":{9},"Id":-1}}],"Status":1,"Total":200000,"Surcharge":0,"Type":1,"Uuid":"{10}","addToAccount":"0","PayingAmount":0,"TotalBeforeDiscount":200000,"ProductDiscount":0,"DebugUuid":"","InvoiceWarranties":[],"CreatedBy":201567}}}}    ${branch_id}    ${get_id_nguoitao}    ${get_id_kh}    ${get_id_nguoiban}
    ...    ${get_id_nguoiban}    ${get_id_nguoiban}    ${get_gia_ban}    ${get_id_sp}    ${quantity}    ${resull_khtt_all}
    ...    ${Uuid_code}
    Log    ${request_payload}
    : FOR    ${time}    IN RANGE    5
    \    ${resp.status_code}    ${resp.json()}    Post request to create invoice and get resp    ${request_payload}
    \    Exit For Loop If    '${resp.status_code}'=='200'
    ${string}    Convert To String    ${resp.json()}
    ${dict}    Set Variable    ${resp.json()}
    ${invoice_code}    Get From Dictionary    ${dict}    Code
    Return From Keyword    ${invoice_code}

Post request to create invoice and get resp
    [Arguments]    ${request_payload}
    ${headers}=    Create Dictionary    Authorization=${bearertoken}    Content-Type=application/json;charset=UTF-8    Retailer=${retailer_code}    BranchId=${branch_id}    Zone=${zone}
    Create Session    kiotvietapi    ${salekvapi}    cookies=${resp.cookies}    verify=True    debug=1
    ${resp}=    Post Request    kiotvietapi    /invoices/save    data=${request_payload}    headers=${headers}
    Log    ${resp.request.body}
    Log    ${resp.json()}
    Log    ${resp.status_code}
    Should Be Equal As Strings    ${resp.status_code}    200
    Return From Keyword    ${resp.status_code}    ${resp.json()}

Delete invoice by invoice code
    [Arguments]    ${invoice_code}
    [Timeout]    5 mins
    ${jsonpath_id_hd}    Format String    $..Data[?(@.Code == '{0}')].Id    ${invoice_code}
    ${endpoint_hoadon_by_branch}    Format String    ${endpoint_hoadon}    ${branch_id}
    ${get_id_hd}    Get data from KV API    ${endpoint_hoadon_by_branch}    ${jsonpath_id_hd}
    ${endpoint_delete_hd}    Format String    ${endpoint_delete_hd}    ${get_id_hd}    ${invoice_code}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${headers}=    Create Dictionary    Authorization=${bearertoken}    Content-Type=application/x-www-form-urlencoded
    ${resp}=    RequestsLibrary.Delete Request    lolo    ${endpoint_delete_hd}    headers=${headers}    allow_redirects=True
    Log    ${resp.request.body}
    Log    ${resp.json()}
    log    ${resp.status_code}
    Should Be Equal As Strings    ${resp.status_code}    200
