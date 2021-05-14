*** Variables ***
${firstproduct_code}    //td[span[contains(text(),'{0}')]]    # code cua sp dau tien trong danh sach
${firstproduct_name}    //td[span[contains(text(),'{0}')]]/../td[@class='text-left name']//h6    # ten cua san pham dau tien tien trong danh sach
${firstproduct_stock}    //td[span[contains(text(),'{0}')]]/../td[5]    # ton kho cua san pham dau tien trong list hang hoa
${firstproduct_baseprice}    //td[span[contains(text(),'{0}')]]/../td[7]    # gia ban cua san pham dau tien trong list hang hoa
${txt_mahanghoa}    //input[@name='keyword']
${btn_loctimkiem}    //button[@class='btn-kv btn btn-success btn-filter']
${firstproduct_saleprice}    //td[span[contains(text(),'{0}')]]/../td[8]    # gia khuyen mai cua san pham dau tien trong list hang hoa
${get_product_code}    //tr[1]//td[3]//span
${btn_onproductactive}    //span[contains(text(),'SP001622')]//parent::td//following-sibling::td//div[@class='kv-product-actions']//a[contains(@class,'js-switch-status')]
${btn_offproductactive}    //span[contains(text(),'SP001622')]//parent::td//following-sibling::td//div[@class='kv-product-actions']//a[contains(@class,'inactive js-switch-status')]
${message_success}    //div[contains(text(),'Thiết Lập Thành công')]
${xemsanpham_storefront}    //a[@title='Xem hàng hóa']//i
${product_show}    //p[contains(text(),'SP001622')]
${curentpage}     //li[@class='active']//span[text()='1']
${pagechoose}     //li//a[text()='{0}']
${nextpage}       //a[@class='page-link next']
${previouspage}    //a[@class='page-link prev']
${pageactive}     //li[@class='active']//span[text()='{0}']
${current_hanghoa}    //button[@class='dropdown-toggle']//strong[contains(text(),'{0}')]
${count_namesp}    //tr//td[@class='text-left name']
${sosp_hienthi}    //a[contains(text(),'50 sản phẩm')]
${btn_sync}       //button[@id='btn-sync-by-last-modify']
