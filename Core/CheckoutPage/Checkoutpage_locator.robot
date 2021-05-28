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