*** Variables ***
${acc_header_link}  //div[@class='header-account-avatar']//img
${order_history_link}  //div[@class='header-account']//a[contains(@href,'/customer/order.html')]
${odercode_text}    //div[@class='acc-table-wrapper']//tr[1]//td[1]//a

${lbl_comment_content}    //td[contains(text(),'{0}')]/../td[contains(text(),'{1}')]
${customer_info_billding}   //div[@class='order-user-box']//p[text()='Automation Test']//following-sibling::p[contains(string(),'0987666332')]//following-sibling::p[contains(string(),'testautomation113@gmail.com')]
${customer_info_shipping}
${total_quantity}  //div[@class='order-detail-total']//div[@class='order-detail-value'][1]//p[@class='font-weight-bold']
${total_tongtien}  //div[@class='order-detail-value'][5]//strong

