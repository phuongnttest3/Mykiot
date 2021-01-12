*** Variables ***
${data_001}       {{"bannerDisplay":"slider","storeId":{0}}}    # update banner display to slider
${data_002}       {{"bannerDisplay":"grid","storeId":{0}}}    # update banner display to grid
${data_003}       {{"category":{{"layoutProduct":2}}, "storeId":{0}}}    #update product list to display 2 columns
${data_004}       {{"category":{{"layoutProduct":3}}, "storeId":{0}}}    #update product list to display 3 columns
${data_005}       {{"category":{{"layoutProduct":4}}, "storeId":{0}}}    #update product list to display 4 columns
${data_006}       {{"category":{{"layoutProduct":5}}, "storeId":{0}}}    #update product list to display 5 columns
${data_007}       {{"category":{{"layoutProduct":6}}, "storeId":{0}}}    #update product list to display 6 columns
${data_008}       {{"category":{{"autoLoad":0}}, "storeId":{0}}}    #update product list to manual load TC027
${data_009}       {{"category":{{"autoLoad":1}}, "storeId":{0}}}    #update product list to autoload TC028
${data_010}       {{"category":{{"visibleSidebar":1}}, "storeId":{0}}}    #update product list to have sidebar
${data_011}       {{"category":{{"visibleSidebar":2}}, "storeId":{0}}}    #update product list to have no sidebar
${data_012}       {{"productDetail":{{"displayWareHouse":1}}, "storeId":{0}}}    #update product detail to display Warhouse
${data_013}       {{"productDetail":{{"displayWareHouse":0}}, "storeId":{0}}}    #update product detail to not display Warhouse
${data_014}       {{"productDetail":{{"displayDescription":1}}, "storeId":{0}}}    #update product detail to display Description
${data_015}       {{"productDetail":{{"displayDescription":0}}, "storeId":{0}}}    #update product detail to not display Description
${data_016}       {{"productDetail":{{"displayComment":1}}, "storeId":{0}}}    #update product detail to display Comment
${data_017}       {{"productDetail":{{"displayComment":0}}, "storeId":{0}}}    #update product detail to not display Comment
${data_018}       {{"productDetail":{{"displayProductRelate":1}}, "storeId":{0}}}    #update product detail to display Related Product
${data_019}       {{"productDetail":{{"displayProductRelate":0}}, "storeId":{0}}}    #update product detail to not display Related Product
${data_reset}     {"menu":{"main_menu":1,"sub_menu":1},"layoutProduct":3,"category":{"layoutProduct":5,"autoLoad":1,"visibleSidebar":1},"productDetail":{"displayDescription":1,"displayComment":1,"displayProductRelate":1,"displayWareHouse":1}}    #update config to default
${data_start}     {{"theme":{{"color":"#45A6AF","second_color":"#2C334D","backgroundColor":"#F9F9F9","backgroundColorHeader":"#fff","topMenuBackgroundColor":"#fff","verticalMenuBackgroundColor":"#fff","footerMenuBackgroundColor":"#fff","font":"'Roboto', sans-serif","headerBackgroundMode":"light-mode","topMenuBackgroundMode":"light-mode","verticalMenuBackgroundMode":"light-mode","horizontalMenuBackgroundMode":"dark-mode","footerMenuBackgroundMode":"light-mode"}},"menu":{{"main_menu":1,"sub_menu":1}},"layoutProduct":3,"layoutFooter":4,"widthBanner":"boxed","bannerDisplay":"slider","profile":{{"logo":"https://staging.citigo.dev:40001/assets/images/kiotvietLogo.jpg"}},"category":{{"layoutProduct":5,"autoLoad":1,"visibleSidebar":1}},"defaultCategory":{{"isShow":true,"displayType":"list"}},"productDetail":{{"displayDescription":1,"displayComment":1,"displayProductRelate":1,"displayWareHouse":1}},"testimonial":{{"isShow":false,"info":[],"items":[]}},"customLayouts":[{{"title":"Sản phẩm nổi bật","productIds":[{0},{1}],"numberItem":4}},{{"title":"Sản phẩm mới","productIds":[{2},{3}],"numberItem":4}}],"quickEnableStatus":{{"footerCopyright":true}},"priceBook":{{"regularPrice":-1}},"branch":{{"branchInventory":[20363],"branchOrder":20363}},"listBranches":[{{"id":20363,"branchName":"Chi nhánh trung tâm","address":"testautomykiot","locationName":"Hà Nội - Quận Hoàn Kiếm","wardName":"Phường Trần Hưng Đạo","retailerId":736403,"createdDate":"2020-09-07T17:20:46.4500000"}}],"syncCategoryCompleted":true,"settingKV":{{"ManagerCustomerByBranch":false,"AllowOrderWhenOutStock":true,"AllowSellWhenOrderOutStock":true,"SellAllowOrder":true}},"isReady":true,"lastModifiedFromNodeSync":"2020-09-08T02:15:00.000000Z","banner":[{{"alt":null,"index":0,"link":null,"url":"https://cdn.mykiot.vn/2020/09/159953204678a014b537db41dd0c20d9b410407a7a.png"}}]}}
