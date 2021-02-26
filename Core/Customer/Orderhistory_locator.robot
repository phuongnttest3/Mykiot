*** Variables ***
${status_allorder}    //a[contains(text(),'Tất cả')]
${txt_searchorder}   //input[@name='keyword']
${status_line1}   //a[contains(text(),'{0}')]//parent::td//following-sibling::td//span[contains(text(),'{1}')]