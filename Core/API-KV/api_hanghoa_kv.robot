*** Settings ***
Library           JSONLibrary
Library           RequestsLibrary
Library           String
Library           StringFormat
Library           BuiltIn
Resource          ../API/api_access.robot
Resource          api_access_kv.robot

*** Variables ***
${endpoint_danhmuc_hh_co_dvt}    /branchs/{0}/products?format=json&Includes=ProductAttributes&IsTabVariants=true&%24inlinecount=allpages    # branchid
${endpoint_delete_product}    /products/{0}
${endpoint_material}    /formula?format=json&Includes=Material&%24inlinecount=allpages&%24top=10&%24filter=ProductId+eq+{0}    # 0 is master product id

*** Keywords ***
Add kv product thr api
    [Arguments]    ${ui_product_code}    ${ten_sp}    ${ten_nhom}    ${gia_ban}    ${giavon}    ${ton}
    ${cat_id}    Get kv category ID    ${ten_nhom}
    log    ${cat_id}
    ${format_data}    Format String    "Id":0,"ProductType":2,"CategoryId":{0},"CategoryName":"","isActive":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Code":"{1}","BasePrice":{2},"Cost":{3},"LatestPurchasePrice":0,"OnHand":{4},"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":0,"CompareBasePrice":0,"CompareCode":"","CompareUnit":"","Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"MasterProductId":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","IsLotSerialControl":false,"IsRewardPoint":false,"ProductFormulas":[],"Name":"{5}","ListPriceBookDetail":[],"ProductImages":[]    ${cat_id}    ${ui_product_code}    ${gia_ban}    ${giavon}
    ...    ${ton}    ${ten_sp}
    log    ${format_data}
    ${data}    Evaluate    (None, '[{${format_data}}]')
    ${payload}    Create Dictionary    ListProducts=${data}
    Log    ${payload}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}    verify=True    debug=1
    ${resp1}=    Post Request    lolo    /products/addmany    files=${payload}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Should Be Equal As Strings    ${resp1.status_code}    200
    Log to Console    ${resp1.json()}

Get kv category ID
    [Arguments]    ${category_name}
    # post to get bearer token
    ${header}    Create Dictionary    Authorization=${bearertoken}
    ${params}    Create Dictionary    format=json
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${resp1}=    RequestsLibrary.Get Request    lolo    /categories    params=${params}    headers=${header}
    Should Be Equal As Strings    ${resp1.status_code}    200
    Log    ${resp1.json()}
    ${json_path}    Format String    $..Data[?(@.Name=="{0}")].{1}    ${category_name}    Id
    ${get_raw_data}    Get Value From Json    ${resp1.json()}    ${json_path}
    ${result} =    Evaluate    ${get_raw_data}[0] if ${get_raw_data} else 0
    ${result} =    Evaluate    $result or 0
    Return From Keyword    ${result}

Delete kv product thr API
    [Arguments]    ${input_prd_code}
    [Timeout]    3 minutes
    ${endpoint_pr}    Format String    ${endpoint_danhmuc_hh_co_dvt}    ${branch_id}
    ${jsonpath_product_id}    Format String    $..Data[?(@.Code=="{0}")].Id    ${input_prd_code}
    ${get_product_id}    Get data from KV API    ${endpoint_pr}    ${jsonpath_product_id}
    ${endpoint_delete_prd}    Format String    ${endpoint_delete_product}    ${get_product_id}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}
    ${resp1}=    Delete Request    lolo    ${endpoint_delete_prd}

