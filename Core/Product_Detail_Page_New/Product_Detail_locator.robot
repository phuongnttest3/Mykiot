*** Variables ***
${lbl_productcode}    //p[contains(text(),'{0}')]
${lbl_productname}    //h1[contains(text(),'{0}')]
${lbl_stock}      //div[@class='product-branches-list']//p[contains(@class,'product-branches-instock')]
${lbl_productprice}    //div[contains(@class,'product-price')]//p[@class='sale']
${link_category_breadcrumb}    //div[@class='breadcrumb-box']//../li[contains(text(),'{0}')]
