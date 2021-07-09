*** Variables ***
${btn_taikhoan}    //i[@class='fas fa-user']
${link_dangnhap}    //span[contains(text(),'Đăng nhập bằng Google')]
${txt_mailaccount}    //input[@type="email"]
${btn_next}       //button[@type='button']//span[contains(text(),'Tiếp theo')]
${txt_passaccount}    //input[@type='password']
${btn_checkout}    //div[@class='header-cart-main']//a[@class='btn btn-primary header-cart-checkout']
${btn_taikhoan_sdn}    //button[@class='btn dropdown-toggle btn-secondary']



${category_viewallxpath}  //a[contains(text(),'{0}')]/parent::h3//following-sibling::a