Get Onhand and Baseprice frm KV API
    [Arguments]    ${input_mahang}
    [Timeout]    3 minute
    ${endpoint_pr}    Format String    ${endpoint_danhmuc_hh_co_dvt}    ${branch_id}
    ${get_resp}    Get KV Request and return body    ${endpoint_pr}
    ${jsonpath_ton}    Format String    $..Data[?(@.Code=="{0}")].OnHand    ${input_mahang}
    ${jsonpath_giaban}    Format String    $..Data[?(@.Code=="{0}")].BasePrice    ${input_mahang}
    ${ton}    Get data from response json    ${get_resp}    ${jsonpath_ton}
    ${ton}    Convert To Number    ${ton}
    ${ton}    Evaluate    round(${ton}, 3)
    ${giaban}    Get data from response json    ${get_resp}    ${jsonpath_giaban}
    Return From Keyword    ${ton}    ${giaban}

Update price product thr API
    [Arguments]    ${ma_sp}    ${pr_type}    ${giaban_update}    ${ton_update}    ${ten_update}
    [Timeout]    3 minutes
    ${get_prd_id}    Get product ID    ${ma_sp}
    ${endpoint_pr}    Format String    ${endpoint_danhmuc_hh_co_dvt}    ${branch_id}
    ${get_resp}    Get KV Request and return body    ${endpoint_pr}
    ${jsonpath_ton}    Format String    $..Data[?(@.Code=="{0}")].OnHand    ${ma_sp}
    ${jsonpath_price}    Format String    $..Data[?(@.Code=="{0}")].BasePrice    ${ma_sp}
    ${jsonpath_cost}    Format String    $..Data[?(@.Code=="{0}")].Cost    ${ma_sp}
    ${jsonpath_name}    Format String    $..Data[?(@.Code=="{0}")].Name    ${ma_sp}
    ${jsonpath_group}    Format String    $..Data[?(@.Code=="{0}")].CategoryName    ${ma_sp}
    ${jsonpath_lastestpurchase}    Format String    $..Data[?(@.Code=="{0}")].LatestPurchasePrice    ${ma_sp}
    ${jsonpath_group}    Format String    $..Data[?(@.Code=="{0}")].CategoryName    ${ma_sp}
    ${jsonpath_unit}    Format String    $..Data[?(@.Code=="{0}")].Unit    ${ma_sp}
    ${ten}    Get data from response json    ${get_resp}    ${jsonpath_name}
    ${nhomhang}    Get data from response json    ${get_resp}    ${jsonpath_group}
    ${giaban_bf}    Get data from response json    ${get_resp}    ${jsonpath_price}
    ${giavon}    Get data from response json    ${get_resp}    ${jsonpath_cost}
    ${ton}    Get data from response json    ${get_resp}    ${jsonpath_ton}
    ${group}    Get data from response json    ${get_resp}    ${jsonpath_group}
    ${lastestprice}    Get data from response json    ${get_resp}    ${jsonpath_lastestpurchase}
    ${unit}    Get data from response json    ${get_resp}    ${jsonpath_unit}
    ${get_list_material_code}    ${get_list_quantity}    Get material product code and quantity lists of combo    ${ma_sp}
    ${get_list_material_id}    Run Keyword If    '${pr_type}'=='com'    Get list product id thr API    ${get_list_material_code}
    ...    ELSE    Set Variable    none
    ${get_material_id_1}    Run Keyword If    '${pr_type}'=='com'    Get From List    ${get_list_material_id}    0
    ...    ELSE    Set Variable    none
    ${get_material_id_2}    Run Keyword If    '${pr_type}'=='com'    Get From List    ${get_list_material_id}    1
    ...    ELSE    Set Variable    none
    ${get_quantity_1}    Run Keyword If    '${pr_type}'=='com'    Get From List    ${get_list_quantity}    0
    ...    ELSE    Set Variable    none
    ${get_quantity_2}    Run Keyword If    '${pr_type}'=='com'    Get From List    ${get_list_quantity}    1
    ...    ELSE    Set Variable    none
    ${get_cat_id}    Get KV category ID    ${nhomhang}
    ${get_retailer_id}    Get RetailerID
    ${format_data}    Run Keyword If    '${pr_type}'=='pro'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002324","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${lastestprice}    ${ton_update}    ${giaban_bf}
    ...    ${ten_update}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='ser'    Format String    "Id":{0},"ProductType":3,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"KLDV020","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":0,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002360","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${lastestprice}    ${ton_update}    ${giaban_bf}
    ...    ${ten_update}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='imei'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":true,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002324","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${lastestprice}    ${ton_update}    ${giaban_bf}
    ...    ${ten_update}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='unit'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":150,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"{9}","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"{9}","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002317","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{10},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${lastestprice}    ${ton_update}    ${giaban_bf}
    ...    ${ten_update}    ${unit}    ${get_retailer_id}
    ...    ELSE    Format String    "Id":{0},"ProductType":1,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{2}","FullName":"{2}","Code":"{3}","BasePrice":{4},"Cost":{5},"LatestPurchasePrice":0,"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{5},"CompareBasePrice":{7},"CompareCode":"{3}","CompareName":"{2}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":0,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductFormulas":[{{"MaterialId":{8},"MaterialCode":"RPT0011","MaterialName":"Ô mai chanh đào Hồng Lam","Quantity":{9},"Cost":30000,"BasePrice":60000,"$$hashKey":"object:12313"}},{{"MaterialId":{10},"MaterialCode":"RPT0015","MaterialName":"Kem whipping cream Anchor","Quantity":{11},"Cost":35000,"BasePrice":20025.46,"$$hashKey":"object:12314"}}],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002377","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{12},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulasOld":[{{"MaterialId":{8},"MaterialCode":"RPT0011","MaterialName":"Ô mai chanh đào Hồng Lam","Quantity":{9},"Cost":30000,"BasePrice":60000,"$$hashKey":"object:12313"}},{{"MaterialId":{10},"MaterialCode":"RPT0015","MaterialName":"Kem whipping cream Anchor","Quantity":{11},"Cost":35000,"BasePrice":20025.46,"$$hashKey":"object:12314"}}],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}    ${ten}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${ton_update}    ${giaban_bf}    ${get_material_id_1}
    ...    ${get_quantity_1}    ${get_material_id_2}    ${get_quantity_2}    ${get_retailer_id}
    log    ${format_data}
    ${data}    Evaluate    (None, '{${format_data}}')
    ${data1}    Evaluate    (None, '[]')
    ${payload}    Create Dictionary    Product=${data}    ListUnitPriceBookDetail=${data1}
    Log    ${payload}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}    verify=True    debug=1
    ${resp1}=    Post Request    lolo    /products/photo    files=${payload}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Should Be Equal As Strings    ${resp1.status_code}    200
    ${format_data}    Run Keyword If    '${pr_type}'=='pro'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002324","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_bf}    ${giavon}    ${lastestprice}    ${ton}    ${giaban_bf}
    ...    ${ten}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='ser'    Format String    "Id":{0},"ProductType":3,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"KLDV020","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":0,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002360","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_bf}    ${giavon}    ${lastestprice}    ${ton}    ${giaban_bf}
    ...    ${ten}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='imei'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":true,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002324","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_bf}    ${giavon}    ${lastestprice}    ${ton}    ${giaban_bf}
    ...    ${ten}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='unit'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":150,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"{9}","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"{9}","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002317","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{10},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_bf}    ${giavon}    ${lastestprice}    ${ton}    ${giaban_bf}
    ...    ${ten}    ${unit}    ${get_retailer_id}
    ...    ELSE    Format String    "Id":{0},"ProductType":1,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{2}","FullName":"{2}","Code":"{3}","BasePrice":{4},"Cost":{5},"LatestPurchasePrice":0,"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{5},"CompareBasePrice":{7},"CompareCode":"{3}","CompareName":"{2}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":0,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductFormulas":[{{"MaterialId":{8},"MaterialCode":"RPT0011","MaterialName":"Ô mai chanh đào Hồng Lam","Quantity":{9},"Cost":30000,"BasePrice":60000,"$$hashKey":"object:12313"}},{{"MaterialId":{10},"MaterialCode":"RPT0015","MaterialName":"Kem whipping cream Anchor","Quantity":{11},"Cost":35000,"BasePrice":20025.46,"$$hashKey":"object:12314"}}],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002377","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{12},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulasOld":[{{"MaterialId":{8},"MaterialCode":"RPT0011","MaterialName":"Ô mai chanh đào Hồng Lam","Quantity":{9},"Cost":30000,"BasePrice":60000,"$$hashKey":"object:12313"}},{{"MaterialId":{10},"MaterialCode":"RPT0015","MaterialName":"Kem whipping cream Anchor","Quantity":{11},"Cost":35000,"BasePrice":20025.46,"$$hashKey":"object:12314"}}],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}    ${ten}
    ...    ${ma_sp}    ${giaban_bf}    ${giavon}    ${ton}    ${giaban_bf}    ${get_material_id_1}
    ...    ${get_quantity_1}    ${get_material_id_2}    ${get_quantity_2}    ${get_retailer_id}
    log    ${format_data}
    ${data}    Evaluate    (None, '{${format_data}}')
    ${data1}    Evaluate    (None, '[]')
    ${payload}    Create Dictionary    Product=${data}    ListUnitPriceBookDetail=${data1}
    Log    ${payload}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}    verify=True    debug=1
    ${resp1}=    Post Request    lolo    /products/photo    files=${payload}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Should Be Equal As Strings    ${resp1.status_code}    200

