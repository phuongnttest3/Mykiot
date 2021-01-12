*** Variables ***
${firstproduct_code}    //td[span[contains(text(),'{0}')]]    # code cua sp dau tien trong danh sach
${firstproduct_name}    //td[span[contains(text(),'{0}')]]/../td[@class='text-left name']//h6    # ten cua san pham dau tien tien trong danh sach
${firstproduct_stock}    //td[span[contains(text(),'{0}')]]/../td[5]    # ton kho cua san pham dau tien trong list hang hoa
${firstproduct_baseprice}    //td[span[contains(text(),'{0}')]]/../td[7]    # gia ban cua san pham dau tien trong list hang hoa
${txt_mahanghoa}    //input[@name='keyword']
${btn_loctimkiem}    //button[contains(text(),'Áp dụng')]
${firstproduct_saleprice}    //td[span[contains(text(),'{0}')]]/../td[8]    # gia khuyen mai cua san pham dau tien trong list hang hoa
