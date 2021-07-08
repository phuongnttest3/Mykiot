*** Variables ***
${title_checkout}    //h4[contains(text(),'Đơn hàng')]
${lbl_name}  //h6[@class='product-card-title']/a
${lbl_gia}   //div[@class='cart-item card card-checkout']//div[@class='card-item-price']

${rb_nhantaichinhanh}    //div[@class='form-group']//span[@class='text-color']
${rb_chinhanh}    //label[contains(string(),'{0}')]
${rb_nhantaidiachi}   //div[@class='form-group mb-0']//span[@class='text-color']
${lbl_thanhtien}    //div[@class='card-item-money color-themes-second']
${total_thanhtoan}  //p[@class='amount card-checkout-price color-themes-second']
${btn_dathang}     //button[@class='btn card-checkout-btn btn-primary mt10']
${lblorder_code}     //div[@class='modal-content']//h5[@class='color-themes-second']
${btn_tieptucmuahang}     //a[contains(@class,'btn-continue btn btn-primary')]

${btn_update_address}    //button[@class='btn-gray btn btn-sm']
${btn_create_address}   //button[@class='btn btn-gray btn btn-sm btn-secondary']
${btn_address_setting}   //a[@class='btn-gray mt-2 mt-md-0 btn btn-sm']

${txt_name}    //div[@class='form-group'][1]//div[@class='account-my-info-item']//input
${txt_phone}  //div[@class='form-group'][2]//div[@class='account-my-info-item']//input
${txt_address}   //div[@class='form-group'][3]//div[@class='account-my-info-item']//input
${dropdown_tinh_tp}    //div[@class='modal-body']//div[@class='form-group'][4]//input
${dropdown_phuong_xa}   //div[@class='modal-body']//div[@class='form-group'][5]//input
${chbox_default_address}  //div[@class='account-my-info-item']//input[@type='checkbox']
${btn_luu_address}   //div[@class='account-my-info-action text-right']//button[@type='button']