Update name, price, stock product thr API
    [Arguments]    ${ma_sp}    ${pr_type}    ${giaban_update}    ${ton_update}    ${ten_update}
    [Timeout]    3 minutes
    ${get_prd_id}    Get product ID    ${ma_sp}
    ${endpoint_pr}    Format String    ${endpoint_danhmuc_hh_co_dvt}    ${branch_id}
    ${get_resp}    Get KV Request and return body    ${endpoint_pr}
    ${jsonpath_ton}    Format String    $..Data[?(@.Code=="{0}")].OnHand    ${ma_sp}
    ${jsonpath_price}    Format String    $..Data[?(@.Code=="{0}")].BasePrice    ${ma_sp}
    ${jsonpath_cost}    Format String    $..Data[?(@.Code=="{0}")].Cost    ${ma_sp}
    ${jsonpath_name}    Format String    $..Data[?(@.Code=="{0}")].Name    ${ma_sp}
    ${jsonpath_group}    Format String    $..Data[?(@.Code=="{0}")].CategoryName    ${ma_sp}
    ${jsonpath_lastestpurchase}    Format String    $..Data[?(@.Code=="{0}")].LatestPurchasePrice    ${ma_sp}
    ${jsonpath_group}    Format String    $..Data[?(@.Code=="{0}")].CategoryName    ${ma_sp}
    ${jsonpath_unit}    Format String    $..Data[?(@.Code=="{0}")].Unit    ${ma_sp}
    ${ten}    Get data from response json    ${get_resp}    ${jsonpath_name}
    ${nhomhang}    Get data from response json    ${get_resp}    ${jsonpath_group}
    ${giaban_bf}    Get data from response json    ${get_resp}    ${jsonpath_price}
    ${giavon}    Get data from response json    ${get_resp}    ${jsonpath_cost}
    ${ton}    Get data from response json    ${get_resp}    ${jsonpath_ton}
    ${group}    Get data from response json    ${get_resp}    ${jsonpath_group}
    ${lastestprice}    Get data from response json    ${get_resp}    ${jsonpath_lastestpurchase}
    ${unit}    Get data from response json    ${get_resp}    ${jsonpath_unit}
    ${get_list_material_code}    ${get_list_quantity}    Get material product code and quantity lists of combo    ${ma_sp}
    ${get_list_material_id}    Run Keyword If    '${pr_type}'=='com'    Get list product id thr API    ${get_list_material_code}
    ...    ELSE    Set Variable    none
    ${get_material_id_1}    Run Keyword If    '${pr_type}'=='com'    Get From List    ${get_list_material_id}    0
    ...    ELSE    Set Variable    none
    ${get_material_id_2}    Run Keyword If    '${pr_type}'=='com'    Get From List    ${get_list_material_id}    1
    ...    ELSE    Set Variable    none
    ${get_quantity_1}    Run Keyword If    '${pr_type}'=='com'    Get From List    ${get_list_quantity}    0
    ...    ELSE    Set Variable    none
    ${get_quantity_2}    Run Keyword If    '${pr_type}'=='com'    Get From List    ${get_list_quantity}    1
    ...    ELSE    Set Variable    none
    ${get_cat_id}    Get KV category ID    ${nhomhang}
    ${get_retailer_id}    Get RetailerID
    ${format_data}    Run Keyword If    '${pr_type}'=='pro'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002324","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${lastestprice}    ${ton_update}    ${giaban_bf}
    ...    ${ten_update}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='ser'    Format String    "Id":{0},"ProductType":3,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"KLDV020","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":0,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002360","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${lastestprice}    ${ton_update}    ${giaban_bf}
    ...    ${ten_update}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='imei'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":true,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002324","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{9},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${lastestprice}    ${ton_update}    ${giaban_bf}
    ...    ${ten_update}    ${get_retailer_id}
    ...    ELSE IF    '${pr_type}'=='unit'    Format String    "Id":{0},"ProductType":2,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{8}","FullName":"{8}","Code":"{2}","BasePrice":{3},"Cost":{4},"LatestPurchasePrice":{5},"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":150,"CompareCost":{4},"CompareBasePrice":{7},"CompareCode":"{2}","CompareName":"{8}","CompareUnit":"{9}","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":999999999,"CustomId":0,"CustomValue":0,"Unit":"{9}","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002317","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{10},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulas":[],"ProductFormulasOld":[],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${lastestprice}    ${ton_update}    ${giaban_bf}
    ...    ${ten_update}    ${unit}    ${get_retailer_id}
    ...    ELSE    Format String    "Id":{0},"ProductType":1,"CategoryId":{1},"CategoryName":"","isActive":true,"HasVariants":false,"VariantCount":0,"AllowsSale":true,"isDeleted":false,"Name":"{2}","FullName":"{2}","Code":"{3}","BasePrice":{4},"Cost":{5},"LatestPurchasePrice":0,"OnHand":{6},"OnOrder":0,"OnHandCompareMin":0,"OnHandCompareMax":0,"CompareOnHand":0,"CompareCost":{5},"CompareBasePrice":{7},"CompareCode":"{3}","CompareName":"{2}","CompareUnit":"","CompareProductShelves":[],"Reserved":0,"MinQuantity":0,"MaxQuantity":0,"CustomId":0,"CustomValue":0,"Unit":"","ConversionValue":1,"OrderTemplate":"","ProductAttributes":[],"ProductShelves":[],"ProductFormulas":[{{"MaterialId":{8},"MaterialCode":"RPT0011","MaterialName":"Ô mai chanh đào Hồng Lam","Quantity":{9},"Cost":30000,"BasePrice":60000,"$$hashKey":"object:12313"}},{{"MaterialId":{10},"MaterialCode":"RPT0015","MaterialName":"Kem whipping cream Anchor","Quantity":{11},"Cost":35000,"BasePrice":20025.46,"$$hashKey":"object:12314"}}],"ProductUnits":[],"IsLotSerialControl":false,"IsRewardPoint":false,"IsBatchExpireControl":false,"FormulaCount":0,"TradeMarkName":"","MasterCode":"SPC002377","GenuineGuarantees":[],"StoreGuarantees":[],"RepeatGuarantee":{{"Uuid":-1,"TimeType":2,"ProductId":{0},"RetailerId":{12},"Description":"Toàn bộ sản phẩm"}},"GuaranteesToDelete":[],"ProductFormulasOld":[{{"MaterialId":{8},"MaterialCode":"RPT0011","MaterialName":"Ô mai chanh đào Hồng Lam","Quantity":{9},"Cost":30000,"BasePrice":60000,"$$hashKey":"object:12313"}},{{"MaterialId":{10},"MaterialCode":"RPT0015","MaterialName":"Kem whipping cream Anchor","Quantity":{11},"Cost":35000,"BasePrice":20025.46,"$$hashKey":"object:12314"}}],"ProductImages":[],"ListPriceBookDetail":[]    ${get_prd_id}    ${get_cat_id}    ${ten}
    ...    ${ma_sp}    ${giaban_update}    ${giavon}    ${ton_update}    ${giaban_bf}    ${get_material_id_1}
    ...    ${get_quantity_1}    ${get_material_id_2}    ${get_quantity_2}    ${get_retailer_id}
    log    ${format_data}
    ${data}    Evaluate    (None, '{${format_data}}')
    ${data1}    Evaluate    (None, '[]')
    ${payload}    Create Dictionary    Product=${data}    ListUnitPriceBookDetail=${data1}
    Log    ${payload}
    Create Session    lolo    ${kvapi_url}    cookies=${resp.cookies}    verify=True    debug=1
    ${resp1}=    Post Request    lolo    /products/photo    files=${payload}
    Log    ${resp1.request.body}
    Log    ${resp1.json()}
    log    ${resp1.status_code}
    Should Be Equal As Strings    ${resp1.status_code}    200
    Return from keyword    ${ten}    ${giaban_bf}    ${ton}

