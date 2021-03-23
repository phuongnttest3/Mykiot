*** Variables ***
${txt_name}       //input[@id='inplace-userName']
${txt_mobilephone}    //input[@id='inplace-phoneNumber']
${btn_thanhtoan}    //button[@id='checkout-kvbtn']
${btn_tieptucmuahang}    //a[@class="btn btn-secondary"]
${lb_giaohangtaidcnguoinhan}    //*[contains(@class,'CoD card')]//div[contains(@class,'cod')]//label
${txt_ten}        //input[@id='order-userName']
${txt_sdt}        //input[@id='order-phoneNumber']
${txt_email}      //input[@id='order-email']
${txt_diachi}     //input[@id='order-address']
${cbb_thanhpho}    //span[@class='select2-selection select2-selection--single' and @aria-labelledby='select2-order-city-container']
${cbb_quanhuyen}    //select[@id='order-district']
${cbb_phuongxa}    //span[@class='select2-selection select2-selection--single' and @aria-labelledby='select2-order-ward-container']
${txa_ghichu}     //textarea[@id='order-note']
${txt_thanhpho}    //input[@class='select2-search__field']
${obj_thanhpho}    //select[@id='order-city']//option[contains(text(),'{0}')]
${obj_quanhuyen}    //select[@id='order-district']//option[contains(text(),'{0}')]
${obj_phuongxa}    //select[@id='order-ward']//option[contains(text(),'{0}')]
${title_orderpage}    //h6[contains(text(),'Giỏ hàng')]
${popup_msg}      //div[@class='modal-body']
${lbl_tongtienhang}    //div[contains(@class,'e-sub-total')]//div[@class='totals-content']
${lbl_footer}     //p[@class='text-right']
${txt_sl}         //input[@class='form-control form-control-sm quantity-value']
${lbl_giasp_order}    //*[@class= 'cart-content-item'][1]//div[contains(@class,'e-cart-price text')]//h6
${lbl_texttongtienhang}    //*[contains(text(),'Tổng tiền hàng')]
${cb_chinhanh}    //label[@class='custom-control-label branch-name']
${link_updatephone}   //a[@class='ml5' and contains(text(),'Cập nhật')]
${btn_taodiachi}  //button[contains(text(),'TẠO NGAY')]
${popup_themdiachi}   //p[contains(text(),'THÊM ĐỊA CHỈ MỚI')]
${txt_addfullname}    //input[@name='full_name']
${txt_addphone}    //input[@name='phone']
${txt_addaddress}    //input[@name='address']
${chb_adddefault}   //input[@id='customCheck']
${cbb_addthanhpho}   //span[@class='select2-selection select2-selection--single' and contains(@aria-labelledby,'select2-location_id')]
${dd_thanhpho}   //select[@name='location_id']
${dd_phuongxa}   //select[@name='ward_id']
${cbb_addphuongxa}    //span[@class='select2-selection select2-selection--single' and contains(@aria-labelledby,'select2-ward_id')]
${btn_luuthongtin}   //button[contains(text(),'LƯU THÔNG TIN')]
${msg_success}    //div[contains(text(),'Thành công')]
${btn_thaydoi}    //button[contains(text(),'THAY ĐỔI')]
${btn_themdiachi}   //button[@id='add-new-address']
${order_code}    //b[@id='code-order']
