*** Variables ***
${btn_tuybienhinhthuc}    //a[contains(string(),'Tùy biến hình thức')]
${menu_thietlaptrangchu}    //a[contains(text(),'Thiết lập Trang Chủ')]
${btn_bannerads}       //button[contains(text(),'Thiết lập Nhóm Banners')]
${ifr_pagebuilder}      //iframe[contains(@iframe-src,'preview_page_builder=true')]
${img_banner_slider}    //div[@class='swiper-slide swiper-slide-active']//img[@class='img-fluid']
${img_banner_grid}    //body[@class='kv-e-theme-basic home']//div[@class='row']//div[@class='row']//div[1]//figure[1]//img[@class='img-fluid']
${menu_thietlapdanhsachsp}    //a[contains(text(),'Danh sách sản phẩm')]    #menu item thiet lap danh sach san pham
${item_sp_2column}    //div[@id='kv-products']/div[contains(@class,'col-item col-item-2')][1]    #san pham dau tien cua list product 2 cot
${item_sp_3column}    //div[@id='kv-products']/div[contains(@class,'col-item col-item-3')][1]    #san pham dau tien cua list product 3 cot
${item_sp_4column}    //div[@id='kv-products']/div[contains(@class,'col-item col-item-4')][1]    #san pham dau tien cua list product 4 cot
${item_sp_5column}    //div[@id='kv-products']/div[contains(@class,'col-item col-item-5')][1]    #san pham dau tien cua list product 5 cot
${item_sp_6column}    //div[@id='kv-products']/div[contains(@class,'col-item col-item-6')][1]    #san pham dau tien cua list product 6 cot
${btn_taithucong}    //a[contains(@class,'btn-show-more read-more')]    #button tai thu cong
${menu_thietlapchitietsp}    //a[contains(text(),'Chi tiết sản phẩm')]    #menu item thiet lap chi tiet san pham
${lbl_thongtinkhohang}    //h6[contains(text(),'Thông tin kho hàng')]    #label thong tin kho hang
${lbl_motasp}     //h6[@class='card-title']    #label mo ta san pham
${lbl_danhgiasp}    //h6[@class='mb-3']    #label danh gia san pham
${lbl_hanghoacungloai}    //h4[@class='kv-title' and contains(text(),'Hàng hóa cùng loại')]    #label hang hoa cung loai
