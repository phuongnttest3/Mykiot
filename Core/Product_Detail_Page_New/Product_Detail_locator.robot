*** Variables ***
${lbl_productcode}    //p[contains(text(),'{0}')]
${lbl_productname}    //h1[contains(text(),'{0}')]
${lbl_stock}      //div[@class='product-branches-list']//p[contains(@class,'product-branches-instock')]
${lbl_productprice}    //div[contains(@class,'product-price')]//p[@class='sale']
${link_category_breadcrumb}    //div[@class='breadcrumb-box']//a[contains(text(),'Hoa')]
${txt_comment_sdn}    //textarea[@name='comment']    # textbox comment sau dang nhap
${btn_comment_sdn}    //button[@class='submit-comment btn btn-primary']    # button comment sdn