Get product ID
    [Arguments]    ${ma_hh}
    ${endpoint_hh_co_dvt}    Format String    ${endpoint_danhmuc_hh_co_dvt}    ${BRANCH_ID}
    ${resp}    Get KV Request and return body    ${endpoint_hh_co_dvt}
    ${jsonpath_id_sp}    Format String    $..Data[?(@.Code == '{0}')].Id    ${ma_hh}
    ${get_prd_id}    Get data from response json    ${resp}    ${jsonpath_id_sp}
    Return From Keyword    ${get_prd_id}

Get material product code and quantity lists of combo
    [Arguments]    ${input_combo_ui_code}
    [Timeout]    3 minute
    ${endpoint_danhmuc_hh_co_dvt}    Format String    ${endpoint_danhmuc_hh_co_dvt}    ${BRANCH_ID}
    ${jsonpath_comboid}    Format String    $..Data[?(@.Code=="{0}")].Id    ${input_combo_ui_code}
    ${get_combo_id}    Get data from KV API    ${endpoint_danhmuc_hh_co_dvt}    ${jsonpath_comboid}
    ${endpoint_material_by_combo_id}    Format String    ${endpoint_material}    ${get_combo_id}
    ${resp.material}    Get KV Request and return body    ${endpoint_material_by_combo_id}
    ${list_material_product_code}    Get Value From Json    ${resp.material}    $.Data..MaterialCode
    ${list_material_quantity}    Get Value From Json    ${resp.material}    $.Data..Quantity
    Return From Keyword    ${list_material_product_code}    ${list_material_quantity}

Get list product id thr API
    [Arguments]    ${list_product}
    ${list_id_sp}    Create List
    ${endpoint_hh_co_dvt}    Format String    ${endpoint_danhmuc_hh_co_dvt}    ${branch_id}
    ${resp}    Get KV Request and return body    ${endpoint_hh_co_dvt}
    : FOR    ${ma_hh}    IN    @{list_product}
    \    ${jsonpath_id_sp}    Format String    $..Data[?(@.Code == '{0}')].Id    ${ma_hh}
    \    ${get_prd_id}    Get data from response json    ${resp}    ${jsonpath_id_sp}
    \    Append To List    ${list_id_sp}    ${get_prd_id}
    Return From Keyword    ${list_id_sp}
